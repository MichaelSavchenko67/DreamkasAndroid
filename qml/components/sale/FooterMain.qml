import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Rectangle {
    id: frame
    width: parent.width
    height: parent.height - calculator.height - 2 * 0.06 * parent.height
    anchors.bottom: parent.bottom
    color: "#F2F3F5"
    DropShadow {
        visible: true
        anchors.fill: parent
        cached: true
        verticalOffset: -1
        radius: 1
        samples: 1 + 2 * radius
        source: parent
        color: "#d6d6d6"
    }

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
