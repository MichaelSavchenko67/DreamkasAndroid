import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: connectionInfoPage
    width: parent.width
    height: parent.height

    property bool isConnected: true
    property string modelName: "Pixel"
    property string networkName: "Dreamkas WiFi"
    property string ip: "192.168.100.5"
    property int port: 8081

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Дримкас Дисплей")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Column {
        width: parent.width - 2 * title.font.pixelSize
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        topPadding: title.font.pixelSize
        bottomPadding: topPadding
        spacing: height -
                 topPadding -
                 mainColumn.height -
                 disconnectDevice.height -
                 bottomPadding

        Column {
            id: mainColumn
            width: parent.width
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: qsTr("Выберите тип подключения")
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
            }

            Rectangle {
                id: frame
                width: connectionDataMainColumn.width
                height: connectionDataMainColumn.height
                color: "#F6F6F6"
                radius: 16

                Column {
                    id: connectionDataMainColumn
                    width: mainColumn.width
                    height: titleconnectionDataColumn.height + 2 * topPadding
                    leftPadding: connectionStatusIco.width
                    topPadding: 0.75 * leftPadding

                    Column {
                        id: titleconnectionDataColumn
                        width: parent.width - 2 * parent.leftPadding
                        height: connectionStatusRow.height +
                                spacing +
                                infoDelegatesColumn.height
                        anchors.centerIn: parent
                        spacing: 0.25 * title.font.pixelSize

                        Rectangle {
                            width: parent.width
                            height: connectionStatusIco.height +
                                    spacing +
                                    connectedMsg.contentHeight
                            color: "transparent"

                            Row {
                                id: connectionStatusRow
                                anchors.fill: parent
                                spacing: 0.5 * connectedMsg.font.pixelSize

                                Image {
                                    id: connectionStatusIco
                                    width: connectedMsg.font.pixelSize
                                    height: width
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: isConnected ? "qrc:/ico/utm/connect.png" : "qrc:/ico/utm/disconnect.png"
                                }

                                Label {
                                    id: connectedMsg
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: qsTr(isConnected ? "Подключено" : "Отключено")
                                    font {
                                        pixelSize: 0.667 * title.font.pixelSize
                                        family: "Roboto"
                                        styleName: "normal"
                                        weight: Font.Normal
                                    }
                                    color: "#979797"
                                    clip: true
                                    elide: "ElideRight"
                                    verticalAlignment: Label.AlignVCenter
                                }
                            }
                        }

                        Column {
                            id: infoDelegatesColumn
                            width: parent.width
                            height: 4 * deviceNameInfoDelegate.height + 3 * spacing
                            spacing: 4 * parent.spacing

                            SettingsComponents.InfoDelegate {
                                id: deviceNameInfoDelegate
                                icoSrc: "qrc:/ico/settings/responsive.png"
                                titleText: "Устройство"
                                description: modelName
                            }

                            SettingsComponents.InfoDelegate {
                                icoSrc: "qrc:/ico/settings/language.png"
                                titleText: "Название сети"
                                description: networkName
                            }

                            SettingsComponents.InfoDelegate {
                                icoSrc: "qrc:/ico/settings/ip.png"
                                titleText: "IP-адрес устройства"
                                description: ip
                            }

                            SettingsComponents.InfoDelegate {
                                icoSrc: "qrc:/ico/utm/port.png"
                                titleText: "Порт"
                                description: port
                            }
                        }
                    }
                }
            }
        }

        SettingsComponents.DelayButtonCustom {
            id: disconnectDevice
            width: 0.9 * connectionInfoPage.width
            height: 0.16 * width
            visible: isConnected
            title: qsTr("ОТКЛЮЧИТЬ УСТРОЙСТВО")
            titleColor: "red"
            buttonColor: "transparent"
            progressColor: "red"
            onActivated: {
                isConnected = false
                root.closePage()
            }
        }
    }
}
