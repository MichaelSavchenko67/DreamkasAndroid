import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

import "qrc:/qml/components/settings" as SettingsComponents

ToolBar {
    width: parent.width
    height: 0.0898 * width
    anchors.top: parent.top

    Action {
        id: startTextInput
        onTriggered: { editOn = true }
    }

    property int defaultCursorPosition: 1
    property string defaultText: "Название или штрихкод"
    property bool editOn: true
    property real fontSize: 0.04939 * width
    property bool isUseShadow: true

    signal changeText(var txt)

    Row {
        id: frame
        anchors.fill: parent
        leftPadding: 0.15 * searchButton.width

        SettingsComponents.ToolButtonCustom {
            id: searchButton
            height: 0.7 * 0.133 * parent.width
            anchors.verticalCenter: parent.verticalCenter
            action: startTextInput
            icon.source: "qrc:/ico/menu/search.png"
            visible: true
        }

        TextField {
            id: textInput
            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter

            Component.onCompleted: { forceActiveFocus() }

            focus: editOn
            leftPadding: frame.leftPadding
            font {
                pixelSize: fontSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
            }
            color: "white"
            placeholderText: defaultText
            placeholderTextColor: "#88FFFFFF"
            cursorPosition: defaultCursorPosition
            background: Rectangle {
                width: frame.width - searchButton.width - 3 * font.pixelSize
                height: frame.height
                anchors.verticalCenter: searchButton.verticalCenter
                border.width: 0
                color: "transparent"
            }
            onDisplayTextChanged: {
                parent.changeText(displayText)
            }
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: "#5C7490"

        DropShadow {
            id: toolBarShadow
            visible: isUseShadow
            anchors.fill: parent
            cached: true
            verticalOffset: 4
            radius: 8
            samples: 1 + 2 * radius
            source: parent
            color: "#D6D6D6"
        }
    }
}
