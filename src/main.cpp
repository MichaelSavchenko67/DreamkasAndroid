#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QQmlComponent>
#include "include/gui.h"
#include "include/guiThread.h"

#include <QFile>
#include <QDir>
#include "include/menumodel.h"

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

    qDebug() << qApp->applicationDirPath();

    QString pathFile(qApp->applicationDirPath() + "/default.txt");

    qDebug() << pathFile;

    QFile file(pathFile);

//    QDir dir;
//    qDebug() << dir.absoluteFilePath("default.txt");

    if ( file.open(QIODevice::ReadOnly) )
    {
        qDebug() << "File open";
    }
    MenuModel menuModel(file.readAll());

    qDebug() << "Row count: " << menuModel.rowCount(QModelIndex());

    engine.rootContext()->setContextProperty("menuModel", &menuModel);

    return app.exec();
}
