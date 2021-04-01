#ifndef MENUMODEL_H
#define MENUMODEL_H

#include <QAbstractItemModel>

class MenuItem
{
public:
    explicit MenuItem(const QString &name_ = "UNKNOWN",
                      const bool visible_ = true,
                      const bool applied_ = false,
                      MenuItem *parentItem = nullptr) : m_parentItem(parentItem), name(name_), visible(visible_), applied(applied_) {}
    ~MenuItem();

    void appendChild(MenuItem *child);

    MenuItem *child(int row);
    int childCount() const;
    int columnCount() const;
    QVariant data() const;
    int row() const;
    MenuItem *parentItem();

private:
    QVector<MenuItem*> m_childItems;
    MenuItem *m_parentItem;

    QString name;   // наименование пункта меню
    bool visible;       // флаг видимости пункта меню
    bool applied;       // флаг применения
};

class MenuModel : public QAbstractItemModel
{
    Q_OBJECT
public:
    explicit MenuModel(QObject *parent = nullptr);
    ~MenuModel();

    QModelIndex index(int row, int column, const QModelIndex &parent) const override;
    QModelIndex parent(const QModelIndex &child) const override;
    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

signals:

private:
    MenuItem *m_rootItem;
};

#endif // MENUMODEL_H
