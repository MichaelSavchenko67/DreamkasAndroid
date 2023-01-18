import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: supportHelpRequest

    property var userName: ""
    property var userPhone: ""
    property var userEmail: ""

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Задать вопрос")
            resetAddRightMenuButton()
            resetAddRightMenuButton2()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    function sendTo1c() {
        return true
    }

    Timer {
        id: sendingDelay
        interval: 30
        repeat: false
        running: false
        onTriggered: {
            // sending to 1C...
            let success = sendTo1c()
            popup.isLoader = false
            popup.isComplite = true
            popup.success = success
            popup.resMsg = success ? "OK" : "FAILED!"
        }
    }

    Action {
        id: send2supportAction
        onTriggered: {
            popupReset()
            root.popupSetTitle("Отпрака в 1С")
            root.popupSetClosePolicy(Popup.NoAutoClose)
            root.popupSetLoader(true)
            root.popupOpen()
            sendingDelay.start()
        }
    }

    function openSupportFormSendDialog() {
        popupReset()
        root.popupSetTitle("Отправки")
        root.popupSetAddMsg("Отправить?")
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(popupCancel)
        root.popupSetFirstActionName("ОТПРАВИТЬ")
        root.popupSetFirstAction(send2supportAction)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    ScrollView {
        width: parent.width
        height: parent.height - 1.25 * saveData.height - dataColumn.topPadding
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.vertical.width: 8

        contentData: Column {
            id: dataColumn
            width: parent.width
            spacing: subjectField.font.pixelSize
            topPadding: 0.25 * saveData.height
            leftPadding: 0.08 * parent.width
            clip: true

            Column {
                id: typeColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: typeTitle
                    width: parent.width
                    text: "Вид заявки"
                    font {
                        pixelSize: 0.67 * subjectField.font.pixelSize
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

                SettingsComponents.CustomComboBox {
                    boxModel: ListModel {
                        id: modelType
                        ListElement { payType: "Проблема"}
                        ListElement { payType: "Запрос нового функционала"}
                        ListElement { payType: "Вопрос"}
                    }
                    isEnabled: true
                    choosenIndex: 2
                    onChoosen: {}
                }
            }

            Column {
                id: subjectColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: subjectTitle
                    width: parent.width
                    text: "Тема обращения"
                    font {
                        pixelSize: 0.67 * subjectField.font.pixelSize
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
                    id: subjectField
                    width: parent.width
                    placeholderText: (text.length === 0) ? "Заполните это поле" : text
                    placeholderTextColor: "#979797"
                    inputMethodHints: Qt.ImhDigitsOnly
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
                id: userContactsColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: parent.spacing

                SettingsComponents.EnterParam {
                    id: enterUsername
                    width: parent.width
                    title: "ФИО"
                    paramPlaceholder: "Введите ФИО"
                    paramValue: userName
                    regExpValidator: RegularExpressionValidator { regularExpression: /^((([а-я,А-Я]{1,}\s{0,1})?([а-я,А-Я]{1,}\s{0,1})?([а-я,А-Я]{1,}))|(([a-z,A-Z]{1,}\s{0,1})?([a-z,A-Z]{1,}\s{0,1})?([a-z,A-Z}]{1,})))$/ }
                    onEntered: {
                        console.log("[SupportHelp.qml]\t\t" + title + ": " + value)
                        userName = value
                    }
                }

                SettingsComponents.EnterParam {
                    id: enterUsersPhone
                    width: parent.width
                    title: "Телефон"
                    paramPlaceholder: "+ 7"
                    paramValue: userPhone
                    inputMethod: Qt.ImhDigitsOnly
                    regExpValidator: RegularExpressionValidator { regularExpression: /^\+7(\(?)\d{3}(\)?)\d{7}$/ }
                    onEntered: {
                        console.log("[SupportHelp.qml]\t\t" + title + ": " + value)
                        userPhone = value
                    }
                }

                SettingsComponents.EnterParam {
                    id: enterUsersEmail
                    width: parent.width
                    title: "Эл. почта"
                    paramPlaceholder: "Введите email"
                    paramValue: userEmail
                    inputMethod: Qt.ImhEmailCharactersOnly
                    regExpValidator: RegularExpressionValidator {regularExpression: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/ }
                    onEntered: {
                        console.log("[SupportHelp.qml]\t\t" + title + ": " + value)
                        userEmail = value
                    }
                }

            }

            Column {
                id: descriptionColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: descriptionTitle
                    width: parent.width
                    bottomPadding: parent.spacing
                    text: "Опишите вашу проблему"
                    font {
                        pixelSize: 0.67 * subjectField.font.pixelSize
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

                TextArea {
                    id: textArea
                    width: parent.width
                    height: contentHeight + 2 * topPadding
                    leftPadding: font.pixelSize
                    topPadding: font.pixelSize
                    rightPadding: leftPadding
                    bottomPadding: topPadding
                    text: ""
                    font {
                        pixelSize: 0.06 * parent.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    wrapMode: TextArea.WordWrap
                    color: "#0064B4"
                    focus: true
                    background: Rectangle {
                        border.color: "#979797"
                        radius: 8
                    }
                }
            }
        }
    }

    SaleComponents.Button_1 {
        id: saveData
        width: 0.92 * dataColumn.width
        height: 0.16 * width
        enabled: (subjectField.text.length > 0) && enterUsername.isAcceptable && (enterUsersEmail.isAcceptable || enterUsersPhone.isAcceptable) && (textArea.text.length > 0)
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 0.25 * height
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
            openSupportFormSendDialog()
        }
    }
}

