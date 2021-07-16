import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: choosePrinterType
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            setMainPageTitle("Подключение ККТ")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Column {
        anchors.fill: parent
        spacing: title.font.pixelSize

        Column {
            id: connectedPrinter
            visible: isPrinterConnected
            width: parent.width
            height: connectedPrinterTitle.contentHeight + connectedPrinterDelegate.height + spacing
            spacing: title.font.pixelSize

            Label {
                id: connectedPrinterTitle
                width: parent.width
                text: qsTr("Подключенное устройство")
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

            Button {
                id: connectedPrinterDelegate
                width: parent.width - printerTypeRow.leftPadding
                height: 2.56 * 0.09 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                background: Rectangle {
                    anchors.fill: parent
                    color: "#F6F6F6"
                    radius: 16

                    Row {
                        id: printerTypeRow
                        anchors.fill: parent
                        leftPadding: 0.7 * title.topPadding

                        Image {
                            id: levelIco
                            anchors.verticalCenter: parent.verticalCenter
                            width: 0.09 * parent.width
                            height: width
                            source: "qrc:/ico/settings/signal_100_percent.png"
                        }

                        Column {
                            width: parent.width - levelIco.width - chooseIco.width - 2 * parent.leftPadding
                            anchors.verticalCenter: levelIco.verticalCenter
                            spacing: 0.25 * networkName.font.pixelSize

                            Label {
                                id: networkName
                                width: parent.width
                                text: qsTr("VIKI PRINT 57 283733")
                                font {
                                    pixelSize: 0.5 * levelIco.height
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Normal
                                }
                                color: "black"
                                clip: true
                                elide: "ElideRight"
                                verticalAlignment: Label.AlignTop
                                leftPadding: font.pixelSize
                            }

                            Row {
                                width: parent.width
                                leftPadding: networkName.leftPadding
                                spacing: 0.25 * connectedMsg.font.pixelSize

                                Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    visible: (ssid === connectedSSID)
                                    width: connectedMsg.font.pixelSize
                                    height: width
                                    source: "qrc:/ico/menu/success_ico_small.png"
                                }

                                Label {
                                    id: connectedMsg
                                    text: "Подключено"
                                    font {
                                        pixelSize: 0.83 * networkName.font.pixelSize
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

                        Image {
                            id: chooseIco
                            anchors.verticalCenter: parent.verticalCenter
                            width: levelIco.width
                            height: width
                            source: "qrc:/ico/menu/choose_right.png"
                        }
                    }
                }

                onClicked: {
                    console.log("[ScanWiFiNetworks.qml]\tChoosen network with index: ")
                    root.openPage("qrc:/qml/pages/subpages/ConnectedPrinterInfo.qml")
                    rootStack.currentItem.deviceName = networkName.text
                    rootStack.currentItem.level = levelIco.source
                    rootStack.currentItem.levelName = getLevelName("100")
                    rootStack.currentItem.plantNum = "57283733"
                    rootStack.currentItem.macAddress = "00:26:57:00:1f:02"
                    rootStack.currentItem.isConnected = true
                }
            }
        }

        Column {
            width: parent.width
            height: parent.height - connectedPrinter.height - parent.spacing
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: qsTr("Выберите устройство")
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

            ListView {
                id: printerTypes
                width: parent.width
                height: parent.height - title.height
                clip: true
                model: ListModel {
                    id: printerTypesList

                    ListElement {
                        manufacturer: "Дримкас"
                        models: "Вики Принт 57, Вики Принт 57+, Вики Принт 80"
                        logo: "qrc:/ico/printer/dreamkas.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }
                }
                delegate: ItemDelegate {
                    id: printerTypeDelegate
                    width: parent.width
                    height: 2.56 * 0.09 * parent.width

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        radius: 16

                        Row {
                            id: printerType
                            width: parent.width
                            height: 0.8 * parent.height
                            anchors.verticalCenter: manufacturerLogo.verticalCenter
                            leftPadding: 0.7 * title.topPadding

                            Image {
                                id: manufacturerLogo
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * parent.width
                                height: width
                                source: logo
                            }

                            Column {
                                width: parent.width - manufacturerLogo.width - chooseIco.width - 2 * parent.leftPadding
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 0.25 * printerTypeName.font.pixelSize

                                Label {
                                    id: printerTypeName
                                    width: parent.width
                                    text: qsTr(manufacturer)
                                    font {
                                        pixelSize: 0.5 * manufacturerLogo.height
                                        family: "Roboto"
                                        styleName: "normal"
                                        weight: Font.Normal
                                    }
                                    color: "black"
                                    clip: true
                                    elide: "ElideRight"
                                    verticalAlignment: Label.AlignTop
                                    leftPadding: font.pixelSize
                                }

                                Label {
                                   width: parent.width

                                   leftPadding: printerTypeName.leftPadding
                                   text: qsTr("Поддерживаемые устройства: " + models)
                                   font {
                                       pixelSize: 0.67 * printerTypeName.font.pixelSize
                                       family: "Roboto"
                                       styleName: "normal"
                                       weight: Font.Normal
                                   }
                                   color: "#979797"
                                   clip: true
                                   elide: "ElideRight"
                                   verticalAlignment: Label.AlignBottom
                                   maximumLineCount: 3
                                   wrapMode: Label.WordWrap
                                }
                            }

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                width: manufacturerLogo.width
                                height: width
                                source: "qrc:/ico/menu/choose_right.png"
                            }
                        }
                    }

//                    onClicked: {
//                        ListView.currentIndex = index
//                        console.log("[ScanWiFiNetworks.qml]\tChoosen printerType with index: " + index)
//                        root.openPage("qrc:/qml/pages/subpages/ConnectedPrinterInfo.qml")
//                        rootStack.currentItem.deviceName = qsTr(ssid)
//                        rootStack.currentItem.level = manufacturerLogo.source
//                        rootStack.currentItem.levelName = getLevelName(level)
//                        rootStack.currentItem.plantNum = plantNum
//                        rootStack.currentItem.macAddress = "00:26:57:00:1f:02"
//                        rootStack.currentItem.isConnected = (ssid === connectedSSID)
//                    }
                }
                ScrollBar.vertical: ScrollBar {
                    id: scroll
                    policy: ScrollBar.AsNeeded
                    width: 8
                }
            }
        }
    }
}
