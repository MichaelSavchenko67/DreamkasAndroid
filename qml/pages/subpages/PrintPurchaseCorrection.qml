import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/pages/subpages" as Subpages

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    contentData: Subpages.Operation {
        id: printPurchaseCorrection
        anchors.fill: parent
        focus: true
        operation: "Печать чека\nкоррекции"
        complite: true
        resMsg: "Чек коррекции\nнапечатан"
    }
}
