#ifndef CASHLESSPAYMODEL_H
#define CASHLESSPAYMODEL_H
#include <QObject>
#include <QtGlobal>
#include <QQmlEngine>
#include <QAbstractListModel>
/**
 * @brief The CashlessPayModel class
 */
class CashlessPayModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit CashlessPayModel(QObject* parent = nullptr) : QAbstractListModel(parent) {}
    /**
     * @brief The Roles enum
     */
    enum Roles
    {
        IdRole = Qt::UserRole + 1,
        NameRole
    };
    /**
     * @brief The CASHLESS_TYPE enum
     */
    enum CASHLESS_TYPE: uint
    {
        CASHLESS_TYPE_PINPAD = 0,
        CASHLESS_TYPE_PAY_QR_SBERBANK
    };
    Q_ENUM(CASHLESS_TYPE)

    static void declareQML() {qmlRegisterType<CashlessPayModel>("CashlessPayModel", 1, 0, "CashlessPayModelEnums");}

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
private:
    static const QList<QPair<uint, QString>> m_payTypes;    //
};
#endif // CASHLESSPAYMODEL_H
