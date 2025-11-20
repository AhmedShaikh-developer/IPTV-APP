#include "ExternalVlcLauncher.h"

#include <QFile>
#include <QStandardPaths>
#include <QDebug>

ExternalVlcLauncher::ExternalVlcLauncher(QObject *parent)
    : QObject(parent)
{
}

ExternalVlcLauncher::~ExternalVlcLauncher()
{
    if (m_process) {
        m_process->disconnect(this);
        m_process->close();
        m_process->deleteLater();
        m_process = nullptr;
    }
}

QString ExternalVlcLauncher::findVlcExecutable() const
{
#ifdef Q_OS_WIN
    // Try common Windows installation paths
    const QStringList candidates = {
        QStringLiteral("C:/Program Files/VideoLAN/VLC/vlc.exe"),
        QStringLiteral("C:/Program Files (x86)/VideoLAN/VLC/vlc.exe")
    };

    for (const QString &path : candidates) {
        if (QFile::exists(path))
            return path;
    }
#endif

    // Fallback to assuming "vlc" is on PATH
    return QStringLiteral("vlc");
}

void ExternalVlcLauncher::playUrl(const QString &url)
{
    if (url.isEmpty()) {
        qWarning() << "ExternalVlcLauncher::playUrl called with empty URL";
        return;
    }

    const QString vlcExe = findVlcExecutable();
    if (vlcExe.isEmpty()) {
        qWarning() << "ExternalVlcLauncher: VLC executable not found";
        return;
    }

    // If there's an existing process, terminate it first
    if (m_process) {
        m_process->kill();
        m_process->deleteLater();
        m_process = nullptr;
    }

    m_process = new QProcess(this);

    // Basic arguments: start playing immediately, show full UI
    QStringList args;
    // Keep VLC UI fully featured; just add some sensible defaults
    args << QStringLiteral("--no-video-title-show");
    // Let VLC exit when playback finishes
    args << QStringLiteral("--play-and-exit");
    // Finally the media URL
    args << url;

    qDebug() << "ExternalVlcLauncher: starting VLC:" << vlcExe << args;

    connect(m_process, &QProcess::started, this, []() {
        qDebug() << "ExternalVlcLauncher: VLC process started";
    });
    connect(m_process,
            QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
            this,
            [this](int code, QProcess::ExitStatus status) {
                qDebug() << "ExternalVlcLauncher: VLC finished, code:" << code
                         << "status:" << status;
                m_process->deleteLater();
                m_process = nullptr;
            });
    connect(m_process, &QProcess::errorOccurred, this, [](QProcess::ProcessError err) {
        qWarning() << "ExternalVlcLauncher: process error:" << err;
    });

    m_process->start(vlcExe, args);

    if (!m_process->waitForStarted(3000)) {
        qWarning() << "ExternalVlcLauncher: failed to start VLC";
    }
}


