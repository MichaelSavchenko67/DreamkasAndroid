import QtQuick 2.12
import QtQuick.Controls 2.12

Menu {
    id: menu
    transformOrigin: Menu.TopRight

    onClosed: {
        itemAt(currentIndex).highlighted = false
    }

    delegate: MenuItem {
        id: menuItem

        indicator: Item {
            implicitWidth: 40
            implicitHeight: 40

            Rectangle {
                width: 26
                height: 26
                anchors.centerIn: parent
                visible: menuItem.checkable
                border.color: "#C4C4C4"
                radius: 3
                Rectangle {
                    width: 14
                    height: 14
                    anchors.centerIn: parent
                    visible: menuItem.checked
                    color: "#C4C4C4"
                    radius: 2
                }
            }
        }

        contentItem: Row {
            id: content
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: itemName.font.pixelSize
            }
            spacing: itemName.font.pixelSize

            Image {
                height: 1.5 * itemName.font.pixelSize
                width: height
                anchors.verticalCenter: parent.verticalCenter
                source: menuItem.action.icon.source
            }

            Text {
                id: itemName
                anchors.verticalCenter: parent.verticalCenter
                text: menuItem.text
                font {
                    pixelSize: 0.07 * menu.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Mormal
                }
                color: menuItem.highlighted ? "#ffffff" : "black"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        background: Rectangle {
            color: menuItem.highlighted ? "#C4C4C4" : "transparent"
        }
    }
}
