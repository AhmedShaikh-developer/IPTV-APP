#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QQmlEngine>
#include "AppState.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    // Set Qt Quick Controls 2 style to support customization
    QQuickStyle::setStyle("Basic");
    
    // Register AppState as QML singleton
    qmlRegisterSingletonType<AppState>("Backend", 1, 0, "AppState",
        [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
            Q_UNUSED(engine)
            Q_UNUSED(scriptEngine)
            return new AppState();
        });
    
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
