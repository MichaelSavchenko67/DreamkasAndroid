import QtQuick 2.12
import QtQuick.Controls 2.12

Drawer {
    id: drawer

    contentData: Page {
        id: menuBar
        anchors.fill: parent
        header: Rectangle {
            height: 0.214 * menuBar.height
            width: menuBar.width
            color: "#4DA13F"

            Image {
                id: logo
                height: 0.3 * parent.height
                width: height
                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin: 0.08 * parent.width
                    topMargin: 0.07 * parent.width
                }
                source: "qrc:/ico/menu/ico_short.png"
            }

            Text {
                id: userName
                height: 0.18 * parent.height
                width:  parent.width - 2 * leftPadding
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    leftMargin: 0.08 * parent.width
                    bottomMargin: 0.07 * parent.width
                }
                text: qsTr("Савченко Михаил")
                font {
                    pixelSize: 0.8 * height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                clip: true
                color: "white"
                elide: Text.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
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
                    "Подключить ККТ": function() { root.openPage("qrc:/qml/pages/subpages/Connect2printer.qml") },
                    "Отключить ККТ": function() { root.openDisconnectPrinterDialog() },
                    "Открыть смену": function() { root.openShiftDialog() },
                    "Закрыть смену": function() { root.closeShiftDialog() },
                    "Кабинет Дримкас": function() { root.openPage("qrc:/qml/pages/subpages/CabinetConnection.qml") },
                    "X-отчёт": function() { root.openXReportDialog() },
                    "Ввод цены товара": function() { root.openEnterAmountDialog("Яблоки красные", "Цена, \u20BD/кг", "Неправильное значение, введите снова") },
                    "Ввод количества товара": function() { root.openEnterAmountDialog("Яблоки красные", "Количество, кг", "Неправильное значение, введите снова") },
                    "Ввод суммы платежа": function() { root.openPage("qrc:/qml/pages/subpages/Pay.qml") }
                }

                ListElement {item: "Формирование чека"}
                ListElement {item: "Подключить ККТ"}
                ListElement {item: "Отключить ККТ"}
                ListElement {item: "Открыть смену"}
                ListElement {item: "Закрыть смену"}
                ListElement {item: "Кабинет Дримкас"}
                ListElement {item: "X-отчёт"}
                ListElement {item: "Ввод цены товара"}
                ListElement {item: "Ввод количества товара"}
                ListElement {item: "Ввод суммы платежа"}
                ListElement {item: "Example 4"}
                ListElement {item: "Example 5"}
                ListElement {item: "Example 6"}
                ListElement {item: "Example 7"}
                ListElement {item: "Example 8"}
                ListElement {item: "Example 9"}
                ListElement {item: "Example 10"}
            }
            delegate: ItemDelegate {
                id: menuItem
                width: menuListView.width
                height: (item === "Открыть смену") ? 0 : 0.1 * menuListView.height

                Row {
                    anchors.fill: parent
                    spacing: (statusIco.visible ? 0.5 * (logo.anchors.leftMargin - statusIco.width) : logo.anchors.leftMargin)
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
