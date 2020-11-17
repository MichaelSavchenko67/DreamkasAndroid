#include "include/gui.h"

using namespace GUI;

const QString AppView::mainScreen = "qrc:/qml/main.qml";

void AppView::startLauncherGui()
{
    emit menu.setInteractive(false);
    emit toolbar.setVisible(false);
    emit changePage(Launcher::launcherPage());
}

void AppView::finishLauncherGui(const QString &page)
{
    emit menu.setInteractive();
    emit toolbar.setVisible();
    emit changePage(page);
}
