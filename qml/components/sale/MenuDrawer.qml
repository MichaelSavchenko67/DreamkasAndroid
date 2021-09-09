import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/settings" as SettingsComponents

Drawer {
    id: drawer

    property var avatarSource: ""

    contentData: Page {
        id: menuBar
        anchors.fill: parent
        header: Rectangle {
            height: 0.25 * menuBar.height
            width: menuBar.width
            color: "#5C7490"

            Column {
                id: menuBarColumn
                anchors.fill: parent
                topPadding: 0.07 * parent.width
                leftPadding: 0.08 * parent.width
                spacing: 0.5 * topPadding

                Image {
                    id: logo
                    height: 0.3 * parent.height
                    width: height
                    source: "qrc:/ico/menu/ico_short.png"
                }

                Row {
                    width: parent.width - 2 * parent.leftPadding

                    Column {
                        width: parent.width - avatar.width
                        height: menuBarColumn.height - logo.height - menuBarColumn.spacing - 2 * menuBarColumn.topPadding
                        anchors.verticalCenter: menuBarColumn.verticalCenter

                        Label {
                            id: userName
                            height: 0.3 * menuBarColumn.height
                            width: parent.width
                            text: qsTr("Савченко Михаил Андреевич")
                            font {
                                pixelSize: 0.38 * height
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Bold
                                bold: true
                            }
                            clip: true
                            color: "white"
                            maximumLineCount: 2
                            wrapMode: Label.WordWrap
                            elide: Label.ElideRight
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignVCenter
                        }

                        Row {
                            width: parent.width
                            spacing: 0.5 * ruleName.font.pixelSize

                            Image {
                                id: ruleIco
                                height: ruleName.font.pixelSize
                                anchors.verticalCenter: ruleName.verticalCenter
                                source: "qrc:/ico/settings/tie.png"
                                fillMode: Image.PreserveAspectFit
                            }

                            Label {
                                id: ruleName
                                width: parent.width - ruleIco.width - parent.spacing
                                text: qsTr("Администратор")
                                font {
                                    pixelSize: 0.83 * userName.font.pixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Bold
                                    bold: true
                                }
                                clip: true
                                color: "white"
                                opacity: 0.75
                                horizontalAlignment: Qt.AlignLeft
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }
                    }

                    Rectangle {
                        id: activeFrame
                        border.width: 3
                        border.color: "#4DA03F"
                        color: "transparent"
                        width: 0.3 * parent.width
                        height: width
                        radius: width
                        anchors.verticalCenter: userName.verticalCenter

                        SettingsComponents.Avatar {
                            id: avatar
                            width: parent.width - 2 * parent.border.width
                            anchors.centerIn: parent
                            avatarSrc: ""
                            userNameFull: "Савченко Михаил Андреевич"
                        }
                    }
                }
            }
        }
        contentData: ListView {
            id: menuListView
            anchors.fill: parent
            clip: true
            model: ListModel {
                id: menuItems

                property var actions : {
                    "Формирование чека": function() { rootStack.pop(null) },
                    "Подключить ККТ": function() { root.openPage("qrc:/qml/pages/subpages/printer/ChoosePrinterType.qml") },
                    "Отключить ККТ": function() { root.openDisconnectPrinterDialog() },
                    "Открыть смену": function() { root.openShiftDialog() },
                    "Закрыть смену": function() { root.closeShiftDialog() },
                    "Кабинет Дримкас": function() { root.openPage("qrc:/qml/pages/subpages/CabinetConnection.qml") },
                    "Пользователи": function() { root.openPage("qrc:/qml/pages/subpages/users/UsersPage.qml") },
                    "Заказы": function() { root.openPage("qrc:/qml/pages/subpages/Orders.qml") },
                    "Банковский терминал": function() { root.openPage("qrc:/qml/pages/subpages/settings/Multipos.qml") },
                    "Сервисные операции": function() { root.openPage("qrc:/qml/pages/subpages/settings/MultiposService.qml") },
                    "Система налогооблажения": function() { root.openPage("qrc:/qml/pages/subpages/DefaultSno.qml") },
                    "X-отчёт": function() { root.openXReportDialog() },
                    "Ввод цены товара": function() { root.openEnterCostDialog("Яблоки красные", "Цена, \u20BD/кг", "Неправильное значение, введите снова") },
                    "Ввод количества товара": function() { root.openEnterAmountDialog("Яблоки красные", "Количество, кг", "Неправильное значение, введите снова") },
                    "Ввод суммы платежа": function() { root.openPage("qrc:/qml/pages/subpages/Pay.qml") },
                    "Изъять или внести": function() { root.openPage("qrc:/qml/pages/subpages/InsResTabs.qml") },
                    "Чек коррекции": function() { root.openPage("qrc:/qml/pages/subpages/PurchaseCorrection.qml") },
                    "УТМ": function() { root.openPage("qrc:/qml/pages/subpages/Utm.qml") },
                    "Test Popup": function() { root.openPage("qrc:/qml/components/sale/PopupCashlessPay.qml") }
                }

                ListElement {item: "Формирование чека"}
                ListElement {item: "Подключить ККТ"}
                ListElement {item: "Отключить ККТ"}
                ListElement {item: "Открыть смену"}
                ListElement {item: "Закрыть смену"}
                ListElement {item: "Кабинет Дримкас"}
                ListElement {item: "Пользователи"}
                ListElement {item: "Заказы"}
                ListElement {item: "Банковский терминал"}
                ListElement {item: "Сервисные операции"}
                ListElement {item: "Система налогооблажения"}
                ListElement {item: "X-отчёт"}
                ListElement {item: "Ввод цены товара"}
                ListElement {item: "Ввод количества товара"}
                ListElement {item: "Ввод суммы платежа"}
                ListElement {item: "Изъять или внести"}
                ListElement {item: "Чек коррекции"}
                ListElement {item: "УТМ"}
                ListElement {item: "Test Popup"}
            }

            delegate: ItemDelegate {
                id: menuItem
                width: menuListView.width
                height: (item === "Открыть смену") ? 0 : 0.1 * menuListView.height

                Row {
                    anchors.fill: parent
                    spacing: (statusIco.visible ? 0.5 * (menuBarColumn.leftPadding - statusIco.width) : menuBarColumn.leftPadding)
                    leftPadding: spacing

                    Image {
                        id: statusIco
                        height: menuItemName.font.pixelSize
                        width: height
                        visible: menuItemName.visible
                        anchors.verticalCenter: parent.verticalCenter
                        source: "qrc:/ico/menu/operation_success.png"

                    }

                    Text {
                        id: menuItemName
                        width: parent.width - statusIco.width
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr(item)
                        visible: (menuItem.height > 0)
                        font {
                            pixelSize: 0.83 * userName.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        clip: true
                        color: "black"
                        elide: Text.ElideRight
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }
                onClicked: {
                    console.log("[MenuDrawer.qml]\t" + (index + 1) + ". "+ menuItemName.text)
                    ListView.currentIndex = index
                    drawer.close()
                    menuItems.actions[item]();
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
