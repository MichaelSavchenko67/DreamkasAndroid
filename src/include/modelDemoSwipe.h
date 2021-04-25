#ifndef MODELDEMOSWIPE_H
#define MODELDEMOSWIPE_H

#include <QAbstractListModel>

class ModelDemoSwipe : public QAbstractListModel
{
    Q_OBJECT
public:
    /**
     * @brief The PagePromo_t struct - структура описывающая одну страницу промо демо-режима.
     */
    struct PagePromo_t
    {
        QString m_pathImage;
        QString m_textNote;
        QString m_textInfo;
        QString m_textButton;

        explicit PagePromo_t(const QString &pathImage   = QString{}, const QString &textNote    = QString{},
                             const QString &textInfo    = QString{}, const QString &textButton  = QString{}) :  m_pathImage(pathImage), m_textNote(textNote),
                                                                                                                m_textInfo(textInfo) , m_textButton(textButton) {}
    };

    enum PagePromoRole
    {
        PathImage = Qt::UserRole + 1,
        TextNote,
        TextInfo,
        TextButton
    };

    explicit ModelDemoSwipe(QObject *parent = nullptr);

//    QModelIndex index(int row, int column, const QModelIndex &parent) const override;
//    QModelIndex parent(const QModelIndex &child) const override;
    int rowCount(const QModelIndex &parent) const override;
//    int columnCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

signals:


private:
    static const QList<PagePromo_t> m_pagesPromo;

};

#endif // MODELDEMOSWIPE_H
