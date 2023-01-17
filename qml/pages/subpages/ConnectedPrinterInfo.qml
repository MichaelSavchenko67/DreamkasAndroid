import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: connectedPrinterInfo
    Layout.fillHeight: true
    Layout.fillWidth: true

    property var deviceName: ""
    property bool isConnected: false
    property var level: ""
    property var levelName: ""
    property var plantNum: ""
    property var macAddress: ""
    property var dns: "viki_print_" + plantNum

    onDeviceNameChanged: {
        setMainPageTitle(deviceName)
    }

    onFocusChanged: {
        if (focus) {
            setMainPageTitle(deviceName)
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Rectangle {
        anchors.fill: parent
        color: "#00FFFFFF"
        border.width: 0

        Column {
            anchors.fill: parent
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: qsTr("Настройка устройства")
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

            ScrollView {
                width: parent.width
                height: parent.height - title.height - title.topPadding - buttonsGroup.height - 2 * parent.spacing
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                ScrollBar.vertical.width: 8

                Column {
                    width: parent.width
                    spacing: 0.25 * title.font.pixelSize

                    ItemDelegate {
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
                                source: level
                            }

                            Column {
                                width: parent.width - levelIco.width - 2 * parent.leftPadding
                                height: levelIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    id: networkName
                                    width: parent.width
                                    text: qsTr("Уровень сигнала")
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

                                Label {
                                    width: parent.width
                                    text: qsTr(levelName)
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
                        }
                    }

                    ItemDelegate {
                        width: parent.width
                        height: network.height

                        Row {
                            width: parent.width
                            height: 2.56 * levelIco.height
                            leftPadding: title.topPadding

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * parent.width
                                height: width
                                source: "qrc:/ico/settings/factory.png"
                            }

                            Column {
                                width: parent.width - levelIco.width - 2 * parent.leftPadding
                                height: levelIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    width: parent.width
                                    text: qsTr("Заводской номер")
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
                        }
                    }

                    ItemDelegate {
                        width: parent.width
                        height: network.height

                        Row {
                            width: parent.width
                            height: 2.56 * levelIco.height
                            leftPadding: title.topPadding

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * parent.width
                                height: width
                                source: "qrc:/ico/settings/language.png"
                            }

                            Column {
                                width: parent.width - levelIco.width - 2 * parent.leftPadding
                                height: levelIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    width: parent.width
                                    text: qsTr("MAC-адрес")
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

                                Label {
                                    width: parent.width
                                    text: qsTr(macAddress.toUpperCase())
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
                        }
                    }

                    ItemDelegate {
                        width: parent.width
                        height: network.height

                        Row {
                            width: parent.width
                            height: 2.56 * levelIco.height
                            leftPadding: title.topPadding

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * parent.width
                                height: width
                                source: "qrc:/ico/settings/language.png"
                            }

                            Column {
                                width: parent.width - levelIco.width - 2 * parent.leftPadding
                                height: levelIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    width: parent.width
                                    text: qsTr("MAC-адрес")
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

                                Label {
                                    width: parent.width
                                    text: qsTr(macAddress.toUpperCase())
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
                        }
                    }

                    ItemDelegate {
                        width: parent.width
                        height: network.height

                        Row {
                            width: parent.width
                            height: 2.56 * levelIco.height
                            leftPadding: title.topPadding

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * parent.width
                                height: width
                                source: "qrc:/ico/settings/language.png"
                            }

                            Column {
                                width: parent.width - levelIco.width - 2 * parent.leftPadding
                                height: levelIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    width: parent.width
                                    text: qsTr("MAC-адрес")
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

                                Label {
                                    width: parent.width
                                    text: qsTr(macAddress.toUpperCase())
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
                        }
                    }

                    ItemDelegate {
                        width: parent.width
                        height: network.height

                        Row {
                            width: parent.width
                            height: 2.56 * levelIco.height
                            leftPadding: title.topPadding

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * parent.width
                                height: width
                                source: "qrc:/ico/settings/language.png"
                            }

                            Column {
                                width: parent.width - levelIco.width - 2 * parent.leftPadding
                                height: levelIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    width: parent.width
                                    text: qsTr("MAC-адрес")
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

                                Label {
                                    width: parent.width
                                    text: qsTr(macAddress.toUpperCase())
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
                        }
                    }

                    ItemDelegate {
                        width: parent.width
                        height: network.height

                        Row {
                            width: parent.width
                            height: 2.56 * levelIco.height
                            leftPadding: title.topPadding

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                width: 0.09 * parent.width
                                height: width
                                source: "qrc:/ico/settings/language.png"
                            }

                            Column {
                                width: parent.width - levelIco.width - 2 * parent.leftPadding
                                height: levelIco.height
                                anchors.verticalCenter: parent.verticalCenter

                                Label {
                                    width: parent.width
                                    text: qsTr("MAC-адрес")
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

                                Label {
                                    width: parent.width
                                    text: qsTr(macAddress.toUpperCase())
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
                        }
                    }
                }
            }

            Column {
                id: buttonsGroup
                width: parent.width

                SaleComponents.Button_1 {
                    id: connectionButton
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 0.9 * parent.width
                    height: 0.16 * width
                    borderWidth: 0
                    backRadius: 8
                    buttonTxt: qsTr((isConnected ? "ОТКЛЮЧИТЬ" : "ПОДКЛЮЧИТЬ") +" УСТРОЙСТВО")
                    fontSize: 0.27 * height
                    buttonTxtColor: isConnected ? "#415A77" : "white"
                    pushUpColor: isConnected ? "#F6F6F6" : "#415A77"
                    pushDownColor: isConnected ? "#B9B9B9" : "#004075"
                    onClicked: {
                        console.log("[Connect2printer.qml]\t" + (isConnected ? "disconnect" : "connect")+ " printer with dns: " + dns)
                        if (isConnected) {
                            root.openDisconnectPrinterDialog()
                        } else {
                            openPage("qrc:/qml/pages/subpages/ConnectPrinter.qml")
                        }
                    }
                }

                SaleComponents.Button_1 {
                    id: anotherButton
                    visible: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 0.9 * parent.width
                    height: 0.16 * width
                    borderWidth: 0
                    backRadius: 8
                    buttonTxt: qsTr((isConnected ? "ОТКЛЮЧИТЬ" : "ПОДКЛЮЧИТЬ") +" УСТРОЙСТВО")
                    fontSize: 0.27 * height
                    buttonTxtColor: isConnected ? "#415A77" : "white"
                    pushUpColor: isConnected ? "#F6F6F6" : "#415A77"
                    pushDownColor: isConnected ? "#B9B9B9" : "#004075"
                    onClicked: {
                        console.log("[Connect2printer.qml]\t" + (isConnected ? "disconnect" : "connect")+ " printer with dns: " + dns)
                        if (isConnected) {
                            root.openDisconnectPrinterDialog()
                        } else {
                            openPage("qrc:/qml/pages/subpages/ConnectPrinter.qml")
                        }
                    }
                }
            }
        }
    }
}
