import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: connect2printerPage
    Layout.fillHeight: true
    Layout.fillWidth: true

    property bool isUtmConnected: false

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            console.log("[Connect2printer.qml]\tfocus changed: " + focus)
            setMainPageTitle("Подключение ККТ")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    Column {
        width: parent.width
        spacing: title.font.pixelSize

        Label {
            id: title
            text: isUtmConnected ? "Подключенное устройство" : "Введите IP-адрес устройства"
            anchors.horizontalCenter: parent.horizontalCenter
            font {
                pixelSize: ip.font.pixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            clip: true
            elide: "ElideRight"
            topPadding: parent.spacing
        }

        Column {
            width: parent.width
            spacing: 0.25 * parent.spacing

            TextField {
                id: ip
                width: 0.5 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
//                enabled: !isUtmConnected
                placeholderText: "___.___.___.___"
                placeholderTextColor: "black"
                font {
                    pixelSize: 0.1 * ip.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                clip: true
                color: "#0064B4"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator {regExp:  /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ }
                cursorDelegate: Rectangle {
                    visible: ip.cursorVisible
                    color: "#5C7490"
                    width: 2 * ip.cursorRectangle.width
                }
                background: Rectangle {
                    border.width: 0
                    color: "#00FFFFFF"
                }
            }

            Rectangle {
                height: 2 * border.width
                width: title.contentWidth
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#E0E0E0"
                border.color: "#E0E0E0"
                border.width: 1
            }

            TextField {
                id: port
                width: 0.5 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
//                enabled: !isUtmConnected
                placeholderText: ""
                placeholderTextColor: "black"
                font: ip.font
                clip: true
                color: "#0064B4"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator {regExp:  /^()([1-9]|[1-5]?[0-9]{2,4}|6[1-4][0-9]{3}|65[1-4][0-9]{2}|655[1-2][0-9]|6553[1-5])$/ }
                cursorDelegate: Rectangle {
                    visible: port.cursorVisible
                    color: "#5C7490"
                    width: 2 * port.cursorRectangle.width
                }
                background: Rectangle {
                    border.width: 0
                    color: "#00FFFFFF"
                }
            }

            Rectangle {
                height: 2 * border.width
                width: title.contentWidth
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#E0E0E0"
                border.color: "#E0E0E0"
                border.width: 1
            }
        }

        SaleComponents.Button_1 {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 0.9 * parent.width
            height: 0.16 * width
            enabled: isUtmConnected || ip.acceptableInput
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr((isUtmConnected ? "ОТКЛЮЧИТЬ" : "ПОДКЛЮЧИТЬ") +" УСТРОЙСТВО")
            fontSize: 0.27 * height
            buttonTxtColor: "white"
            pushUpColor: enabled ? "#415A77" : "#BDC3C7"
            pushDownColor: "#004075"
            onClicked: {
                if (isUtmConnected) {
                    console.log("[Connect2printer.qml]\tdisconnect printer with ip: " + ip.displayText)
                    root.openDisconnectPrinterDialog()
                } else {
                    console.log("[Connect2printer.qml]\tconnect to printer with ip: " + ip.displayText)
                    openPage("qrc:/qml/pages/subpages/ConnectPrinter.qml")
                }
            }
        }
    }
}
