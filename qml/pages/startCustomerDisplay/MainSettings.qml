import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/menu" as MenuComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: mainSettingsPage
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            root.setMenuEnabled(false)
        }
    }

    header: MenuComponents.ToolBarSimple {
        id: toolBar
        title: "Настройки"
    }
    contentData: Column {
        width: 0.896 * parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        bottomPadding: 0.039 * mainSettingsPage.width

        ScrollView {
            width: parent.width
            height: parent.height -
                    disconnectCashboxButton.height -
                    parent.bottomPadding
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.vertical.width: 8

            Column {
                id: mainSettingsColumn
                width: parent.width
                spacing: 0.5 * workingWithoutCashboxRow.height

                Column {
                    id: workingWithoutCashboxRowColumn
                    width: parent.width

                    Row {
                        id: workingWithoutCashboxRow
                        width: parent.width

                        Label {
                            id: workingWithoutCashboxLabel
                            width: parent.width - workingWithoutCashboxSwitch.width
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("Работа без кассы")
                            font {
                                pixelSize: 0.0394 * mainSettingsPage.width
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "black"
                            clip: true
                            elide: Label.ElideRight
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignHCenter
                        }

                        Switch {
                            id: workingWithoutCashboxSwitch
                            anchors.verticalCenter: parent.verticalCenter
                            Material.accent: "#0064B4"
                            onCheckedChanged: {
                            }
                        }
                    }

                    Label {
                        width: parent.width - workingWithoutCashboxSwitch.width
                        text: qsTr("Дисплей покупателя может работать без подключения кассы. В этом случае возможна непрерывная демонстрация рекламы и контента для клиентов магазина")
                        font {
                            pixelSize: 0.7 * 0.04375 * mainSettingsPage.width
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        lineHeight: 1.4
                        color: "#979797"
                        clip: true
                        elide: Label.ElideRight
                        maximumLineCount: 5
                        wrapMode: Label.WordWrap
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                }

                Column {
                    width: workingWithoutCashboxRowColumn.width

                    Row {
                        width: parent.width

                        Label {
                            width: parent.width - purchaseInFirstSwitch.width
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("Показывать чек первым")
                            font: workingWithoutCashboxLabel.font
                            color: workingWithoutCashboxLabel.color
                            clip: workingWithoutCashboxLabel.clip
                            elide: workingWithoutCashboxLabel.elide
                            horizontalAlignment: workingWithoutCashboxLabel.horizontalAlignment
                            verticalAlignment: workingWithoutCashboxLabel.verticalAlignment
                        }

                        Switch {
                            id: purchaseInFirstSwitch
                            anchors.verticalCenter: parent.verticalCenter
                            Material.accent: "#0064B4"
                            onCheckedChanged: {
                            }
                        }
                    }

                    Label {
                        width: parent.width - workingWithoutCashboxSwitch.width
                        text: qsTr("Если данная настройка включена на экране продажи чек будет отображаться первым, если нет - первым отображается крайняя позиция в чеке")
                        font {
                            pixelSize: 0.7 * 0.04375 * mainSettingsPage.width
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        lineHeight: 1.4
                        color: "#979797"
                        clip: true
                        elide: Label.ElideRight
                        maximumLineCount: 5
                        wrapMode: Label.WordWrap
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                }

                Column {
                    width: workingWithoutCashboxRowColumn.width

                    Row {
                        width: parent.width

                        Row {
                            width: parent.width - purchaseInFirstSwitch.width
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 0.5 * workingWithoutCashboxLabel.font.pixelSize

                            Label {
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("Использовать Bluetooth")
                                font: workingWithoutCashboxLabel.font
                                color: workingWithoutCashboxLabel.color
                                clip: workingWithoutCashboxLabel.clip
                                elide: workingWithoutCashboxLabel.elide
                                horizontalAlignment: workingWithoutCashboxLabel.horizontalAlignment
                                verticalAlignment: workingWithoutCashboxLabel.verticalAlignment
                            }

                            Image {
                                height: 1.25 * workingWithoutCashboxLabel.font.pixelSize
                                anchors.verticalCenter: parent.verticalCenter
                                source: "qrc:/ico/settings/bluetooth.png"
                                fillMode: Image.PreserveAspectFit
                            }
                        }

                        Switch {
                            id: bluetoothUsageSwitch
                            anchors.verticalCenter: parent.verticalCenter
                            Material.accent: "#0064B4"
                            onCheckedChanged: {
                            }
                        }
                    }

                    Label {
                        width: parent.width - workingWithoutCashboxSwitch.width
                        text: qsTr("Для активации данной настройки необходимо отключить кассу. Если данная настройка включена, то в качестве основного интерфейса связи будет использоваться Bluetooth")
                        font {
                            pixelSize: 0.7 * 0.04375 * mainSettingsPage.width
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        lineHeight: 1.4
                        color: "#979797"
                        clip: true
                        elide: Label.ElideRight
                        maximumLineCount: 5
                        wrapMode: Label.WordWrap
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                }
            }
        }

        SettingsComponents.DelayButtonCustom {
            id: disconnectCashboxButton
            width: 0.5 * parent.width
            height: 0.112 * parent.width
            title: qsTr("ОТКЛЮЧИТЬ КАССУ")
            titleColor: "red"
            buttonColor: "white"
            progressColor: "red"
            onActivated: {
                visible = false
            }
        }
    }
}
