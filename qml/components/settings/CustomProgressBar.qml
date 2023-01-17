import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

ProgressBar {
    property bool isUseShadow: false
    property bool isRunning: false
    property color backgroundColor: "#5C7490"
    property color accentColor: "white"

    width: parent.width
    height: 12
    indeterminate: isRunning
    Material.accent: accentColor
    background: Item {
        Rectangle {
            id: rect
            anchors.fill: parent
            color: backgroundColor
            implicitWidth: parent.width
            implicitHeight: parent.height
        }

        DropShadow {
            id: dropShadow
            visible: isUseShadow
            anchors.fill: rect
            cached: true
            samples: 1 + 2 * radius
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8
            color: "#D6D6D6"
            source: rect
        }
    }
}
