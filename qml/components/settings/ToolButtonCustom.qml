import QtQuick
import QtQuick.Controls

ToolButton {
    id: control

    property real icoHeight: 0.5 * control.width

    height: 0.7 * parent.height
    width: height
    anchors.verticalCenter: parent.verticalCenter
    onIconChanged: {
        if (icon.source != "") {
            ico.source = icon.source
        }
        icon.source = ""
    }

    Image {
        id: ico
        height: icoHeight
        width: height
        anchors.centerIn: parent
        source: ""
        fillMode: Image.PreserveAspectFit
    }

    background: Rectangle {
        anchors.fill: parent
        radius: width
        color: Qt.darker("#33333333", control.enabled && (control.checked || control.highlighted) ? 1.5 : 1.0)
        opacity: enabled ? 1 : 0.3
        visible: control.down || (control.enabled && (control.checked || control.highlighted))
    }
}
