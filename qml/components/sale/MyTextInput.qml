import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0


Rectangle {
    id: frame
    width: parent.width
    height: 0.0898 * width

    anchors.top: parent.top

    property int defaultCursorPosition: 1
    property var defaultText: "Название или штрихкод"
    property var editOn: true
    property real fontSize: 0.55 * height

    signal changeText(var txt)

    border.width: 0

    TextField {
        id: textInput
        focus: editOn
        font {
            pixelSize: fontSize
            family: "Roboto"
            styleName: "normal"
            weight: Font.DemiBold
        }
        color: "white"
        leftPadding: font.pixelSize
        rightPadding: font.pixelSize
        placeholderText: defaultText
        placeholderTextColor: "#88FFFFFF"
        cursorPosition: defaultCursorPosition

        background: Rectangle {
            width: frame.width
            height: frame.height

            border.width: 0
            radius: 0
            color: "#5C7490"

            DropShadow {
                visible: true
                anchors.fill: parent
                cached: true
                samples: 1 + 2 * radius
                horizontalOffset: 0
                verticalOffset: 2
                radius: 8
                color: "#D6D6D6"
                source: parent

            }
        }

        onDisplayTextChanged: {
            parent.changeText(displayText)
        }

        Component.onCompleted: {
            forceActiveFocus()
        }
    }
}
