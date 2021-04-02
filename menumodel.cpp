#include "menumodel.h"

#include <QDebug>

MenuItem::MenuItem(const QString &data, MenuItem *parentItem) :
    m_itemData(data),
    m_parentItem(parentItem)
{
    m_parentItem->appendChild(this);
}


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

//int MenuItem::columnCount() const
//{
//    return m_itemData.count();
//}

QVariant MenuItem::data() const
{
//    if (column < 0 || column >= m_itemData.size() )
//        return QVariant();

    return m_itemData/*.at(column)*/;
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
//    m_rootItem->appendChild(new MenuItem("Check", m_rootItem));
//    m_rootItem->appendChild(new MenuItem("Check", m_rootItem));
//    qDebug() << m_rootItem->childCount();
//    setupModelData(data.split('\n'), m_rootItem);

    MenuItem *check = new MenuItem(QString("Check"), m_rootItem);
    MenuItem *smena = new MenuItem(QString("Smena"), m_rootItem);



    if (smena)
    {
        MenuItem *openCloseSmena = new MenuItem(QString("open/close"), smena);
        MenuItem *xReport = new MenuItem(QString("X-report"), smena);
    }


//    QVector<MenuItem*> parents;
//    parents << check << smena;

//    for(auto &parent : parents)
//        m_rootItem->appendChild(parent);




//    m_rootItem->appendChild(new MenuItem(QVector<QVariant>{ ("Check") }, m_rootItem));
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
//    if (parent.isValid())
//        return static_cast<MenuItem*>(parent.internalPointer())->columnCount();
//    return m_rootItem->columnCount();
    return 1;
}

QVariant MenuModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();


    switch (role)
    {
        case Qt::DisplayRole:
        {
            MenuItem *item = static_cast<MenuItem*>(index.internalPointer());
            return item->data(/*index.column()*/);
        }
//        case CustomRoles::NameRole:    return QString(EncodeConvertor::CP866toUTF8(menuItems.at(index.row()).name).c_str());
//        case CustomRoles::VisibleRole: return menuItems.at(index.row()).visible;
//        case CustomRoles::AppliedRole: return menuItems.at(index.row()).applied;
        default:
            return QVariant();
    }


//    if (role != Qt::DisplayRole)
//        return QVariant();

//    MenuItem *item = static_cast<MenuItem*>(index.internalPointer());

//    return item->data(index.column());
}

QVariant MenuModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    Q_UNUSED(section)

    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
        return m_rootItem->data(/*section*/);

    return QVariant();
}

Qt::ItemFlags MenuModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractItemModel::flags(index);
}

QHash<int, QByteArray> MenuModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles[CustomRoles::NameRole] =  "modelName_";
    roles[CustomRoles::VisibleRole] = "modelVisible_";
    roles[CustomRoles::AppliedRole] = "modelApplied_";
    return roles;
}

void MenuModel::setupModelData(const QStringList &lines, MenuItem *parent)
{
    qDebug() << "Parent: " << parent;

    QVector<MenuItem*> parents;
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
//            parents.last()->appendChild(new MenuItem(columnData, parents.last()));
        }
        ++number;
    }
}

