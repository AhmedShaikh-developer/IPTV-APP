#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QQmlEngine>
#include <QJSEngine>
#include "src/PlaylistManager.h"
#include "src/FilePicker.h"

static QObject* playlistManagerProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    
    PlaylistManager *manager = new PlaylistManager();
    return manager;
}

int main(int argc, char *argv[])
{
    // Use QApplication instead of QGuiApplication to support QFileDialog
    // QApplication inherits from QGuiApplication, so QML still works
    QApplication app(argc, argv);
    
    // Set Qt Quick Controls 2 style to support customization
    QQuickStyle::setStyle("Basic");
    
    // Register PlaylistManager as QML singleton
    qmlRegisterSingletonType<PlaylistManager>("IPTVBackend", 1, 0, "PlaylistManager", playlistManagerProvider);
    
    // Register FilePicker as QML type
    qmlRegisterType<FilePicker>("IPTVBackend", 1, 0, "FilePicker");
    
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
