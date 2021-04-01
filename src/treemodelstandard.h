#ifndef TREEMODELSTANDARD_H
#define TREEMODELSTANDARD_H

#include <QStandardItemModel>

class TreeModelStandard : public QStandardItemModel
{
    Q_OBJECT
public:
    explicit TreeModelStandard(QObject *parent = nullptr);

signals:

};

#endif // TREEMODELSTANDARD_H
