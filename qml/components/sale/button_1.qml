import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Button {
    id: button
    property real backRadius: 0
    property real borderWidth: 1
    property var buttonTxt
    property color buttonTxtColor
    property bool dropShadow: false
    property color pushUpColor: "#ffffff"
    property color pushDownColor: "#d6d6d6"
    property bool fontBold: true
    property var iconPath: ""
    property var fontSize: height / 4

    contentItem: Row {
        Image {
            id: ico
            source: iconPath
            height: 0.26 * parent.height
            width: height
            anchors {
                verticalCenter: parent.verticalCenter
                right: txt.left
                rightMargin: 0.5 * fontSize
            }
        }

        Text {
            id: txt
            text: qsTr(buttonTxt)
            anchors.fill: parent
            elide: Text.ElideRight
            maximumLineCount: 3
            wrapMode: Text.WordWrap
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            color: enabled ? buttonTxtColor : ((button.opacity < 1.0) ? buttonTxtColor : "#595959")
            font {
                pixelSize: fontSize
                weight: Font.DemiBold
                bold: fontBold
            }
        }
    }

    background: Rectangle {
        id: rect
        color: enabled ? (parent.down ? pushDownColor : pushUpColor) : ((button.opacity < 1.0) ? pushUpColor : "#C2C2C2")
        border.color: "#c4c4c4"
        border.width: borderWidth
        radius: backRadius
    }

    DropShadow {
        visible: dropShadow
        anchors.fill: rect
        cached: true
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#d6d6d6"
        source: rect
    }
}
