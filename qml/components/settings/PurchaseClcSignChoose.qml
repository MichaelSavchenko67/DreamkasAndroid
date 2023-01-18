import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Column {
    width: parent.width
    spacing: parent.spacing

    property int clcSignChoosen

    SettingsComponents.ParamTitle { id: clcSign; text: "Признак расчета"; topPadding: leftPadding }

    Column {
        id: clcSignChoose
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 1.5 * parent.spacing

        SaleComponents.RadioButtonCursor {
            id: clcSale
            checked: true
            text: qsTr("Приход")
            font {
                pixelSize: cashTitle.font.pixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("Возврат прихода")
            font: clcSale.font
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("Расход")
            font: clcSale.font
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("Возврат расхода")
            font: clcSale.font
        }
    }
}
