import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Column {
    width: parent.width
    spacing: parent.spacing

    property int snoChoosen

    SettingsComponents.ParamTitle { id: title; text: "Система налогооблажения" }

    Column {
        width: parent.width
        leftPadding: 1.5 * parent.spacing

        SaleComponents.RadioButtonCursor {
            id: snoOSN
            checked: true
            text: qsTr("ОСН")
            font {
                pixelSize: 0.67 * title.font.pixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("УСН доход")
            font: snoOSN.font
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("УСН доход-расход")
            font: snoOSN.font
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("ЕНВД")
            font: snoOSN.font
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("Патент")
            font: snoOSN.font
        }
    }
}
