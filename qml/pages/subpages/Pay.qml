import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/content/calculator.js" as CalcEngine

Page {
    id: payPage

    property var pageIndex: "payPage"
    property var purchaseTotal: "0,00"
    property var excessTotal: "0,00"
    property var deliveryTotal: "0,00"
    property var lackTotal: "0,00"
    property bool isGetCash: true

    onPurchaseTotalChanged: {
        calculator.setInitValue(purchaseTotal)
    }

    onFocusChanged: {
        if (focus) {
            console.log("[Pay.qml]\tfocus changed: " + focus)
            setMainPageTitle("Оплата наличными")
            setLeftMenuButtonAction(back)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    function isExcess() {
        return (Number(excessTotal.replace(',', '.')) > 0)
    }

    function isDelivery() {
        return (Number(deliveryTotal.replace(',', '.')) > 0)
    }

    contentData: Rectangle {
        anchors.fill: parent

        Column {
            width: parent.width
            height: parent.height - spacing
            anchors {
                top: parent.top
                topMargin: 2 * spacing
            }

            spacing: 0.5 * (height - 0.4 * calculator.getKeyboardWidth() - calculator.height)

            Rectangle {
                width: 0.92 * parent.width
                height: 0.12 * width
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F6F6F6"
                border.width: 0
                radius: 16

                Label {
                    text: qsTr("К оплате " + '<b>' + purchaseTotal + " \u20BD" + '<b>')
                    height: 2 * font.pixelSize
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    font {
                        pixelSize: totalTitle.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    leftPadding: totalTitle.font.pixelSize
                }
            }

            Column {
                width: parent.width
                spacing: 0.5 * parent.spacing

                Label {
                    id: totalTitle
                    text: qsTr("Принято от клиента")
                    height: 2 * font.pixelSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    font {
                        pixelSize: 0.13 * 0.4 * calculator.getKeyboardWidth()
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }

                Label {
                    id: enterPaymentSum
                    width: parent.width
                    height: totalTitle.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:  CalcEngine.formatCommaResult(calculator.formulaStr) + " \u20BD"
                    font {
                        pixelSize: 1.3 * totalTitle.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Bold
                        bold: true
                    }
                    clip: totalTitle.clip
                    color: "#0064B4"
                    elide: totalTitle.elide
                    horizontalAlignment: totalTitle.horizontalAlignment
                    verticalAlignment: totalTitle.verticalAlignment
                    background: Rectangle {
                        color: "#00FFFFFF"
                        border.width: 0
                    }

                    property var difference
                    property var total

                    onTextChanged: {
                        total = CalcEngine.formatCommaResult(calculator.formulaStr)
                        difference = CalcEngine.calc(total.replace(/\s/g, '') + "-" + purchaseTotal.replace(/\s/g, ''))

                        if (Number(difference) >= 0) {
                            deliveryTotal = difference.replace(".", ",")
                            excessTotal = "0,00"
                        } else {
                            excessTotal = difference.replace(".", ",").substring(1)
                            deliveryTotal = "0,00"
                        }
                    }
                }

                Rectangle {
                    height: 2
                    width: enterPaymentSum.contentWidth + 2 * enterPaymentSum.font.pixelSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#00FFFFFF"
                    border.width: 1
                    border.color: "#E0E0E0"
                }

                Text {
                    id: excessDeliverySum
                    width: totalTitle.width
                    height: totalTitle.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: isExcess() ? "Доплатить " + '<b>' + CalcEngine.formatCommaResult(excessTotal) + " \u20BD</b>" :
                                       isDelivery() ? "Сдача " + '<b>' +CalcEngine.formatCommaResult(deliveryTotal) + " \u20BD</b>" : ""
                    font: totalTitle.font
                    clip: totalTitle.clip
                    color: isExcess() ? "#C62828" : "black"
                    elide: totalTitle.elide
                    horizontalAlignment: totalTitle.horizontalAlignment
                    verticalAlignment: totalTitle.verticalAlignment
                }
            }

            SaleComponents.Calculator {
                id: calculator

                Component.onCompleted: {
                    reset()
                    setKeyboard("keyboardShortest")
                    setPrecDigits(2)
                    setEnable(isGetCash)
                }
            }
        }
    }

    footer: SaleComponents.FooterMain {
        id: footerMain
        height: btnRow.height + 2 * 0.125 * btnRow.height

        Rectangle {
            anchors.fill: parent
            color: "#F6F6F6"

            Row {
                id: btnRow
                width: parent.width
                height: 0.16 * width
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 0.125 * height
                }
                spacing: 0.03 * width
                leftPadding: spacing
                rightPadding: spacing

                SaleComponents.ButtonIcoH {
                    id: openPurchase
                    width: (parent.width - 3 * parent.spacing) / 3
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    iconPath: "qrc:/ico/menu/purchase.png"
                    buttonTxt: "ЧЕК"
                    buttonTxtColor: "#415A77"
                    pushUpColor: "#FFFFFF"
                    pushDownColor: "#F2F2F2"
                    enabled: (enterPaymentSum.total !== "0,00")

                    onClicked: {
                        root.openPage("qrc:/qml/pages/subpages/Purchase.qml")
                    }
                    topPadding: buttons.spacing
                    leftPadding: buttons.spacing
                }

                SaleComponents.ButtonIcoH {
                    width: 2 / 3 * (parent.width - 3 * parent.spacing)
                    height: parent.height
                    iconPath: "qrc:/ico/menu/credit_card.png"
                    buttonTxt: enabled ? (Number(deliveryTotal.replace(',', '.') > 0) ? "ОПЛАТИТЬ" : "ОПЛАТИТЬ БЕЗ СДАЧИ") :  "ОПЛАТИТЬ"
                    enabled: (excessTotal === "0,00")

                    onClicked: {
                        openPage("qrc:/qml/pages/subpages/FiscalPurchase.qml")
                        rootStack.currentItem.isCashPay = true
                        rootStack.currentItem.paymentSum = CalcEngine.formatResult(enterPaymentSum.total.replace(/\s/g, ''))
                        rootStack.currentItem.delivery = CalcEngine.formatResult(payPage.deliveryTotal)
                    }
                }
            }
        }
    }
}
