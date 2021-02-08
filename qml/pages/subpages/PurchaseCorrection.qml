import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents
import "qrc:/content/calculator.js" as CalcEngine

Flickable {
    id: flickable
    contentHeight: pane.height
    width: parent.width

    onFocusChanged: {
        if (focus) {
            console.log("[PurchaseCorrection.qml]\tfocus changed: " + focus)
            setMainPageTitle("Чек коррекции")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    SettingsComponents.PopupDate {
        id: popupDate
        anchors.centerIn: parent
    }

    Pane {
        id: pane
        width: flickable.width

        Column {
            id: frame
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: corTypeTitle.topPadding

            SettingsComponents.ParamTitle { id: corTypeTitle; text: "Тип чека коррекции"; topPadding: leftPadding }

            Column {
                id: corrTypeChoose
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                leftPadding: 1.5 * parent.spacing

                SaleComponents.RadioButtonCursor {
                    id: corrSale
                    checked: true
                    text: qsTr("Коррекция прихода")
                    font {
                        pixelSize: cashTitle.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                }

                SaleComponents.RadioButtonCursor {
                    text: qsTr("Коррекция расхода")
                    font: corrSale.font
                }
            }

            SettingsComponents.ParamTitle { text: "Система налогооблажения" }

            Column {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                leftPadding: 1.5 * parent.spacing

//                enum SNO_TYPES
//                {
//                    SNO_OSN          = 0x00,               //  Основная
//                    SNO_USN          = 0x01,               //  Упрощенная Доход
//                    SNO_USN_DOH_RASH = 0x02,               //  Упрощенная Доход минус Расход
//                    SNO_ENVD         = 0x03,               //  Единый налог на вмененный доход
//                    SNO_ESN          = 0x04,               //  Единый сельскохозяйственный налог
//                    SNO_PATENT       = 0x05                //  Патентная система налогообложения
//                };

//                string TOTAL_STR                 = "ОСН",
//                       SIMPLIFIED_INCOME_STR     = "УСН доход",
//                       SIMPLIFIED_INC_EXP_STR    = "УСН доход-расход",
//                       SINGLE_IMPUTED_INCOME_STR = "ЕНВД",
//                       UNIFIED_AGRICULTURAL_STR  = "ЕСХН",
//                       PATENT_STR                = "Патент" ,
//                       UNKNOWN_TAX_SYS           = "Неизвестная СНО";

                SaleComponents.RadioButtonCursor {
                    id: snoOSN
                    checked: true
                    text: qsTr("ОСН")
                    font: corrSale.font
                }

                SaleComponents.RadioButtonCursor {
                    text: qsTr("УСН доход")
                    font: corrSale.font
                }

                SaleComponents.RadioButtonCursor {
                    text: qsTr("УСН доход-расход")
                    font: corrSale.font
                }

                SaleComponents.RadioButtonCursor {
                    text: qsTr("ЕНВД")
                    font: corrSale.font
                }

                SaleComponents.RadioButtonCursor {
                    text: qsTr("Патент")
                    font: corrSale.font
                }
            }

            SettingsComponents.ParamTitle { text: "Суммы" }

            Row {
                width: parent.width

                Column {
                    id: paymentFrame
                    width: 0.5 * parent.width

                    SettingsComponents.ParamSubTitle {id: cashTitle; text: "Наличные, \u20BD"}
                    SettingsComponents.EnterParamValue { id: cashSum; width: 0.75 * parent.width; height: 0.38 * width }
                }

                Column {
                    width: paymentFrame.width

                    SettingsComponents.ParamSubTitle {text: "Безналичные, \u20BD"}
                    SettingsComponents.EnterParamValue { id: cashlessSum; width: cashSum.width; height: cashSum.height; }
                }
            }

            Row {
                width: parent.width

                Column {
                    width: paymentFrame.width

                    SettingsComponents.ParamSubTitle {text: "Предоплата, \u20BD"}
                    SettingsComponents.EnterParamValue { id: prepaidSum; width: cashSum.width; height: cashSum.height }
                }

                Column {
                    width: paymentFrame.width

                    SettingsComponents.ParamSubTitle {text: "Постоплата, \u20BD"}
                    SettingsComponents.EnterParamValue { id: creditSum;width: cashSum.width; height: cashSum.height }
                }
            }

            Column {
                width: parent.width

                SettingsComponents.ParamSubTitle {text: "Встречное представление, \u20BD"; font: cashTitle.font }
                SettingsComponents.EnterParamValue { id: exchangeSum; width: cashSum.width; height: cashSum.height }
            }

            SettingsComponents.ParamTitle { text: "Основание коррекции" }

            Column {
                width: corrTypeChoose.width
                anchors.horizontalCenter: parent.horizontalCenter
                leftPadding: corrTypeChoose.leftPadding

                SaleComponents.RadioButtonCursor {
                    id: corrReason
                    checked: true
                    text: qsTr("Самостоятельно")
                    font: corrSale.font
                }

                SaleComponents.RadioButtonCursor {
                    text: qsTr("По предписанию")
                    font: corrSale.font
                }
            }

            Column {
                width: corrTypeChoose.width
                anchors.horizontalCenter: parent.horizontalCenter

                SettingsComponents.ParamTitle { text: "Номер документа основания" }

                SettingsComponents.EnterParamValue {
                    id: docNumber
                    width: parent.width - 2 * frame.spacing
                    height: cashSum.height;
                    font: cashSum.font
                    placeholderText: ""
                    validator: RegExpValidator { regExp: /.*/ }
                    inputMethodHints: Qt.ImhNone
                }
            }

            Column {
                leftPadding: corTypeTitle.leftPadding

                Text {
                    id: corDateTitle
                    text: "Дата документа основания"
                    font: corTypeTitle.font
                    horizontalAlignment: corTypeTitle.horizontalAlignment
                    verticalAlignment: corTypeTitle.verticalAlignment
                }

                Button {
                    id: docDate
                    width: cashSum.width
                    height: cashSum.height
                    anchors.horizontalCenter: cashSum.horizontalCenter
                    font {
                        pixelSize: 0.6 * 0.07 * 3.5 * width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    clip: true
                    text: popupDate.choosenDate.toLocaleDateString(locale, Locale.ShortFormat)
                    background: Rectangle {
                        height: 2 * parent.font.pixelSize
                        anchors.verticalCenter: parent.verticalCenter
                        border {
                            color: parent.focus ? "#5C7490" : "#415A77"
                            width: 2
                        }
                        radius: 5
                    }
                    onClicked: {
                        console.log("[PurchaseCorrection.qml]\tenter date")
                        popupDate.open()
                    }
                }
            }

            SettingsComponents.ParamTitle { id: ndsTitle; text: "Сумма по ставкам НДС" }

            Column {
                width: parent.width - 2 * leftPadding
                spacing: frame.spacing
                leftPadding: corTypeTitle.leftPadding

                Row { width: parent.width; height: cashSum.height;
                    SettingsComponents.ParamName { width: 0.5 * (parent.width - nds20.width); text: "20%, \u20BD" }
                    SettingsComponents.EnterParamValue { id: nds20; width: cashSum.width; height: cashSum.height }
                }

                Row { width: parent.width; height: cashSum.height;
                    SettingsComponents.ParamName { width: 0.5 * (parent.width - nds10.width); text: "10%, \u20BD" }
                    SettingsComponents.EnterParamValue { id: nds10; width: cashSum.width; height: cashSum.height }
                }

                Row { width: parent.width; height: cashSum.height;
                    SettingsComponents.ParamName { width: 0.5 * (parent.width - nds0.width); text: "0%, \u20BD" }
                    SettingsComponents.EnterParamValue { id: nds0; width: cashSum.width; height: cashSum.height }
                }

                Row { width: parent.width; height: cashSum.height;
                    SettingsComponents.ParamName { width: 0.5 * (parent.width - nds20_120.width); text: "20/120, \u20BD" }
                    SettingsComponents.EnterParamValue { id: nds20_120; width: cashSum.width; height: cashSum.height }
                }

                Row { width: parent.width; height: cashSum.height;
                    SettingsComponents.ParamName { width: 0.5 * (parent.width - nds10_110.width); text: "20/120, \u20BD" }
                    SettingsComponents.EnterParamValue { id: nds10_110; width: cashSum.width; height: cashSum.height }
                }

                Row { width: parent.width; height: cashSum.height;
                    SettingsComponents.ParamName { width: 0.5 * (parent.width - withoutNds.width); text: "Без НДС, \u20BD" }
                    SettingsComponents.EnterParamValue { id: withoutNds; width: cashSum.width; height: cashSum.height }
                }
            }

            SaleComponents.Button_1 {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.9 * parent.width
                height: 0.16 * width
                enabled: (docNumber.text.length > 0) *
                         (CalcEngine.getNumber(cashSum.text) +
                          CalcEngine.getNumber(cashlessSum.text) +
                          CalcEngine.getNumber(prepaidSum.text) +
                          CalcEngine.getNumber(creditSum.text) +
                          CalcEngine.getNumber(exchangeSum.text) +
                          CalcEngine.getNumber(withoutNds.text) +
                          CalcEngine.getNumber(nds0.text) +
                          CalcEngine.getNumber(nds10.text) +
                          CalcEngine.getNumber(nds10_110.text) +
                          CalcEngine.getNumber(nds20.text) +
                          CalcEngine.getNumber(nds20_120.text))
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr("СФОРМИРОВАТЬ")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: enabled ? "#415A77" : "#BDC3C7"
                pushDownColor: "#004075"
                onClicked: {
                    root.openPage("qrc:/qml/pages/subpages/PurchaseCorrectionView.qml")
                }
            }
        }
    }

    ScrollBar.vertical: ScrollBar {
        width: 8
        policy: ScrollBar.AlwaysOn
        onVisualPositionChanged: {
            focus = true
        }
    }
}
