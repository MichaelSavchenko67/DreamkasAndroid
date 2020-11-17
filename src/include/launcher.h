#ifndef _LAUNCHER_H
#define _LAUNCHER_H

#include <QObject>
#include <QString>

namespace GUI
{
    /**
     * @brief The Launcher class
     */
    class Launcher : public QObject
    {
        Q_OBJECT
    public:
        explicit Launcher(QObject *parent = 0) : QObject(parent) {}

        static QString launcherPage() {return "qrc:/qml/pages/LauncherPage.qml";}
    signals:
        /**
         * @brief changeMsg
         * @param msg
         */
        void changeMsg(const QString &msg);
        /**
         * @brief changeIndicationColor
         * @param color
         */
        void changeIndicationColor(const QString &color);
        /**
         * @brief stopBusyIndicator
         */
        void stopBusyIndicator();
    };
}

#endif
