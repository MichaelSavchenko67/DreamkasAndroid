import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: parent.width - 2 * parent.leftPadding
    implicitHeight: 40
    anchors.horizontalCenter: parent.horizontalCenter

    property string subtitle: ""

    onSubtitleChanged: {
        subtitleLabel.text = subtitle
    }

    Label {
        id: subtitleLabel
        leftPadding: deleteMenu.leftPadding
        text: qsTr(subtitle)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 0.67 * deleteMenu.font.pixelSize
        color: "#979797"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
