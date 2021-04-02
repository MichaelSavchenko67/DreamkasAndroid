import QtQuick 2.12
import QtQuick.Controls 2.3

Row {
    property var message: ""
    property var customWidth: 0.7 * parent.width

    anchors.horizontalCenter: parent.horizontalCenter

    Label {
        id: circle
        text: qsTr("\u25CF")
        font {
            pixelSize: 0.047 * customWidth
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
        width: customWidth - 3 * circle.font.pixelSize
        text: qsTr(message)
        font: circle.font
        color: "#979797"
        clip: true
        elide: "ElideRight"
        maximumLineCount: 3
        wrapMode: Label.WordWrap
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
    }
}
