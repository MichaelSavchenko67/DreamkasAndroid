#ifndef GUI_H
#define GUI_H

#include <QObject>
#include <QThread>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlContext>

#include "launcher.h"
#include "toolbar.h"
#include "menu.h"
#include "searchGoods.h"

namespace GUI
{
    /**
     * @brief The AppView class
     */
    class AppView : public QObject
    {
        Q_OBJECT
    public:
        explicit AppView(QQmlApplicationEngine *engine, QObject *parent = 0) : QObject(parent)
        {
            if (engine != nullptr)
            {
//                QQmlContext *context = engine->rootContext();
//                if (context != nullptr)
//                {
//                    context->setContextProperty("appViewGui", this);
//                    context->setContextProperty("toolbarGui", &toolbar);
//                    context->setContextProperty("menuGui", &menu);
//                    context->setContextProperty("launcherGui", &launcher);
//                }

                engine->load(QUrl(GUI::AppView::mainScreen));
//                startLauncherGui();
            }
        }
        static const QString mainScreen;    
        Launcher launcher;                  
        Toolbar toolbar;                    
        Menu menu;
        /**
         * @brief startLauncherGui
         */
        void startLauncherGui();
        /**
         * @brief finishLauncherGui
         * @param page
         */
        void finishLauncherGui(const QString &page);
    signals:
        /**
         * @brief startLauncher
         */
        void startLauncher();
        /**
         * @brief changePage
         * @param page
         */
        void changePage(const QString& page);
    };
}

#endif // GUI_H
