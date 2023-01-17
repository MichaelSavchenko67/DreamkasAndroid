import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

RoundButton {
    property real backRadius: 8
    property real borderWidth: 0
    property string buttonTxt: "КНОПКА"
    property color buttonTxtColor: "#415A77"
    property color pushUpColor: "#FFFFFF"
    property color pushDownColor: "#F2F2F2"
    property string iconPath: ""
    property real fontSize: 0.2 * height
    property bool fontBold: true

    background: Rectangle {
        id: rect
        color: parent.down ? pushDownColor : pushUpColor
        border.color: "#c4c4c4"
        border.width: borderWidth
        radius: backRadius
        opacity: enabled ? 1.0 : 0.6

        Column {
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: enabled ? 1.0 : 0.6
            topPadding: (height -
                         ico.height -
                         txt.contentHeight) / 3
            bottomPadding: topPadding
            spacing: topPadding

            Image {
                id: ico
                height: 0.345 * parent.height
                width: height
                source: iconPath
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: txt
                text: buttonTxt
                anchors.horizontalCenter: parent.horizontalCenter
                elide: Text.ElideRight
                maximumLineCount: 3
                wrapMode: Text.WordWrap
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter
                color: buttonTxtColor
                font {
                    pixelSize: fontSize
                    weight: fontBold ? Font.DemiBold : Font.Normal
                    bold: fontBold
                }
            }
        }
    }

    DropShadow {
        anchors.fill: rect
        visible: true
        cached: true
        horizontalOffset: 0
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#d6d6d6"
        source: rect
    }
}
