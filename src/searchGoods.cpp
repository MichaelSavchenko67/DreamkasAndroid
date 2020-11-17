#include "include/searchGoods.h"

using namespace GUI;

void FoundGoodsElement::setName(QString name)
{
    if (_name == name) {
        return;
    }

    _name = name;

    emit nameChanged(_name);
}

void FoundGoodsElement::setBarcode(QString barcode)
{
    if (_barcode == barcode) {
        return;
    }

    _barcode = barcode;

    emit barcodeChanged(_barcode);
}

FoundGoods::FoundGoods(QQmlApplicationEngine *engine, QObject *parent) : QObject(parent)
{
    QQmlComponent comp(engine, QUrl("qrc:/qml/pages/SalePage.qml"));
    QObject *salePageQML = comp.create();
    if (salePageQML)
    {
        qDebug() << "Ptr salePageQML  = " << salePageQML;
        QObject *addGoodsButton = salePageQML->findChild<QObject*>("addGoodsButton");
        if (addGoodsButton)
        {
            qDebug() << "Ptr addGoodsButton = " << addGoodsButton;
            QObject::connect(addGoodsButton, SIGNAL(addGoods()), this, SLOT(searchGoods()));
            qDebug() << "Create FoundGoods [SLOT] for QML success";
        }
    }

    qDebug() << "This = " << this;
}

void FoundGoods::searchGoods()
{
    qDebug() << "searchGoods: SLOT C++ FINE!";
}
