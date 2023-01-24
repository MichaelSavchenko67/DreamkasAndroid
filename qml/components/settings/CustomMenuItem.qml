import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

MenuItem {
    id: menuItem

    readonly property string iconSource: action.icon.source

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

            Item {
                id: ico
                width: menuItem.font.pixelSize
                height: width
                anchors.verticalCenter: parent.verticalCenter
                visible: iconSource.length

                Image {
                    id: icoImage
                    sourceSize: Qt.size(parent.width, parent.height)
                    source: iconSource
                    fillMode: Image.PreserveAspectFit
                }

                ColorOverlay {
                    anchors.fill: icoImage
                    source: icoImage
                    color: "#5C7490"
                }
            }

            Label {
                id: menuItemLabel
                width: parent.width -
                       (ico.visible ? ico.width : 0) -
                       (ico.visible + 1) * parent.spacing -
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
                fillMode: Image.PreserveAspectFit
            }
        }

        onClicked: {
            menuItem.action.triggered()
        }
    }
}
