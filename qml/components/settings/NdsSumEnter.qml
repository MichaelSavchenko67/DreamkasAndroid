import QtQuick 2.12
import QtQuick.Controls 2.12

Row {
    width: parent.width

    property var nds
    property var sum: "0,00"
    property var valueFontPixelSize: 0.6 * 0.07 * parent.width

    Text {
        width: 0.5 * (parent.width - sumField.width)
        anchors.verticalCenter: parent.verticalCenter
        text: nds
        font {
            pixelSize: 0.6 * 0.07 * parent.width
            family: "Roboto"
            styleName: "normal"
            weight: Font.Bold
            bold: true
        }
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    Label {
        id: sumField
        width: 0.5 * 0.75 * parent.width
        height: 0.38 * width
        anchors.verticalCenter: parent.verticalCenter
        text: sum
        font {
            pixelSize: valueFontPixelSize
            family: "Roboto"
            styleName: "normal"
            weight: Font.Normal
        }
        clip: true
        elide: "ElideRight"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        background: Rectangle {
            height: 2 * parent.font.pixelSize
            anchors.verticalCenter: parent.verticalCenter
            border {
                color: "#0064B4"
                width: 2
            }
            radius: 5
        }
    }
}
