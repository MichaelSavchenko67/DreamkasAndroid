import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: userPage
    anchors.fill: parent

    property bool passwordView: false
    property var avatarSource: ""
    property var userName: ""
    property var userPassword: ""
    property var userRule: 0
    property var userInn: ""
    property var userTabNumber: ""

    Action {
        id: deleteUser
        onTriggered: {
            root.popupReset()
            root.popupSetTitle("Удаление пользователя")
            root.popupSetAddMsg("Вы уверены, что хотите удалить данные пользователя " + nameField.text + "?")
            root.popupSetFirstActionName("УДАЛИТЬ")
            root.popupSetSecondActionName("ОТМЕНА")
            root.popupSetSecondAction(popupCancel)
            root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
            root.popupOpen()
        }
    }

    function initPage() {
        let isEdit = (state == "edit")
        setMainPageTitle(isEdit ? "Редактирование пользователя" : "Новый пользователь")
        resetAddRightMenuButton()
        setLeftMenuButtonAction(back)
        setRightMenuButtonVisible(false)

        if (isEdit) {
            setRightMenuButtonIco("qrc:/ico/menu/delete.png")
            setRightMenuButtonAction(deleteUser)
            setRightMenuButtonVisible(true)
        }

        setToolbarVisible(true)
    }

    onFocusChanged: {
        if (focus) {
            initPage()
        }
    }

    onStateChanged: {
        initPage()
    }

    states: [
        State { name: "default" },
        State { name: "edit" },
        State {
            name: "firstUser"
            PropertyChanges { target: nameFieldColumn; visible: true }
            PropertyChanges { target: passwordFieldColumn; visible: true }
            PropertyChanges { target: rulesFieldColumn; visible: true }
            PropertyChanges { target: innFieldColumn; visible: false }
            PropertyChanges { target: tabNumberFieldColumn; visible: false }
        }
    ]

    state: "default"

    SettingsComponents.CreateAvatarPopup {
        id: createAvatarPopup
        onAvatarCaptured: {
            avatarSource = avatarImage.source
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
            spacing: nameField.font.pixelSize
            topPadding: 0.5 * spacing
            leftPadding: 0.08 * parent.width
            clip: true

            Button {
                width: 0.28 * userPage.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    radius: width

                    SettingsComponents.Avatar {
                        id: avatar
                        anchors.fill: parent
                        avatarSrc: avatarSource
                        userNameFull: userName
                    }

                    Image {
                        width: 0.33 * avatar.width
                        height: width
                        source: "qrc:/ico/settings/take_photo.png"
                        anchors {
                            right: parent.right
                            bottom: parent.bottom
                        }
                    }
                }
                onClicked: {
                    createAvatarPopup.open()
                }
            }

            Column {
                id: nameFieldColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: nameFieldTitle
                    width: parent.width
                    text: "ФИО"
                    font {
                        pixelSize: 0.56 * nameField.font.pixelSize
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
                    id: nameField
                    width: parent.width
                    text: userName
                    placeholderText: (text.length === 0) ? "Введите ФИО" : text
                    placeholderTextColor: "#979797"
                    font {
                        pixelSize: 0.073 * parent.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#0064B4"
                    // Савченко                     Savchenko
                    // Савченко Михаил              Savchenko Mikhail
                    // Савченко Михаил Андреевич    Savchenko Mikhail Andreevich
                    validator: RegularExpressionValidator { regularExpression: /^((([а-я,А-Я]{1,}\s{0,1})?([а-я,А-Я]{1,}\s{0,1})?([а-я,А-Я]{1,}))|(([a-z,A-Z]{1,}\s{0,1})?([a-z,A-Z]{1,}\s{0,1})?([a-z,A-Z}]{1,})))$/ }
                    onAcceptableInputChanged: {
                        if (acceptableInput) {
                            console.log("[UserPage.qml]\t\t Username accepted")
                        }
                    }
                    onEditingFinished: {
                        console.log("onEditingFinished")
                        userName = text
                    }
                }
            }

            Column {
                id: passwordFieldColumn
                width: nameFieldColumn.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: nameFieldColumn.spacing

                Label {
                    width: parent.width
                    text: "Пароль для входа (4 цифры)"
                    font: nameFieldTitle.font
                    color: nameFieldTitle.color
                    clip: nameFieldTitle.clip
                    elide: nameFieldTitle.elide
                    horizontalAlignment: nameFieldTitle.horizontalAlignment
                    verticalAlignment: nameFieldTitle.verticalAlignment
                }

                Column {
                    width: nameFieldColumn.width
                    spacing: 0.5 * parent.spacing

                    Row {
                        width: parent.width

                        TextField {
                            id: passwordField
                            width: parent.width - eyeButton.width
                            text: userPassword
                            placeholderText: (text.length === 0) ? "Введите пароль" : text
                            placeholderTextColor: nameField.placeholderTextColor
                            font: nameField.font
                            color: nameField.color
                            echoMode: passwordView ? TextInput.Normal : TextInput.Password
                            inputMethodHints: Qt.ImhDigitsOnly
                            validator: RegularExpressionValidator { regularExpression: /[0-9]\d{3}/ }
                            onAcceptableInputChanged: {
                                if (acceptableInput) {
                                    console.log("[UserPage.qml]\t\t Password accepted")
                                }
                            }
                        }

                        Button {
                            id: eyeButton
                            height: 2.5 * nameField.font.pixelSize
                            width: height
                            anchors.verticalCenter: passwordField.verticalCenter
                            enabled: (passwordField.text.length > 0)
                            background: Image {
                                source: passwordView ? "qrc:/ico/settings/eye.png" : "qrc:/ico/settings/eye_off.png"
                            }
                            onClicked: {
                                passwordView = !passwordView
                            }
                        }
                    }

                    Label {
                        width: parent.width
                        text: "Пользователь с таким паролем уже существует"
                        font: nameFieldTitle.font
                        color: "red"
                        clip: nameFieldTitle.clip
                        elide: nameFieldTitle.elide
                        horizontalAlignment: nameFieldTitle.horizontalAlignment
                        verticalAlignment: nameFieldTitle.verticalAlignment
                    }
                }
            }

            Column {
                id: rulesFieldColumn
                width: nameFieldColumn.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: nameFieldColumn.spacing

                Label {
                    width: parent.width
                    text: "Права пользователя"
                    font: nameFieldTitle.font
                    color: nameFieldTitle.color
                    clip: nameFieldTitle.clip
                    elide: nameFieldTitle.elide
                    horizontalAlignment: nameFieldTitle.horizontalAlignment
                    verticalAlignment: nameFieldTitle.verticalAlignment
                }

                SettingsComponents.CustomComboBox {
                    boxModel: ListModel {
                        id: model
                        ListElement { payType: "Администратор" }
                        ListElement { payType: "Кассир" }
                    }
                    isEnabled: (userPage.state !== "firstUser")
                    choosenIndex: userRule
                    onChoosen: {
                        console.log("[UserPage.qml]\t\tchoosen rule: " + choosenIndex)
                    }
                }
            }

            Column {
                id: innFieldColumn
                width: nameFieldColumn.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: nameFieldColumn.spacing

                Label {
                    width: parent.width
                    text: "ИНН (10 или 12 цифр)"
                    font: nameFieldTitle.font
                    color: nameFieldTitle.color
                    clip: nameFieldTitle.clip
                    elide: nameFieldTitle.elide
                    horizontalAlignment: nameFieldTitle.horizontalAlignment
                    verticalAlignment: nameFieldTitle.verticalAlignment
                }

                TextField {
                    id: innField
                    width: nameField.width
                    text: userInn
                    placeholderText: (text.length === 0) ? "ИНН" : text
                    placeholderTextColor: nameField.placeholderTextColor
                    font: nameField.font
                    color: nameField.color
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: RegularExpressionValidator { regularExpression: /^([1-9]{1}([0-9]{9}|[0-9]{11}))$/}
                    onAcceptableInputChanged: {
                        if (acceptableInput) {
                            console.log("[UserPage.qml]\t\t INN accepted")
                        }
                    }
                }
            }

            Column {
                id: tabNumberFieldColumn
                width: nameFieldColumn.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: nameFieldColumn.spacing

                Label {
                    width: parent.width
                    text: "Табельный номер пользователя"
                    font: nameFieldTitle.font
                    color: nameFieldTitle.color
                    clip: nameFieldTitle.clip
                    elide: nameFieldTitle.elide
                    horizontalAlignment: nameFieldTitle.horizontalAlignment
                    verticalAlignment: nameFieldTitle.verticalAlignment
                }

                TextField {
                    id: tabNumberField
                    width: nameField.width
                    text: userTabNumber
                    placeholderText: (text.length === 0) ? "Табельный номер" : text
                    placeholderTextColor: nameField.placeholderTextColor
                    font: nameField.font
                    color: nameField.color
                }
            }
        }
    }

    SaleComponents.Button_1 {
        id: saveData
        width: 0.92 * dataColumn.width
        height: 0.2 * width
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 0.5 * dataColumn.spacing
        }
        enabled: nameField.acceptableInput &&
                 passwordField.acceptableInput &&
                 ((userPage.state == "firstUser") || innField.acceptableInput)
        opacity: enabled ? 1 : 0.6
        borderWidth: 0
        backRadius: 8
        buttonTxt: qsTr("СОХРАНИТЬ")
        fontSize: 0.27 * height
        buttonTxtColor: "white"
        pushUpColor: "#415A77"
        pushDownColor: "#004075"
        onClicked: {
            if (state !== "edit") {
                console.log("[UserPage.qml]\t\tadd new user")
            } else {
                console.log("[UserPage.qml]\t\tsave edit user data")
            }
        }
    }
}
