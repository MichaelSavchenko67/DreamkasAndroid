import QtQuick 2.12
import QtQuick.Controls 2.3

Image {
    id: indicator
    width: 0.03 * parent.width
    height: width

    property bool shake: false

    function getIco() {
        if (shake) {
            return "qrc:/ico/menu/login_err.png"
        } else if (enabled) {
            return "qrc:/ico/menu/login_en.png"
        } else {
            return "qrc:/ico/menu/login_dis.png"
        }
    }

    enabled: false
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
