#include "include/treemodel.h"
#include <QDebug>

TreeItem::TreeItem(const QVector<QVariant> &data, TreeItem *parentItem) :
    m_itemData(data),
    m_parentItem(parentItem)
{

}

TreeItem::~TreeItem()
{
    qDeleteAll(m_childItems);
}

void TreeItem::appendChild(TreeItem *child)
{
    m_childItems.append(child);
}

TreeItem *TreeItem::child(int row)
{
    if (row < 0 || row >= m_childItems.size() )
        return nullptr;

    return  m_childItems.at(row);
}

int TreeItem::childCount() const
{
    return m_childItems.count();
}

int TreeItem::columnCount() const
{
    return m_itemData.count();
}

QVariant TreeItem::data(int column) const
{
    if (column < 0 || column >= m_itemData.size() )
        return QVariant();

    return m_itemData.at(column);
}

int TreeItem::row() const
{
    if (m_parentItem)
        return m_parentItem->m_childItems.indexOf(const_cast<TreeItem*>(this));

    return 0;
}

TreeItem *TreeItem::parentItem()
{
    return m_parentItem;
}



TreeModel::TreeModel(const QString &data, QObject *parent) : QAbstractItemModel(parent)
{
    m_rootItem = new TreeItem( {tr("Title"), tr("Summary")} );
    setupModelData(data.split('\n'), m_rootItem);


//    QVector<TreeItem*> parents =

//    m_rootItem->appendChild(new TreeItem(QVector<QVariant>{"Формирование чека"}, m_rootItem));

//    parents.last()->appendChild(new TreeItem(columnData, parents.last()));
}

TreeModel::~TreeModel()
{
    delete m_rootItem;
}

QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if ( !hasIndex(row, column, parent) )
        return QModelIndex();

    TreeItem *parentItem;

    if (!parent.isValid())
        parentItem = m_rootItem;
    else
        parentItem = static_cast<TreeItem*>(parent.internalPointer());

    TreeItem *childItem = parentItem->child(row);

    if (childItem)
        return createIndex(row, column, childItem);

    return QModelIndex();
}

QModelIndex TreeModel::parent(const QModelIndex &child) const
{
    if ( !child.isValid() )
        return QModelIndex();

    TreeItem *childItem     = static_cast<TreeItem*>(child.internalPointer());
    TreeItem *parentItem    = childItem->parentItem();

    if (parentItem == m_rootItem)
        return QModelIndex();

    return createIndex(parentItem->row(), 0, parentItem);
}

int TreeModel::rowCount(const QModelIndex &parent) const
{
    TreeItem *parentItem;

    if (parent.column() > 0)
        return 0;

    if (!parent.isValid())
        parentItem = m_rootItem;
    else
        parentItem = static_cast<TreeItem*>(parent.internalPointer());

    return parentItem->childCount();
}

int TreeModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return static_cast<TreeItem*>(parent.internalPointer())->columnCount();
    return m_rootItem->columnCount();
}

QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (role != Qt::DisplayRole)
        return QVariant();

    TreeItem *item = static_cast<TreeItem*>(index.internalPointer());

    return item->data(index.column());
}

QVariant TreeModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
        return m_rootItem->data(section);

    return QVariant();
}

Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractItemModel::flags(index);
}

void TreeModel::setupModelData(const QStringList &lines, TreeItem *parent)
{
    qDebug() << "Parent: " << parent;

    QVector<TreeItem*> parents;
    QVector<int> indentations;
    parents << parent;
    indentations << 0;

    int number = 0;

    while (number < lines.count())
    {
        qDebug() << "Vector Parents: " << parents;

        int position = 0;
        while (position < lines[number].length()) {
            if (lines[number].at(position) != ' ')
                break;
            position++;
        }

        const QString lineData = lines[number].mid(position).trimmed();

        qDebug() << "LineData: " << lineData;

        if (!lineData.isEmpty()) {
            // Read the column data from the rest of the line.
            const QStringList columnStrings =
                    lineData.split(QLatin1Char('\t'), QString::SkipEmptyParts);
            QVector<QVariant> columnData;
            columnData.reserve(columnStrings.count());

            for (const QString &columnString : columnStrings)
                columnData << columnString;

            if (position > indentations.last())
            {
                qDebug() << "1.";
                // The last child of the current parent is now the new parent
                // unless the current parent has no children.

                if (parents.last()->childCount() > 0)
                {
                    qDebug() << "2.";
                    qDebug() << "That << to parents: " << parents.last()->child(parents.last()->childCount()-1);
                    parents << parents.last()->child(parents.last()->childCount()-1);
                    indentations << position;
                }
            }
            else
            {
                qDebug() << "3.";
                while ( (position < indentations.last()) && (parents.count() > 0) )
                {
                    parents.pop_back();
                    indentations.pop_back();
                }
            }

            qDebug() << "That append: 1) columnData: " << columnData << ", parents.last: " << parents.last();

            // Append a new item to the current parent's list of children.
            parents.last()->appendChild(new TreeItem(columnData, parents.last()));
        }
        ++number;
    }
}

//QHash<int, QByteArray> MenuModel::roleNames() const
//{
//    QHash<int, QByteArray> roles;
//    roles[KeyRole] = "keyData";
//    roles[ValueRole] = "valueData";
//    return roles;
//}
