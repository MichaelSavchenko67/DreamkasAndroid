#include "include/cashlessPayModel.h"

const QList<QPair<uint, QString>> CashlessPayModel::m_payTypes = {{CASHLESS_TYPE::CASHLESS_TYPE_PINPAD, "Банковская карта"},
                                                                  {CASHLESS_TYPE::CASHLESS_TYPE_PAY_QR_SBERBANK, "Плати QR от Сбера"},
                                                                  {CASHLESS_TYPE::CASHLESS_TYPE_PAY_CHECKING_ACCOUNT, "Оплата на Р/С"}};

int CashlessPayModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
    {
        return 0;
    }
    return m_payTypes.count();
}

QHash<int, QByteArray> CashlessPayModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[IdRole] = "modelId";
    roles[NameRole] = "modelName";
    return roles;
}

QVariant CashlessPayModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || (index.row() < 0) || (index.row() >= m_payTypes.count()))
    {
        return QVariant();
    }

    switch (role)
    {
        case IdRole: return m_payTypes.at(index.row()).first;
        case NameRole: return m_payTypes.at(index.row()).second;
    }
    return QVariant();
}
