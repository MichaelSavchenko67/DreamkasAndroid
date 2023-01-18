import QtQuick
import QtQuick.Controls

MenuItem {
    id: menuItem
    width: parent.width
    implicitHeight: enabled ? 40 : 0
    anchors.horizontalCenter: parent.horizontalCenter
    visible: enabled
    arrow: Canvas {
        implicitWidth: 0
        implicitHeight: 0
    }
    indicator: Item {
        implicitWidth: 0
        implicitHeight: 0
    }
    contentItem: ItemDelegate {
        anchors.fill: parent

        Row {
            width: menuItem.width - 1.25 * spacing
            height: menuItem.implicitHeight
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0.5 * checkStatus.width

            Label {
                width: parent.width -
                       parent.spacing -
                       checkStatus.width
                anchors.verticalCenter: parent.verticalCenter
                text: menuItem.text
                font: menuItem.font
                opacity: enabled ? 1.0 : 0.3
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            Image {
                id: checkStatus
                visible: menuItem.checkable && menuItem.checked
                width: menuItem.font.pixelSize
                height: width
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/ico/settings/check_blue.png"
            }
        }

        onClicked: {
            menuItem.action.triggered()
        }
    }
}
