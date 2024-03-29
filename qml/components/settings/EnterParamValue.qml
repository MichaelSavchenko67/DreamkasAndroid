import QtQuick
import QtQuick.Controls
import "qrc:/content/calculator.js" as CalcEngine

TextField {
    anchors.horizontalCenter: parent.horizontalCenter
    placeholderText: "0,00"
    font {
        pixelSize: 0.6 * 0.07 * 3.5 * width
        family: "Roboto"
        styleName: "normal"
        weight: Font.Normal
    }
    clip: true
    inputMethodHints: Qt.ImhFormattedNumbersOnly
    validator: RegularExpressionValidator { regularExpression: /^(0|[1-9]\d*)([,]\d{1,2})?$/ }
    placeholderTextColor: "black"
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignBottom
    background: Rectangle {
        height: 2 * parent.font.pixelSize
        anchors.verticalCenter: parent.verticalCenter
        border {
            color: parent.focus ? "#5C7490" : "#415A77"
            width: 2
        }
        radius: 5
    }
}
