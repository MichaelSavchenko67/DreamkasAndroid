#include "menumodel.h"

#include <QDebug>

MenuItem::~MenuItem()
{
    qDeleteAll(m_childItems);
}

void MenuItem::appendChild(MenuItem *child)
{
    m_childItems.append(child);
}

MenuItem *MenuItem::child(int row)
{
    if (row < 0 || row >= m_childItems.size() )
        return nullptr;

    return  m_childItems.at(row);
}

int MenuItem::childCount() const
{
    return m_childItems.count();
}

int MenuItem::columnCount() const
{
    return 1;//m_itemData.count();
}

QVariant MenuItem::data() const
{
    return name;
}

int MenuItem::row() const
{
    if (m_parentItem)
        return m_parentItem->m_childItems.indexOf(const_cast<MenuItem*>(this));

    return 0;
}

MenuItem *MenuItem::parentItem()
{
    return m_parentItem;
}


MenuModel::MenuModel(QObject *parent) : QAbstractItemModel(parent)
{
    m_rootItem = new MenuItem();


    m_rootItem->appendChild(new MenuItem("Check", m_rootItem));
    m_rootItem->appendChild(new MenuItem("Check", m_rootItem));

    qDebug() << m_rootItem->childCount();

}

MenuModel::~MenuModel()
{
    delete m_rootItem;
}

QModelIndex MenuModel::index(int row, int column, const QModelIndex &parent) const
{
    if ( !hasIndex(row, column, parent) )
        return QModelIndex();

    MenuItem *parentItem;

    if (!parent.isValid())
        parentItem = m_rootItem;
    else
        parentItem = static_cast<MenuItem*>(parent.internalPointer());

    MenuItem *childItem = parentItem->child(row);

    if (childItem)
        return createIndex(row, column, childItem);

    return QModelIndex();
}

QModelIndex MenuModel::parent(const QModelIndex &child) const
{
    if ( !child.isValid() )
        return QModelIndex();

    MenuItem *childItem     = static_cast<MenuItem*>(child.internalPointer());
    MenuItem *parentItem    = childItem->parentItem();

    if (parentItem == m_rootItem)
        return QModelIndex();

    return createIndex(parentItem->row(), 0, parentItem);
}

int MenuModel::rowCount(const QModelIndex &parent) const
{
    MenuItem *parentItem;

    if (parent.column() > 0)
        return 0;

    if (!parent.isValid())
        parentItem = m_rootItem;
    else
        parentItem = static_cast<MenuItem*>(parent.internalPointer());

    return parentItem->childCount();
}

int MenuModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return static_cast<MenuItem*>(parent.internalPointer())->columnCount();
    return m_rootItem->columnCount();
}

QVariant MenuModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (role != Qt::DisplayRole)
        return QVariant();

    MenuItem *item = static_cast<MenuItem*>(index.internalPointer());

    return item->data();
}

QVariant MenuModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    Q_UNUSED(section)

    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
        return m_rootItem->data();

    return QVariant();
}

Qt::ItemFlags MenuModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractItemModel::flags(index);
}
