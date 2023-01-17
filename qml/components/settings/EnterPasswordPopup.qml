import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: enterPasswordPopup

    signal entered()

    property var networkName: "Dreamkas_Free Wi-Fi"
    property bool passwordView: false
    property var enteredPassword: ""

    width: 0.9 * parent.width
    height: 0.9 * width
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
                height: 0.038 * parent.height
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                enterPasswordPopup.close()
            }
        }

        Column {
            id: rootColumn
            width: parent.width
            height: parent.height - exitButton.height
            anchors.top: exitButton.bottom
            spacing: 2 * title.font.pixelSize
            leftPadding: 0.5 * spacing

            Column {
                width: parent.width - 2 * parent.leftPadding
                height: parent.height - connectionButton.height - 2 * parent.spacing
                spacing: title.font.pixelSize

                Label {
                    id: title
                    width: parent.width
                    text: qsTr(networkName)
                    font {
                        pixelSize: 0.08 * enterPasswordPopup.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Bold
                        bold: true
                    }
                    clip: true
                    elide: "ElideRight"
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }

                Column {
                    id: passwordFrame
                    width: parent.width
                    height: parent.height - title.contentHeight - parent.spacing
                    spacing: 0.25 * parent.spacing

                    Label {
                        width: parent.width
                        text: "Пароль"
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
                            id: password
                            width: parent.width - eyeButton.implicitBackgroundWidth + rootColumn.leftPadding
                            placeholderText: "Введите пароль"
                            placeholderTextColor: "#979797"
                            font {
                                pixelSize: 0.8 * title.font.pixelSize
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "#0064B4"
                            echoMode: passwordView ? TextInput.Normal : TextInput.Password
                        }

                        ToolButton {
                            id: eyeButton
                            scale: 0.5
                            anchors.verticalCenter: password.verticalCenter
                            enabled: (password.text.length > 0)
                            contentItem: Image {
                                source: passwordView ? "qrc:/ico/settings/eye.png" : "qrc:/ico/settings/eye_off.png"
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
                                passwordView = !passwordView
                            }
                        }
                    }
                }
            }

            SaleComponents.Button_1 {
                id: connectionButton
                width: passwordFrame.width
                height: 0.18 * width
                enabled: eyeButton.enabled
                opacity: enabled ? 1 : 0.6
                borderWidth: 0
                backRadius: 8
                buttonTxt: qsTr("ПОДКЛЮЧИТЬ")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    enteredPassword = password.text
                    entered()
                    enterPasswordPopup.close()
                }
            }
        }
    }
}
