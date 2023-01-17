import QtQuick
import QtQuick.Controls

Row {
    width: parent.width

    property var param
    property var value

    Text {
        id: paramName
        width: 0.5 * parent.width
        anchors.verticalCenter: parent.verticalCenter
        text: param
        font {
            pixelSize: 0.045 * parent.width
            family: "Roboto"
            styleName: "normal"
            weight: Font.Bold
            bold: true
        }
        color: "black"
        clip: true
        elide: Text.ElideRight
        maximumLineCount: 2
        wrapMode: Text.WordWrap
        lineHeight: 1.3
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: paramValue
        width: 0.5 * parent.width
        anchors.verticalCenter: parent.verticalCenter
        text: value
        font {
            pixelSize: paramName.font.pixelSize
            family: paramName.font.family
            styleName: paramName.font.styleName
            weight: Font.Normal
        }
        color: paramName.color
        clip: paramName.clip
        elide: paramName.elide
        horizontalAlignment: Text.AlignRight
        verticalAlignment: paramName.verticalAlignment
    }
}
