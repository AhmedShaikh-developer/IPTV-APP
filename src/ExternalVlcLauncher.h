#pragma once

#include <QObject>
#include <QProcess>

// Simple helper class to launch the system VLC player (vlc.exe) in a
// separate window with the given media URL. This gives the user the
// full VLC UI with all controls, while our Qt/QML app continues to
// manage playlists, routes, etc.
//
// Usage from QML:
//   import IPTVBackend 1.0
//   ExternalVlcLauncher {
//       id: externalVlc
//   }
//   externalVlc.playUrl(streamUrl)
//
class ExternalVlcLauncher : public QObject
{
    Q_OBJECT

public:
    explicit ExternalVlcLauncher(QObject *parent = nullptr);
    ~ExternalVlcLauncher() override;

    // Launch VLC with the given URL in a separate process.
    // On Windows we try common installation paths for vlc.exe.
    Q_INVOKABLE void playUrl(const QString &url);

private:
    QString findVlcExecutable() const;

    QProcess *m_process = nullptr;
};


