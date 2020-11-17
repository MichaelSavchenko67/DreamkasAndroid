#ifndef TOOLBAR_H
#define TOOLBAR_H

#include <QObject>

namespace GUI
{
    /**
     * @brief The Toolbar class
     */
    class Toolbar : public QObject
    {
        Q_OBJECT
    public:
        explicit Toolbar(QObject *parent = 0) : QObject(parent) {}
    signals:
        /**
         * @brief setVisible
         * @param isVisible
         */
        void setVisible(const bool isVisible = true);
        /**
         * @brief setTitle
         * @param title
         */
        void setTitle(const QString &titleTb);
    };
}

#endif // TOOLBAR_H
