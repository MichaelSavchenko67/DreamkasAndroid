#include "treemodelstandard.h"

TreeModelStandard::TreeModelStandard(QObject *parent) : QStandardItemModel(parent)
{
    setColumnCount(1);
    QStandardItem *rootItem = invisibleRootItem();

    QStandardItem *gr1 = new QStandardItem;
    QStandardItem *gr2 = new QStandardItem;

    QStandardItem *vl1 = new QStandardItem;
    QStandardItem *vl2 = new QStandardItem;
    QStandardItem *vl3 = new QStandardItem;
    QStandardItem *vl4 = new QStandardItem;
    QStandardItem *vl5 = new QStandardItem;

    gr1->setText("Gr 1");
    gr2->setText("Gr 2");

    vl1->setText("Vl 1");
    vl2->setText("Vl 2");
    vl3->setText("Vl 3");
    vl4->setText("Vl 4");
    vl5->setText("Vl 5");

    gr1->appendRow(vl1);
    gr1->appendRow(vl2);

    gr2->appendRow(vl3);
    gr2->appendRow(vl4);
    gr2->appendRow(vl5);

    rootItem->appendRow(gr1);
    rootItem->appendRow(gr2);
}
