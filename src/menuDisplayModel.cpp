#include "menuDisplayModel.h"

int MenuDisplayModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
    {
        return 0;
    }
    return m_menuItemsList.count();
}

QHash<int, QByteArray> MenuDisplayModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[NameRole] = "name";
    roles[IconRole] = "icoSrc";
    roles[AppliedAvailableRole] = "isCanApply";
    roles[AppliedRole] = "isApplied";
    return roles;
}

QVariant MenuDisplayModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || (index.row() < 0) || (index.row() >= m_menuItemsList.count()))
    {
        return QVariant();
    }

    switch (role)
    {
        case NameRole: return m_menuItemsList.at(index.row()).m_name;
        case IconRole: return m_menuItemsList.at(index.row()).m_icon;
        case AppliedAvailableRole: return m_menuItemsList.at(index.row()).m_appliedAvailable;
        case AppliedRole: return m_menuItemsList.at(index.row()).m_applied;
    }
    return QVariant();
}

void MenuDisplayModel::create()
{
    m_menuItemsList.clear();
    m_menuItemsList.append(MenuItem {MENU_ID::MENU_ID_SETTINGS, "Настройки", "qrc:/ico/menu/settings_blue.png", false, false});
    m_menuItemsList.append(MenuItem {MENU_ID::MENU_ID_GALLERY, "Галерея", "qrc:/ico/menu/gallery.png", false, false});
    m_menuItemsList.append(MenuItem {MENU_ID::MENU_ID_2CAN, "Терминал 2can NFC", "qrc:/ico/settings/2can.png", true, false});
    m_menuItemsList.append(MenuItem {MENU_ID::MENU_ID_OTHER, "Ещё", "qrc:/ico/menu/other.png", false, false});
    emit layoutChanged();
}

void MenuDisplayModel::setItemApplied(const MENU_ID id, const bool applied)
{
    const auto it = std::find_if(std::begin(m_menuItemsList),
                                 std::end(m_menuItemsList),
                                 [id](const MenuItem &menuItem) { return (menuItem.m_id == id); });

    if (it != std::end(m_menuItemsList))
    {
        (*it).m_applied = applied;
        emit layoutChanged();
    }
}
