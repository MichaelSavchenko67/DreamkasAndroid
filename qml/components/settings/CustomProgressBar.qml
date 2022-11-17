import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15
import QtQuick.Controls.Material 2.12

ProgressBar {
    property bool isUseShadow: false
    property bool isRunning: false
    property color backgroundColor: "#5C7490"
    property color accentColor: "white"

    width: parent.width
    height: 12
    indeterminate: isRunning
    Material.accent: accentColor
    background: Rectangle {
        color: backgroundColor
        implicitWidth: parent.width
        implicitHeight: parent.height

        DropShadow {
            id: dropShadow
            visible: isUseShadow
            anchors.fill: parent
            cached: true
            samples: 1 + 2 * radius
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8
            color: "#D6D6D6"
            source: parent
        }
    }
}
