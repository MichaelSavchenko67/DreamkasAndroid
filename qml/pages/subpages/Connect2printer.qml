import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: connect2printerPage
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            console.log("[Connect2printer.qml]\tfocus changed: " + focus)
            setMainPageTitle("Подключение ККТ")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    Column {
        anchors {
           fill: parent
           leftMargin: 0.044 * connect2printerPage.width
           topMargin: 2 * 0.044 * connect2printerPage.width
        }

        Label {
            id: title
            text: isPrinterConnected ? "Подключенное устройство" : "Устройство для подключения"
            font {
                pixelSize: ip.font.pixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            clip: true
            elide: "ElideRight"
        }

        Row {
            width: parent.width
            anchors {
                top: title.bottom
                topMargin: 0.044 * connect2printerPage.width
            }

            Label {
                id: ipTitle
                width: 0.25 * parent.width
                anchors.verticalCenter: ip.verticalCenter
                text: "IP-адрес:"
                font: ip.font
                clip: true
                elide: "ElideRight"
            }

            TextField {
                id: ip
                width: 0.5 * parent.width
                anchors.left: ipTitle.right
                enabled: !isPrinterConnected
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
                color: "black"
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
                    border.width: 2
                    border.color: ip.focus ? "#5C7490" : "gray"
                    color: "#FFFFFF"
                    radius: 5
                }
            }
        }
    }

    SaleComponents.Button_1 {
        anchors.centerIn: parent
        anchors.horizontalCenter: parent.horizontalCenter
        width: 0.9 * parent.width
        height: 0.16 * width
        enabled: isPrinterConnected || ip.acceptableInput
        borderWidth: 0
        backRadius: 5
        buttonTxt: qsTr(isPrinterConnected ? "ОТКЛЮЧИТЬ" : "ПОДКЛЮЧИТЬ")
        fontSize: 0.27 * height
        buttonTxtColor: "white"
        pushUpColor: enabled ? "#415A77" : "#BDC3C7"
        pushDownColor: "#004075"
        onClicked: {
            if (isPrinterConnected) {
                console.log("[Connect2printer.qml]\tdisconnect printer with ip: " + ip.displayText)
                root.openDisconnectPrinterDialog()
            } else {
                console.log("[Connect2printer.qml]\tconnect to printer with ip: " + ip.displayText)
                openPage("qrc:/qml/pages/subpages/ConnectPrinter.qml")
            }
        }
    }
}
