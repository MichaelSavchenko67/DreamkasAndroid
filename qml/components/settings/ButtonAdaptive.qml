import QtQuick
import QtQuick.Controls

ToolButton {
    id: button

    property color buttonTxtColor
    property real fontSize

    width: label.contentWidth
    height: label.font.pixelSize
    contentItem: Label {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr(action.text)
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        font {
            pixelSize: fontSize
            weight: Font.DemiBold
        }
        color: buttonTxtColor
    }
}
