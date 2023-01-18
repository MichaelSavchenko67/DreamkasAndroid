import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/qml/pages/subpages" as Subpages

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    contentData: Subpages.Operation {
        id: connect2Cabinet
        anchors.fill: parent
        focus: true
        operation: "Отключение от Кабинета"
        complite: true
        resMsg: "Отключено от Кабинета"
    }
}
