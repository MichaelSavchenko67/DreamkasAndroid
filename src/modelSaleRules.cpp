#include "include/modelSaleRules.h"

QList<ModelSaleRules::SaleRule_t> ModelSaleRules::m_salesRules = {
    {ModelSaleRules::SaleRule_t(QStringLiteral("Облачная касса"), QStringLiteral("Фискализация чеков будет происходить на облачной кассе, подключенной квашему Кабинету Дримкас"), false)},
    {ModelSaleRules::SaleRule_t(QStringLiteral("Облачная asd"), QStringLiteral("Фискализация чеков ddd"), true)},
    {ModelSaleRules::SaleRule_t(QStringLiteral("Облачная "), QStringLiteral("Фискализация чеков fff"), false)}
};

int ModelSaleRules::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_salesRules.count();
}

QVariant ModelSaleRules::data(const QModelIndex &index, int role) const
{
    if ( !index.isValid() || index.row() < 0 || index.row() >= m_salesRules.count() )
        return QVariant();

    switch (role)
    {
        case SaleRulesRole::TextName:      return m_salesRules.at(index.row()).m_textName;
        case SaleRulesRole::TextInfo:      return m_salesRules.at(index.row()).m_textInfo;
        case SaleRulesRole::State:         return m_salesRules.at(index.row()).m_state;
        default:            break;
    }
    return QVariant();
}

QHash<int, QByteArray> ModelSaleRules::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[SaleRulesRole::TextName]      = "textName_";
    roles[SaleRulesRole::TextInfo]      = "textInfo_";
    roles[SaleRulesRole::State]         = "state_";
    return roles;
}

void ModelSaleRules::setState(const int row, const bool state)
{
    if ( row < 0 || row >= m_salesRules.count() )
        return;

    m_salesRules[row].m_state = state;
}
