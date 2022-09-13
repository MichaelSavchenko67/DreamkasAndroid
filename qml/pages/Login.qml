import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Rectangle {
    id: loginPage
    width: parent.width
    height: parent.height
    color: "transparent"

    property bool isLogo: true
    property bool isFirstConnectToPrinter: demo.isFirstConnectionPrinter()
    property string pswd: ""

    onFocusChanged: {
        if (focus) {
            console.log("[Login.qml]\tfocus changed: " + focus)
            setToolbarVisible(false)
            userTilesSwipeView.goIn()
        }
    }

    states: [
        State {
            name: "createUser"
            PropertyChanges { target: enterPasswordColumn; visible: false }
            PropertyChanges { target: enterPasswordTitle; text: qsTr("") }
            PropertyChanges { target: loginTitle; text: qsTr("Добавьте нового\nпользователя") }
            PropertyChanges { target: loginTitle; visible: true }
            PropertyChanges { target: loginField; visible: true }
            PropertyChanges { target: chooseUserColumn; visible: true }
        },
        State {
            name: "chooseUser"
            PropertyChanges { target: enterPasswordColumn; visible: false }
            PropertyChanges { target: enterPasswordTitle; text: qsTr("") }
            PropertyChanges { target: loginTitle; text: qsTr("Выберите пользователя") }
            PropertyChanges { target: loginTitle; visible: true }
            PropertyChanges { target: loginField; visible: true }
            PropertyChanges { target: chooseUserColumn; visible: true }
        },
        State {
            name: "enterPassword"
            PropertyChanges { target: chooseUserColumn; visible: false }
            PropertyChanges { target: loginTitle; visible: false }
            PropertyChanges { target: enterPasswordTitle; text: qsTr("Введите код") }
            PropertyChanges { target: loginField; visible: true }
            PropertyChanges { target: enterPasswordColumn; visible: true }
        },
        State {
            name: "loggedIn"
            PropertyChanges { target: chooseUserColumn; visible: false }
            PropertyChanges { target: loginTitle; visible: false }
            PropertyChanges { target: enterPasswordTitle; text: qsTr("") }
            PropertyChanges { target: loginField; visible: true }
            PropertyChanges { target: enterPasswordColumn; visible: true }
            PropertyChanges { target: loginIndicators; visible: false }
            PropertyChanges { target: loaderLogin; running: true }
            PropertyChanges { target: grid; visible: false }
        }
    ]
    state: "chooseUser"

    function enterDigit(digit) {
        if (first.shake) {
            setLoginIndShake(false)
            pswd = ""
        }

        if (pswd.length < 4) {
            pswd = pswd + digit
        }
    }

    function deleteDigit() {
        setLoginIndShake(false)
        if (pswd.length > 0) {
            pswd = pswd.substring(0, pswd.length - 1)
        }
    }

    function setLoginIndShake(shake) {
        first.shake = shake
        second.shake = shake
        third.shake = shake
        fourth.shake = shake
    }

    Timer { id: loggedInDelay; interval: 3000; repeat: false; onTriggered: { closePage() } }

    Action {
        id: loggedIn
        onTriggered: {
            loginPage.state = "loggedIn"
            loggedInDelay.running = true
        }
    }

    onPswdChanged: {
        if (pswd.length >= 4) {
            console.log("[Login.qml]\tPassword by user: " + pswd)
            if (pswd === "0000") {
                console.log("[Login.qml]\tFailed!")
                setLoginIndShake(true)
            } else {
                console.log("[Login.qml]\tSuccess")
                loggedIn.triggered()
            }
        }
    }

    Column {
        id: frame
        width: parent.width
        height: parent.height - 1.25 * changeUserButton.height
        topPadding: 0.2 * 0.463 * parent.width
        bottomPadding: topPadding
        spacing: topPadding

        Rectangle {
            id: dreamkasLogo
            width: 0.463 * parent.width
            height: 0.233 * width
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"

            Image {
                width: parent.width
                anchors.centerIn: parent
                visible: isLogo
                source: "qrc:/ico/menu/logo.png"
                fillMode: Image.PreserveAspectFit
                clip: true
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height -
                    dreamkasLogo.height -
                    parent.topPadding -
                    parent.spacing

            Column {
                id: loginField
                width: parent.width
                height: parent.height
                visible: false
                topPadding: (parent.height -
                             loginTitle.contentHeight -
                             loginIndicators.height -
                             wrongPswd.contentHeight -
                             grid.height -
                             2 * spacing) / 2
                spacing: 1.5 * loginTitle.font.pixelSize

                Label {
                    id: loginTitle
                    width: parent.width
                    visible: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    font {
                        pixelSize: 0.05 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    elide: Label.ElideRight
                    maximumLineCount: 2
                    wrapMode: Label.WordWrap
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }

                Column {
                    id: chooseUserColumn
                    width: parent.width
                    height: parent.height
                    visible: false

                    SettingsComponents.UserTilesSwipeView {
                        id: userTilesSwipeView
                        width: parent.width
                        height: 0.67 * width
                        anchors.horizontalCenter: parent.horizontalCenter
                        onCreateUser: {

                        }
                        onUserChoosen: {
                            loginPage.state = "enterPassword"
                        }
                    }
                }

                Column {
                    id: enterPasswordColumn
                    width: parent.width
                    x: -parent.width
                    visible: false
                    spacing: parent.spacing

                    Row {
                        id: userInfoRow
                        width: 0.75 * parent.width
                        height: avatarImage.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: usernameLoginLabel.font.pixelSize
                        leftPadding: spacing
                        scale: 1.0

                        SettingsComponents.AvatarFrame {
                            id: avatarImage
                            width: 0.3 * parent.width
                            height: width
                            x: parent.leftPadding

                            Image {
                                anchors.fill: parent
                                source: "qrc:/ico/tiles/tileGoods11.png"
                                fillMode: Image.PreserveAspectCrop
                            }
                        }

                        Column {
                            id: userInfoColumn
                            width: parent.width -
                                   avatarImage.width -
                                   parent.spacing
                            height: avatarImage.height
                            spacing: height - usernameLoginLabel.contentHeight - roleLabel.contentHeight

                            Label {
                                id: usernameLoginLabel
                                width: parent.width
                                text: qsTr("Савченко Михаил Андреевич")
                                font {
                                    pixelSize: 0.2 * avatarImage.height
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Normal
                                }
                                color: "black"
                                elide: Label.ElideRight
                                maximumLineCount: 2
                                wrapMode: Text.WordWrap
                                lineHeight: 1.2
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }

                            Label {
                                id: roleLabel
                                width: usernameLoginLabel.width
                                text: qsTr("Администратор")
                                font {
                                    pixelSize: 0.833 * usernameLoginLabel.font.pixelSize
                                    family: usernameLoginLabel.font.family
                                    styleName: usernameLoginLabel.font.styleName
                                    weight: usernameLoginLabel.font.weight
                                }
                                color: "#979797"
                                elide: usernameLoginLabel.elide
                                horizontalAlignment: usernameLoginLabel.horizontalAlignment
                                verticalAlignment: usernameLoginLabel.verticalAlignment
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 1.5 * enterPasswordTitle.font.pixelSize

                        Label {
                            id: enterPasswordTitle
                            width: parent.width
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("Введите код")
                            font: loginTitle.font
                            color: loginTitle.color
                            elide: loginTitle.elide
                            horizontalAlignment: loginTitle.horizontalAlignment
                            verticalAlignment: loginTitle.verticalAlignment
                        }

                        Column {
                            width: parent.width
                            spacing: 0.25 * loaderLogin.height
                            anchors.centerIn: parent

                            BusyIndicator {
                                id: loaderLogin
                                implicitWidth: 0.1 * root.width
                                implicitHeight: implicitWidth
                                running: false
                                visible: running
                                anchors.horizontalCenter: parent.horizontalCenter
                                Material.accent: "#5C7490"
                            }

                            Label {
                                id: welcomeLabel
                                width: parent.width
                                anchors.horizontalCenter: parent.horizontalCenter
                                opacity: 0.0
                                text: qsTr("Добро пожаловать")
                                font {
                                    pixelSize: 0.833 * loginTitle.font.pixelSize
                                    family: loginTitle.font.family
                                    styleName: loginTitle.font.styleName
                                    weight: loginTitle.font.weight
                                }
                                color: "black"
                                elide: loginTitle.elide
                                horizontalAlignment: loginTitle.horizontalAlignment
                                verticalAlignment: loginTitle.verticalAlignment

                                OpacityAnimator {
                                    target: welcomeLabel
                                    to: 1.0
                                    duration: 2000
                                    running: loaderLogin.running
                                }
                            }
                        }
                    }

                    Column {
                        width: parent.width
                        spacing: 0.25 * parent.spacing

                        Row {
                            id: loginIndicators
                            width: 0.3 * frame.width
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 2 * first.width

                            SaleComponents.LoginIndicator { id: first; width: 0.03 * frame.width; enabled: (pswd.length >= 1) }
                            SaleComponents.LoginIndicator { id: second; width: first.width; enabled: (pswd.length >= 2) }
                            SaleComponents.LoginIndicator { id: third; width: first.width; enabled: (pswd.length >= 3) }
                            SaleComponents.LoginIndicator { id: fourth; width: first.width; enabled: (pswd.length === 4) }
                        }

                        Rectangle {
                            width: 0.5 * parent.width
                            height: 3 * wrongPswd.font.pixelSize
                            anchors.horizontalCenter: parent.horizontalCenter

                            Label {
                                id: wrongPswd
                                width: parent.width
                                anchors.centerIn: parent
                                visible: first.shake && !loaderLogin.running
                                text: qsTr("Неверный пароль, попробуйте ещё раз")
                                font {
                                    pixelSize: 0.025 * frame.height
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Normal
                                }
                                color: "red"
                                elide: Label.ElideRight
                                maximumLineCount: 2
                                wrapMode: Label.WordWrap
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                            }
                        }

                        Grid {
                            id: grid
                            width: 0.69 * frame.width
                            height: 0.82 * width
                            anchors.horizontalCenter: loginIndicators.horizontalCenter
                            columns: 3
                            spacing: 0

                            SaleComponents.LoginButton { text: "1"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { text: "2"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { text: "3"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { text: "4"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { text: "5"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { text: "6"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { text: "7"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { text: "8"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { text: "9"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton { enabled: false }
                            SaleComponents.LoginButton { text: "0"; onPressed: enterDigit(text)}
                            SaleComponents.LoginButton {
                                enabled: (pswd.length > 0)
                                icon {
                                    width: parent.width
                                    height: parent.height
                                    source: enabled ? "qrc:/ico/calculator/del_en.png" : "qrc:/ico/calculator/del_dis.png"
                                    color: enabled ? "#415A77" : "grey"
                                }
                                onClicked: {
                                    deleteDigit()
                                }
                            }
                        }

                        Column {
                            width: parent.width
                            visible: grid.visible && (userTilesSwipeView.getCount() > 1)
                            topPadding: 4 * parent.spacing

                            SaleComponents.Button_1 {
                                id: changeUserButton
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 0.673 * loginPage.width
                                height: 0.16 * width
                                borderWidth: 0
                                backRadius: 8
                                buttonTxt: qsTr("ВЫБРАТЬ ДРУГОГО ПОЛЬЗОВАТЕЛЯ")
                                fontSize: 0.555 * loginTitle.font.pixelSize
                                buttonTxtColor: "#0064B4"
                                pushUpColor: "white"
                                pushDownColor: "#F6F6F6"
                                onClicked: {
                                    loginPage.state = "chooseUser"
                                }
                            }
                        }
                    }

                    NumberAnimation on x {
                        id: enterPasswordColumnGoIn
                        running: enterPasswordColumn.visible
                        alwaysRunToEnd: true
                        from: -parent.width
                        to: 0
                        duration: 350
                        easing.type: Easing.Linear
                    }

                    NumberAnimation on y {
                        alwaysRunToEnd: true
                        to: 0.5 * parent.height -
                            dreamkasLogo.height -
                            frame.spacing -
                            2 * frame.topPadding
                        duration: 500
                        easing.type: Easing.Linear
                        running: loaderLogin.running
                    }
                }
            }
        }
    }
}
