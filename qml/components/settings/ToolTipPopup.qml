import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

ToolTip {
    id: toolTip
    width: parent.width
    delay: 0
    contentItem: Text {
        text: toolTip.text
        width: parent.width
        font {
            pixelSize: 0.56 * 0.06 * parent.width
            family: "Roboto"
            styleName: "normal"
            weight: Font.Normal
        }
        color: "black"
        lineHeight: 1.2
        maximumLineCount: 3
        wrapMode: Text.WordWrap
    }
    background: Rectangle {
        id: toolTipFrame
        color: "white"
        border.color: "#d6d6d6"
        border.width: 1
        radius: 8
    }

    DropShadow {
        visible: true
        anchors.fill: toolTipFrame
        cached: true
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#d6d6d6"
        source: toolTipFrame
    }
}

