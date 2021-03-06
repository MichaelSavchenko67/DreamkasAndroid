#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QQmlComponent>

#include "include/gui.h"
#include "include/guiThread.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("Dreamkas");
    QGuiApplication::setOrganizationName("Dreamkas");
    QGuiApplication::setOrganizationDomain("https://dreamkas.ru");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    GUI::AppView appView(&engine);
//    GUI::FoundGoods foundGoods(&engine);
//    GUI::GuiThread guiThread(&appView);
//    emit guiThread.run();

    return app.exec();
}
