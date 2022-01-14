#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QQmlComponent>
#include <QFontDatabase>
#include "include/gui.h"
#include "include/guiThread.h"

#include "include/modelDemoSwipe.h"
#include "include/cashlessPayModel.h"
#include <QFile>
#include <QDir>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("Dreamkas");
    QGuiApplication::setOrganizationName("Dreamkas");
    QGuiApplication::setOrganizationDomain("https://dreamkas.ru");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);   
    QQmlApplicationEngine engine;

    Demo demo;
    engine.rootContext()->setContextProperty("demo", &demo);

    CashlessPayModel cashlessPayModel;
    CashlessPayModel::declareQML();
    engine.rootContext()->setContextProperty("cashlessPayModel", &cashlessPayModel);

    ModelDemoSwipe modelDemoSwipe;
    engine.rootContext()->setContextProperty("modelDemoSwipe", &modelDemoSwipe);

    const QFont fixedFont = QFontDatabase::systemFont(QFontDatabase::FixedFont);
    engine.rootContext()->setContextProperty("fixedFont", fixedFont);

    GUI::AppView appView(&engine);
//    GUI::FoundGoods foundGoods(&engine);
//    GUI::GuiThread guiThread(&appView);
//    emit guiThread.run();

    return app.exec();
}
