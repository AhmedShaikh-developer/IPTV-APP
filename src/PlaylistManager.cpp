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
    
    // Set a proper User-Agent for network requests
    // This helps with servers that require specific headers
    m_networkManager->setProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
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
    m_pendingPlaylist.channelCount = 0;  // Will be set after parsing
    m_pendingPlaylist.vodCount = 0;

    // Call Xtream API to verify credentials
    QUrl apiUrl(normalizedUrl + "/player_api.php");
    QUrlQuery query;
    query.addQueryItem("username", username);
    query.addQueryItem("password", password);
    apiUrl.setQuery(query);

    qDebug() << "PlaylistManager: Calling Xtream API:" << apiUrl.toString();

    QNetworkRequest request(apiUrl);
    // Set headers to avoid 403 Forbidden errors
    request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
    request.setRawHeader("Accept", "application/json");
    request.setRawHeader("Accept-Language", "en-US,en;q=0.9");
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
    // Set headers to avoid 403 Forbidden errors
    request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
    request.setRawHeader("Accept", "*/*");
    request.setRawHeader("Accept-Language", "en-US,en;q=0.9");
    request.setRawHeader("Connection", "keep-alive");
    m_currentReply = m_networkManager->get(request);
    connect(m_currentReply, &QNetworkReply::finished, this, &PlaylistManager::onM3UDownloadFinished);
}

void PlaylistManager::addM3UFilePlaylist(const QString &name, const QString &filePath)
{
    qDebug() << "========================================";
    qDebug() << "PlaylistManager::addM3UFilePlaylist CALLED";
    qDebug() << "Name:" << name;
    qDebug() << "FilePath:" << filePath;

    // Validate inputs
    if (name.isEmpty() || filePath.isEmpty()) {
        m_errorMessage = "Playlist name and file path are required";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Validation failed - empty fields";
        return;
    }

    // Normalize file path - convert Windows backslashes to forward slashes
    QString normalizedPath = filePath;
    normalizedPath.replace("\\", "/");
    qDebug() << "Normalized file path:" << normalizedPath;

    // Check if file exists
    QFileInfo fileInfo(normalizedPath);
    qDebug() << "File exists:" << fileInfo.exists();
    qDebug() << "Is file:" << fileInfo.isFile();
    qDebug() << "Absolute path:" << fileInfo.absoluteFilePath();
    
    if (!fileInfo.exists() || !fileInfo.isFile()) {
        m_errorMessage = QString("File does not exist: %1").arg(normalizedPath);
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: File not found:" << normalizedPath;
        return;
    }

    Playlist playlist;
    playlist.id = generateId();
    playlist.name = name;
    playlist.type = "m3uFile";
    playlist.filePath = fileInfo.absoluteFilePath();  // Use absolute path
    playlist.lastUsed = QDateTime::currentSecsSinceEpoch();
    playlist.channelCount = 0;  // Will be set after parsing
    playlist.vodCount = 0;

    // Read file
    QFile file(fileInfo.absoluteFilePath());
    qDebug() << "Opening file:" << fileInfo.absoluteFilePath();
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        m_errorMessage = QString("Failed to read file: %1").arg(file.errorString());
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Failed to open file:" << fileInfo.absoluteFilePath() << "Error:" << file.errorString();
        return;
    }

    QString content = QString::fromUtf8(file.readAll());
    file.close();
    qDebug() << "File read successfully, content length:" << content.length();

    if (content.isEmpty()) {
        m_errorMessage = "File is empty";
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: File is empty:" << fileInfo.absoluteFilePath();
        return;
    }

    // Parse M3U content to get channel counts
    qDebug() << "Parsing M3U content...";
    M3UParser::ParseResult result = m_parser->parse(content);
    playlist.channelCount = result.liveChannels.size();
    playlist.vodCount = result.vodItems.size();
    qDebug() << "M3U parsed - Channels:" << playlist.channelCount << "VOD items:" << playlist.vodCount;
    
    // Add playlist with counts
    qDebug() << "Adding playlist to list...";
    addPlaylist(playlist);
    savePlaylists();
    qDebug() << "Playlist saved to disk with counts";
    
    // Populate models for immediate use (if this playlist should be active)
    // Note: Models are populated here for immediate access, but playlist is only made active when setActivePlaylist is called
    parseM3UContent(content);
    
    // Emit signals
    qDebug() << "Emitting playlistAdded signal, ID:" << playlist.id;
    emit playlistAdded(playlist.id);
    emit playlistsChanged();
    qDebug() << "PlaylistManager: M3U file playlist added successfully, ID:" << playlist.id << "Channels:" << playlist.channelCount;
    qDebug() << "========================================";
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
    qDebug() << "========================================";
    qDebug() << "PlaylistManager::setActivePlaylist CALLED";
    qDebug() << "Playlist ID:" << id;
    qDebug() << "Current active playlist ID:" << m_activePlaylistId;

    if (m_activePlaylistId == id) {
        qDebug() << "Playlist is already active, skipping";
        return;
    }

    for (const Playlist &playlist : m_playlists) {
        if (playlist.id == id) {
            qDebug() << "Found playlist:" << playlist.name << "Type:" << playlist.type;
            m_activePlaylistId = id;

            if (playlist.type == "m3uFile") {
                // Read from file
                qDebug() << "Reading M3U file:" << playlist.filePath;
                QFileInfo fileInfo(playlist.filePath);
                if (!fileInfo.exists()) {
                    qDebug() << "ERROR: File does not exist:" << playlist.filePath;
                    m_errorMessage = QString("File not found: %1").arg(playlist.filePath);
                    emit errorMessageChanged();
                    return;
                }
                QFile file(playlist.filePath);
                if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
                    QString content = QString::fromUtf8(file.readAll());
                    file.close();
                    qDebug() << "File read successfully, content length:" << content.length();
                    parseM3UContent(content);
                    qDebug() << "M3U parsed - Channels:" << m_liveChannelsModel->rowCount() << "VOD:" << m_vodItemsModel->rowCount();
                    
                    // Update channel counts in playlist if they changed
                    if (m_liveChannelsModel->rowCount() != playlist.channelCount || m_vodItemsModel->rowCount() != playlist.vodCount) {
                        for (int i = 0; i < m_playlists.size(); ++i) {
                            if (m_playlists[i].id == id) {
                                m_playlists[i].channelCount = m_liveChannelsModel->rowCount();
                                m_playlists[i].vodCount = m_vodItemsModel->rowCount();
                                savePlaylists();
                                emit playlistsChanged();
                                qDebug() << "Updated channel counts in playlist";
                                break;
                            }
                        }
                    }
                } else {
                    qDebug() << "ERROR: Failed to open file:" << file.errorString();
                    m_errorMessage = QString("Failed to read file: %1").arg(file.errorString());
                    emit errorMessageChanged();
                    return;
                }
            } else if (playlist.type == "m3uUrl") {
                // Download M3U
                qDebug() << "Downloading M3U from URL:" << playlist.m3uUrl;
                m_pendingPlaylist = playlist;
                QUrl url(playlist.m3uUrl);
                QNetworkRequest request(url);
                // Set headers to avoid 403 Forbidden errors
                request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.setRawHeader("Accept", "*/*");
                request.setRawHeader("Accept-Language", "en-US,en;q=0.9");
                request.setRawHeader("Connection", "keep-alive");
                m_currentReply = m_networkManager->get(request);
                connect(m_currentReply, &QNetworkReply::finished, this, &PlaylistManager::onM3UDownloadFinished);
                qDebug() << "Download started, will parse when finished";
            } else if (playlist.type == "xtream") {
                // Build M3U URL from Xtream API
                qDebug() << "Building Xtream M3U URL...";
                QString m3uUrl = QString("%1/get.php?username=%2&password=%3&type=m3u_plus&output=ts")
                    .arg(playlist.serverUrl, playlist.username, playlist.password);
                m_pendingPlaylist = playlist;
                QUrl url(m3uUrl);
                QNetworkRequest request(url);
                // Set headers to avoid 403 Forbidden errors
                request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.setRawHeader("Accept", "*/*");
                request.setRawHeader("Accept-Language", "en-US,en;q=0.9");
                request.setRawHeader("Connection", "keep-alive");
                m_currentReply = m_networkManager->get(request);
                connect(m_currentReply, &QNetworkReply::finished, this, &PlaylistManager::onM3UDownloadFinished);
                qDebug() << "Download started, will parse when finished";
            }

            emit activePlaylistChanged();
            qDebug() << "Active playlist changed signal emitted";
            qDebug() << "========================================";
            return;
        }
    }
    
    qDebug() << "ERROR: Playlist not found with ID:" << id;
    qDebug() << "Available playlists:" << m_playlists.size();
    qDebug() << "========================================";
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
    // Set headers to avoid 403 Forbidden errors
    request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
    request.setRawHeader("Accept", "*/*");
    request.setRawHeader("Accept-Language", "en-US,en;q=0.9");
    request.setRawHeader("Connection", "keep-alive");
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

    // Parse M3U to get channel counts
    M3UParser::ParseResult result = m_parser->parse(content);
    m_pendingPlaylist.channelCount = result.liveChannels.size();
    m_pendingPlaylist.vodCount = result.vodItems.size();
    qDebug() << "M3U parsed - Channels:" << m_pendingPlaylist.channelCount << "VOD items:" << m_pendingPlaylist.vodCount;
    
    // Populate models
    parseM3UContent(content);

    // Add playlist if it's new (with counts)
    if (!m_pendingPlaylist.id.isEmpty()) {
        addPlaylist(m_pendingPlaylist);
        savePlaylists();
        emit playlistAdded(m_pendingPlaylist.id);
        emit playlistsChanged();
        qDebug() << "PlaylistManager: Playlist added successfully with" << m_pendingPlaylist.channelCount << "channels";
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

QStringList PlaylistManager::getChannelVlcOptions(const QString &url) const
{
    QStringList options;
    if (!m_liveChannelsModel)
        return options;

    // Normalize URL for matching (remove trailing slashes, handle encoding)
    QString normalizedUrl = url.trimmed();
    if (normalizedUrl.endsWith('/'))
        normalizedUrl.chop(1);

    qDebug() << "PlaylistManager: Looking for VLC options for URL:" << normalizedUrl;

    const int count = m_liveChannelsModel->rowCount();
    for (int i = 0; i < count; ++i) {
        LiveChannel *channel = m_liveChannelsModel->get(i);
        if (!channel) continue;

        QString channelUrl = channel->url().trimmed();
        if (channelUrl.endsWith('/'))
            channelUrl.chop(1);

        // Try exact match first
        if (channelUrl == normalizedUrl || channelUrl == url) {
            options = channel->vlcOptions();
            qDebug() << "PlaylistManager: Found matching channel at index" << i << "with" << options.size() << "VLC options";
            if (!options.isEmpty()) {
                qDebug() << "PlaylistManager: VLC options:" << options;
            }
            break;
        }

        // Also try case-insensitive match
        if (channelUrl.compare(normalizedUrl, Qt::CaseInsensitive) == 0) {
            options = channel->vlcOptions();
            qDebug() << "PlaylistManager: Found case-insensitive match at index" << i << "with" << options.size() << "VLC options";
            if (!options.isEmpty()) {
                qDebug() << "PlaylistManager: VLC options:" << options;
            }
            break;
        }
    }

    if (options.isEmpty()) {
        qDebug() << "PlaylistManager: No VLC options found for URL. Searched" << count << "channels.";
    }

    return options;
}

QStringList PlaylistManager::getVodVlcOptions(const QString &url) const
{
    QStringList options;
    if (!m_vodItemsModel)
        return options;

    // Normalize URL for matching (remove trailing slashes, handle encoding)
    QString normalizedUrl = url.trimmed();
    if (normalizedUrl.endsWith('/'))
        normalizedUrl.chop(1);

    qDebug() << "PlaylistManager: Looking for VOD VLC options for URL:" << normalizedUrl;

    const int count = m_vodItemsModel->rowCount();
    for (int i = 0; i < count; ++i) {
        VodItem *item = m_vodItemsModel->get(i);
        if (!item) continue;

        QString itemUrl = item->url().trimmed();
        if (itemUrl.endsWith('/'))
            itemUrl.chop(1);

        // Try exact match first
        if (itemUrl == normalizedUrl || itemUrl == url) {
            options = item->vlcOptions();
            qDebug() << "PlaylistManager: Found matching VOD item at index" << i << "with" << options.size() << "VLC options";
            break;
        }

        // Also try case-insensitive match
        if (itemUrl.compare(normalizedUrl, Qt::CaseInsensitive) == 0) {
            options = item->vlcOptions();
            qDebug() << "PlaylistManager: Found case-insensitive VOD match at index" << i << "with" << options.size() << "VLC options";
            break;
        }
    }

    if (options.isEmpty()) {
        qDebug() << "PlaylistManager: No VOD VLC options found for URL. Searched" << count << "items.";
    }

    return options;
}

QString PlaylistManager::generateId()
{
    return QString::number(QDateTime::currentMSecsSinceEpoch());
}

void PlaylistManager::clearError()
{
    if (!m_errorMessage.isEmpty()) {
        m_errorMessage.clear();
        emit errorMessageChanged();
        qDebug() << "PlaylistManager: Error message cleared";
    }
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
    obj["channelCount"] = playlist.channelCount;
    obj["vodCount"] = playlist.vodCount;

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
    playlist.channelCount = json.contains("channelCount") ? json["channelCount"].toInt() : 0;
    playlist.vodCount = json.contains("vodCount") ? json["vodCount"].toInt() : 0;

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

