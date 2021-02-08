import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents

Page {
    anchors.fill: parent

    property var email: "m.savchenko@dreamkas.ru"

    contentData: Rectangle {
        anchors.fill: parent

        Column {
            anchors.fill: parent
            spacing: 0.2 * statusIco.height
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 1.25 * statusIco.height
            }

            Image {
                id: statusIco
                width: 0.22 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/ico/menu/operation_success.png"
            }

            Label {
                id: statusMsg
                width: 0.82 * parent.width
                height: 0.25 * width
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Подключено к Кабинету\n" + email
                font {
                    pixelSize: 0.25 * height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                elide: Label.ElideRight
                maximumLineCount: 2
                wrapMode: Text.WordWrap
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            SaleComponents.Button_1 {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.18 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr("ОТКЛЮЧИТЬ ОТ КАБИНЕТА")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: enabled ? "#415A77" : "#BDC3C7"
                pushDownColor: "#004075"
                onClicked: {
                    console.log("[CabinetConnection.qml]\tdisconnect")
                    root.openPage("qrc:/qml/pages/subpages/DisconnectCabinet.qml")
                    isCabinetEnable = false
                }
            }

            SaleComponents.Button_1 {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.18 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr("ПОДКЛЮЧИТЬ К ДРУГОМУ КАБИНЕТУ")
                fontSize: 0.27 * height
                buttonTxtColor: clicked ? "#5C7490" : "#206914"
                pushUpColor: "#00FFFFFF"
                pushDownColor: pushUpColor
                onClicked: {
                    console.log("[CabinetConnection.qml]\treconnect")
                    root.openPage("qrc:/qml/pages/subpages/CabinetCodeEnter.qml")
                    isCabinetEnable = true
                }
            }
        }
    }
}
