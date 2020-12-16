import QtQuick 2.12
import QtQuick.Controls 2.12

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
