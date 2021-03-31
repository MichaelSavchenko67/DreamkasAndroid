#ifndef MENUMODEL_H
#define MENUMODEL_H

#include <QAbstractItemModel>
//#include <QStandardItemModel>

class TreeItem
{
public:
    explicit TreeItem(const QVector<QVariant> &data, TreeItem *parentItem = nullptr);
    ~TreeItem();

    void appendChild(TreeItem *child);

    TreeItem *child(int row);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
    int row() const;
    TreeItem *parentItem();

private:
    QVector<TreeItem*> m_childItems;
    QVector<QVariant> m_itemData;
    TreeItem *m_parentItem;
};


class MenuModel : public QAbstractItemModel
{
    Q_OBJECT
public:
    explicit MenuModel(const QString &data, QObject *parent = nullptr);
    ~MenuModel();

    QModelIndex index(int row, int column, const QModelIndex &parent) const override;
    QModelIndex parent(const QModelIndex &child) const override;
    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

private:
    void setupModelData(const QStringList &lines, TreeItem *parent);

    TreeItem *m_rootItem;

    // QAbstractItemModel interface
public:
//    QHash<int, QByteArray> roleNames() const override;
};

#endif // MENUMODEL_H
