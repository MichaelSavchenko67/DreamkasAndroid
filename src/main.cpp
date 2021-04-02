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
#include "include/treemodel.h"
#include "treemodelstandard.h"
#include "menumodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("Dreamkas");
    QGuiApplication::setOrganizationName("Dreamkas");
    QGuiApplication::setOrganizationDomain("https://dreamkas.ru");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);   
    QQmlApplicationEngine engine;

//    GUI::FoundGoods foundGoods(&engine);
//    GUI::GuiThread guiThread(&appView);
//    emit guiThread.run();

//    qDebug() << qApp->applicationDirPath();
    QString pathFile(qApp->applicationDirPath() + "/default_2.txt");
//    qDebug() << pathFile;
    QFile file(pathFile);

//    QDir dir;
//    qDebug() << dir.absoluteFilePath("default.txt");

    if ( file.open(QIODevice::ReadOnly) )
    {
        qDebug() << "File open";
    }
//    TreeModel treeModel(file.readAll());
//    qDebug() << "Row count: " << treeModel.rowCount(QModelIndex());
//    TreeModelStandard treeModelStandard;

    MenuModel menuModel;
//    qDebug() << "Initialize";
//    qDebug() << menuModel.rowCount(QModelIndex());

    engine.rootContext()->setContextProperty("menuModel", &menuModel);

    GUI::AppView appView(&engine);

    return app.exec();
}
