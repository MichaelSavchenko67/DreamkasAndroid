import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.11

Drawer {
    id: drawer

    contentData: Page {
        id: menuBar
        anchors.fill: parent
        header: Rectangle {
            height: 0.214 * menuBar.height
            width: menuBar.width
            color: "#5C7490"

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

        contentData: TreeView
        {
            id: menuTreeView
            anchors.fill: parent
            clip: true
            headerVisible: false
            selectionMode: SelectionMode.NoSelection
            alternatingRowColors: false

            model: menuModel

            style: TreeViewStyle
            {
                backgroundColor: "#00000000"
                branchDelegate: Rectangle
                {
                    width: 15; height: 15
                    color: "#00000000"
                    x: menuTreeView.width - (width + 5)

                    Image
                    {
                        id: expandArrow
                        source: styleData.isExpanded ? "qrc:/ico/menu/up.png" : "qrc:/ico/menu/down.png"
                        sourceSize.width: parent.width
                        sourceSize.height: parent.height
                    }
                }

                rowDelegate: Row {
                    height: (0.1 * menuTreeView.height)

                }

//                Row {
//                    height: 100
//                }
            }

            onClicked:
            {
                console.log("Index: " + (index) )
                console.log("Childer: " + menuModel.hasChildren(index))

                if(menuModel.hasChildren(index))
                {
                    console.log("Show child")
                    if(menuTreeView.isExpanded(index))
                        menuTreeView.collapse(index)
                    else
                        menuTreeView.expand(index)
                }
                else
                {
                    console.log("Call window")
                }

//                console.log("[MenuDrawer.qml]\t" + (index + 1) + ". "+ menuItemName.text)
//                ListView.currentIndex = index
//                drawer.close()
//                menuItems.actions[item]();
            }

            TableViewColumn
            {
                role: "display"
//                delegate: Text {
//                    text: styleData.value
//                }
            }

//            itemDelegate: Component {
//            }

            itemDelegate: Row
            {
                id: menuItem
                width: menuTreeView.width
                spacing: /*menuItemName.font.pixelSize*/(statusIco.visible ? 0.8 * (logo.anchors.leftMargin - statusIco.width) : logo.anchors.leftMargin)

                Image
                {
                    id: statusIco
                    height: menuItemName.font.pixelSize
                    width: height
                    visible: menuItemName.visible /*&& modelApplied_*/
                    anchors.verticalCenter: menuItem.verticalCenter
                    source: "qrc:/ico/menu/operation_success.png"
                }

                Text
                {
//                    id: menuItemName
//                    anchors.verticalCenter: menuItem.verticalCenter
//                    text: styleData.value
//                    font
//                    {
//                        family: "Roboto"
//                        styleName: "normal"
//                        weight: Font.Normal
//                    }
//                    horizontalAlignment: Text.AlignLeft
//                    verticalAlignment: Text.AlignVCenter
//                    elide: Text.ElideRight
                    id: menuItemName
                    width: parent.width - statusIco.width
                    anchors.verticalCenter: parent.verticalCenter
                    text: styleData.value
                    visible: (menuItem.height > 0)
                    font
                    {
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

//            ScrollBar.vertical: ScrollBar {
//                id: scroll
//                policy: ScrollBar.AsNeeded
//                width: 8
//            }

//            {
//                id: menuItems

//                property var actions : {
//                    "Формирование чека": function() { rootStack.pop(null) },
//                    "Подключить ККТ": function() { root.openPage("qrc:/qml/pages/subpages/ScanWiFiNetworks.qml") },
//                    "Отключить ККТ": function() { root.openDisconnectPrinterDialog() },
//                    "Открыть смену": function() { root.openShiftDialog() },
//                    "Закрыть смену": function() { root.closeShiftDialog() },
//                    "Кабинет Дримкас": function() { root.openPage("qrc:/qml/pages/subpages/CabinetConnection.qml") },
//                    "Система налогооблажения": function() { root.openPage("qrc:/qml/pages/subpages/DefaultSno.qml") },
//                    "X-отчёт": function() { root.openXReportDialog() },
//                    "Ввод цены товара": function() { root.openEnterCostDialog("Яблоки красные", "Цена, \u20BD/кг", "Неправильное значение, введите снова") },
//                    "Ввод количества товара": function() { root.openEnterAmountDialog("Яблоки красные", "Количество, кг", "Неправильное значение, введите снова") },
//                    "Ввод суммы платежа": function() { root.openPage("qrc:/qml/pages/subpages/Pay.qml") },
//                    "Изъять или внести": function() { root.openPage("qrc:/qml/pages/subpages/InsRes.qml") },
//                    "Чек коррекции": function() { root.openPage("qrc:/qml/pages/subpages/PurchaseCorrection.qml") }
//                }

//                ListElement {item: "Формирование чека"}
//                ListElement {item: "Подключить ККТ"}
//                ListElement {item: "Отключить ККТ"}
//                ListElement {item: "Открыть смену"}
//                ListElement {item: "Закрыть смену"}
//                ListElement {item: "Кабинет Дримкас"}
//                ListElement {item: "Система налогооблажения"}
//                ListElement {item: "X-отчёт"}
//                ListElement {item: "Ввод цены товара"}
//                ListElement {item: "Ввод количества товара"}
//                ListElement {item: "Ввод суммы платежа"}
//                ListElement {item: "Изъять или внести"}
//                ListElement {item: "Чек коррекции"}
//                ListElement {item: "Example 5"}
//                ListElement {item: "Example 6"}
//                ListElement {item: "Example 7"}
//                ListElement {item: "Example 8"}
//                ListElement {item: "Example 9"}
//                ListElement {item: "Example 10"}
//            }
//            delegate: ItemView {
//                id: menuItem
//                width: menuListView.width
//                height: (item === "Открыть смену") ? 0 : 0.1 * menuListView.height

//                Row {
//                    anchors.fill: parent
//                    spacing: (statusIco.visible ? 0.5 * (logo.anchors.leftMargin - statusIco.width) : logo.anchors.leftMargin)
//                    leftPadding: spacing

//                    Image {
//                        id: statusIco
//                        height: menuItemName.font.pixelSize
//                        width: height
//                        visible: menuItemName.visible
//                        anchors.verticalCenter: parent.verticalCenter
//                        source: "qrc:/ico/menu/operation_success.png"

//                    }

//                    Text {
//                        id: menuItemName
//                        width: parent.width - statusIco.width
//                        anchors.verticalCenter: parent.verticalCenter
//                        text: qsTr(item)
//                        visible: (menuItem.height > 0)
//                        font {
//                            pixelSize: 0.83 * userName.font.pixelSize
//                            family: "Roboto"
//                            styleName: "normal"
//                            weight: Font.Normal
//                        }
//                        clip: true
//                        color: "black"
//                        elide: Text.ElideRight
//                        horizontalAlignment: Qt.AlignLeft
//                        verticalAlignment: Qt.AlignVCenter
//                    }
//                }
//                onClicked: {
//                    console.log("[MenuDrawer.qml]\t" + (index + 1) + ". "+ menuItemName.text)
//                    ListView.currentIndex = index
//                    drawer.close()
//                    menuItems.actions[item]();
//                }
//            }
//            ScrollBar.vertical: ScrollBar {
//                id: scroll
//                policy: ScrollBar.AsNeeded
//                width: 8
//            }
        }
    }
}
