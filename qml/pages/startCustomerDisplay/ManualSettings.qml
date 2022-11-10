import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: manualConnectionPage
    width: parent.width
    height: parent.height
    header: Row {
        id: toolBar
        width: parent.width
        leftPadding: 0.25 * (width - 0.896 * width)
        topPadding: 1.5 * 0.04375 * parent.width
        bottomPadding: topPadding
        spacing: 0.25 * backButton.width

        SettingsComponents.ToolButtonCustom {
            id: backButton
            visible: true
            height: 1.5 * titleLabel.font.pixelSize
            icon.source: "qrc:/ico/menu/back_blue.png"
            onClicked: {
                root.replacePage("qrc:/qml/pages/startCustomerDisplay/CashboxWait.qml")
            }
        }

        Label {
            id: titleLabel
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Данные сети")
            font {
                pixelSize: 0.04375 * manualConnectionPage.width
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
                bold: true
            }
            color: "black"
            elide: Label.ElideRight
            horizontalAlignment: Label.AlignLeft
            verticalAlignment: Label.AlignVCenter
        }
    }
    contentData: Column {
        width: 0.896 * parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        Column {
            id: infoColumn
            width: parent.width
            spacing: parent.topPadding

            Column {
                width: parent.width
                spacing: titleLabel.font.pixelSize

                Column {
                    id: networkNameColumn
                    width: parent.width - 2 * parent.leftPadding
                    spacing: 0.32 * parent.spacing

                    Label {
                        id: networkNameTitle
                        width: parent.width
                        text: qsTr("Название сети")
                        font {
                            pixelSize: 0.75 * titleLabel.font.pixelSize
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

                    TextField {
                        id: networkNameField
                        width: parent.width
                        enabled: false
                        text: "Dreamkas"
                        font {
                            pixelSize: 0.9 * titleLabel.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#0064B4"
                    }
                }

                Column {
                    id: ipColumn
                    width: networkNameColumn.width
                    spacing: networkNameColumn.spacing

                    Label {
                        id: ipTitle
                        width: parent.width
                        text: qsTr("IP-адрес")
                        font: networkNameTitle.font
                        color: networkNameTitle.color
                        clip: networkNameTitle.clip
                        elide: networkNameTitle.elide
                        horizontalAlignment: networkNameTitle.horizontalAlignment
                        verticalAlignment: networkNameTitle.verticalAlignment
                    }

                    TextField {
                        id: ipField
                        width: parent.width
                        enabled: networkNameField.enabled
                        text: "192.168.255.255"
                        font: networkNameField.font
                        color: networkNameField.color
                    }
                }

                Column {
                    id: portColumn
                    width: networkNameColumn.width
                    spacing: networkNameColumn.spacing

                    Label {
                        id: portTitle
                        width: parent.width
                        text: qsTr("Порт")
                        font: networkNameTitle.font
                        color: networkNameTitle.color
                        clip: networkNameTitle.clip
                        elide: networkNameTitle.elide
                        horizontalAlignment: networkNameTitle.horizontalAlignment
                        verticalAlignment: networkNameTitle.verticalAlignment
                    }

                    TextField {
                        id: portField
                        width: parent.width
                        enabled: networkNameField.enabled
                        text: "8081"
                        font: networkNameField.font
                        color: networkNameField.color
                    }
                }
            }
        }
    }
}
