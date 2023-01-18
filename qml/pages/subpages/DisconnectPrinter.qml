import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/qml/pages/subpages" as Subpages

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    contentData: Subpages.Operation {
        id: disconnectPrinter
        anchors.fill: parent
        focus: true
        operation: "Отключение ККТ"
        complite: true
        resMsg: "ККТ отключена"
    }
}
