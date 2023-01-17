import QtQuick
import QtQuick.Controls

ToolButton {
    id: button

    property real buttonWidth
    property var disabledIcon: "qrc:/ico/menu/circle_dis.png"
    property var enabledIcon: "qrc:/ico/menu/circle_en_green.png"

    height: buttonWidth
    width: height

    background: Rectangle {
        border.width: 0
        color: "#FFFFFF"
        Image {
            source: enabled ? enabledIcon : disabledIcon
            anchors.fill: parent
            anchors.centerIn: parent
        }
    }
    transformOrigin: Item.Center
    states: State {
        name: "pressed"; when: button.pressed
        PropertyChanges { target: button; scale: 1.3 }
    }
    transitions: Transition {
        to: "pressed"
        reversible: true
        PropertyAnimation { property: "scale"; easing.type: Easing.InOutQuad; duration: 50 }
    }
}
