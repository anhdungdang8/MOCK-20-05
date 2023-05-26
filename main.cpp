#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Control/MediaControl.h"
#include <QApplication>
#include <QQmlContext>



int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
   // qmlRegisterType<MediaController>("MediaController",1,0,"MediaController");
    QApplication app(argc, argv);
    MediaController *mediaObj=new MediaController;
    mediaObj->getRootContext()->setContextProperty("mediaObj",mediaObj);
    mediaObj->initEngine();

    //control.transtoVietNamese();

   // QQmlApplicationEngine engine;
//    const QUrl url(QStringLiteral("qrc:/main.qml"));
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);


    return app.exec();
}
