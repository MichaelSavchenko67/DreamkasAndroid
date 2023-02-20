import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Rectangle {
    property bool isBlocked: false
    property bool isActive: false
    property var firstAction
    property var secondAction

    function reset() {
        firstAction = secondAction = 'undefined'
    }

    width: root.width
    height: 0.119 * width
    visible: !isBlocked && isActive
    anchors.horizontalCenter: parent.horizontalCenter
    y: -0.5 * (root.height - parent.height)

    Column {
        id: mainColumn
        anchors.fill: parent

        SaleComponents.Line {
            id: line
        }

        Row {
            id: mainRow
            width: parent.width
            height: parent.height - 2 * line.height
            leftPadding: 0.5 * hideButton.width
            rightPadding: leftPadding
            anchors.verticalCenter: parent.verticalCenter
            spacing: width -
                     2 * leftPadding -
                     hideButton.width -
                     buttonsRow.width

            ToolButtonCustom {
                id: hideButton
                height: 0.65 * mainColumn.height
                icoHeight: (0.5 / 0.65) * height
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "qrc:/ico/settings/keypad_hide.png"
                onClicked: {
                }
            }

            Row {
                id: buttonsRow
                anchors.verticalCenter: parent.verticalCenter
                spacing: mainRow.leftPadding

                SettingsComponents.ButtonAdaptive {
                    id: firstButton
                    anchors.verticalCenter: parent.verticalCenter
                    action: firstAction
                    fontSize: 0.5 * hideButton.icoHeight
                    buttonTxtColor: enabled ? "#0064B4" : "#BDC3C7"
                    opacity: enabled ? 1 : 0.6
                    enabled: false
                    onClicked: {
                    }
                }

                SettingsComponents.ButtonAdaptive {
                    id: secondButton
                    anchors.verticalCenter: parent.verticalCenter
                    action: secondAction
                    fontSize: firstButton.fontSize
                    buttonTxtColor: firstButton.buttonTxtColor
                    opacity: enabled ? 1 : 0.6
                    enabled: true
                    onClicked: {
                    }
                }
            }
        }
    }
}
