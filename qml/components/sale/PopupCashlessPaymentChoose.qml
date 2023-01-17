import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents
import "qrc:/content/calculator.js" as CalcEngine

Popup {
    id: popupCashlessPaymentChoose

    property var total: "0,00"

    width: 0.8 * parent.width
    height: 1.2 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    background: Rectangle {
        id: popupFrame
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                right: parent.right
            }
            icon {
                color: "#979797"
                height: 0.038 * parent.height
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                popupCashlessPaymentChoose.close()
            }
        }

        Column {
            width: parent.width
            spacing: 0.038 * parent.height
            anchors.centerIn: parent

            SettingsComponents.CashlessPaymentChoose { id: cashlessPaymentChoose }

            SaleComponents.Button_1 {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.25 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: cashlessPaymentChoose.cashlessPaymentChoosen.toUpperCase()
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: "#0064B4"
                pushDownColor: "#004075"
                onClicked: {
                    popupCashlessPaymentChoose.close()
                    root.openPage("qrc:/qml/pages/subpages/FiscalPurchase.qml")
                    rootStack.currentItem.isCashPay = false
                    rootStack.currentItem.cashlessPaymentName = cashlessPaymentChoose.cashlessPaymentChoosen
                    rootStack.currentItem.paymentSum = CalcEngine.formatResult(total)
                }
            }
        }
    }
}
