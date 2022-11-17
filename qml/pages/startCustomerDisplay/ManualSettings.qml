import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/menu" as MenuComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: manualConnectionPage
    width: parent.width
    height: parent.height
    header: MenuComponents.ToolBarSimple {
        id: toolBar
        title: "Данные сети"
    }
    contentData: Column {
        width: 0.896 * parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        Column {
            id: infoColumn
            width: parent.width

            Column {
                width: parent.width
                spacing: 0.04375 * manualConnectionPage.width

                Column {
                    id: networkNameColumn
                    width: parent.width
                    spacing: 0.32 * parent.spacing

                    Label {
                        id: networkNameTitle
                        width: parent.width
                        text: qsTr("Название сети")
                        font {
                            pixelSize: 0.7 * 0.04375 * manualConnectionPage.width
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
                            pixelSize: 0.9 * 0.04375 * manualConnectionPage.width
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
