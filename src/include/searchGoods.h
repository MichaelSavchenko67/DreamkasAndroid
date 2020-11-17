#ifndef SEARCHGOODS_H
#define SEARCHGOODS_H
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QDebug>
#include <QString>

#include <iostream>

namespace GUI
{
    class FoundGoodsElement : public QObject
    {
        Q_OBJECT
        Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
        Q_PROPERTY(QString barcode READ barcode WRITE setBarcode NOTIFY barcodeChanged)
    public:
        explicit FoundGoodsElement(QObject *parent = 0) : QObject(parent) {}

        QString name() const {return _name;}
        void setName(QString name);
        QString barcode() const {return _barcode;};
        void setBarcode(QString text);
    signals:
        void nameChanged(QString name);
        void barcodeChanged(QString barcode);
    private:
        QString _name;
        QString _barcode;
    };


    class FoundGoods : public QObject
    {
        Q_OBJECT
    public:
        explicit FoundGoods(QQmlApplicationEngine *engine, QObject *parent = 0);
    signals:
        void sendFoundGoods();
    public slots:
        void searchGoods();
    };
}
#endif // SEARCHGOODS_H
