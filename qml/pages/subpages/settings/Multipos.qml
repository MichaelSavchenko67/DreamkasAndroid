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
    property string connectedDeviceName: ""

    function setDiscovery(discover) {
        console.log("[Multipos.qml]\t\tsetDiscovery: " + discover)
        integratedPinpad.setLoader(discover)
    }

    onFocusChanged: {
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
        } else if ((type === "2CAN") && pinpad2can.getChecked()) {
            console.log("[Multipos.qml]\t\tchoosen pinpad: " + type)
            externalPinpad.setChecked(false)
            integratedPinpad.setChecked(false)
        }

        isExternalPinpad = externalPinpad.getChecked()
        isIntegratedPinpad = integratedPinpad.getChecked()
        isInpasSoftPosPinpad = inpasSoftPosPinpad.getChecked()
        setDiscovery(isIntegratedPinpad)
    }

    contentData: Column {
        id: mainColumn
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
            topPadding: 0.5 * parent.spacing
            leftPadding: 0.042 * externalPinpad.width
        }

        Rectangle {
            width: parent.width
            height: parent.height -
                    title.contentHeight -
                    title.topPadding -
                    parent.spacing

            ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.vertical.width: 8
                contentData: Column {
                    width: parent.width
                    spacing: mainColumn.spacing

                    SettingsComponents.InfoToggle {
                        id: externalPinpad
                        width: parent.width
                        icoHeight: 0.09 * width
                        icoWidth: icoHeight
                        itemLogo: "qrc:/ico/settings/calculator.png"
                        itemTitle: qsTr("Внешний")
                        itemSubscription: qsTr("Подключение не требуется")
                        onSwitched: {
                            changePinpad("EXTERNAL")
                        }
                    }

                    Column {
                        width: parent.width
                        spacing: 0.5 * parent.spacing

                        SettingsComponents.InfoToggle {
                            id: inpasSoftPosPinpad
                            width: externalPinpad.width
                            icoHeight: externalPinpad.icoHeight
                            icoWidth: icoHeight
                            itemLogo: "qrc:/ico/settings/cellphone_wireless.png"
                            itemTitle: qsTr("INPAS SoftPos")
                            itemSubscription: qsTr("Приём платежей через NFC")
                            onSwitched: {
                                changePinpad("INPAS_SOFTPOS")
                            }
                        }

                        Rectangle {
                            width: parent.width - 4 * parent.spacing
                            height: 0.4 * width
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: inpasSoftPosPinpad.getChecked()
                            clip: true
                            color: "#F6F6F6"
                            radius: 8

                            Column {
                                width: parent.width - mainColumn.spacing
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
                                    }
                                }
                            }
                        }
                    }

                    Column {
                        width: parent.width
                        spacing: 0.5 * parent.spacing

                        SettingsComponents.InfoToggle {
                            id: payQrPinpad
                            width: externalPinpad.width
                            icoHeight: externalPinpad.icoHeight
                            icoWidth: icoHeight
                            itemLogo: "qrc:/ico/settings/pay_qr.png"
                            itemTitle: qsTr("Оплата по QR")
                            itemSubscription: qsTr("Приём безналичной оплаты")
                            onSwitched: {
                                payQrSberbank.visible = getChecked()
                            }
                        }

                        SettingsComponents.ChoosenItemSimple {
                            id: payQrSberbank
                            visible: payQrPinpad.getChecked()
                            leftPadding: 0.042 * parent.width
                            width: parent.width - 4 * parent.spacing
                            height: 1.6 * payQrPinpad.height
                            anchors.horizontalCenter: payQrPinpad.horizontalCenter
                            title: "Плати QR от Сбербанк"
                            fontPixelSize: 0.045 * payQrPinpad.width
                            icoPath: "qrc:/ico/settings/sberbank_logo.png"
                            icoHeight: payQrPinpad.icoHeight
                            onClicked: {
                                root.openPage("qrc:/qml/pages/subpages/settings/PayQrSberbankSettings.qml")
                            }
                        }
                    }

                    Column {
                        width: parent.width
                        spacing: 0.5 * parent.spacing

                        SettingsComponents.InfoToggle {
                            id: checkingAccount
                            width: externalPinpad.width
                            icoWidth: externalPinpad.icoWidth
                            icoHeight: 0.75 * icoWidth
                            itemLogo: "qrc:/ico/settings/contacts.png"
                            itemTitle: qsTr("Оплата на расчётный счёт")
                            itemSubscription: qsTr("Оплата по реквизитам и QR коду")
                            onSwitched: {
                                checkingAccountSetup.visible = getChecked()
                            }
                        }

                        SettingsComponents.ChoosenItemSimple {
                            id: checkingAccountSetup
                            visible: checkingAccount.getChecked()
                            leftPadding: payQrSberbank.leftPadding
                            width: payQrSberbank.width
                            height: payQrSberbank.height
                            anchors.horizontalCenter: checkingAccount.horizontalCenter
                            title: "Реквизиты расчётного счёта"
                            fontPixelSize: payQrSberbank.fontPixelSize
                            icoPath: "qrc:/ico/settings/manual.png"
                            icoHeight: checkingAccount.icoHeight
                            onClicked: {
                                root.openPage("qrc:/qml/pages/subpages/settings/CheckingAccountSettings.qml")
                            }
                        }
                    }

                    SettingsComponents.InfoToggle {
                        id: integratedPinpad
                        width: externalPinpad.width
                        icoHeight: externalPinpad.icoHeight
                        icoWidth: icoHeight
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
                        height: 0.3 * mainColumn.height
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
                                        width: 0.09 * mainColumn.width
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

                    Row {
                        id: pinpadsNotFoundRow
                        width: parent.width
                        height: girl.height
                        visible: integratedPinpad.getChecked() && (pinpads.count == 0)
                        leftPadding: title.leftPadding
                        spacing: leftPadding

                        Column {
                            width: parent.width -
                                   girl.width -
                                   parent.leftPadding -
                                   parent.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: title.font.pixelSize

                            Label {
                                id: pinpadsNotFoundLabel
                                width: parent.width
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: qsTr("Терминалы не найдены")
                                font {
                                    pixelSize: 0.6 * 0.09 * mainColumn.width
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Bold
                                    bold: true
                                }
                                color: "#979797"
                                clip: true
                                elide: "ElideRight"
                                maximumLineCount: 2
                                wrapMode: Label.WordWrap
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                            }

                            Column {
                                width: parent.width
                                spacing: 0.5 * parent.spacing
                                anchors.horizontalCenter: parent.horizontalCenter

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
                            visible: pinpadsNotFoundRow.visible
                            source: "qrc:/ico/settings/girl.png"
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    Column {
                        width: parent.width
                        spacing: 0.5 * parent.spacing

                        SettingsComponents.InfoToggle {
                            id: pinpad2can
                            width: externalPinpad.width
                            icoHeight: externalPinpad.icoHeight
                            icoWidth: icoHeight
                            itemLogo: "qrc:/ico/settings/2can.png"
                            itemTitle: qsTr("2can")
                            itemSubscription: qsTr("Интеграция с платёжным сервисом")
                            onSwitched: {
                                changePinpad("2CAN")
                            }
                        }

                        SettingsComponents.ChoosenItemSimple {
                            id: pinpad2canCredentials
                            visible: pinpad2can.getChecked()
                            leftPadding: payQrSberbank.leftPadding
                            width: payQrSberbank.width
                            height: payQrSberbank.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            title: root.is2canLoggedIn ? "m.savchenko@dreamkas.ru" : "Авторизация в 2can"
                            fontPixelSize: (root.is2canLoggedIn ? 0.8 : 1) * payQrSberbank.fontPixelSize
                            icoPath: "qrc:/ico/settings/language.png"
                            icoHeight: checkingAccount.icoHeight
                            isApplied: root.is2canLoggedIn
                            appliedMsg: "Вход выполнен"
                            onClicked: {
                                root.openPage("qrc:/qml/pages/subpages/settings/Login2can.qml")
                            }
                        }

                        SettingsComponents.ChoosenItemSimple {
                            id: pinpad2canSettings
                            visible: pinpad2can.getChecked() && root.is2canLoggedIn
                            leftPadding: payQrSberbank.leftPadding
                            width: payQrSberbank.width
                            height: payQrSberbank.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            title: "Настройки 2can"
                            fontPixelSize: payQrSberbank.fontPixelSize
                            icoPath: "qrc:/ico/settings/cast.png"
                            icoHeight: checkingAccount.icoHeight
                            onClicked: {
                                root.openPage("qrc:/qml/pages/subpages/settings/Pinpad2canSettings.qml")
                            }
                        }
                    }
                }
            }
        }
    }
}
