import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

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
