import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    implicitHeight: parent.height
    implicitWidth: parent.width
    anchors.fill: parent

    contentData: Column {
        anchors.fill: parent

        Image {
            id: cashierImg
            height: 0.4 * parent.height
            width: 0.465 * height
            anchors {
                top: parent.top
                topMargin: 0.33 * height
                horizontalCenter: parent.horizontalCenter
            }
            source: "qrc:/img/sale/cashier.png"
        }

        Text {
            id: title
            width:  0.71 * parent.width
            height: 0.11 * width
            anchors {
                top: cashierImg.bottom
                topMargin: 0.78 * height
                horizontalCenter: cashierImg.horizontalCenter
            }

            text: qsTr("Открытие смены")
            font {
                pixelSize: 0.8 * height
                family: "Roboto"
                styleName: "normal"
                weight: Font.Bold
                bold: true
            }
            clip: true
            color: "black"
            elide: Text.ElideRight
            horizontalAlignment: Qt.AlignCenter
            verticalAlignment: Qt.AlignVCenter
        }

        Text {
            id: msg2user
            width:  title.width
            anchors {
                top: title.bottom
                topMargin: 0.5 * title.anchors.topMargin
                horizontalCenter: title.horizontalCenter
            }

            text: qsTr("Для продолжения работы вам\nнеобходимо открыть смену")
            font {
                pixelSize: 0.56 * title.font.pixelSize
                family: title.font.family
                styleName: title.font.styleName
                weight: Font.Thin
            }
            clip: true
            color: "black"
            elide: title.elide
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            horizontalAlignment: title.horizontalAlignment
            verticalAlignment: title.verticalAlignment
        }

        SaleComponents.Button_1 {
            width: 0.5 * parent.width
            height: 0.25 * width
            anchors {
                top: msg2user.bottom
                topMargin: msg2user.anchors.topMargin
                horizontalCenter: title.horizontalCenter
            }
            borderWidth: 0
            backRadius: 5
            buttonTxt: qsTr("ОТКРЫТЬ СМЕНУ")
            fontSize: 0.33 * height
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            action: openShift
        }
    }
}
