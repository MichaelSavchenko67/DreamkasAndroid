import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Button {
    id: button

    property string txt: "undefinded"
    property real fontPixelSize: 0.5 * parent.height

    width: 0.5 * parent.width
    height: parent.height
    display: AbstractButton.TextOnly
    background: Rectangle {
        anchors.fill: parent
        border.width: 0
        color: "#00FFFFFF"

        Text {
            id: name
            anchors.fill: parent
            text: (txt !== "undefinded") ? qsTr(txt) : ""
            clip: true
            font {
                pixelSize: fontPixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Bold
            }
            color: "#415A77"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        transformOrigin: Item.Center
        states: State {
            name: "toPressed"; when: button.pressed
            PropertyChanges {
                target: name
                scale: 1.5
            }
        }
        transitions: Transition {
            to: "toPressed"
            reversible: true

            PropertyAnimation {
                properties: "scale"
                easing.type: Easing.InOutQuad
                duration: 100
            }
        }
    }
}
