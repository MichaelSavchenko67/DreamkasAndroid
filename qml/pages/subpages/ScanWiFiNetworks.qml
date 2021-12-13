import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: scanWiFiNetworks
    Layout.fillHeight: true
    Layout.fillWidth: true

    property bool isNetworksFound: true
    property var connectedSSID: "VIKI PRINT WIFI 0493099329"

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Подключение ККТ")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
            enterPasswordPopup.open()
        }
    }

    function getLevelIco(level) {
        let percent = level / 25

        if (percent <= 1) {
            return "qrc:/ico/settings/signal_25_percent.png"
        } else if (percent <= 2) {
            return "qrc:/ico/settings/signal_50_percent.png"
        } else if (percent <= 3) {
            return "qrc:/ico/settings/signal_75_percent.png"
        } else if (percent <= 4) {
            return "qrc:/ico/settings/signal_100_percent.png"
        }

        return ""
    }

    function getLevelName(level) {
        let percent = level / 25

        if (percent <= 1) {
            return "Слабый"
        } else if (percent <= 2) {
            return "Средний"
        } else if (percent <= 3) {
            return "Хороший"
        } else if (percent <= 4) {
            return "Отличный"
        }

        return ""
    }

    SettingsComponents.EnterPasswordPopup {
        id: enterPasswordPopup
        onEntered: {
            console.log("Entered password: " + enteredPassword)
        }
    }

    contentData: Rectangle {
        anchors.fill: parent
        color: "#00FFFFFF"
        border.width: 0

        Column {
            anchors.fill: parent
            visible: isNetworksFound
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: qsTr(isPrinterConnected ? "Устройство подключено" : "Выберите устройство")
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
                id: networks
                width: parent.width
                height: parent.height - title.height
                clip: true
                model: ListModel {
                    id: networksList

                    ListElement {
                        ssid: "VIKI PRINT WIFI 0493099329"
                        plantNum: "03849292722"
                        level: 25
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283734"
                        plantNum: "03849292902"
                        level: 50
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283735"
                        plantNum: "03849292725"
                        level: 75
                        isPassNeeded: false
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                        isPassNeeded: true
                    }
                }
                delegate: ItemDelegate {
                    width: parent.width
                    height: network.height

                    Rectangle {
                        anchors.fill: parent
                        color: (ssid !== connectedSSID) ? "#00FFFFFF" : "#F6F6F6"
                        radius: 16

                        Row {
                            id: network
                            width: parent.width
                            height: 2.56 * levelIco.height
                            leftPadding: 0.7 * title.topPadding

                            Image {
                                id: levelIco
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * parent.width
                                height: width
                                source: getLevelIco(level)
                            }

                            Column {
                                width: parent.width - levelIco.width - (lockNetworkIco.visible ? lockNetworkIco.width : 0) - chooseIco.width - 2 * parent.leftPadding
                                height: levelIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    id: networkName
                                    width: parent.width
                                    text: qsTr(ssid)
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
                                        text: qsTr((ssid === connectedSSID) ? "Подключено" : plantNum)
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
                                id: lockNetworkIco
                                visible: isPassNeeded
                                anchors.verticalCenter: parent.verticalCenter
                                width: levelIco.width
                                height: width
                                source: "qrc:/ico/settings/lock.png"
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
                        ListView.currentIndex = index
                        console.log("[ScanWiFiNetworks.qml]\tChoosen network with index: " + index)
                        root.openPage("qrc:/qml/pages/subpages/ConnectedPrinterInfo.qml")
                        rootStack.currentItem.deviceName = qsTr(ssid)
                        rootStack.currentItem.level = levelIco.source
                        rootStack.currentItem.levelName = getLevelName(level)
                        rootStack.currentItem.plantNum = plantNum
                        rootStack.currentItem.macAddress = "00:26:57:00:1f:02"
                        rootStack.currentItem.isConnected = (ssid === connectedSSID)
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
            visible: !isNetworksFound
            width: parent.width
            anchors.centerIn: parent
            spacing: title.font.pixelSize

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Устройства не найдены")
                font {
                    pixelSize: title.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                clip: true
                elide: "ElideRight"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Image {
                width: 0.45 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/ico/settings/signal_off.png"
            }

            SaleComponents.Button_1 {
                id: connectionButton
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.6 * parent.width
                height: 0.2 * width
                borderWidth: 0
                backRadius: 8
                buttonTxt: qsTr("ПОДКЛЮЧИТЬ ПО IP-АДРЕСУ")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    root.openPage("qrc:/qml/pages/subpages/printer/ConnectionByIp.qml")
                }
            }
        }
    }
}
