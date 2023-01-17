import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/qml/pages/subpages" as Subpages

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    contentData: Subpages.Operation {
        id: connectPrinter
        anchors.fill: parent
        focus: true
        operation: "Подключение ККТ"
        complite: true
        resMsg: "ККТ подключена"
    }
}
