#ifndef MENUDISPLAYMODEL_H
#define MENUDISPLAYMODEL_H

#include <QQmlEngine>
#include <QAbstractListModel>

class MenuDisplayModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit MenuDisplayModel(QObject *parent = nullptr) : QAbstractListModel(parent) { create(); }
    ~MenuDisplayModel() {}

    enum MENU_ID
    {
        MENU_ID_UNKNOWN = -1,
        MENU_ID_SETTINGS = 0,
        MENU_ID_GALLERY,
        MENU_ID_2CAN,
        MENU_ID_OTHER
    };
    Q_ENUM(MENU_ID)
    /**
     * @brief The CustomRoles enum - роли пунктов меню.
     */
    enum CustomRoles : int
    {
        NameRole = Qt::UserRole + 1,    //!< Имя пункта меню
        IconRole,                       //!< Адрес иконки пункта меню в ресурсах
        AppliedAvailableRole,           //!< Наличие признака активности (применяемости)
        AppliedRole                     //!< Состояние активности (применяемости)
    };
    Q_ENUM(CustomRoles)

    static void declareQML() { qmlRegisterType<MenuDisplayModel>("MenuRolesEnum", 1, 0, "MenuRoles"); }

    int rowCount(const QModelIndex &parent) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role) const override;
    /**
     * @brief setItemApplied установка флага применения
     * @param id уникальный идентификатор элемента меню
     * @param applied флаг применения
     */
    Q_INVOKABLE void setItemApplied(const MenuDisplayModel::MENU_ID id, const bool applied);
private:
    struct MenuItem
    {
        explicit MenuItem(const MENU_ID id = MENU_ID::MENU_ID_UNKNOWN,
                          const QString &name = "MENU_ID_UNKNOWN",
                          const QString &icon = "",
                          const bool appliedAvailable = false,
                          const bool applied = false) : m_id(id),
                                                        m_name(name),
                                                        m_icon(icon),
                                                        m_appliedAvailable(appliedAvailable),
                                                        m_applied(applied) {}

        ~MenuItem() {}

        MENU_ID m_id;               //!< id пункта меню.
        QString m_name;             //!< наименование пункта меню.
        QString m_icon;             //!< путь к иконке
        bool m_appliedAvailable;    //!< Флаг наличия флага применения.
        bool m_applied;             //!< флаг применения.
    };
    QList<MenuItem> m_menuItemsList;    // лист пунктов меню
    /**
     * @brief create - Метод инициализации пунктов меню.
     */
    void create();
};
#endif // MENUDISPLAYMODEL_H
