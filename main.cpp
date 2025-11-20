#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QQmlEngine>
#include <QJSEngine>
#include "src/PlaylistManager.h"
#include "src/FilePicker.h"
#include "src/VlcPlayer.h"
#include "src/ExternalVlcLauncher.h"
#include "AppState.h"

static QObject* playlistManagerProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    
    PlaylistManager *manager = new PlaylistManager();
    return manager;
}

int main(int argc, char *argv[])
{
    // Set FFmpeg environment variables BEFORE creating QApplication
    // Note: Qt Multimedia's Video component uses FFmpeg internally
    // Unfortunately, we can't directly control FFmpeg's HTTP headers from Qt
    // Some environment variables may help, but not all are supported
    
    // Set default backend (already default, but explicit)
    qputenv("QTMULTIMEDIA_DEFAULTBACKEND", "ffmpeg");
    
    // Try to set FFmpeg user agent (may not be supported by all Qt versions)
    // This is attempted but may not work - it's a Qt/FFmpeg limitation
    qputenv("QT_FFMPEG_USER_AGENT", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
    
    // Set FFmpeg HTTP options (experimental - may not be recognized)
    qputenv("FFREPORT", "file=ffmpeg.log:level=32"); // Enable FFmpeg logging for debugging
    
    // Use QApplication instead of QGuiApplication to support QFileDialog
    // QApplication inherits from QGuiApplication, so QML still works
    QApplication app(argc, argv);
    
    // Set Qt Quick Controls 2 style to support customization
    QQuickStyle::setStyle("Basic");
    
    // Register AppState as QML singleton (for settings)
    qmlRegisterSingletonType<AppState>("Backend", 1, 0, "AppState",
        [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
            Q_UNUSED(engine)
            Q_UNUSED(scriptEngine)
            return new AppState();
        });
    
    // Register PlaylistManager as QML singleton (for playlist management)
    qmlRegisterSingletonType<PlaylistManager>("IPTVBackend", 1, 0, "PlaylistManager", playlistManagerProvider);
    
    // Register FilePicker as QML type (for file dialog)
    qmlRegisterType<FilePicker>("IPTVBackend", 1, 0, "FilePicker");
    
    // Register VlcPlayer as QML type (for video playback with custom headers)
    qmlRegisterType<VlcPlayer>("IPTVBackend", 1, 0, "VlcPlayer");

    // Register ExternalVlcLauncher as QML type (to open full VLC UI window)
    qmlRegisterType<ExternalVlcLauncher>("IPTVBackend", 1, 0, "ExternalVlcLauncher");
    
    QQmlApplicationEngine engine;
    
    // Set application properties
    app.setApplicationName("App Shell & System");
    app.setApplicationVersion("2.2.0");
    app.setOrganizationName("IPTV Pro");
    
    // Load the main QML file
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(url);
    
    return app.exec();
}
