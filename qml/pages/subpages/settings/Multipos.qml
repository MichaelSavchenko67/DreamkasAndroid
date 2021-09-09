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
    property bool isIntegratedPinpad: false
    property bool isInpasSoftPosPinpad: false
    property var connectedDeviceName: ""

    function setDiscovery(discover) {
        console.log("[Multipos.qml]\t\tsetDiscovery: " + discover)
        integratedPinpad.setLoader(discover)
    }

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            setMainPageTitle("Банковский терминал")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
            setDiscovery(integratedPinpad.getChecked())
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
            integratedPinpad.setLoader(!integratedPinpad.getLoader())
        }
        onRunningChanged: {
            integratedPinpad.setLoader(running)
        }
    }

    function changePinpad(type) {
        if ((type === "EXTERNAL") && (externalPinpad.getChecked())) {
            console.log("[Multipos.qml]\t\tchoosen pinpad: " + type)
            inpasSoftPosPinpad.setChecked(false)
            integratedPinpad.setChecked(false)
        } else if ((type === "INPAS_SOFTPOS") && (inpasSoftPosPinpad.getChecked())) {
            console.log("[Multipos.qml]\t\tchoosen pinpad: " + type)
            externalPinpad.setChecked(false)
            integratedPinpad.setChecked(false)
        } else if ((type === "INTEGRATED") && (integratedPinpad.getChecked())) {
            console.log("[Multipos.qml]\t\tchoosen pinpad: " + type)
            externalPinpad.setChecked(false)
            inpasSoftPosPinpad.setChecked(false)
        }

        isExternalPinpad = externalPinpad.getChecked()
        isIntegratedPinpad = integratedPinpad.getChecked()
        isInpasSoftPosPinpad = inpasSoftPosPinpad.getChecked()
        setDiscovery(isIntegratedPinpad)
    }

    contentData: ScrollView {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.vertical.width: 8

        Rectangle {
            anchors.fill: parent
            color: "#00FFFFFF"
            border.width: 0

            Column {
                id: rootColumn
                anchors.fill: parent
                spacing: 1.5 * title.font.pixelSize

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
                    leftPadding: 0.042 * externalPinpad.width
                }

                SettingsComponents.InfoToggle {
                    id: externalPinpad
                    width: parent.width
                    height: 0.09 * rootColumn.width
                    itemLogo: "qrc:/ico/settings/calculator.png"
                    itemTitle: qsTr("Внешний")
                    itemSubscription: qsTr("Подключение не требуется")
                    onSwitched: {
                        changePinpad("EXTERNAL")
                    }
                }

                SettingsComponents.InfoToggle {
                    id: inpasSoftPosPinpad
                    width: externalPinpad.width
                    height: externalPinpad.height
                    itemLogo: "qrc:/ico/settings/cellphone_wireless.png"
                    itemTitle: qsTr("INPAS SoftPos")
                    itemSubscription: qsTr("Приём платежей через NFC")
                    onSwitched: {
                        changePinpad("INPAS_SOFTPOS")
                    }
                }

                Rectangle {
                    width: pinpads.width
                    height: 0.4 * width
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: inpasSoftPosPinpad.getChecked()
                    clip: true
                    color: "#F6F6F6"
                    radius: 8

                    Column {
                        width: parent.width - rootColumn.spacing
                        height: 0.8 * parent.height
                        anchors.centerIn: parent
                        topPadding: (height - 2 * installInpasSoftpos.height) / 3
                        spacing: 2 * topPadding

                        SettingsComponents.ButtonHyperlink {
                            id: installInpasSoftpos
                            width: parent.width
                            height: 0.45 * parent.height
                            title: "Установите «INPAS SoftPos»"
                            icoTitle: "Скачать файл"
                            icoPath: "qrc:/ico/settings/download"
                            onGo: {
                                console.info("installInpasSoftpos onGo")
                            }
                        }

                        SettingsComponents.ButtonHyperlink {
                            id: inpasSoftPosManual
                            width: installInpasSoftpos.width
                            height: installInpasSoftpos.height
                            title: "Интструкция по настройке"
                            icoTitle: "Открыть PDF"
                            icoPath: "qrc:/ico/settings/pdf"
                            onGo: {
                                console.info("inpasSoftPosManual onGo")
                                // https://drive.google.com/file/d/1S8EPZDIvR282iK3zIV76JJDA0L9NokeU/view?usp=sharing
                            }
                        }
                    }
                }

                SettingsComponents.InfoToggle {
                    id: integratedPinpad
                    width: externalPinpad.width
                    height: externalPinpad.height
                    itemLogo: "qrc:/ico/settings/responsive.png"
                    itemTitle: qsTr("Интегрированный")
                    itemSubscription: qsTr("Подключение по USB или Bluetooth")
                    onSwitched: {
                        changePinpad("INTEGRATED")
                    }
                }

                ListView {
                    id: pinpads
                    width: parent.width - 2 * parent.spacing
                    height: parent.height -
                            title.height -
                            externalPinpad.height -
                            integratedPinpad.height -
                            inpasSoftPosPinpad.height -
                            4 * parent.spacing
                    visible: integratedPinpad.getChecked() && (pinpads.count > 0)
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
                visible: integratedPinpad.getChecked() && (pinpads.count == 0)
                width: parent.width
                anchors.centerIn: parent
                spacing: title.font.pixelSize

                Label {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Терминалы не найдены")
                    font {
                        pixelSize: 0.5 * 0.09 * rootColumn.width
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
}
