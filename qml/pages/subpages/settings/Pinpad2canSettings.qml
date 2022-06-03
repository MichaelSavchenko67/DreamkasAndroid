import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents
import "qrc:/qml/pages/subpages/settings" as SettingsSubpages

Page {
    id: pinpad2canSettingsPage
    Layout.fillWidth: true
    Layout.fillHeight: true

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

        Image {
            id: logoImg
            width: 0.15 * parent.width
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "qrc:/ico/settings/2can_color.png"
        }

        Label {
            id: title
            width: parent.width
            text: qsTr("Выберите тип терминала")
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
        }

        Rectangle {
            width: parent.width
            height: parent.height -
                    logoImg.height -
                    title.contentHeight -
                    title.topPadding -
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
                                width: parent.width - 2 * parent.leftPadding
                                anchors.centerIn: parent
                                spacing: mainColumn.spacing

                                Label {
                                    id: physicalPinpadsGroupTitle
                                    width: parent.width
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

                                SettingsComponents.ChoosenItemSimple {
                                    id: usb2canButton
                                    width: mainColumn.width - 2 * mainColumn.spacing
                                    height: 0.2 * width
                                    leftPadding: 0.042 * mainColumn.width
                                    title: "Мобильный терминал USB"
                                    fontPixelSize: 0.045 * mainColumn.width
                                    icoPath: "qrc:/ico/settings/usb.png"
                                    icoHeight: 0.09 * width
                                    isApplied: true
                                    appliedMsg: "Подключено"
                                    onClicked: {
                                    }
                                }

                                SettingsComponents.ChoosenItemSimple {
                                    width: usb2canButton.width
                                    height: usb2canButton.height
                                    leftPadding: usb2canButton.leftPadding
                                    title: "Мобильный терминал Bluetooth"
                                    fontPixelSize: usb2canButton.fontPixelSize
                                    icoPath: "qrc:/ico/settings/bluetooth.png"
                                    icoHeight: usb2canButton.icoHeight
                                    onClicked: {
                                    }
                                }

                                ListView {
                                    id: bluetoothReaders
                                    width: parent.width - parent.spacing
                                    height: 0.3 * mainColumn.height
                                    visible: (bluetoothReaders.count > 0)
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
                                    delegate: SettingsComponents.ChoosenItemSimple {
                                        width: 0.8 * usb2canButton.width
                                        height: usb2canButton.height
                                        leftPadding: usb2canButton.leftPadding
                                        title: deviceName
                                        fontPixelSize: usb2canButton.fontPixelSize
                                        icoPath: "qrc:/ico/settings/bluetooth.png"
                                        icoHeight: usb2canButton.icoHeight
                                        isApplied: isConnected
                                        appliedMsg: "Подключено"
                                        onClicked: {
                                        }
                                    }
                                    ScrollBar.vertical: ScrollBar {
                                        id: scroll
                                        policy: ScrollBar.AsNeeded
                                        width: 8
                                    }
                                }
                            }
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
                                    isApplied: true
                                    appliedMsg: "Подключено"
                                    onClicked: {
                                    }
                                }
                            }
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
                                    isApplied: true
                                    appliedMsg: "Подключено"
                                    onClicked: {
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
