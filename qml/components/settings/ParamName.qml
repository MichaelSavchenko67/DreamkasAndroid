import QtQuick
import QtQuick.Controls

Text {
    anchors.verticalCenter: parent.verticalCenter
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
