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
            width: 0.33 * parent.width
            height: 0.93 * width
            anchors {
                top: parent.top
                topMargin: height
                horizontalCenter: parent.horizontalCenter
            }
            source: "qrc:/img/sale/printer.png"
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

            text: qsTr("Не подключена ККТ")
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

            text: qsTr("Для продолжения работы вам\nнеобходимо подключить ККТ")
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
            buttonTxt: qsTr("ПОДКЛЮЧИТЬ ККТ")
            fontSize: 0.33 * height
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"

            onClicked: {
                openPage("qrc:/qml/pages/subpages/printer/ChoosePrinterType.qml")
            }
        }
    }
}
