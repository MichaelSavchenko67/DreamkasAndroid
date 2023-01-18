import QtQuick
import QtQuick.Controls
//import Taxes 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Column {
    width: parent.width
    spacing: parent.spacing

//    property int ndsChoosen: shiftModel.getNdsDefault()

    SettingsComponents.ParamTitle { id: title; text: "Ставка НДС для сумм. режима" }

    Column {
        width: parent.width
        leftPadding: 1.5 * parent.spacing

        SaleComponents.RadioButtonCursor {
            id: ndsNo
            text: qsTr("Без НДС")
//            checked: (ndsChoosen === TaxesEnums.NDS_NO)
            font {
                pixelSize: 0.67 * title.font.pixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            onCheckedChanged: {
                if (checked) {
//                    ndsChoosen = TaxesEnums.NDS_NO
                }
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("0 %")
//            checked: (ndsChoosen === TaxesEnums.NDS_0)
            font: ndsNo.font
            onCheckedChanged: {
                if (checked) {
//                    ndsChoosen = TaxesEnums.NDS_0
                }
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("10 %")
//            checked: (ndsChoosen === TaxesEnums.NDS_10)
            font: ndsNo.font
            onCheckedChanged: {
                if (checked) {
//                    ndsChoosen = TaxesEnums.NDS_10
                }
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("20 %")
//            checked: (ndsChoosen === TaxesEnums.NDS_20)
            font: ndsNo.font
            onCheckedChanged: {
                if (checked) {
//                    ndsChoosen = TaxesEnums.NDS_20
                }
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("10/110 %")
//            checked: (ndsChoosen === TaxesEnums.NDS_10_110)
            font: ndsNo.font
            onCheckedChanged: {
                if (checked) {
//                    ndsChoosen = TaxesEnums.NDS_10_110
                }
            }
        }

        SaleComponents.RadioButtonCursor {
            text: qsTr("20/120 %")
//            checked: (ndsChoosen === TaxesEnums.NDS_20_120)
            font: ndsNo.font
            onCheckedChanged: {
                if (checked) {
//                    ndsChoosen = TaxesEnums.NDS_20_120
                }
            }
        }
    }
}
