import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: multipos
    Layout.fillHeight: true
    Layout.fillWidth: true

    property bool isExternalPinpad: true
    property var connectedDeviceName: ""

    function setDiscovery(discover) {
        console.log("[Multipos.qml]\t\tsetDiscovery: " + discover)
        loaderSwitch.running = discover
    }

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            setMainPageTitle("Банковский терминал")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
            setDiscovery(integratedPinpadSwitch.checked)
        } else {
            setDiscovery(false)
        }
    }

    Action {
        id: connectMultipos
        onTriggered: {
            console.log("[Multipos.qml]\t\tconnecting...")
            popupReset()
        }
    }

    Action {
        id: disconnectMultipos
        onTriggered: {
            console.log("[Multipos.qml]\t\tdisconnecting...")
            popupReset()
        }
    }

    function openConnectMultiposDialog(deviceName) {
        popupReset()
        root.popupSetTitle("Подключение терминала")
        root.popupSetAddMsg("Вы подключаете интегрированный терминал " + deviceName)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(popupCancel)
        root.popupSetFirstActionName("ПОДКЛЮЧИТЬ")
        root.popupSetFirstAction(connectMultipos)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    function openDisconnectMultiposDialog(deviceName) {
        popupReset()
        root.popupSetTitle("Отключение терминала")
        root.popupSetAddMsg("Отключить интегрированный терминал " + deviceName + "?")
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(popupCancel)
        root.popupSetFirstActionName("ДА, ОТКЛЮЧИТЬ")
        root.popupSetFirstAction(disconnectMultipos)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    function openChangeMultiposDialog(deviceName) {
        popupReset()
        root.popupSetTitle("Смена терминала")
        root.popupSetAddMsg("Вы хотите подключить интегрированный терминал " + deviceName + ".\nТерминал " + connectedDeviceName + " будет отключен.")
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(popupCancel)
        root.popupSetFirstActionName("ПОДКЛЮЧИТЬ")
        root.popupSetFirstAction(connectMultipos)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    function getInterfaceIco(deviceInterface) {
        if (deviceInterface === "USB") {
            return "qrc:/ico/settings/usb.png"
        } else if (deviceInterface === "Bluetooth") {
            return "qrc:/ico/settings/bluetooth.png"
        }
        return ""
    }

    Timer {
        id: loaderSwitch
        interval: 3000
        repeat: true
        onTriggered: {
            loader.running = !loader.running
        }
        onRunningChanged: {
            loader.running = running
        }
    }

    contentData: Rectangle {
        anchors.fill: parent
        color: "#00FFFFFF"
        border.width: 0

        Column {
            id: rootColumn
            anchors.fill: parent
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: qsTr("Выберите терминал")
                font {
                    pixelSize: 0.06 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                clip: true
                elide: "ElideRight"
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
                topPadding: parent.spacing
                leftPadding: 0.7 * topPadding
            }

            Row {
                id: externalPinpad
                width: parent.width
                leftPadding: title.leftPadding

                Image {
                    id: externalPinpadIco
                    anchors.verticalCenter: parent.verticalCenter
                    width: 0.09 * rootColumn.width
                    height: width
                    source: "qrc:/ico/settings/calculator.png"
                }

                Label {
                    id: externalPinpadTitle
                    width: parent.width - externalPinpadIco.width - externalPinpadSwitch.width - 2 * title.leftPadding
                    text: qsTr("Внешний")
                    anchors.verticalCenter: parent.verticalCenter
                    font {
                        pixelSize: 0.5 * externalPinpadIco.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    clip: true
                    elide: "ElideRight"
                    verticalAlignment: Label.AlignVCenter
                    leftPadding: font.pixelSize
                }

                Switch {
                    id: externalPinpadSwitch
                    anchors.verticalCenter: parent.verticalCenter
                    checked: isExternalPinpad
                    onCheckedChanged: {
                        integratedPinpadSwitch.checked = !checked
                    }
                }
            }

            Row {
                id: integratedPinpad
                width: externalPinpad.width
                height: externalPinpad.height
                leftPadding: externalPinpad.leftPadding

                Image {
                    id: integratedPinpadIco
                    anchors.verticalCenter: parent.verticalCenter
                    width: externalPinpadIco.width
                    height: width
                    source: "qrc:/ico/settings/responsive.png"
                }

                Label {
                    id: integratedPinpadTitle
                    width: externalPinpadTitle.width - loaderRow.width
                    text: qsTr("Интегрированный")
                    anchors.verticalCenter: parent.verticalCenter
                    font: externalPinpadTitle.font
                    color: externalPinpadTitle.color
                    clip: externalPinpadTitle.clip
                    elide: externalPinpadTitle.elide
                    verticalAlignment: Label.AlignTop
                    leftPadding: externalPinpadTitle.leftPadding
                }

                Row {
                    id: loaderRow
                    width: loader.implicitWidth
                    anchors.verticalCenter: parent.verticalCenter

                    BusyIndicator {
                        id: loader
                        anchors.verticalCenter: parent.verticalCenter
                        implicitWidth: integratedPinpadIco.height
                        implicitHeight: implicitWidth
                        running: false
                        Material.accent: "#5C7490"
                    }
                }

                Switch {
                    id: integratedPinpadSwitch
                    width: externalPinpadSwitch.width
                    height: externalPinpadSwitch.height
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged: {
                        externalPinpadSwitch.checked = !checked
                        setDiscovery(checked)
                    }
                }
            }

            ListView {
                id: pinpads
                width: parent.width - 2 * title.leftPadding
                height: parent.height - title.height - externalPinpad.height
                visible: integratedPinpadSwitch.checked && (pinpads.count > 0)
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                model: ListModel {
                    id: pinpadsList

                    ListElement {
                        deviceName: "SkyPos MP200"
                        deviceInterface: "Bluetooth"
                        isConnected: true
                    }

                    ListElement {
                        deviceName: "SkyPos MP200"
                        deviceInterface: "USB"
                        isConnected: false
                    }

                    ListElement {
                        deviceName: "Ingenico"
                        deviceInterface: "USB"
                        isConnected: false
                    }

                    ListElement {
                        deviceName: "Sberbank"
                        deviceInterface: "USB"
                        isConnected: false
                    }

                    ListElement {
                        deviceName: "SkyPos MP200"
                        deviceInterface: "Bluetooth"
                        isConnected: false
                    }
                }
                delegate: ItemDelegate {
                    width: parent.width
                    height: pinpad.height

                    Rectangle {
                        anchors.fill: parent
                        color: isConnected ? "#F6F6F6" : "#00FFFFFF"
                        radius: 16

                        Row {
                            id: pinpad
                            width: parent.width
                            height: 2.56 * interfaceIco.height
                            leftPadding: 2 * interfaceIco.width

                            Image {
                                id: interfaceIco
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * rootColumn.width
                                height: width
                                source: getInterfaceIco(deviceInterface)
                            }

                            Column {
                                width: parent.width - interfaceIco.width - 2 * parent.leftPadding
                                height: interfaceIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    id: pinpadName
                                    width: parent.width
                                    text: qsTr(deviceName)
                                    anchors.verticalCenter: isConnected ? anchors.verticalCenter : parent.verticalCenter
                                    font {
                                        pixelSize: 0.5 * interfaceIco.height
                                        family: "Roboto"
                                        styleName: "normal"
                                        weight: Font.Normal
                                    }
                                    color: "black"
                                    clip: true
                                    elide: "ElideRight"
                                    verticalAlignment: isConnected ? Label.AlignTop : Label.AlignVCenter
                                    leftPadding: font.pixelSize
                                }

                                Row {
                                    width: parent.width
                                    leftPadding: pinpadName.leftPadding
                                    spacing: 0.25 * connectedMsg.font.pixelSize
                                    visible: isConnected

                                    Image {
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: connectedMsg.font.pixelSize
                                        height: width
                                        source: "qrc:/ico/menu/success_ico_small.png"
                                    }

                                    Label {
                                        id: connectedMsg
                                        text: qsTr("Подключено")
                                        font {
                                            pixelSize: 0.83 * pinpadName.font.pixelSize
                                            family: "Roboto"
                                            styleName: "normal"
                                            weight: Font.Normal
                                        }
                                        color: "#979797"
                                        clip: true
                                        elide: "ElideRight"
                                        verticalAlignment: Label.AlignBottom
                                    }
                                }
                            }
                        }
                    }

                    onClicked: {
                        ListView.currentIndex = index
                        console.log("[multipos.qml]\tChoosen pinpad with index: " + index)
                        if (isConnected) {
                            openDisconnectMultiposDialog(deviceName)
                        } else if (connectedDeviceName.length > 0) {
                            openChangeMultiposDialog(deviceName)
                        } else {
                            openConnectMultiposDialog(deviceName)
                        }
                    }
                }
                ScrollBar.vertical: ScrollBar {
                    id: scroll
                    policy: ScrollBar.AsNeeded
                    width: 8
                }
            }
        }

        Column {
            id: pinpadsNotFoundColumn
            visible: integratedPinpadSwitch.checked && (pinpads.count == 0)
            width: parent.width
            anchors.centerIn: parent
            spacing: title.font.pixelSize

            Label {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Терминалы не найдены")
                font {
                    pixelSize: externalPinpadTitle.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                color: "#979797"
                clip: true
                elide: "ElideRight"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Column {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.5 * parent.spacing

                SettingsComponents.ParagraphMessage {
                    message: "Убедитесь, что терминал включен;"
                }

                SettingsComponents.ParagraphMessage {
                    message: "Проверьте подключение по USB или Bluetooth."
                }
            }
        }

        Image {
            id: girl
            width: 0.38 * parent.width
            height: 1.45 * width
            visible: pinpadsNotFoundColumn.visible
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            source: "qrc:/ico/settings/girl.png"
            fillMode: Image.PreserveAspectFit
        }
    }
}
