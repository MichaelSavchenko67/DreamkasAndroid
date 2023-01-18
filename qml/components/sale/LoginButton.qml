import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Button {
    id: loginButton
    width: parent.width / 3
    height: parent.height / 4
    transformOrigin: Item.Center
    font {
        pixelSize: 0.5 * height
        family: "Roboto"
        styleName: "normal"
        weight: Font.DemiBold
    }

    states: State {
        name: "pushDown"; when: pressed
        PropertyChanges {
            target: loginButton;
            scale: 2
        }
    }

    transitions: Transition {
        to: "pushDown"
        reversible: true

        PropertyAnimation {
            properties: "scale"
            easing.type: Easing.InOutQuad
            duration: 100
        }
    }

    background: Rectangle {
        border.width: 0
        color: "transparent"
    }
}
