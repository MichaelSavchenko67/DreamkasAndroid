import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Rectangle {
    id: frame
    width: parent.width
    height: 0.3 * width
    anchors.bottom: parent.bottom
    color: "#F6F6F6"
    opacity: 0.5

    DropShadow {
        visible: true
        anchors.fill: parent
        cached: true
        verticalOffset: -6
        radius: 8
        source: parent
        color: "#D6D6D6"
    }
}
