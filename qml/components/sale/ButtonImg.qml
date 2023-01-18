import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Button {
    property var iconPath: ""

    contentItem: Row {
        Image {
            source: iconPath
            anchors.fill: parent
        }
    }

    states: State {
        name: "toPressed"; when: pressed
        PropertyChanges {
            target: parent
            opacity: 0.7
        }
    }

    transitions: Transition {
        to: "toPressed"
        reversible: true

        PropertyAnimation {
            properties: "opacity"
            easing.type: Easing.InOutQuad
            duration: 100
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: "#00FFFFFF"
    }
}
