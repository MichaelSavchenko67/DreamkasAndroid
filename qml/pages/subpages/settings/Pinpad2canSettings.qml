import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents
import "qrc:/qml/pages/subpages/settings" as SettingsSubpages

Page {
    id: pinpad2canSettingsPage
    Layout.fillWidth: true
    Layout.fillHeight: true

    property bool isUsbConnected: false
    property bool isBluetoothConnected: false
    property bool isTap2goConnected: false
    property bool isTtkConnected: false

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Настройки 2can")
            resetAddRightMenuButton()
            resetAddRightMenuButton2()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Column {
        id: mainColumn
        width: 0.9 * parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0.05 * parent.width
        topPadding: 1.5 * spacing

        Rectangle {
            width: parent.width
            height: parent.height -
                    parent.topPadding -
                    2 * parent.spacing

            ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.vertical.width: 8
                contentData: Column {
                    width: parent.width
                    spacing: mainColumn.spacing

                    Column {
                        width: parent.width
                        spacing: mainColumn.spacing
                        leftPadding: spacing

                        Label {
                            id: physicalPinpadsGroupTitle
                            width: physicalPinpadsColumn.width
                            visible: true
                            text: qsTr("Оплата через мобильный терминал")
                            font {
                                pixelSize: usb2canButton.fontPixelSize
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "black"
                            clip: true
                            elide: Label.ElideRight
                            maximumLineCount: 2
                            wrapMode: Label.WordWrap
                            verticalAlignment: Label.AlignVCenter
                        }

                        Rectangle {
                            id: physicalPinpadsGroup
                            width: parent.width - parent.leftPadding
                            height: physicalPinpadsColumn.height + parent.leftPadding
                            anchors.horizontalCenter: parent.horizontalCenter
                            border.color: "#979797"
                            border.width: 1
                            radius: 8

                            Column {
                                id: physicalPinpadsColumn
                                width: parent.width - parent.leftPadding
                                anchors.centerIn: parent
                                spacing: mainColumn.spacing

                                SettingsComponents.ChoosenItemSimple {
                                    id: usb2canButton
                                    width: mainColumn.width - 2 * mainColumn.spacing
                                    height: 0.2 * width
                                    leftPadding: 0.042 * mainColumn.width
                                    title: "Подключение по USB"
                                    fontPixelSize: 0.045 * mainColumn.width
                                    icoPath: "qrc:/ico/settings/usb.png"
                                    icoHeight: 0.09 * width
                                    isApplied: isUsbConnected
                                    appliedMsg: isUsbConnected ? "Подключено" : "Подключите по USB"
                                    isChooseVisible: false
                                    onClicked: {
                                        isUsbConnected = !isUsbConnected
                                    }
                                }

                                SettingsComponents.ChoosenItemSimple {
                                    width: usb2canButton.width
                                    height: usb2canButton.height
                                    leftPadding: usb2canButton.leftPadding
                                    title: "Подключение по Bluetooth"
                                    fontPixelSize: usb2canButton.fontPixelSize
                                    icoPath: "qrc:/ico/settings/bluetooth.png"
                                    icoHeight: usb2canButton.icoHeight
                                    isChooseVisible: false
                                    onClicked: {
                                        isBluetoothConnected = !isBluetoothConnected
                                    }
                                }

                                ListView {
                                    id: bluetoothReaders
                                    width: parent.width - parent.spacing
                                    height: 1.1 * usb2canButton.height * count
                                    visible: isBluetoothConnected && (bluetoothReaders.count > 0)
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    clip: true
                                    model: ListModel {
                                        id: pinpadsList

                                        ListElement {
                                            deviceName: "MPOS 0000000001"
                                            isConnected: false
                                        }

                                        ListElement {
                                            deviceName: "MPOS 0000000002"
                                            isConnected: false
                                        }

                                        ListElement {
                                            deviceName: "MPOS 0000000003"
                                            isConnected: true
                                        }
                                    }
                                    delegate: Column {
                                        id: delegateFrame
                                        width: 1.1 * usb2canButton.width
                                        height: 1.1 * usb2canButton.height
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        SettingsComponents.ChoosenItemSimple {
                                            id: delegateItem
                                            width: 0.8 * usb2canButton.width
                                            height: 0.8 * usb2canButton.height
                                            anchors.centerIn: parent
                                            leftPadding: usb2canButton.leftPadding
                                            title: deviceName
                                            fontPixelSize: 0.9 * usb2canButton.fontPixelSize
                                            icoPath: ""
                                            pushUpColor: "transparent"
                                            pushDownColor: "#F6F6F6"
                                            icoHeight: usb2canButton.icoHeight
                                            isApplied: isConnected
                                            appliedMsg: isConnected ? "Подключено" : "Нажмите для подключения"
                                            isChooseVisible: false
                                            onClicked: {
                                            }
                                        }

                                        Row {
                                            width: usb2canButton.width
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            leftPadding: (usb2canButton.width - delegateItem.width - 0.5 * delegateItem.leftPadding)

                                            SaleComponents.Line {
                                                width: parent.width - parent.leftPadding
                                            }
                                        }
                                    }
                                    ScrollBar.vertical: ScrollBar {
                                        id: scroll
                                        policy: ScrollBar.AsNeeded
                                        width: 8
                                    }
                                }

                                Label {
                                    width: parent.width - parent.spacing
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: !bluetoothReaders.visible
                                    text: qsTr("- включите терминал\n- нажмите на Подключение по Bluetooth\n- сопрягите устройство\n- вернитесь в приложении для настройки")
                                    font {
                                        pixelSize: 0.85 * usb2canButton.fontPixelSize
                                        family: "Roboto"
                                        styleName: "normal"
                                        weight: Font.Normal
                                    }
                                    color: accessCodeLabel.color
                                    clip: accessCodeLabel.clip
                                    elide: accessCodeLabel.elide
                                    maximumLineCount: 5
                                    wrapMode: Label.WordWrap
                                    leftPadding: usb2canButton.leftPadding
                                    verticalAlignment: Label.AlignVCenter
                                }
                            }
                        }

                        Label {
                            id: tap2goGroup
                            width: physicalPinpadsGroupTitle.width
                            text: qsTr("Оплата через приложение tap2go")
                            font: physicalPinpadsGroupTitle.font
                            color: physicalPinpadsGroupTitle.color
                            clip: physicalPinpadsGroupTitle.clip
                            elide: physicalPinpadsGroupTitle.elide
                            maximumLineCount: physicalPinpadsGroupTitle.maximumLineCount
                            wrapMode: physicalPinpadsGroupTitle.wrapMode
                            verticalAlignment: physicalPinpadsColumn.verticalCenter
                        }

                        Rectangle {
                            width: physicalPinpadsGroup.width
                            height: tap2goColumn.height + parent.leftPadding
                            anchors.horizontalCenter: parent.horizontalCenter
                            border.color: "#979797"
                            border.width: 1
                            radius: 8

                            Column {
                                id: tap2goColumn
                                width: physicalPinpadsColumn.width
                                anchors.centerIn: parent
                                spacing: physicalPinpadsColumn.spacing

                                Rectangle {
                                    width: usb2canButton.width
                                    height: usb2canButton.height
                                    clip: true
                                    color: "#F6F6F6"
                                    radius: 8

                                    SettingsComponents.ButtonHyperlink {
                                        id: installTap2go
                                        width: parent.width - 2 * leftPadding
                                        height: 0.8 * parent.height
                                        leftPadding: 0.5 * usb2canButton.leftPadding
                                        anchors.centerIn: parent
                                        title: "Установите «tap2go»"
                                        icoTitle: "Перейти в Google Play"
                                        icoPath: "qrc:/ico/settings/google_play_market.png"
                                        onGo: {
                                        }
                                    }
                                }

                                SettingsComponents.ChoosenItemSimple {
                                    width: usb2canButton.width
                                    height: usb2canButton.height
                                    leftPadding: usb2canButton.leftPadding
                                    title: "tap2go NFC"
                                    fontPixelSize: usb2canButton.fontPixelSize
                                    icoPath: "qrc:/ico/settings/nfc.png"
                                    icoHeight: 0.9 * usb2canButton.icoHeight
                                    isApplied: isTap2goConnected
                                    appliedMsg: isTap2goConnected ? "Подключено" : "Нажмите для подключения"
                                    isChooseVisible: false
                                    onClicked: {
                                        isTap2goConnected = !isTap2goConnected
                                    }
                                }

                                Column {
                                    id: accessCode
                                    width: parent.width
                                    spacing: 0.25 * parent.spacing

                                    Label {
                                        id: accessCodeLabel
                                        width: parent.width
                                        text: qsTr("Код авторизации")
                                        font {
                                            pixelSize: tap2goGroup.font.pixelSize
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
                                        id: accessCoderRow
                                        width: parent.width
                                        height: eyeButton.height * eyeButton.scale
                                        property bool passwordView: false

                                        TextField {
                                            id: accessCodeField
                                            width: parent.width - eyeButton.implicitBackgroundWidth
                                            text: qsTr("123123123")
                                            placeholderText: qsTr((text.length === 0) ? "Код авторизации" : text)
                                            placeholderTextColor: "#979797"
                                            font: tap2goGroup.font
                                            color: "#0064B4"
                                            inputMethodHints: Qt.ImhDigitsOnly
                                            echoMode: accessCoderRow.passwordView ? TextInput.Normal : TextInput.Password
                                        }

                                        ToolButton {
                                            id: eyeButton
                                            scale: 0.5
                                            anchors.verticalCenter: accessCodeField.verticalCenter
                                            enabled: (accessCodeField.text.length > 0)
                                            contentItem: Image {
                                                source: accessCoderRow.passwordView ? "qrc:/ico/settings/eye.png" : "qrc:/ico/settings/eye_off.png"
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
                                                accessCoderRow.passwordView = !accessCoderRow.passwordView
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Label {
                            id: ttkGroup
                            width: physicalPinpadsGroupTitle.width
                            text: qsTr("Оплата через приложение TTK")
                            font: physicalPinpadsGroupTitle.font
                            color: physicalPinpadsGroupTitle.color
                            clip: physicalPinpadsGroupTitle.clip
                            elide: physicalPinpadsGroupTitle.elide
                            maximumLineCount: physicalPinpadsGroupTitle.maximumLineCount
                            wrapMode: physicalPinpadsGroupTitle.wrapMode
                            verticalAlignment: physicalPinpadsColumn.verticalCenter
                        }

                        Rectangle {
                            width: physicalPinpadsGroup.width
                            height: ttkColumn.height + parent.leftPadding
                            anchors.horizontalCenter: parent.horizontalCenter
                            border.color: "#979797"
                            border.width: 1
                            radius: 8

                            Column {
                                id: ttkColumn
                                width: physicalPinpadsColumn.width
                                anchors.centerIn: parent
                                spacing: physicalPinpadsColumn.spacing

                                Rectangle {
                                    width: usb2canButton.width
                                    height: usb2canButton.height
                                    clip: true
                                    color: "#F6F6F6"
                                    radius: 8

                                    SettingsComponents.ButtonHyperlink {
                                        id: installTtk
                                        width: parent.width - 2 * leftPadding
                                        height: 0.8 * parent.height
                                        leftPadding: 0.5 * usb2canButton.leftPadding
                                        anchors.centerIn: parent
                                        title: "Установите «TTK»"
                                        icoTitle: "Перейти в Google Play"
                                        icoPath: "qrc:/ico/settings/google_play_market.png"
                                        onGo: {
                                        }
                                    }
                                }

                                SettingsComponents.ChoosenItemSimple {
                                    width: usb2canButton.width
                                    height: usb2canButton.height
                                    leftPadding: usb2canButton.leftPadding
                                    title: "TTK NFC"
                                    fontPixelSize: usb2canButton.fontPixelSize
                                    icoPath: "qrc:/ico/settings/nfc.png"
                                    icoHeight: 0.9 * usb2canButton.icoHeight
                                    isApplied: isTtkConnected
                                    appliedMsg: isTtkConnected ? "Подключено" : "Нажмите для подключения"
                                    isChooseVisible: false
                                    onClicked: {
                                        isTtkConnected = !isTtkConnected
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
