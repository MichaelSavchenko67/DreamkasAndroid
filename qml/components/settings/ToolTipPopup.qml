import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

ToolTip {
    id: toolTip
    width: parent.width
    delay: 0
    contentItem: Text {
        width: parent.width
        text: toolTip.text
        onLinkActivated: Qt.openUrlExternally(link)
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
    background: Item {
        Rectangle {
            id: toolTipFrame
            anchors.fill: parent
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
}
