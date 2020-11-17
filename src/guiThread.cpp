#include "include/guiThread.h"

using namespace GUI;

void AppViewWorker::process()
{
    qDebug("doWork ...");
    int i {3};
    while (i > 0)
    {
        emit _appView->launcher.changeMsg(QString::fromUtf8("Загрузка ") +
                                          QString::number(i--) +
                                          QString::fromUtf8(" секунд ..."));
        QThread::sleep(1);
    }
    _appView->finishLauncherGui("qrc:/qml/pages/SalePage.qml");
    emit _appView->toolbar.setTitle("Продажа");
    emit result("FINISH");
}
