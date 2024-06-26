import QtQuick
import QtQuick.Controls

Text {
    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter
    font {
        pixelSize: 0.6 * 0.07 * 2 * width
        family: "Roboto"
        styleName: "normal"
        weight: Font.Normal
    }
    clip: true
    elide: Text.ElideRight
    maximumLineCount: 2
    wrapMode: Text.WordWrap
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
