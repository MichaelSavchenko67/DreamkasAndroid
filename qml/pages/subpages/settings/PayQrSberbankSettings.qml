import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: payQrSberbankSettings

    property bool clientSecretView: false

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Плати QR (Сбербанк)")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    ScrollView {
        width: parent.width
        height: parent.height - saveData.height - dataColumn.topPadding
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.vertical.width: 8

        contentData: Column {
            id: dataColumn
            width: parent.width
            spacing: cientIdField.font.pixelSize
            topPadding: 0.5 * spacing
            leftPadding: 0.08 * parent.width
            clip: true

            Column {
                id: cientIdFieldColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: cientIdFieldTitle
                    width: parent.width
                    text: "Имя пользователя"
                    font {
                        pixelSize: 0.67 * cientIdField.font.pixelSize
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

                TextField {
                    id: cientIdField
                    width: parent.width
//                    text:
                    placeholderText: (text.length === 0) ? "Client ID" : text
                    placeholderTextColor: "#979797"
                    font {
                        pixelSize: 0.06 * parent.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#0064B4"
                    onEditingFinished: {
                    }
                }
            }

            Column {
                id: cientSecretFieldColumn
                width: cientIdFieldColumn.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: cientIdFieldColumn.spacing

                Label {
                    width: parent.width
                    text: "Пароль"
                    font: cientIdFieldTitle.font
                    color: cientIdFieldTitle.color
                    clip: cientIdFieldTitle.clip
                    elide: cientIdFieldTitle.elide
                    horizontalAlignment: cientIdFieldTitle.horizontalAlignment
                    verticalAlignment: cientIdFieldTitle.verticalAlignment
                }

                Column {
                    width: cientIdFieldColumn.width
                    spacing: 0.5 * parent.spacing

                    Row {
                        width: parent.width

                        TextField {
                            id: passwordField
                            width: parent.width - eyeButton.width
//                            text: userPassword
                            placeholderText: (text.length === 0) ? "Client Secret" : text
                            placeholderTextColor: cientIdField.placeholderTextColor
                            font: cientIdField.font
                            color: cientIdField.color
                            echoMode: clientSecretView ? TextInput.Normal : TextInput.Password
                            onEditingFinished: {
                            }
                        }

                        Button {
                            id: eyeButton
                            height: 2.5 * cientIdField.font.pixelSize
                            width: height
                            anchors.verticalCenter: passwordField.verticalCenter
                            enabled: (passwordField.text.length > 0)
                            background: Image {
                                source: clientSecretView ? "qrc:/ico/settings/eye.png" : "qrc:/ico/settings/eye_off.png"
                            }
                            onClicked: {
                                clientSecretView = !clientSecretView
                            }
                        }
                    }
                }
            }

            Column {
                id: idQrFieldColumn
                width: cientIdFieldColumn.width
                anchors.horizontalCenter: cientIdFieldColumn.horizontalCenter
                spacing: cientIdFieldColumn.spacing

                Label {
                    id: idQrFieldTitle
                    width: cientIdFieldTitle.width
                    text: "Идентификатор терминала"
                    font: cientIdFieldTitle.font
                    color: cientIdFieldTitle.color
                    clip: cientIdFieldTitle.clip
                    elide: cientIdFieldTitle.elide
                    horizontalAlignment: cientIdFieldTitle.horizontalAlignment
                    verticalAlignment: cientIdFieldTitle.verticalAlignment
                }

                TextField {
                    id: idQrField
                    width: cientIdField.width
//                    text:
                    placeholderText: (text.length === 0) ? "idQR устройства" : text
                    placeholderTextColor: cientIdField.placeholderTextColor
                    font: cientIdField.font
                    color: cientIdField.color
                    maximumLength: 20
                    onEditingFinished: {
                    }
                }
            }

            Column {
                id: memberIdFieldColumn
                width: cientIdFieldColumn.width
                anchors.horizontalCenter: cientIdFieldColumn.horizontalCenter
                spacing: cientIdFieldColumn.spacing

                Label {
                    id: memberIdFieldTitle
                    width: cientIdFieldTitle.width
                    text: "Идентификатор клиента"
                    font: cientIdFieldTitle.font
                    color: cientIdFieldTitle.color
                    clip: cientIdFieldTitle.clip
                    elide: cientIdFieldTitle.elide
                    horizontalAlignment: cientIdFieldTitle.horizontalAlignment
                    verticalAlignment: cientIdFieldTitle.verticalAlignment
                }

                TextField {
                    id: memberIdField
                    width: cientIdField.width
//                    text:
                    placeholderText: (text.length === 0) ? "Member ID" : text
                    placeholderTextColor: cientIdField.placeholderTextColor
                    font: cientIdField.font
                    color: cientIdField.color
                    maximumLength: 32
                    onEditingFinished: {
                    }
                }
            }
        }
    }

    SaleComponents.Button_1 {
        id: saveData
        width: 0.92 * dataColumn.width
        height: 0.16 * width
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 0.5 * dataColumn.spacing
        }
        opacity: enabled ? 1 : 0.6
        borderWidth: 0
        backRadius: 8
        buttonTxt: qsTr("СОХРАНИТЬ")
        fontSize: 0.27 * height
        buttonTxtColor: "white"
        pushUpColor: "#415A77"
        pushDownColor: "#004075"
        onClicked: {
        }
    }
}
