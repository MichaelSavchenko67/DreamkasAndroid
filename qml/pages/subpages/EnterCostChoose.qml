import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/content/calculator.js" as CalcEngine

Page {
    id: enterCostChoose
    implicitHeight: parent.height
    implicitWidth: parent.width
    anchors.fill: parent

    contentData: Item {
        anchors.fill: parent

        SaleComponents.Calculator {
            id: calculator

            anchors.top: parent.top

            Component.onCompleted: {
                reset()
                setDisplay("saleDisplay")
                setKeyboard("keyboardFull")
            }

            onAdd2purchase: {
                openPurchase.total = calculator.formulaTotal
                calculator.reset()
            }
        }

        SaleComponents.PopupCashlessPaymentChoose {
            id: popupCashlessPaymentChoose
            onClosed: {
                cashlessButton.hold = false
            }
        }
    }

    footer: SaleComponents.FooterMain {
        Rectangle {
            anchors.fill: parent
            color: "#F2F3F5"

            Column {
                anchors.fill: parent
                spacing: 0.5 * buttons.spacing

                Text {
                    id: clcSign
                    text: "ВОЗВРАТ ПРИХОДА" + " • " + "ПАТЕНТ"
                    font {
                        pixelSize: cashButton.fontSize
                        weight: Font.DemiBold
                        bold: fontBold
                    }
                    color: "#595959"
                    elide: Text.ElideRight
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: TextInput.AlignVCenter
                    topPadding: buttons.spacing
                    leftPadding: buttons.spacing
                }

                Row {
                    id: buttons
                    width: parent.width
                    height: 0.9 * (parent.height - clcSign.height)
                    spacing: 0.5 * (0.044 * width)
                    leftPadding: spacing
                    rightPadding: spacing

                    SaleComponents.Button_1 {
                        id: cashButton
                        width: (parent.width - 4 * parent.spacing) / 3
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        borderWidth: 1
                        backRadius: 5
                        buttonTxt: qsTr("НАЛИЧНЫЕ")
                        fontSize: 0.23 * height
                        buttonTxtColor: "#0064B4"
                        pushUpColor: "#FFFFFF"
                        pushDownColor: "#C2C2C2"
                        enabled: openPurchase.enabled

                        onClicked: {
                            root.openPage("qrc:/qml/pages/subpages/Pay.qml")
                            rootStack.currentItem.purchaseTotal = openPurchase.total
                        }
                    }

                    SaleComponents.Button_1 {
                        id: cashlessButton
                        width: (parent.width - 4 * parent.spacing) / 3
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        borderWidth: 1
                        backRadius: 5
                        buttonTxt: qsTr(root.cashlessPaymentName.toUpperCase())
                        fontSize: 0.23 * height
                        buttonTxtColor: "#0064B4"
                        pushUpColor: "#FFFFFF"
                        pushDownColor: "#C2C2C2"
                        enabled: openPurchase.enabled

                        property bool hold: false

                        Timer {
                            id: holdTimer
                            repeat: false
                            running: false

                            onTriggered: {
                                parent.hold = parent.pressed
                                if (parent.pressed) {
                                    running = false
                                    popupCashlessPaymentChoose.open()
                                }
                            }
                        }

                        onPressedChanged: {
                            holdTimer.interval = 1000
                            holdTimer.running = !hold && pressed
                        }

                        onClicked: {
                            if (!hold) {
                                popupCashlessPaymentChoose.close()
                                root.openPage("qrc:/qml/pages/subpages/FiscalPurchase.qml")
                                rootStack.currentItem.isCashPay = false
                                rootStack.currentItem.paymentSum = CalcEngine.formatResult(openPurchase.total)
                            }
                        }
                    }

                    SaleComponents.Button_1 {
                        id: openPurchase
                        property var total: "0,00"

                        width: (parent.width - 4 * parent.spacing) / 3
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        borderWidth: 1
                        backRadius: 5
                        buttonTxt: qsTr("ИТОГО\n" + total + " \u20BD")
                        fontSize: 0.23 * height
                        buttonTxtColor: "#FFFFFF"
                        pushUpColor: "#0064B4"
                        pushDownColor: "#004075"
                        enabled: (total != "0,00")

                        onClicked: {
                            root.openPage("qrc:/qml/pages/subpages/Purchase.qml")
                        }
                    }
                }
            }
        }
    }
}
