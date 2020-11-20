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
                    leftMargin: 0.057 * parent.width
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
                    leftMargin: 0.057 * parent.width
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
                    "Открыть смену": function() { root.openShiftDialog() },
                    "Закрыть смену": function() { root.closeShiftDialog() }
                }

                ListElement {item: "Открыть смену"}
                ListElement {item: "Закрыть смену"}
                ListElement {item: "Example 1"}
                ListElement {item: "Example 2"}
                ListElement {item: "Example 3"}
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
                height: 0.1 * menuListView.height

                Text {
                    id: menuItemName
                    anchors.fill: parent
                    text: qsTr(item)
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
                    leftPadding: logo.anchors.leftMargin
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
                width: 5
            }
        }
    }
}
