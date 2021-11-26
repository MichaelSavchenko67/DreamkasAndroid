import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Button {
    property var buttonTitle: ""
    property var connectedMsgTitle: ""
    property var modelIcoPath: ""

    background: Rectangle {
        anchors.fill: parent
        color: "#F6F6F6"
        radius: 16

        Row {
            id: printerTypeRow
            anchors.fill: parent
            leftPadding: 0.042 * parent.width

            Image {
                id: levelIco
                anchors.verticalCenter: parent.verticalCenter
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                source: (modelIcoPath.length > 0) ? modelIcoPath : "qrc:/ico/settings/signal_100_percent.png"
            }

            Column {
                width: parent.width - levelIco.width - chooseIco.width - 2 * parent.leftPadding
                anchors.verticalCenter: levelIco.verticalCenter
                spacing: 0.25 * networkName.font.pixelSize

                Label {
                    id: networkName
                    width: parent.width
                    text: qsTr(buttonTitle)
                    font {
                        pixelSize: 0.5 * 0.09 * printerTypeRow.width
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
                        id: connectedIco
                        anchors.verticalCenter: parent.verticalCenter
                        width: connectedMsg.font.pixelSize
                        height: width
                        source: "qrc:/ico/menu/success_ico_small.png"
                    }

                    Label {
                        id: connectedMsg
                        text: qsTr(connectedMsgTitle)
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

                    Image {
                        visible: (modelIcoPath.length > 0)
                        anchors.verticalCenter: parent.verticalCenter
                        width: connectedIco.width
                        height: width
                        source: "qrc:/ico/settings/signal_100_percent.png"
                    }
                }
            }

            Image {
                id: chooseIco
                anchors.verticalCenter: parent.verticalCenter
                width: 0.09 * printerTypeRow.width
                height: width
                source: "qrc:/ico/menu/choose_right.png"
            }
        }
    }

    onClicked: {
        console.log("[ScanWiFiNetworks.qml]\tChoosen network with index: ")
        root.openPage("qrc:/qml/pages/subpages/ConnectedPrinterInfo.qml")
        rootStack.currentItem.deviceName = networkName.text
        rootStack.currentItem.level = "qrc:/ico/settings/signal_100_percent.png"
        rootStack.currentItem.levelName = getLevelName("Отличный")
        rootStack.currentItem.plantNum = "57283733"
        rootStack.currentItem.macAddress = "00:26:57:00:1f:02"
        rootStack.currentItem.isConnected = true
    }
}
