import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Button {
    property real backRadius: 8
    property real borderWidth: 1
    property var buttonTxt: "КНОПКА"
    property color buttonTxtColor: "#415A77"
    property color pushUpColor: "#FFFFFF"
    property color pushDownColor: "#F2F2F2"
    property var iconPath: ""
    property var fontSize: 0.23 * height

    contentItem: Rectangle {
        id: frame
        anchors.fill: parent
        color: "#00FFFFFF"

        Column {
            anchors.centerIn: parent
            opacity: enabled ? 1.0 : 0.6
            spacing: 0.5 * txt.font.pixelSize

            Image {
                id: ico
                height: 1.5 * fontSize
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
                    weight: Font.DemiBold
                    bold: true
                }
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
