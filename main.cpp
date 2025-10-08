#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    // Set Qt Quick Controls 2 style to support customization
    QQuickStyle::setStyle("Basic");
    
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
