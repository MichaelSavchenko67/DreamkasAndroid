import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.15

DelayButton {
    id: delayButton

    property string title: ""
    property color titleColor: "black"
    property color buttonColor: "white"
    property color progressColor: "black"

    width: 0.5 * parent.width
    height: 0.112 * parent.width
    text: qsTr(title)
    font {
        pixelSize: height / 4
        weight: Font.DemiBold
        bold: true
    }
    contentItem: Text {
        text: delayButton.text
        font: delayButton.font
        color: titleColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    anchors.horizontalCenter: parent.horizontalCenter
    delay: 2000
    Material.accent: progressColor
    Material.background: buttonColor
}
