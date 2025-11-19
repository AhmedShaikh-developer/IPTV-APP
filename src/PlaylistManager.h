#ifndef PLAYLISTMANAGER_H
#define PLAYLISTMANAGER_H

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QStandardPaths>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QUrl>
#include <QUrlQuery>
#include "ChannelModel.h"
#include "VodModel.h"
#include "M3UParser.h"

class PlaylistManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ChannelModel* liveChannelsModel READ liveChannelsModel CONSTANT)
    Q_PROPERTY(VodModel* vodItemsModel READ vodItemsModel CONSTANT)
    Q_PROPERTY(QString errorMessage READ errorMessage NOTIFY errorMessageChanged)

public:
    explicit PlaylistManager(QObject *parent = nullptr);

    ChannelModel* liveChannelsModel() const { return m_liveChannelsModel; }
    VodModel* vodItemsModel() const { return m_vodItemsModel; }
    QString errorMessage() const { return m_errorMessage; }

    Q_INVOKABLE void addXtreamPlaylist(const QString &name, const QString &serverUrl, const QString &username, const QString &password);
    Q_INVOKABLE void addM3UUrlPlaylist(const QString &name, const QString &url);
    Q_INVOKABLE void addM3UFilePlaylist(const QString &name, const QString &filePath);
    Q_INVOKABLE void removePlaylist(const QString &id);
    Q_INVOKABLE QJsonArray getPlaylists();
    Q_INVOKABLE void setActivePlaylist(const QString &id);
    Q_INVOKABLE void refreshActivePlaylist();
    Q_INVOKABLE void playSingleStream(const QString &url);
    Q_INVOKABLE void clearError();

    void loadPlaylists();
    void savePlaylists();

signals:
    void errorMessageChanged();
    void playlistAdded(const QString &id);
    void playlistRemoved(const QString &id);
    void activePlaylistChanged();
    void playStream(const QString &url);
    void playlistsChanged();

private slots:
    void onXtreamApiFinished();
    void onM3UDownloadFinished();

private:
    struct Playlist {
        QString id;
        QString name;
        QString type; // "xtream", "m3uUrl", "m3uFile"
        QString serverUrl;
        QString username;
        QString password;
        QString m3uUrl;
        QString filePath;
        qint64 lastUsed;
        int channelCount;  // Number of live channels
        int vodCount;      // Number of VOD items
    };

    void addPlaylist(const Playlist &playlist);
    void parseM3UContent(const QString &content);
    QString generateId();
    QString getPlaylistsFilePath() const;
    QJsonObject playlistToJson(const Playlist &playlist) const;
    Playlist jsonToPlaylist(const QJsonObject &json) const;

    QList<Playlist> m_playlists;
    QString m_activePlaylistId;
    ChannelModel *m_liveChannelsModel;
    VodModel *m_vodItemsModel;
    M3UParser *m_parser;
    QNetworkAccessManager *m_networkManager;
    QNetworkReply *m_currentReply;
    QString m_errorMessage;
    QString m_pendingPlaylistName;
    QString m_pendingPlaylistType;
    Playlist m_pendingPlaylist;
};

#endif // PLAYLISTMANAGER_H

