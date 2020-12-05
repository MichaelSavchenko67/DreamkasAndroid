import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("[Login.qml]\tfocus changed: " + focus)
            setToolbarVisible(false)
        }
    }

    property bool loaded: false
    property var pswd: ""

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

    onPswdChanged: {
        if (pswd.length >= 4) {
            console.log("[Login.qml]\tPassword by user: " + pswd)
            if (pswd === "3552") {
                console.log("[Login.qml]\tSuccess")
                rootStack.replace("qrc:/qml/pages/PromoSwipeView.qml")
            } else {
                console.log("[Login.qml]\tFailed!")
                setLoginIndShake(true)
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: false
        onTriggered: {
            console.log("[Login.qml]\tStop loader")
            loader.running = false
            loaded = true
        }
    }

    contentData: Rectangle {
        id: frame
        anchors.fill: parent
        color: "white"

        BusyIndicator {
            id: loader
            anchors.centerIn: parent
            implicitWidth: 0.1 * parent.width
            implicitHeight: implicitWidth
            running: true
            Material.accent: "green"
        }

        Timer {
            interval: 1000
            running: loader.running
            repeat: true
            property int i: 1
            onTriggered: {
                loaderMsg.add2Queue("Загрузка\n" + i++)
            }
        }

        SaleComponents.AnimatedText {
            id: loaderMsg
            width: 0.8 * parent.height
            height: 0.1 * width
            anchors {
                top: loader.bottom
                topMargin: loader.height
                horizontalCenter: loader.horizontalCenter
            }
            visible: loader.running
        }

        Column {
            id: loginField
            anchors.fill: parent
            visible: false
            opacity: 0
            spacing: 1.5 * loginTitle.font.pixelSize
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 0.12 * parent.height
            }

            Image {
                width: 0.637 * parent.width
                height: 0.245 * width
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/ico/menu/logo.png"
            }

            Text {
                id: loginTitle
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Введите пароль")
                font {
                    pixelSize: 0.05 * parent.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

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

            Text {
                id: wrongPswd
                width: parent.width
                height: 0.025 * frame.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: loginIndicators.bottom
                anchors.topMargin: font.pixelSize
                visible: first.shake
                text: qsTr("Неверный пароль, попробуйте ещё раз")
                font {
                    pixelSize: height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "red"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Grid {
                id: grid
                width: 0.69 * frame.width
                height: 0.77 * width
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
                        color: enabled ? "#0064B4" : "grey"
                    }
                    onClicked: {
                        deleteDigit()
                    }
                }
            }

            states: State {
                name: "enable"; when: loaded
                PropertyChanges {
                    target: loginField;
                    visible: true
                    opacity: 1
                }
            }

            transitions: Transition {
                to: "enable"
                reversible: true

                SequentialAnimation {
                    PropertyAnimation { property: "visible" }
                    PropertyAnimation {
                        properties: "opacity"
                        easing.type: Easing.InOutQuad
                        duration: 1500
                    }
                }
            }
        }
    }
}
