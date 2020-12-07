import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Rectangle {
    id: frame
    width: parent.width
    height: 0.25 * width
    anchors.bottom: parent.bottom
    color: "#F2F3F5"

    DropShadow {
        visible: true
        anchors.fill: parent
        cached: true
        verticalOffset: -8
        radius: 8
        samples: 1 + 2 * radius
        source: parent
        color: "#d1d1d1"
    }
}
