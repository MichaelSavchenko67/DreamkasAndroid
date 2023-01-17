import QtQuick
import QtQuick.Controls

Rectangle {
    color: "#00FFFFFF"
    width: 0.03 * parent.width
    height: width
    enabled: false

    property bool shake: false
    property var digit

    Image {
        id: indicator

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

        width: parent.width
        height: parent.height
        enabled: parent.enabled
        visible: (digit.length === 0)
        source: getIco()
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


