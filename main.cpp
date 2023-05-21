#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Control/mediacontroller.h"
#include <QApplication>
#include <QQmlContext>

#include <fileref.h>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
//    MediaController mediaObj;
//    QQmlContext* context=  engine.rootContext();
//    context->setContextProperty("mediaObj",&mediaObj);
    qmlRegisterType<MediaController>("MediaController",1,0,"MediaController");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
