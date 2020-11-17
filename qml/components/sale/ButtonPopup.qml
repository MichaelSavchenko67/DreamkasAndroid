import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Button {
    id: button
    width: 0.5 * parent.width
    height: parent.height

    property var txt

    display: AbstractButton.TextOnly
    background: Rectangle {
        anchors.fill: parent
        border.width: 0
        color: "#00FFFFFF"
        Text {
            id: name
            anchors.fill: parent
            text: qsTr(txt)
            clip: true
            font {
                pixelSize: 0.8 * parent.height
                family: "Roboto"
                styleName: "normal"
                weight: Font.Bold
            }
            color: "#AC58E1"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        transformOrigin: Item.Center

        property bool isEnable: false

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
