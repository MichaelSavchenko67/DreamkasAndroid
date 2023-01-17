import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    width: parent.width
    height: 0.3 * width
    anchors.bottom: parent.bottom

    Rectangle {
        id: frame
        anchors.fill: parent
        color: "#F6F6F6"
    }

    DropShadow {
        visible: true
        anchors.fill: frame
        cached: true
        verticalOffset: -6
        radius: 8
        source: frame
        color: "#D6D6D6"
    }
}
