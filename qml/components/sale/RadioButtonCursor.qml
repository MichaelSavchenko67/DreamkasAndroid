import QtQuick
import QtQuick.Controls

RadioButton {
    id: button
    indicator: Rectangle {
        implicitHeight: 26
        implicitWidth: 26
        x: button.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        border.color: button.checked ? "#415A77" : "#979797"
        color: "#00FFFFFF"

        Rectangle {
            width: 14
            height: 14
            x: 6
            y: 6
            radius: 7
            color: parent.border.color
            visible: button.checked
        }
    }
}
