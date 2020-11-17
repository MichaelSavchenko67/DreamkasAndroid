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
            color: "#4DA13F"

            DropShadow {
                visible: true
                anchors.fill: parent
                cached: true
                verticalOffset: 1
                radius: verticalOffset
                samples: 1 + 2 * radius
                source: parent
                color: "#d6d6d6"
            }

            DropShadow {
                visible: true
                anchors.fill: parent
                cached: true
                verticalOffset: 8
                radius: verticalOffset
                samples: 1 + 2 * radius
                source: parent
                color: "#d1d1d1"
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
