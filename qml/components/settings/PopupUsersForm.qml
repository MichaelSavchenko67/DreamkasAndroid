import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Popup {
    id: popupUsersForm

    property var userName: ""
    property var userPhone: ""
    property var userEmail: ""

    signal save()

    width: 0.9 * parent.width
    height: exitButton.height +
            exitButton.anchors.topMargin +
            rootColumn.height +
            rootColumn.spacing
    parent: Overlay.overlay
    x: Math.round((root.width - width) / 2)
    y: Math.round(0.3 * (root.height - height))
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
                height: 0.038 * 0.9 * parent.width
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                popupUsersForm.close()
            }
        }

        Column {
            id: rootColumn
            width: parent.width - 2 * title.font.pixelSize
            anchors {
                top: exitButton.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 2 * title.font.pixelSize

            Column {
                width: parent.width
                spacing: title.font.pixelSize

                Label {
                    id: title
                    width: parent.width
                    text: qsTr("Заявка на консультацию")
                    font {
                        pixelSize: 0.072 * popupUsersForm.width
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

                SettingsComponents.EnterParam {
                    id: enterUsername
                    title: "ФИО"
                    paramPlaceholder: "Введите ФИО"
                    paramValue: userName
                    regExpValidator: RegularExpressionValidator { regularExpression: /^((([а-я,А-Я]{1,}\s{0,1})?([а-я,А-Я]{1,}\s{0,1})?([а-я,А-Я]{1,}))|(([a-z,A-Z]{1,}\s{0,1})?([a-z,A-Z]{1,}\s{0,1})?([a-z,A-Z}]{1,})))$/ }
                    onEntered: {
                        console.log("[PopupUsersForm.qml]\t\t" + title + ": " + value)
                        userName = value
                    }
                }

                SettingsComponents.EnterParam {
                    id: enterUsersPhone
                    title: "Телефон"
                    paramPlaceholder: "Введите телефон"
                    paramValue: userPhone
                    inputMethod: Qt.ImhDigitsOnly
                    regExpValidator: RegularExpressionValidator {regularExpression: /^(?:\d{11})$/ }
                    onEntered: {
                        console.log("[PopupUsersForm.qml]\t\t" + title + ": " + value)
                        userPhone = value
                    }
                }

                SettingsComponents.EnterParam {
                    id: enterUsersEmail
                    title: "Эл. почта"
                    paramPlaceholder: "Введите email"
                    paramValue: userEmail
                    inputMethod: Qt.ImhEmailCharactersOnly
                    regExpValidator: RegularExpressionValidator {regularExpression: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/ }
                    onEntered: {
                        console.log("[PopupUsersForm.qml]\t\t" + title + ": " + value)
                        userEmail = value
                    }
                }
            }

            SaleComponents.Button_1 {
                id: connectionButton
                width: enterUsername.width
                height: 0.18 * width
                enabled: enterUsername.isAcceptable && (enterUsersPhone.isAcceptable || enterUsersEmail.isAcceptable)
                opacity: enabled ? 1 : 0.6
                borderWidth: 0
                backRadius: 8
                buttonTxt: qsTr("ОТПРАВИТЬ")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: enabled ? "#415A77" : "#BDC3C7"
                pushDownColor: "#004075"
                onClicked: {
                    console.log("[PopupUsersForm.qml]\t\tsave")
                    save()
                    popupUsersForm.close()
                }
            }
        }
    }
}
