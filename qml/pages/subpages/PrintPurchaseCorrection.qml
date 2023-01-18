import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
