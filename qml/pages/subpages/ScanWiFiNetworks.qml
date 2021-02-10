import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: scanWiFiNetworks
    Layout.fillHeight: true
    Layout.fillWidth: true

    property bool isNetworksFound: true

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
                leftPadding: topPadding
            }

            ListView {
                id: networks
                width: parent.width
                height: parent.height - title.height
                clip: true
                model: ListModel {
                    id: networksList

                    ListElement {
                        ssid: "VIKI PRINT 57 283733"
                        plantNum: "03849292722"
                        level: 25
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283734"
                        plantNum: "03849292902"
                        level: 50
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283735"
                        plantNum: "03849292725"
                        level: 75
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }

                    ListElement {
                        ssid: "VIKI PRINT 57 283736"
                        plantNum: "03849292156"
                        level: 100
                    }
                }
                delegate: ItemDelegate {
                    width: parent.width
                    height: network.height

                    Row {
                        id: network
                        width: parent.width
                        height: 2.56 * levelIco.height
                        leftPadding: title.topPadding

                        Image {
                            id: levelIco
                            anchors.verticalCenter: parent.verticalCenter
                            width: 0.09 * parent.width
                            height: width
                            source: getLevelIco(level)
                        }

                        Column {
                            width: parent.width - levelIco.width - chooseIco.width - 2 * parent.leftPadding
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
                                    weight: Font.Bold
                                    bold: true
                                }
                                color: "black"
                                clip: true
                                elide: "ElideRight"
                                verticalAlignment: Label.AlignTop
                                leftPadding: font.pixelSize
                            }

                            Label {
                                width: parent.width
                                text: qsTr(plantNum)
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
                                leftPadding: networkName.leftPadding
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

                    onClicked: {
                        ListView.currentIndex = index
                        console.log("[ScanWiFiNetworks.qml]\tChoosen network with index: " + index)
                        rootStack.pop()
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
            anchors.centerIn: parent
            spacing: 2 * title.font.pixelSize

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
        }
    }
}
