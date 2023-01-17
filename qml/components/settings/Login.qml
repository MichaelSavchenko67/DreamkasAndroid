import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts

Column {
    property string title: ""
    property string usernameTitle: ""
    property var usernameInputMethod: Qt.ImhEmailCharactersOnly
    property var usernameRegex: RegularExpressionValidator {regularExpression: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/ }
    property string username: ""
    property string passwordTitle: ""
    property var passwordInputMethod: Qt.ImhNone
    property var passwordRegex: RegularExpressionValidator {regularExpression: /^\w+$/ }
    property string password: ""
    property bool passwordView: false
    property bool isAccepted: usernameField.acceptableInput && (passwordField.length > 0)
    property bool isEnabled: !inProgress
    property bool inProgress: false
    property bool isLoggedIn: false
    property string loginProcessMsg: "Авторизация"

    signal loggedIn()

    onInProgressChanged: {
        loginProcessRow.state = inProgress ? "login" : (isLoggedIn ? "success" : "failed")
    }

    function start() {
        isLoggedIn = false
        inProgress = true
    }

    function finish(isSuccess) {
        isLoggedIn = isSuccess
        inProgress = false
    }

    spacing: titleLabel.font.pixelSize

    Label {
        id: titleLabel
        width: parent.width
        text: qsTr(title)
        font {
            pixelSize: 0.05 * parent.width
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
        id: loginFieldsColumn
        width: parent.width
        spacing: 0.25 * parent.spacing

        Column {
            id: usernameColumn
            width: parent.width

            Label {
                id: usernameFieldTitle
                width: parent.width
                text: qsTr(usernameTitle)
                font {
                    pixelSize: 0.67 * usernameField.font.pixelSize
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
                id: usernameFieldRow
                width: parent.width
                spacing: 0.5 * usernameFieldTitle.font.pixelSize

                TextField {
                    id: usernameField
                    width: parent.width - parent.spacing
                    text: qsTr(username)
                    enabled: isEnabled
                    placeholderText: qsTr((username.length === 0) ? usernameTitle : username)
                    placeholderTextColor: "#979797"
                    font {
                        pixelSize: 0.06 * parent.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: enabled ? "#0064B4" : "#C2C2C2"
                    inputMethodHints: usernameInputMethod
                    validator: usernameRegex
                    onFocusChanged: {
                        if (focus) {
                            loginProcessRow.state = "init"
                        }
                    }
                    onTextChanged: {
                        console.log("[Login.qml]\t\tusername: " + text)
                        username = text
                        isAccepted = usernameField.acceptableInput && (passwordField.length > 0)
                    }
                }
            }
        }

        Column {
            id: passwordFrame
            width: usernameColumn.width
            spacing: usernameColumn.spacing

            Label {
                width: parent.width
                text: qsTr(passwordTitle)
                font {
                    pixelSize: 0.67 * usernameField.font.pixelSize
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
                id: passwordRow
                width: parent.width
                height: eyeButton.height * eyeButton.scale

                TextField {
                    id: passwordField
                    width: parent.width - eyeButton.implicitBackgroundWidth
                    text: qsTr(password)
                    enabled: isEnabled
                    placeholderText: qsTr((password.length === 0) ? passwordTitle : password)
                    placeholderTextColor: "#979797"
                    font: usernameField.font
                    color: enabled ? usernameField.color : "#C2C2C2"
                    inputMethodHints: passwordInputMethod
                    validator: passwordRegex
                    echoMode: passwordView ? TextInput.Normal : TextInput.Password
                    onFocusChanged: {
                        if (focus) {
                            loginProcessRow.state = "init"
                        }
                    }
                    onTextChanged: {
                        password = text
                        isAccepted = usernameField.acceptableInput && (passwordField.length > 0)
                    }
                }

                ToolButton {
                    id: eyeButton
                    scale: 0.5
                    anchors.verticalCenter: passwordField.verticalCenter
                    enabled: (passwordField.text.length > 0)
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

    Row {
        id: loginProcessRow
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0.5 * loginMsg.font.pixelSize

        Timer {
            id: successDelay
            interval: 1500
            repeat: false
            onTriggered: {
                loggedIn()
            }
        }

        states: [
            State {
                name: "init";
                PropertyChanges { target: loginProcessRow; visible: false }
                PropertyChanges { target: loaderLogin; running: false }
            },
            State {
                name: "login";
                PropertyChanges { target: loginProcessRow; visible: true }
                PropertyChanges { target: loginMsg; text: qsTr(loginProcessMsg) }
                PropertyChanges { target: loginMsg; color: "#979797" }
                PropertyChanges { target: loaderLogin; running: true }
            },
            State {
                name: "failed";
                PropertyChanges { target: loginProcessRow; visible: true }
                PropertyChanges { target: loginMsg; text: qsTr("Ошибка авторизации") }
                PropertyChanges { target: loginMsg; color: "red" }
                PropertyChanges { target: loaderLogin; running: false }
                PropertyChanges { target: statusImage; source: "qrc:/ico/menu/operation_failed.png" }
            },
            State {
                name: "success";
                PropertyChanges { target: loginProcessRow; visible: true }
                PropertyChanges { target: loginMsg; text: qsTr("Вход выполнен") }
                PropertyChanges { target: loginMsg; color: "green" }
                PropertyChanges { target: loaderLogin; running: false }
                PropertyChanges { target: successDelay; running: true }
                PropertyChanges { target: statusImage; source: "qrc:/ico/menu/operation_success.png" }
            }
        ]
        state: "init"

        Image {
            id: statusImage
            visible: !loaderLogin.visible
            width: 0.8 * loaderLogin.width
            height: width
            anchors.verticalCenter: loginMsg.verticalCenter
            fillMode: Image.PreserveAspectFit
        }

        BusyIndicator {
            id: loaderLogin
            implicitWidth: 0.1 * root.width
            implicitHeight: implicitWidth
            visible: running
            anchors.verticalCenter: loginMsg.verticalCenter
            Material.accent: "#5C7490"
        }

        Label {
            id: loginMsg
            font {
                pixelSize: 0.05 * 0.9 * root.width
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            clip: true
            elide: Label.ElideRight
            maximumLineCount: 2
            wrapMode: Label.WordWrap
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
        }
    }
}
