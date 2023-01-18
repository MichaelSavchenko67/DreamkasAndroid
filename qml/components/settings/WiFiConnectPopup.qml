import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: wifiConnectPopup

    signal connect()

    property string ssid: ""
    property string pswd: ""
    property bool pswdView: false

    width: 0.9 * parent.width
    height: 2 * exitButton.icon.height +
            2 * exitButton.anchors.topMargin +
            rootColumn.height +
            rootColumn.spacing +
            connectionButton.height
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle {
        id: popupFrame
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                topMargin: 0.5 *  0.038 * parent.height
                right: parent.right
                rightMargin: 0.5 *  0.038 * parent.height
            }
            icon {
                color: "#979797"
                width: 0.035 * parent.width
                height: width
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                wifiConnectPopup.close()
            }
        }

        Column {
            id: rootColumn
            width: parent.width - 2 * spacing
            height: title.contentHeight +
                    rootColumn.spacing +
                    ssidTitle.contentHeight +
                    ssidFrame.spacing +
                    2 * ssidField.contentHeight +
                    rootColumn.spacing +
                    pswdTitle.contentHeight +
                    pswdFrame.spacing +
                    2 * pswdField.contentHeight
            anchors {
                top: exitButton.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: qsTr("Настройка WiFi")
                font {
                    pixelSize: 0.08 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                clip: true
                maximumLineCount: 2
                wrapMode: Label.WordWrap
                elide: "ElideRight"
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }

            Column {
                id: ssidFrame
                width: pswdFrame.width
                spacing: pswdFrame.spacing

                Label {
                    id: ssidTitle
                    width: pswdTitle.width
                    text: qsTr("Сеть WiFi")
                    font: pswdTitle.font
                    color: pswdTitle.color
                    clip: pswdTitle.clip
                    elide: pswdTitle.elide
                    horizontalAlignment: pswdTitle.horizontalAlignment
                    verticalAlignment: pswdTitle.verticalAlignment
                }

                Row {
                    width: parent.width

                    TextField {
                        id: ssidField
                        width: parent.width
                        text: ssid
                        placeholderText: qsTr("Введите название WiFi сети")
                        placeholderTextColor: pswdField.placeholderTextColor
                        font: pswdField.font
                        color: pswdField.color
                        onTextChanged: {
                            ssid = text
                        }
                    }
                }
            }

            Column {
                id: pswdFrame
                width: parent.width
                spacing: 0.25 * parent.spacing

                Label {
                    id: pswdTitle
                    width: parent.width
                    text: qsTr("Пароль")
                    font {
                        pixelSize: 0.67 * title.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    clip: true
                    elide: "ElideRight"
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }

                Row {
                    width: parent.width

                    TextField {
                        id: pswdField
                        width: parent.width - eyeButton.implicitBackgroundWidth + rootColumn.leftPadding
                        text: pswd
                        placeholderText: qsTr("Введите пароль")
                        placeholderTextColor: "#979797"
                        font {
                            pixelSize: 0.8 * title.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#0064B4"
                        echoMode: pswdView ? TextInput.Normal : TextInput.Password
                        onTextChanged: {
                            pswd = text
                        }
                    }

                    ToolButton {
                        id: eyeButton
                        scale: 0.5
                        anchors.verticalCenter: pswdField.verticalCenter
                        enabled: (pswdField.text.length > 0)
                        contentItem: Image {
                            source: pswdView ? "qrc:/ico/settings/eye.png" : "qrc:/ico/settings/eye_off.png"
                        }
                        background: Rectangle {
                            implicitWidth: parent.width
                            implicitHeight: parent.height
                            radius: 0.5 * implicitWidth
                            color: Qt.darker("#33333333", eyeButton.enabled && (eyeButton.checked || eyeButton.highlighted) ? 1.5 : 1.0)
                            opacity: enabled ? 1 : 0.3
                            visible: eyeButton.down || (eyeButton.enabled && (eyeButton.checked || eyeButton.highlighted))
                        }
                        onClicked: {
                            pswdView = !pswdView
                        }
                    }
                }
            }
        }

        SaleComponents.Button_1 {
            id: connectionButton
            width: pswdFrame.width
            height: 0.18 * width
            anchors {
                top: rootColumn.bottom
                topMargin: rootColumn.spacing
                horizontalCenter: parent.horizontalCenter
            }
            enabled: (ssid.length > 0) && eyeButton.enabled
            opacity: enabled ? 1 : 0.6
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr("ПОДКЛЮЧИТЬ")
            fontSize: 0.27 * height
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            onClicked: {
                connect()
                wifiConnectPopup.close()
            }
        }
    }
}
