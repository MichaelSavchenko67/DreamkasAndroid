#include "include/modelDemoSwipe.h"

const QList<ModelDemoSwipe::PagePromo_t> ModelDemoSwipe::m_pagesPromo = {
    { ModelDemoSwipe::PagePromo_t(QStringLiteral("qrc:/img/demo/first.png"), "В демо-режиме вы можете:", "Добавлять товары в чек по поиску в общей базе, "
      "при сканировании штрихкода, по свободной цене;\n\nВыбирать товары в тематических разделах;\n\nПроводить тестовые продажи.", "Начать")                },
    { ModelDemoSwipe::PagePromo_t(QStringLiteral("qrc:/img/demo/second.png"), "Начнём!", "В этой вкладке вы можете пробивать товары по свободной цене", "Далее")},
    { ModelDemoSwipe::PagePromo_t(QStringLiteral("qrc:/img/demo/third.png"), "", "Вы можете найти товар по названию или штрихкоду", "Далее")},
    { ModelDemoSwipe::PagePromo_t(QStringLiteral("qrc:/img/demo/fourth.png"), "", "Заходите в разделы для быстрого доступа к товарам", "Далее")},
    { ModelDemoSwipe::PagePromo_t(QStringLiteral("qrc:/img/demo/fifth.png"), "", "Добавляйте новые разделы для группировки товаров", "Далее")},
    { ModelDemoSwipe::PagePromo_t(QStringLiteral("qrc:/img/demo/sixth.png"), "", "Чтобы оформить возврат, поменяйте режим", "Далее")},
    { ModelDemoSwipe::PagePromo_t(QStringLiteral("qrc:/img/demo/seventh.png"), "", "Добавленные товары можно посмотреть в чеке", "Далее")},
    { ModelDemoSwipe::PagePromo_t(QStringLiteral("qrc:/img/demo/eighth.png"), "Отлично!", "А теперь попробуйте провести тестовую продажу", "Перейти к продаже")},
};

ModelDemoSwipe::ModelDemoSwipe(QObject *parent) : QAbstractListModel(parent)
{

}

//QModelIndex ModelDemoSwipe::index(int row, int column, const QModelIndex &parent) const
//{

//}

//QModelIndex ModelDemoSwipe::parent(const QModelIndex &child) const
//{

//}

int ModelDemoSwipe::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_pagesPromo.count();
}

//int ModelDemoSwipe::columnCount(const QModelIndex &parent) const
//{
//}

QVariant ModelDemoSwipe::data(const QModelIndex &index, int role) const
{
    if ( !index.isValid() || index.row() < 0 || index.row() >= m_pagesPromo.count() )
        return QVariant();

    switch (role)
    {
        case PathImage:     return m_pagesPromo.at(index.row()).m_pathImage;
        case TextNote:      return m_pagesPromo.at(index.row()).m_textNote;
        case TextInfo:      return m_pagesPromo.at(index.row()).m_textInfo;
        case TextButton:    return m_pagesPromo.at(index.row()).m_textButton;
        default:            return QVariant();
    }
}

QHash<int, QByteArray> ModelDemoSwipe::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[PagePromoRole::PathImage]     = "pathImage_";
    roles[PagePromoRole::TextNote]      = "textNote_";
    roles[PagePromoRole::TextInfo]      = "textInfo_";
    roles[PagePromoRole::TextButton]    = "textButton_";
    return roles;
}
