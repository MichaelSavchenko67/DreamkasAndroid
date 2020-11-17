#ifndef GUITHREAD_H
#define GUITHREAD_H

#include <QObject>
#include <QThread>
#include <QDebug>

#include "gui.h"

namespace GUI
{
    /**
     * @brief The AppViewWorker class
     */
    class AppViewWorker : public QObject
    {
        Q_OBJECT
    public:
        AppViewWorker(GUI::AppView *appView) : _appView(appView) {}
    public slots:
        void process();
    signals:
        void result(const QString &result);
    private:
        GUI::AppView *_appView = nullptr;
    };
    /**
     * @brief The GuiThread class
     */
    class GuiThread : public QObject
    {
        Q_OBJECT
        QThread workerThread;
    public:
        GuiThread(GUI::AppView *appView) {
            AppViewWorker *worker = new AppViewWorker(appView);
            worker->moveToThread(&workerThread);
            connect(&workerThread, &QThread::finished, worker, &QObject::deleteLater);
            connect(this, &GuiThread::run, worker, &AppViewWorker::process);
            connect(worker, &AppViewWorker::result, this, &GuiThread::handleResults);
            workerThread.start();
        }
        ~GuiThread() {
            workerThread.quit();
            workerThread.wait();
        }
    public slots:
        void handleResults(const QString &result) {qDebug() << result;}
    signals:
        void run();
    };
}

#endif // GUITHREAD_H
