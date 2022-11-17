import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Button {
    property real backRadius: 8
    property real borderWidth: 1
    property color borderColor: "#c4c4c4"
    property var buttonTxt: "КНОПКА"
    property color buttonTxtColor: "white"
    property color pushUpColor: "#415A77"
    property color pushDownColor: "#004075"
    property var iconPath: ""
    property var iconHeight: 1.5 * fontSize
    property var fontSize: 0.23 * height
    property var gradientParams
    property real opacityParam: 1.0
    property bool isChoosen: false
    property bool fontBold: true

    contentItem: Row {
        width: parent.width
        opacity: enabled ? 1.0 : 0.6
        spacing: 0.755 * txt.font.pixelSize
        leftPadding: 0.5 * (width - ico.width - spacing - txt.contentWidth)

        Image {
            id: ico
            source: iconPath
            height: iconHeight
            width: height
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: txt
            text: buttonTxt
            anchors.verticalCenter: parent.verticalCenter
            elide: Label.ElideRight
            maximumLineCount: 3
            wrapMode: Label.WordWrap
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            color: buttonTxtColor
            font {
                pixelSize: fontSize
                weight: fontBold ? Font.DemiBold : Font.Normal
                bold: fontBold
            }
        }
    }

    background: Rectangle {
        id: rect
        color: parent.down ? pushDownColor : pushUpColor
        border {
            width: borderWidth
            color: borderColor
        }
        radius: backRadius
        opacity: (isChoosen ? opacityParam : (enabled ? 1.0 : 0.6))
        gradient: isChoosen ? gradientParams : 'undefined'
    }
}
