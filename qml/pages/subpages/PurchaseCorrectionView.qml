import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/settings" as SettingsComponents
import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: page
    anchors.fill: parent

    onFocusChanged: {
        if (focus) {
            console.log("[PurchaseCorrection.qml]\tfocus changed: " + focus)
            setMainPageTitle("Чек коррекции")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    Column {
        width: parent.width
        spacing: msg2user.font.pixelSize
        leftPadding: 0.5 * (parent.width - frame.width)

        Text {
            id: msg2user
            text: "Проверьте данные.\nОтправить чек коррекции в ФНС?"
            font {
                pixelSize: 0.05 * parent.width
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
            }
            color: "#666666"
            clip: true
            elide: Text.ElideRight
            maximumLineCount: 2
            lineHeight: 1.2
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            topPadding: font.pixelSize
        }

        ScrollView {
            id: frame
            width: 0.9 * page.width
            height: page.height - msg2user.contentHeight - 4 * parent.spacing
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.width: 8

            Flickable {
                contentHeight: pane.height
                width: parent.width

                Pane {
                    id: pane
                    width: parent.width
                    clip: true

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#F3F3F3"
                        radius: 5
                    }

                    Column {
                        id: corrDataView
                        anchors.fill: parent
                        spacing: 0.045 * width
                        topPadding: 0.5 * spacing
                        bottomPadding: topPadding

                        SettingsComponents.ParamRow { param: "Тип чека коррекции";                  value: "Коррекция прихода" }
                        SettingsComponents.ParamRow { param: "Система\nналогооблажения";            value: "ОСН" }
                        SettingsComponents.ParamRow { param: "Сумма наличными";                     value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма безналичными";                  value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма предоплатой";                   value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма постоплатой";                   value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма встречным представлением";      value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Основание коррекции";                 value: "По предписанию" }
                        SettingsComponents.ParamRow { param: "Номер документа основания";           value: "234" }
                        SettingsComponents.ParamRow { param: "Дата создания документа основания";   value: "11.12.2020" }
                        SettingsComponents.ParamRow { param: "Сумма по ставке НДС 20%";             value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма по ставке НДС 10%";             value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма по ставке НДС 0%";              value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма по ставке НДС 20/120";          value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма по ставке НДС 10/110";          value: "0,00 \u20BD" }
                        SettingsComponents.ParamRow { param: "Сумма без НДС";                       value: "0,00 \u20BD" }

                        SaleComponents.Button_1 {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 0.9 * parent.width
                            height: 0.18 * width
                            borderWidth: 0
                            backRadius: 5
                            buttonTxt: qsTr("ПЕЧАТЬ")
                            fontSize: 0.27 * height
                            buttonTxtColor: "white"
                            pushUpColor: enabled ? "#415A77" : "#BDC3C7"
                            pushDownColor: "#004075"
                            onClicked: {
                                root.openPage("qrc:/qml/pages/subpages/PrintPurchaseCorrection.qml")
                            }
                        }
                    }
                }
            }
        }
    }
}
