#ifndef MODELSALERULES_H
#define MODELSALERULES_H

#include <QAbstractListModel>

/**
 * @brief The modelSaleRules class - Класс модели правил торговли для заполнения данных и отображения в QML на страницу SalesRules.qml
 */
class ModelSaleRules : public QAbstractListModel
{
    Q_OBJECT
public:
    /**
     * @brief The SaleRule_t struct - структура описывающая один элемент правил торговли.
     */
    struct SaleRule_t
    {
        QString m_textName;
        QString m_textInfo;
        bool    m_state;

        explicit SaleRule_t(const QString &textName = QString{}, const QString &textInfo = QString{}, const bool state = false) : m_textName(textName), m_textInfo(textInfo), m_state(state) {}
    };

    /**
     * @brief The SaleRulesRole enum для использование в QML.
     */
    enum SaleRulesRole
    {
        TextName = Qt::UserRole + 1,    //!< Название пункта.
        TextInfo,                       //!< Текст Информации.
        State                           //!< Состояние (вкл/выкл).
    };

    explicit ModelSaleRules(QObject *parent = nullptr) : QAbstractListModel(parent) {}

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void setState(const int row, bool state);
private:
    static QList<SaleRule_t> m_salesRules; //!< Элементы правил торговли.
};

#endif // MODELSALERULES_H
