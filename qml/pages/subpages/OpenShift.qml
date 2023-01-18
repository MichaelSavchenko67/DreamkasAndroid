import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/qml/pages/subpages" as Subpages

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    contentData: Subpages.Operation {
        id: openShift
        anchors.fill: parent
        focus: true
        operation: "Открытие смены"
        complite: true
        resMsg: "Смена открыта"
    }
}
