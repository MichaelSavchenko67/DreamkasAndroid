#include "include/menuModelTree.h"

const MenuModelTree::ICONS_TABLE MenuModelTree::m_mapIcons = {
    {MenuModelTree::MENU_ID::SALES_ID,                              "qrc:/ico/menu/drawer/sales.png"},
    {MenuModelTree::MENU_ID::ORDERS_ID,                             "qrc:/ico/menu/drawer/orders.png"},
    {MenuModelTree::MENU_ID::TAXS_CLOUD_ID,                         "qrc:/ico/menu/drawer/taxes.png"},
    {MenuModelTree::MENU_ID::SHIFT_ID,                              "qrc:/ico/menu/drawer/shift.png"},
    {MenuModelTree::MENU_ID::CABINET_CONNECT,                       "qrc:/ico/menu/drawer/account.png"},
    {MenuModelTree::MENU_ID::SETTINGS_ID,                           "qrc:/ico/menu/drawer/settings.png"},
    {MenuModelTree::MENU_ID::SHIFT_ID_OPEN,                         "qrc:/ico/menu/drawer/open_id.png"},
    {MenuModelTree::MENU_ID::SHIFT_ID_CLOSE,                        "qrc:/ico/menu/drawer/close_id.png"},
    {MenuModelTree::MENU_ID::SHIFT_ID_INS_RES,                      "qrc:/ico/menu/drawer/ins_res.png"},
    {MenuModelTree::MENU_ID::DOCS_ID_CUR_REP,                       "qrc:/ico/menu/drawer/cur_rep.png"},
    {MenuModelTree::MENU_ID::SHIFT_ID_X_REPORT,                     "qrc:/ico/menu/drawer/x-report.png"},
    {MenuModelTree::MENU_ID::SETTINGS_ID_TAXS,                      "qrc:/ico/menu/drawer/taxes.png"},
    {MenuModelTree::MENU_ID::DOCS_ID_RECEIPT_COR,                   "qrc:/ico/menu/drawer/receipt_cor.png"},
    {MenuModelTree::MENU_ID::CONNECT_KKT,                           "qrc:/ico/menu/drawer/connect_kkt.png"},
    {MenuModelTree::MENU_ID::CONNECT_BARCODE_SCANNER,               "qrc:/ico/menu/drawer/connect_scanner.png"},
    {MenuModelTree::MENU_ID::CONNECT_SCALES,                        "qrc:/ico/menu/drawer/connect_scales.png"},
    {MenuModelTree::MENU_ID::DREAMKAS_DISPLAY,                      "qrc:/ico/menu/drawer/dreamkas_display_menu.png"},
    {MenuModelTree::MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM,       "qrc:/ico/menu/drawer/bank_term.png"},
    {MenuModelTree::MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM_STATE, "qrc:/ico/menu/drawer/bank_term_state.png"},
    {MenuModelTree::MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS,   "qrc:/ico/menu/drawer/bank_term_ops.png"},
    {MenuModelTree::MENU_ID::SETTINGS_ID_TRADE_RULES_EGAIS_SET_UTM, "qrc:/ico/menu/drawer/utm.png"},
    {MenuModelTree::MENU_ID::SETTINGS_ID_BEER,                      "qrc:/ico/menu/drawer/beer.png"},
    {MenuModelTree::MENU_ID::SETTINGS_ID_TRADE_RULES,               "qrc:/ico/menu/drawer/sale_rules.png"},
    {MenuModelTree::MENU_ID::SETTINGS_ID_TECH_REP,                  "qrc:/ico/menu/drawer/tech_rep.png"},
    {MenuModelTree::MENU_ID::SYSTEM_ID_SEND_LOG,                    "qrc:/ico/menu/drawer/send_log.png"},
    {MenuModelTree::MENU_ID::SYSTEM_ID_USERS,                       "qrc:/ico/menu/drawer/account-box-outline.png"},
};

/**
 *  @brief Описание методов пункта меню MenuItemTree.
 */
MenuModelTree::MenuItemTree::MenuItemTree(MenuItemTree *parentItem, const int pos,
                           const MENU_ID id,
                           const QString &name,
                           const bool appliedAvailable,
                           const bool visible,
                           const bool applied) : m_childItems(QVector<MenuItemTree*>{}),
                                                          m_parentItem(parentItem),
                                                          m_pos(pos),
                                                          m_id(id),
                                                          m_name(name),
                                                          m_appliedAvailable(appliedAvailable),
                                                          m_visible(visible),
                                                          m_applied(applied)

{
    if (m_parentItem != nullptr)
    {
        m_parentItem->appendChild(this);
    }
}

MenuModelTree::MenuItemTree::~MenuItemTree()
{
    qDeleteAll(m_childItems);
}

void MenuModelTree::MenuItemTree::appendChild(MenuItemTree *child)
{
    if (child != nullptr)
    {
        m_childItems.append(child);
    }
}

MenuModelTree::MenuItemTree *MenuModelTree::MenuItemTree::child(int row)
{
    return ( row < 0 || (row >= m_childItems.size()) ) ? nullptr : m_childItems.at(row);
}

int MenuModelTree::MenuItemTree::row()
{
    return m_parentItem ? m_parentItem->m_childItems.indexOf(const_cast<MenuItemTree*>(this)) : 0;
}

/**
 *  @brief Описание методов модели MenuModelTree.
 */
MenuModelTree::MenuModelTree(QObject *parent) : QAbstractItemModel(parent),
                                            m_isPrinterConnected(false),
                                            m_isPrinterRegistered(false),
                                            m_isShiftOpened(false)
{
    connect(this, &MenuModelTree::menuSetVisibleInvItems, this, [this] (const QList<MENU_ID> &visItems, const QList<MENU_ID> &invisItems) {

        QMutexLocker locker(&m_menuMutex);

        for (const auto visItem : visItems)
        {
            if (m_mapMenuItems.contains(visItem))
            {
                MenuItemTree *item = m_mapMenuItems.value(visItem);

                if (item != nullptr)
                {
                    MenuItemTree *parent = item->m_parentItem;
                    insertItem(parent, item);
                }
            }
        }

        for (const auto invItem : invisItems)
        {
            if (m_mapMenuItems.contains(invItem))
            {
                MenuItemTree *item = m_mapMenuItems.value(invItem);
                if (item != nullptr)
                {
                    removeItem(item);
                }
            }
        }
    });

    initialize();
    updatePrinterConnectionItems();
    updateShiftItems();
}

MenuModelTree::~MenuModelTree()
{
    delete m_rootItem;
    m_rootItem = nullptr;
}

void MenuModelTree::initialize()
{
    m_rootItem = new MenuItemTree;

    //! Up level.
    m_mapMenuItems[MENU_ID::SALES_ID]               = new MenuItemTree{ m_rootItem, 0, MENU_ID::SALES_ID,               "Формирование чека" };
    m_mapMenuItems[MENU_ID::ORDERS_ID]              = new MenuItemTree{ m_rootItem, 1, MENU_ID::ORDERS_ID,              "Чеки" };
    m_mapMenuItems[MENU_ID::TAXS_CLOUD_ID]          = new MenuItemTree{ m_rootItem, 2, MENU_ID::TAXS_CLOUD_ID,          "СНО и НДС" };
    m_mapMenuItems[MENU_ID::SHIFT_ID]               = new MenuItemTree{ m_rootItem, 3, MENU_ID::SHIFT_ID,               "Смена", true };
    m_mapMenuItems[MENU_ID::CABINET_CONNECT]        = new MenuItemTree{ m_rootItem, 4, MENU_ID::CABINET_CONNECT,        "Кабинет Дримкас", true };
    m_mapMenuItems[MENU_ID::SETTINGS_ID]            = new MenuItemTree{ m_rootItem, 5, MENU_ID::SETTINGS_ID,            "Настройки" };

        //! Shift level.
        MenuItemTree *shiftId = m_mapMenuItems[MENU_ID::SHIFT_ID];
        m_mapMenuItems[MENU_ID::SHIFT_ID_OPEN]        = new MenuItemTree{ shiftId, 0, MENU_ID::SHIFT_ID_OPEN,         "Открыть смену" };
        m_mapMenuItems[MENU_ID::SHIFT_ID_CLOSE]       = new MenuItemTree{ shiftId, 1, MENU_ID::SHIFT_ID_CLOSE,        "Закрыть смену" };
        m_mapMenuItems[MENU_ID::SHIFT_ID_X_REPORT]    = new MenuItemTree{ shiftId, 2, MENU_ID::SHIFT_ID_X_REPORT,     "X-отчёт" };
        m_mapMenuItems[MENU_ID::SHIFT_ID_INS_RES]     = new MenuItemTree{ shiftId, 3, MENU_ID::SHIFT_ID_INS_RES,      "Изъять или внести" };
        m_mapMenuItems[MENU_ID::SETTINGS_ID_TAXS]     = new MenuItemTree{ shiftId, 4, MENU_ID::SETTINGS_ID_TAXS,      "СНО и НДС" };
        m_mapMenuItems[MENU_ID::DOCS_ID_RECEIPT_COR]  = new MenuItemTree{ shiftId, 5, MENU_ID::DOCS_ID_RECEIPT_COR,   "Чек коррекции" };
        m_mapMenuItems[MENU_ID::DOCS_ID_CUR_REP]      = new MenuItemTree{ shiftId, 6, MENU_ID::DOCS_ID_CUR_REP,       "Отчёт о тек. расчётах" };

        //! Settings level.
        MenuItemTree *settingId = m_mapMenuItems[MENU_ID::SETTINGS_ID];
        m_mapMenuItems[MENU_ID::CONNECT_KKT]                       = new MenuItemTree{ settingId, 0, MENU_ID::CONNECT_KKT,                        "Подключение ККТ",      true };
        m_mapMenuItems[MENU_ID::CONNECT_BARCODE_SCANNER]           = new MenuItemTree{ settingId, 1, MENU_ID::CONNECT_BARCODE_SCANNER,            "Подключение сканера",  false };
        m_mapMenuItems[MENU_ID::CONNECT_SCALES]                    = new MenuItemTree{ settingId, 2, MENU_ID::CONNECT_SCALES,                     "Подключение весов",    true };
        m_mapMenuItems[MENU_ID::DREAMKAS_DISPLAY]                  = new MenuItemTree{ settingId, 3, MENU_ID::DREAMKAS_DISPLAY,                   "Дримкас Дисплей",      true };
        m_mapMenuItems[MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM]   = new MenuItemTree{ settingId, 4, MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM,    "Безналичная оплата",   true };
            //! Bank term level.
            MenuItemTree *bankTerm = m_mapMenuItems[MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM];
            m_mapMenuItems[MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM_STATE] = new MenuItemTree{ bankTerm, 0, MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM_STATE,   "Подключение" };
            m_mapMenuItems[MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS]   = new MenuItemTree{ bankTerm, 1, MENU_ID::SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS,     "Сервисные операции" };

        m_mapMenuItems[MENU_ID::SETTINGS_ID_TRADE_RULES_EGAIS_SET_UTM] = new MenuItemTree{ settingId, 3, MENU_ID::SETTINGS_ID_TRADE_RULES_EGAIS_SET_UTM,  "ЕГАИС", true};
        m_mapMenuItems[MENU_ID::SETTINGS_ID_BEER]                      = new MenuItemTree{ settingId, 4, MENU_ID::SETTINGS_ID_BEER,                       "Разливное пиво"};
        m_mapMenuItems[MENU_ID::SETTINGS_ID_TRADE_RULES]               = new MenuItemTree{ settingId, 5, MENU_ID::SETTINGS_ID_TRADE_RULES,                "Правила торговли"};
        m_mapMenuItems[MENU_ID::SETTINGS_ID_TECH_REP]                  = new MenuItemTree{ settingId, 6, MENU_ID::SETTINGS_ID_TECH_REP,                   "Технический отчёт"};
        m_mapMenuItems[MENU_ID::SYSTEM_ID_SEND_LOG]                    = new MenuItemTree{ settingId, 7, MENU_ID::SYSTEM_ID_SEND_LOG,                     "Отправка логов"};
        m_mapMenuItems[MENU_ID::SYSTEM_ID_USERS]                       = new MenuItemTree{ settingId, 8, MENU_ID::SYSTEM_ID_USERS,                        "Пользователи"};
}

QModelIndex MenuModelTree::index(int row, int column, const QModelIndex &parent) const
{
    if ( !hasIndex(row, column, parent) )
        return QModelIndex();

    MenuItemTree *parentItem;

    if (!parent.isValid())
        parentItem = m_rootItem;
    else
        parentItem = static_cast<MenuItemTree*>(parent.internalPointer());

    if (parentItem != nullptr)
    {
        MenuItemTree *childItem = parentItem->child(row);

        if (childItem)
            return createIndex(row, column, childItem);
    }

    return QModelIndex();
}

QModelIndex MenuModelTree::parent(const QModelIndex &child) const
{
    if ( !child.isValid() )
        return QModelIndex();

    MenuItemTree *childItem   = static_cast<MenuItemTree*>(child.internalPointer());
    MenuItemTree *parentItem  = childItem->m_parentItem;

    if (parentItem == m_rootItem)
        return QModelIndex();

    const int column = 0;

    return createIndex(parentItem->row(), column, parentItem);
}

int MenuModelTree::rowCount(const QModelIndex &parent) const
{
    MenuItemTree *parentItem = nullptr;

    if (parent.column() > 0)
        return 0;

    if (!parent.isValid())
        parentItem = m_rootItem;
    else
        parentItem = static_cast<MenuItemTree*>(parent.internalPointer());

    if (parentItem == nullptr)
        return -1;

    return parentItem->childCount();
}

int MenuModelTree::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 1;
}

QVariant MenuModelTree::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    MenuItemTree *item = static_cast<MenuItemTree*>(index.internalPointer());

    if (item == nullptr)
        return QVariant();

    switch (role)
    {
        case Qt::DisplayRole:
        case CustomRoles::IdRole:               return item->m_id;
        case CustomRoles::NameRole:             return item->m_name;
        case CustomRoles::VisibleRole:          return item->m_visible;
        case CustomRoles::IconRole:             return m_mapIcons.contains(item->m_id) ? QString::fromStdString(m_mapIcons.value(item->m_id)) : QVariant();
        case CustomRoles::AppliedRole:          return item->m_applied;
        case CustomRoles::AppliedAvailableRole: return item->m_appliedAvailable;
        case CustomRoles::IsHighlighted:        return item->m_isHighlighted;
        case CustomRoles::IsFirstHighlighted:   return item->m_isFirstHighlighted;
        case CustomRoles::IsLastHighlighted:    return item->m_isLastHighlighted;
        case CustomRoles::IsRootItem:           return (item->m_parentItem->m_pos == -1);
        default: return QVariant();
    }
}

QVariant MenuModelTree::headerData(int section, Qt::Orientation orientation, int role) const
{
    Q_UNUSED(section)

    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
        return m_rootItem->m_name;

    return QVariant();
}

Qt::ItemFlags MenuModelTree::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractItemModel::flags(index);
}

QHash<int, QByteArray> MenuModelTree::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles[CustomRoles::IdRole]                  = "modelId";                    //!< 257
    roles[CustomRoles::NameRole]                = "modelName";                  //!< 258
    roles[CustomRoles::VisibleRole]             = "modelVisible";               //!< 259
    roles[CustomRoles::IconRole]                = "modelIcon";                  //!< 260
    roles[CustomRoles::AppliedRole]             = "modelApplied";               //!< 261
    roles[CustomRoles::AppliedAvailableRole]    = "modelAppliedAvailable";      //!< 262
    roles[CustomRoles::IsHighlighted]           = "modelIsHighlighted";         //!< 263
    roles[CustomRoles::IsFirstHighlighted]      = "modelIsFirstHighlighted";    //!< 264
    roles[CustomRoles::IsLastHighlighted]       = "modelIsLastHighlighted";     //!< 265
    roles[CustomRoles::IsRootItem]              = "modelIsRootItem";            //!< 266

    return roles;
}

bool MenuModelTree::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;

    MenuItemTree *item = static_cast<MenuItemTree*>(index.internalPointer());

    if (item == nullptr)
        return false;

    switch (role)
    {
        case CustomRoles::NameRole:             if (value.canConvert<QString>())    item->m_name                = value.toString(); break;
        case CustomRoles::VisibleRole:          if (value.canConvert<bool>())       item->m_visible             = value.toBool();   break;
        case CustomRoles::AppliedRole:          if (value.canConvert<bool>())       item->m_applied             = value.toBool();   break;
        case CustomRoles::AppliedAvailableRole: if (value.canConvert<bool>())       item->m_appliedAvailable    = value.toBool();   break;
        case CustomRoles::IsHighlighted:        if (value.canConvert<bool>())       item->m_isHighlighted       = value.toBool();   break;
        case CustomRoles::IsFirstHighlighted:   if (value.canConvert<bool>())       item->m_isFirstHighlighted  = value.toBool();   break;
        case CustomRoles::IsLastHighlighted:    if (value.canConvert<bool>())       item->m_isLastHighlighted   = value.toBool();   break;
        default: return false;
    }

    return true;
}

int MenuModelTree::rowForItem(const MenuItemTree *item)
{
    return item ? item->m_parentItem->m_childItems.indexOf(const_cast<MenuItemTree*>(item)) : -1;
}

QModelIndex MenuModelTree::indexForItem(const MenuItemTree *item)
{
    if (item == nullptr || item == m_rootItem)
    {
        return QModelIndex();
    }

    const int row = rowForItem(item);
    const int column = 0;
    return createIndex(row, column, const_cast<MenuItemTree*>(item));
}

void MenuModelTree::removeItem(MenuItemTree *item)
{
    MenuItemTree *parentItem = item->m_parentItem;

    if (parentItem == nullptr || !parentItem->m_childItems.contains(item) || ((parentItem != m_rootItem) && !parentItem->m_visible))
    {
        return;
    }

    const QModelIndex parent = indexForItem(parentItem);
    int pos = rowForItem(item);

    if (pos < rowCount(parent))
    {
        beginRemoveRows(parent, pos, pos);
        parentItem->m_childItems.removeAt(pos);
        endRemoveRows();
        item->m_visible = false;

        if (parentItem->m_childItems.empty())
        {
            removeItem(parentItem);
        }
    }
}

void MenuModelTree::insertItem(MenuItemTree *parentItem, MenuItemTree *item)
{
    if (parentItem == nullptr || item == nullptr)
    {
        return;
    }
    //! Проверка на видимость родительского пункта item'а.
    if (!parentItem->m_visible && parentItem != m_rootItem)
    {
        return;
    }
    //! Проверка на уже добавленность пункта.
    if (parentItem->m_childItems.contains(item))
    {
        return;
    }

    int posReal {item->m_pos};
    //! Проверяем позицию для сортировки пунктов.
    for (int i {0}; i < parentItem->m_childItems.size(); ++i)
    {
        if (posReal < parentItem->m_childItems.at(i)->m_pos)
        {
            posReal = i;
            break;
        }
    }

    if (posReal > parentItem->m_childItems.size())
    {
        posReal = parentItem->m_childItems.size();
    }

    const QModelIndex parent = indexForItem(parentItem);
    int firstRow = posReal;
    int lastRow = posReal;
    beginInsertRows(parent, firstRow, lastRow);
    parentItem->m_childItems.insert(posReal, item);
    endInsertRows();
    item->m_visible = true;
}

void MenuModelTree::setPopupFinished(int key,
                                     const QString &unitPrice,
                                     const QString &quantity,
                                     const QString &totalPrice,
                                     const bool isMarked)
{
    emit popupFinished(key, unitPrice, quantity, totalPrice, isMarked);
}

MenuModelTree::MENU_ITEMS_TABLE::iterator MenuModelTree::getItem(const MENU_ID id)
{
    return m_mapMenuItems.find(id);
}

void MenuModelTree::delItem(const MENU_ID id)
{
    const auto it = getItem(id);
    if (it != m_mapMenuItems.end())
    {
        m_mapMenuItems.erase(it);
        emit layoutChanged();
    }
}

void MenuModelTree::addItem(const MenuItemTree &item)
{
    if ( getItem(item.m_id) == m_mapMenuItems.end() )
    {
        m_mapMenuItems.insert(item.m_id, const_cast<MenuItemTree*>(&item));
        emit layoutChanged();
    }
}

void MenuModelTree::setItemApplied(const MENU_ID id, const bool applied)
{
    QMutexLocker locker(&m_menuMutex);

    auto item = getItem(id);

    if ((item != m_mapMenuItems.end()) && item.value()->m_appliedAvailable && (item.value()->m_applied != applied))
    {
        item.value()->m_applied = applied;
        emit layoutChanged();
    }
}

void MenuModelTree::setIsPrinterConnected(const bool isPrinterConnected)
{
    if (m_isPrinterConnected != isPrinterConnected)
    {
        m_isPrinterConnected = isPrinterConnected;
        updatePrinterConnectionItems();
        updateShiftItems();
    }
}

void MenuModelTree::setIsPrinterRegistered(const bool isPrinterRegistered)
{
    if (m_isPrinterRegistered != isPrinterRegistered)
    {
        m_isPrinterRegistered = isPrinterRegistered;
        updateShiftItems();
    }
}

void MenuModelTree::setIsShiftOpened(const bool isShiftOpened)
{
    if (m_isShiftOpened != isShiftOpened)
    {
        m_isShiftOpened = isShiftOpened;
        updateShiftItems();
    }
}

void MenuModelTree::updateShiftItems()
{
    auto shiftItem = getItem(MENU_ID::SHIFT_ID);
    shiftItem.value()->m_visible = m_isPrinterConnected && m_isPrinterRegistered;

    if (shiftItem != m_mapMenuItems.end())
    {
        shiftItem.value()->m_applied = m_isShiftOpened;
    }

    auto openShiftItem = getItem(MENU_ID::SHIFT_ID_OPEN);
    if (openShiftItem != m_mapMenuItems.end())
    {
        openShiftItem.value()->m_visible = shiftItem.value()->m_visible && !m_isShiftOpened;
    }

    auto closeShiftItem = getItem(MENU_ID::SHIFT_ID_CLOSE);
    if (closeShiftItem != m_mapMenuItems.end())
    {
        closeShiftItem.value()->m_visible = shiftItem.value()->m_visible && m_isShiftOpened;
    }

    auto xReportItem = getItem(MENU_ID::SHIFT_ID_X_REPORT);
    if (xReportItem != m_mapMenuItems.end())
    {
        xReportItem.value()->m_visible = closeShiftItem.value()->m_visible;
    }

    auto calcStateItem = getItem(MENU_ID::DOCS_ID_CUR_REP);
    if (calcStateItem != m_mapMenuItems.end())
    {
        calcStateItem.value()->m_visible = xReportItem.value()->m_visible;
    }

    auto insResItem = getItem(MENU_ID::SHIFT_ID_INS_RES);
    if (insResItem != m_mapMenuItems.end())
    {
        insResItem.value()->m_visible = xReportItem.value()->m_visible;
    }

    auto snoItem = getItem(MENU_ID::SETTINGS_ID_TAXS);
    if (snoItem != m_mapMenuItems.end())
    {
        snoItem.value()->m_visible = shiftItem.value()->m_visible;
    }

    auto techReportItem = getItem(MENU_ID::SETTINGS_ID_TECH_REP);
    if (techReportItem != m_mapMenuItems.end())
    {
        techReportItem.value()->m_visible = m_isPrinterConnected;
    }

    QList<MENU_ITEMS_TABLE::iterator> listItems {openShiftItem,
                                                 closeShiftItem,
                                                 xReportItem,
                                                 calcStateItem,
                                                 insResItem,
                                                 snoItem,
                                                 techReportItem};

    QList<MENU_ID> invisibleItems {};
    QList<MENU_ID> visibleItems {};

    for (const auto item : listItems)
    {
        item.value()->m_visible ? visibleItems << item.value()->m_id : invisibleItems << item.value()->m_id;
    }

    onModelItemsVisibleChanged(visibleItems, true);
    onModelItemsVisibleChanged(invisibleItems, false);

    emit layoutChanged();
}

void MenuModelTree::updatePrinterConnectionItems()
{
    setItemApplied(MENU_ID::CONNECT_KKT, m_isPrinterConnected);
}

void MenuModelTree::send(int what)
{
    switch(what)
    {
        case 0: // send logs
        {
            emit sendLogs();
            break;
        }
        default:
        {
            emit sendFinished(false, "Ошибка, неизвестный параметр для отправки!");
        }
    }
}

bool MenuModelTree::isRootItem(const QModelIndex &index) const
{
    bool rc {index.isValid()};

    if (rc)
    {
        MenuItemTree *item = static_cast<MenuItemTree*>(index.internalPointer());
        rc = (item != nullptr) && (item->m_parentItem->m_pos < 0);
    }

    return rc;
}

void MenuModelTree::onDreamkasDisplayConnectChanged(const bool isConnected)
{
    setItemApplied(MENU_ID::DREAMKAS_DISPLAY, isConnected);
}

void MenuModelTree::onScalesConnected()
{
    setItemApplied(MENU_ID::CONNECT_SCALES,true);
}

void MenuModelTree::onScalesDisconnected()
{
    setItemApplied(MENU_ID::CONNECT_SCALES,false);

}

void MenuModelTree::onCoreSent(bool status, const QString &message)
{
    emit sendFinished(status, message);
}

void MenuModelTree::onModelShiftStateChanged(bool isShiftOpened)
{
    setIsShiftOpened(isShiftOpened);
}

void MenuModelTree::onModelPrinterConnectChanged(bool isPrinterConnected)
{
    setIsPrinterConnected(isPrinterConnected);
}

void MenuModelTree::onModelPrinterRegisteredChanged(bool isPrinterRegistered)
{
    setIsPrinterRegistered(isPrinterRegistered);
}

void MenuModelTree::onModelItemsVisibleChanged(const QList<MENU_ID> &idList, const bool visible)
{
    visible ? menuSetVisibleInvItems(idList, {}) : menuSetVisibleInvItems({}, idList);
}

void MenuModelTree::onModelItemsAppliedChanged(const QList<MENU_ID> &idList, const bool applied)
{
    for (const auto &id : idList)
    {
        setItemApplied(id, applied);
    }
}

void MenuModelTree::onOpenPopup(int popupType, const QString &mess, const QStringList &list)
{
    popupList_ = list;
    emit popupListChanged();
    emit openPopup(popupType, mess, "");
}
