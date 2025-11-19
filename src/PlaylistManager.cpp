#include "PlaylistManager.h"
#include <QDebug>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QStandardPaths>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QUrl>
#include <QUrlQuery>
#include <QCryptographicHash>
#include <QDateTime>

PlaylistManager::PlaylistManager(QObject *parent)
    : QObject(parent)
    , m_liveChannelsModel(new ChannelModel(this))
    , m_vodItemsModel(new VodModel(this))
    , m_parser(new M3UParser(this))
    , m_networkManager(new QNetworkAccessManager(this))
    , m_currentReply(nullptr)
{
    loadPlaylists();
    connect(m_networkManager, &QNetworkAccessManager::finished, this, &PlaylistManager::onM3UDownloadFinished);
}

void PlaylistManager::addXtreamPlaylist(const QString &name, const QString &serverUrl, const QString &username, const QString &password)
{
    qDebug() << "PlaylistManager: Adding Xtream playlist:" << name;

    // Validate inputs
    if (name.isEmpty() || serverUrl.isEmpty() || username.isEmpty() || password.isEmpty()) {
        m_errorMessage = "All fields are required";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Validation failed - empty fields";
        return;
    }

    // Validate URL
    QUrl url(serverUrl);
    if (!url.isValid() || url.scheme().isEmpty()) {
        m_errorMessage = "Invalid server URL";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Invalid URL:" << serverUrl;
        return;
    }

    // Normalize URL (remove trailing slash)
    QString normalizedUrl = serverUrl;
    if (normalizedUrl.endsWith('/')) {
        normalizedUrl.chop(1);
    }

    // Store pending playlist info
    m_pendingPlaylistName = name;
    m_pendingPlaylistType = "xtream";
    m_pendingPlaylist.id = generateId();
    m_pendingPlaylist.name = name;
    m_pendingPlaylist.type = "xtream";
    m_pendingPlaylist.serverUrl = normalizedUrl;
    m_pendingPlaylist.username = username;
    m_pendingPlaylist.password = password;
    m_pendingPlaylist.lastUsed = QDateTime::currentSecsSinceEpoch();

    // Call Xtream API to verify credentials
    QUrl apiUrl(normalizedUrl + "/player_api.php");
    QUrlQuery query;
    query.addQueryItem("username", username);
    query.addQueryItem("password", password);
    apiUrl.setQuery(query);

    qDebug() << "PlaylistManager: Calling Xtream API:" << apiUrl.toString();

    QNetworkRequest request(apiUrl);
    request.setRawHeader("User-Agent", "IPTV Pro/1.0");
    m_currentReply = m_networkManager->get(request);
    connect(m_currentReply, &QNetworkReply::finished, this, &PlaylistManager::onXtreamApiFinished);
}

void PlaylistManager::addM3UUrlPlaylist(const QString &name, const QString &url)
{
    qDebug() << "PlaylistManager: Adding M3U URL playlist:" << name;

    // Validate inputs
    if (name.isEmpty() || url.isEmpty()) {
        m_errorMessage = "Playlist name and URL are required";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Validation failed - empty fields";
        return;
    }

    // Validate URL
    QUrl qurl(url);
    if (!qurl.isValid() || (qurl.scheme() != "http" && qurl.scheme() != "https")) {
        m_errorMessage = "Invalid M3U URL";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Invalid URL:" << url;
        return;
    }

    Playlist playlist;
    playlist.id = generateId();
    playlist.name = name;
    playlist.type = "m3uUrl";
    playlist.m3uUrl = url;
    playlist.lastUsed = QDateTime::currentSecsSinceEpoch();

    // Download M3U
    m_pendingPlaylist = playlist;
    QNetworkRequest request(qurl);
    request.setRawHeader("User-Agent", "IPTV Pro/1.0");
    m_currentReply = m_networkManager->get(request);
    connect(m_currentReply, &QNetworkReply::finished, this, &PlaylistManager::onM3UDownloadFinished);
}

void PlaylistManager::addM3UFilePlaylist(const QString &name, const QString &filePath)
{
    qDebug() << "PlaylistManager: Adding M3U file playlist:" << name;

    // Validate inputs
    if (name.isEmpty() || filePath.isEmpty()) {
        m_errorMessage = "Playlist name and file path are required";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Validation failed - empty fields";
        return;
    }

    // Check if file exists
    QFileInfo fileInfo(filePath);
    if (!fileInfo.exists() || !fileInfo.isFile()) {
        m_errorMessage = "File does not exist";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: File not found:" << filePath;
        return;
    }

    Playlist playlist;
    playlist.id = generateId();
    playlist.name = name;
    playlist.type = "m3uFile";
    playlist.filePath = filePath;
    playlist.lastUsed = QDateTime::currentSecsSinceEpoch();

    // Read file
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        m_errorMessage = "Failed to read file";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Failed to open file:" << filePath;
        return;
    }

    QString content = QString::fromUtf8(file.readAll());
    file.close();

    if (content.isEmpty()) {
        m_errorMessage = "File is empty";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: File is empty:" << filePath;
        return;
    }

    // Parse and add playlist
    parseM3UContent(content);
    addPlaylist(playlist);
    savePlaylists();
    emit playlistAdded(playlist.id);
    emit playlistsChanged();
    qDebug() << "PlaylistManager: M3U file playlist added successfully";
}

void PlaylistManager::removePlaylist(const QString &id)
{
    qDebug() << "PlaylistManager: Removing playlist:" << id;

    for (int i = 0; i < m_playlists.size(); ++i) {
        if (m_playlists[i].id == id) {
            m_playlists.removeAt(i);
            savePlaylists();

            if (m_activePlaylistId == id) {
                m_activePlaylistId.clear();
                m_liveChannelsModel->clear();
                m_vodItemsModel->clear();
                emit activePlaylistChanged();
            }

            emit playlistRemoved(id);
            emit playlistsChanged();
            qDebug() << "PlaylistManager: Playlist removed";
            return;
        }
    }
}

QJsonArray PlaylistManager::getPlaylists()
{
    QJsonArray array;
    for (const Playlist &playlist : m_playlists) {
        array.append(playlistToJson(playlist));
    }
    return array;
}

void PlaylistManager::setActivePlaylist(const QString &id)
{
    qDebug() << "PlaylistManager: Setting active playlist:" << id;

    if (m_activePlaylistId == id) {
        return;
    }

    for (const Playlist &playlist : m_playlists) {
        if (playlist.id == id) {
            m_activePlaylistId = id;

            if (playlist.type == "m3uFile") {
                // Read from file
                QFile file(playlist.filePath);
                if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
                    QString content = QString::fromUtf8(file.readAll());
                    file.close();
                    parseM3UContent(content);
                }
            } else if (playlist.type == "m3uUrl") {
                // Download M3U
                m_pendingPlaylist = playlist;
                QUrl url(playlist.m3uUrl);
                QNetworkRequest request(url);
                request.setRawHeader("User-Agent", "IPTV Pro/1.0");
                m_currentReply = m_networkManager->get(request);
                connect(m_currentReply, &QNetworkReply::finished, this, &PlaylistManager::onM3UDownloadFinished);
            } else if (playlist.type == "xtream") {
                // Build M3U URL from Xtream API
                QString m3uUrl = QString("%1/get.php?username=%2&password=%3&type=m3u_plus&output=ts")
                    .arg(playlist.serverUrl, playlist.username, playlist.password);
                m_pendingPlaylist = playlist;
                QUrl url(m3uUrl);
                QNetworkRequest request(url);
                request.setRawHeader("User-Agent", "IPTV Pro/1.0");
                m_currentReply = m_networkManager->get(request);
                connect(m_currentReply, &QNetworkReply::finished, this, &PlaylistManager::onM3UDownloadFinished);
            }

            emit activePlaylistChanged();
            return;
        }
    }
}

void PlaylistManager::refreshActivePlaylist()
{
    if (m_activePlaylistId.isEmpty()) {
        return;
    }

    setActivePlaylist(m_activePlaylistId);
}

void PlaylistManager::playSingleStream(const QString &url)
{
    qDebug() << "PlaylistManager: Playing single stream:" << url;

    if (url.isEmpty()) {
        m_errorMessage = "URL is required";
        emit errorMessageChanged();
        return;
    }

    QUrl qurl(url);
    if (!qurl.isValid() || qurl.scheme().isEmpty()) {
        m_errorMessage = "Invalid stream URL";
        emit errorMessageChanged();
        return;
    }

    emit playStream(url);
}

void PlaylistManager::loadPlaylists()
{
    QString filePath = getPlaylistsFilePath();
    QFile file(filePath);

    if (!file.exists()) {
        qDebug() << "PlaylistManager: Playlists file does not exist, starting fresh";
        return;
    }

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "PlaylistManager: Failed to open playlists file";
        return;
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(data, &error);

    if (error.error != QJsonParseError::NoError) {
        qDebug() << "PlaylistManager: Failed to parse playlists JSON:" << error.errorString();
        return;
    }

    QJsonArray array = doc.array();
    m_playlists.clear();

    for (const QJsonValue &value : array) {
        if (value.isObject()) {
            Playlist playlist = jsonToPlaylist(value.toObject());
            m_playlists.append(playlist);
        }
    }

    qDebug() << "PlaylistManager: Loaded" << m_playlists.size() << "playlists";
}

void PlaylistManager::savePlaylists()
{
    QString filePath = getPlaylistsFilePath();
    QFileInfo fileInfo(filePath);
    QDir dir = fileInfo.absoluteDir();

    if (!dir.exists()) {
        dir.mkpath(".");
    }

    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qDebug() << "PlaylistManager: Failed to open playlists file for writing";
        return;
    }

    QJsonArray array;
    for (const Playlist &playlist : m_playlists) {
        array.append(playlistToJson(playlist));
    }

    QJsonDocument doc(array);
    file.write(doc.toJson());
    file.close();

    qDebug() << "PlaylistManager: Saved" << m_playlists.size() << "playlists";
}

void PlaylistManager::onXtreamApiFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if (!reply) {
        return;
    }

    if (reply->error() != QNetworkReply::NoError) {
        m_errorMessage = "Network error: " + reply->errorString();
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Xtream API error:" << reply->errorString();
        reply->deleteLater();
        return;
    }

    QByteArray data = reply->readAll();
    reply->deleteLater();

    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(data, &error);

    if (error.error != QJsonParseError::NoError) {
        m_errorMessage = "Invalid response from server";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: JSON parse error:" << error.errorString();
        return;
    }

    QJsonObject obj = doc.object();

    // Check if response indicates error (some Xtream APIs return error in user_info)
    if (obj.contains("user_info")) {
        QJsonObject userInfo = obj["user_info"].toObject();
        if (userInfo.contains("status") && userInfo["status"].toString() != "Active") {
            m_errorMessage = "Invalid credentials or account inactive";
            emit errorMessageChanged();
            qDebug() << "PlaylistManager: Account not active";
            return;
        }
    }

    // Check for auth error indicators
    if (obj.contains("status") && obj["status"].toString() != "OK") {
        m_errorMessage = "Invalid credentials";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Authentication failed";
        return;
    }

    // Success - get M3U URL
    QString m3uUrl;
    if (obj.contains("server_info") && obj["server_info"].toObject().contains("url")) {
        m3uUrl = obj["server_info"].toObject()["url"].toString();
    }

    // Build M3U URL if not provided
    if (m3uUrl.isEmpty()) {
        m3uUrl = QString("%1/get.php?username=%2&password=%3&type=m3u_plus&output=ts")
            .arg(m_pendingPlaylist.serverUrl, m_pendingPlaylist.username, m_pendingPlaylist.password);
    }

    m_pendingPlaylist.m3uUrl = m3uUrl;

    // Download M3U
    QUrl url(m3uUrl);
    QNetworkRequest request(url);
    request.setRawHeader("User-Agent", "IPTV Pro/1.0");
    m_currentReply = m_networkManager->get(request);
    connect(m_currentReply, &QNetworkReply::finished, this, &PlaylistManager::onM3UDownloadFinished);
}

void PlaylistManager::onM3UDownloadFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if (!reply) {
        return;
    }

    if (reply->error() != QNetworkReply::NoError) {
        m_errorMessage = "Failed to download M3U: " + reply->errorString();
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: M3U download error:" << reply->errorString();
        reply->deleteLater();
        return;
    }

    QByteArray data = reply->readAll();
    reply->deleteLater();

    QString content = QString::fromUtf8(data);

    if (content.isEmpty() || !content.contains("#EXTM3U")) {
        m_errorMessage = "Invalid M3U file";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Invalid M3U content";
        return;
    }

    // Parse M3U
    parseM3UContent(content);

    // Add playlist if it's new
    if (!m_pendingPlaylist.id.isEmpty()) {
        addPlaylist(m_pendingPlaylist);
        savePlaylists();
        emit playlistAdded(m_pendingPlaylist.id);
        emit playlistsChanged();
        qDebug() << "PlaylistManager: Playlist added successfully";
    }
}

void PlaylistManager::addPlaylist(const Playlist &playlist)
{
    // Check if playlist with same ID already exists
    for (int i = 0; i < m_playlists.size(); ++i) {
        if (m_playlists[i].id == playlist.id) {
            m_playlists[i] = playlist;
            return;
        }
    }

    m_playlists.append(playlist);
}

void PlaylistManager::parseM3UContent(const QString &content)
{
    m_liveChannelsModel->clear();
    m_vodItemsModel->clear();

    M3UParser::ParseResult result = m_parser->parse(content);

    for (LiveChannel *channel : result.liveChannels) {
        m_liveChannelsModel->addChannel(channel);
    }

    for (VodItem *item : result.vodItems) {
        m_vodItemsModel->addItem(item);
    }

    qDebug() << "PlaylistManager: Parsed M3U -" << result.liveChannels.size() << "channels," << result.vodItems.size() << "VOD items";
}

QString PlaylistManager::generateId()
{
    return QString::number(QDateTime::currentMSecsSinceEpoch());
}

QString PlaylistManager::getPlaylistsFilePath() const
{
    QString appDataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir dir(appDataPath);
    if (!dir.exists()) {
        dir.mkpath(".");
    }
    return dir.filePath("playlists.json");
}

QJsonObject PlaylistManager::playlistToJson(const Playlist &playlist) const
{
    QJsonObject obj;
    obj["id"] = playlist.id;
    obj["name"] = playlist.name;
    obj["type"] = playlist.type;
    obj["lastUsed"] = playlist.lastUsed;

    if (playlist.type == "xtream") {
        obj["serverUrl"] = playlist.serverUrl;
        obj["username"] = playlist.username;
        obj["password"] = playlist.password;
        obj["m3uUrl"] = playlist.m3uUrl;
    } else if (playlist.type == "m3uUrl") {
        obj["m3uUrl"] = playlist.m3uUrl;
    } else if (playlist.type == "m3uFile") {
        obj["filePath"] = playlist.filePath;
    }

    return obj;
}

PlaylistManager::Playlist PlaylistManager::jsonToPlaylist(const QJsonObject &json) const
{
    Playlist playlist;
    playlist.id = json["id"].toString();
    playlist.name = json["name"].toString();
    playlist.type = json["type"].toString();
    playlist.lastUsed = json["lastUsed"].toVariant().toLongLong();

    if (playlist.type == "xtream") {
        playlist.serverUrl = json["serverUrl"].toString();
        playlist.username = json["username"].toString();
        playlist.password = json["password"].toString();
        playlist.m3uUrl = json["m3uUrl"].toString();
    } else if (playlist.type == "m3uUrl") {
        playlist.m3uUrl = json["m3uUrl"].toString();
    } else if (playlist.type == "m3uFile") {
        playlist.filePath = json["filePath"].toString();
    }

    return playlist;
}

