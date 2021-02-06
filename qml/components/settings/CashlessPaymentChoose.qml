import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Column {
    width: parent.width
    spacing: parent.spacing

    property var cashlessPaymentChoosen: "Картой"

    SettingsComponents.ParamTitle { text: "Безналичный платёж" }

    Column {
        width: parent.width
        leftPadding: 1.5 * parent.spacing

        SaleComponents.RadioButtonCursor {
            id: cashless
            checked: true
            text: qsTr("Картой")
            font {
                pixelSize: 0.6 * 0.07 * parent.width
                family: "Roboto"
                styleName: "normal"
                weight: Font.Bold
                bold: true
            }
            onCheckedChanged: {
                if (checked) {
                    cashlessPaymentChoosen = text
                }
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("Аванс")
            font: cashless.font
            onCheckedChanged: {
                if (checked) {
                    cashlessPaymentChoosen = text
                }
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("Кредит")
            font: cashless.font
            onCheckedChanged: {
                if (checked) {
                    cashlessPaymentChoosen = text
                }
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("Иная форма")
            font: cashless.font
            onCheckedChanged: {
                if (checked) {
                    cashlessPaymentChoosen = text
                }
            }
        }
    }
}
