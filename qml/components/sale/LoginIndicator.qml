import QtQuick 2.12
import QtQuick.Controls 2.3

Rectangle {
    color: "#00FFFFFF"
    width: 0.03 * parent.width
    height: width
    enabled: false

    property bool shake: false
    property var digit

    Image {
        id: indicator
        anchors.fill: parent

        function getIco() {
            if (shake) {
                return "qrc:/ico/menu/login_err.png"
            }
            else if (enabled) {
                return "qrc:/ico/menu/login_en.png"
            } else {
                return "qrc:/ico/menu/login_dis.png"
            }
        }

        enabled: parent.enabled
        visible: (digit.length === 0)
        source: getIco()

        states:
            State {
            name: "moved"; when: shake
            PropertyChanges { target: indicator; x: x }
        }

        transitions: Transition {
            to: "moved"
            NumberAnimation { properties: "x"; from: x; to: x + 0.8 * width; easing.type: Easing.OutElastic; duration: 250}
        }
    }

    Label {
        anchors.fill: parent
        visible: !indicator.visible
        text: digit
        font {
            pixelSize: 3 * parent.height
            family: "Roboto"
            styleName: "normal"
            weight: Font.Normal
        }
        color: "#415A77"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }
}


