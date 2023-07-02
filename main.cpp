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

    QApplication app(argc, argv);
    MediaController *mediaObj=new MediaController;
    mediaObj->getRootContext()->setContextProperty("mediaObj",mediaObj);
    mediaObj->initEngine();


    return app.exec();
}
