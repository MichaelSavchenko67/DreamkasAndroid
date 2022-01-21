import QtQuick 2.12
import QtQuick.Controls 2.12

Text {
    width: parent.width
    font {
        pixelSize: 0.06 * width
        family: "Roboto"
        styleName: "normal"
        weight: Font.Normal
    }
    color: "black"
    elide: Label.ElideRight
    horizontalAlignment: Qt.AlignLeft
    verticalAlignment: Qt.AlignVCenter
    leftPadding: 0.5 * font.pixelSize
}
