#ifndef MENU_H
#define MENU_H

#include <QObject>

namespace GUI
{
    /**
     * @brief The Menu class
     */
    class Menu : public QObject
    {
        Q_OBJECT
    public:
        explicit Menu(QObject *parent = 0) : QObject(parent) {}
    signals:
        /**
         * @brief setInteractive
         * @param isInteractive
         */
        void setInteractive(const bool isInteractive = true);
    };
}

#endif // MENU_H
