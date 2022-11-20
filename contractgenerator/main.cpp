#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "filereader.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/contractgenerator/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);



    qmlRegisterType<FileReader>("module.reader",1,0,"MyFileReader");

    engine.load(url);

    return app.exec();
}
