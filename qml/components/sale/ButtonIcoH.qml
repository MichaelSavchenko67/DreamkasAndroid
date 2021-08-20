import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Button {
    property real backRadius: 8
    property real borderWidth: 1
    property var buttonTxt: "КНОПКА"
    property color buttonTxtColor: "white"
    property color pushUpColor: "#415A77"
    property color pushDownColor: "#004075"
    property var iconPath: ""
    property var iconHeight: 1.5 * fontSize
    property var fontSize: 0.23 * height

    contentItem: Row {
        width: parent.width
        opacity: enabled ? 1.0 : 0.6

        Image {
            id: ico
            source: iconPath
            height: iconHeight
            width: height
            anchors {
                verticalCenter: parent.verticalCenter
                right: txt.left
                rightMargin: 0.5 * txt.font.pixelSize
            }
        }

        Text {
            id: txt
            text: buttonTxt
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
                horizontalCenterOffset: 0.5 * (ico.width + 0.5 * font.pixelSize)
            }
            elide: Text.ElideRight
            maximumLineCount: 3
            wrapMode: Text.WordWrap
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            color: buttonTxtColor
            font {
                pixelSize: fontSize
                weight: Font.DemiBold
                bold: true
            }
        }
    }

    background: Rectangle {
        id: rect
        color: parent.down ? pushDownColor : pushUpColor
        border.color: "#c4c4c4"
        border.width: borderWidth
        radius: backRadius
        opacity: enabled ? 1.0 : 0.6
    }
}
