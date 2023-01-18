import QtQuick
import QtQuick.Controls

Row {
    width: parent.width
    spacing: 0.5 * circle.width

    property string message: ""

    Label {
        id: circle
        text: qsTr("\u25CF")
        font {
            pixelSize: 0.055 * parent.width
            family: "Roboto"
            styleName: "normal"
            weight: Font.Normal
        }
        color: "#85B5DB"
        clip: true
        elide: "ElideRight"
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
    }

    Label {
        id: userMsg
        width: parent.width - 3 * circle.font.pixelSize
        text: qsTr(message)
        font: circle.font
        color: "#979797"
        clip: true
        elide: "ElideRight"
        maximumLineCount: 3
        wrapMode: Label.WordWrap
        horizontalAlignment: Label.AlignLeft
        verticalAlignment: Label.AlignVCenter
    }
}
