#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "client.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Client client;
    client.ConnectToServer("127.0.0.1", 60000);

    QQmlApplicationEngine engine;
    QQmlContext* root_context = engine.rootContext();
    root_context->setContextProperty("Client", &client);

    const QUrl url(u"qrc:/Employee/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // Set application dir path to properly read realive paths to product images
    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    engine.load(url);

    return app.exec();
}
