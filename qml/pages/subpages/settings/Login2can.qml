import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: login2canPage
    Layout.fillWidth: true
    Layout.fillHeight: true

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Авторизация в 2can")
            resetAddRightMenuButton()
            resetAddRightMenuButton2()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    Timer {
        id: loginDelay
        interval: 3000
        repeat: false
        onRunningChanged: {
            if (running) {
                login.start()
            }
        }
        onTriggered: {
            root.is2canLoggedIn = true
            login.finish(root.is2canLoggedIn)
        }
    }

    contentData: Column {
        id: mainColumn
        width: 0.9 * parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0.05 * parent.width
        topPadding: 1.5 * spacing

        Image {
            id: logoImg
            width: 0.15 * parent.width
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "qrc:/ico/settings/2can_color.png"
        }

        Column {
            width: parent.width
            height: parent.height -
                    logoImg.height -
                    buttonsGroup.height -
                    3 * parent.spacing -
                    parent.topPadding
            spacing: mainColumn.spacing
            topPadding: mainColumn.topPadding - spacing

            SettingsComponents.Login {
                id: login
                width: parent.width
                title: "Введите учётные данные"
                usernameTitle: "Электронная почта"
                username: "a.pushkin@gmail.com"
                passwordTitle: "Секретный ключ"
                password: "123123123"
                onIsAcceptedChanged: {
                    confirmButton.enabled = isAccepted
                }
                onLoggedIn: {
                    root.closePage()
                }
            }
        }

        Column {
            id: buttonsGroup
            visible: !login.inProgress && !login.isLoggedIn
            width: parent.width

            SaleComponents.Button_1 {
                id: confirmButton
                enabled: login.isAccepted && !login.inProgress
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.9 * parent.width
                height: 0.16 * width
                borderWidth: 0
                backRadius: 8
                buttonTxt: qsTr("ПОДТВЕРДИТЬ")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    loginDelay.running = true
                }
            }

            SaleComponents.Button_1 {
                id: registrationButton
                enabled: !login.inProgress
                anchors.horizontalCenter: confirmButton.horizontalCenter
                width: confirmButton.width
                height: confirmButton.height
                borderWidth: confirmButton.borderWidth
                backRadius: confirmButton.backRadius
                buttonTxt: qsTr("РЕГИСТРАЦИЯ В 2CAN")
                fontSize: confirmButton.fontSize
                buttonTxtColor: "#415A77"
                pushUpColor: "transparent"
                pushDownColor: "#F6F6F6"
                onClicked: {
                }
            }
        }
    }
}
