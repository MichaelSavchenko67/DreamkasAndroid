import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Popup {
    id: popupCashlessPaymentChoose

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
                    root.cashlessPaymentName = cashlessPaymentChoose.cashlessPaymentChoosen
                    popupCashlessPaymentChoose.close()
                }
            }
        }
    }
}
