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
            clearContextMenu()
            setToolbarVisible(true)
        }
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

            spacing: 0.5 * (height - totalSums.height - calculator.height)

            Row {
                id: totalSums
                width: calculator.getKeyboardWidth()
                height: 0.4 * width
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    width: 0.5 * parent.width
                    height: parent.height

                    Text {
                        id: totalTitle
                        width: parent.width
                        height: parent.height / 3
                        text: qsTr(isGetCash ? "Получено" : "Сумма")
                        font {
                            pixelSize: 0.13 * totalSums.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        color: "black"
                        elide: Text.ElideRight
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                        topPadding: leftPadding
                    }

                    Label {
                        id: enterPaymentSum
                        width: totalTitle.width
                        height: totalTitle.height

                        text:  CalcEngine.formatCommaResult(calculator.formulaStr) + " \u20BD"

                        font {
                            pixelSize: 1.3 * totalTitle.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Bold
                            bold: true
                        }
                        clip: totalTitle.clip
                        color: totalTitle.color
                        elide: totalTitle.elide
                        horizontalAlignment: totalTitle.horizontalAlignment
                        verticalAlignment: totalTitle.verticalAlignment
                        leftPadding: font.pixelSize
                        background: Rectangle {
                            border {
                                color: "green"
                                width: 2
                            }
                            radius: 5
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

                    Text {
                        id: excessSum
                        width: totalTitle.width
                        height: totalTitle.height
                        text: "Доплата " + '<b>' + CalcEngine.formatCommaResult(excessTotal) + " \u20BD</b>"
                        visible: isGetCash
                        font: totalTitle.font
                        clip: totalTitle.clip
                        color: totalTitle.color
                        elide: totalTitle.elide
                        horizontalAlignment: totalTitle.horizontalAlignment
                        verticalAlignment: totalTitle.verticalAlignment
                        bottomPadding: leftPadding
                    }

                    Text {
                        id: lackSum
                        width: totalSums.width
                        height: totalTitle.height
                        text: "Сумма превышена на " + '<b>' + "0,00" + " \u20BD</b>"
                        visible: !excessSum.visible
                        font: totalTitle.font
                        clip: totalTitle.clip
                        color: "red"
                        elide: totalTitle.elide
                        horizontalAlignment: totalTitle.horizontalAlignment
                        verticalAlignment: totalTitle.verticalAlignment
                        bottomPadding: leftPadding
                    }
                }

                Column {
                    width: 0.5 * parent.width
                    height: parent.height
                    visible: isGetCash

                    Text {
                        id: deliveryTitle
                        width: totalTitle.width
                        height: totalTitle.height
                        anchors.verticalCenter: totalTitle.verticalCenter
                        text: "Сдача"
                        font: totalTitle.font
                        clip: totalTitle.clip
                        color: totalTitle.color
                        elide: totalTitle.elide
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                        topPadding: totalTitle.topPadding
                    }

                    Text {
                        width: deliveryTitle.width
                        height: deliveryTitle.height
                        text: CalcEngine.formatCommaResult(deliveryTotal) + " \u20BD"
                        font: enterPaymentSum.font
                        clip: deliveryTitle.clip
                        color: deliveryTitle.color
                        elide: deliveryTitle.elide
                        horizontalAlignment: deliveryTitle.horizontalAlignment
                        verticalAlignment: deliveryTitle.verticalAlignment
                        leftPadding: deliveryTitle.leftPadding
                    }
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
                        pixelSize: payButton.fontSize
                        weight: Font.DemiBold
                        bold: fontBold
                    }
                    color: "#595959"
                    elide: Text.ElideRight
                    horizontalAlignment: TextInput.AlignLeft
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
                        id: payButton
                        width: 2 / 3 * (parent.width - 3 * parent.spacing)
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        borderWidth: 1
                        backRadius: 5
                        buttonTxt: qsTr("ОПЛАТИТЬ")
                        fontSize: 0.23 * height
                        buttonTxtColor: "#0064B4"
                        pushUpColor: "#FFFFFF"
                        pushDownColor: "#C2C2C2"
                        enabled: (excessTotal === "0,00")

                        onClicked: {
                            openPage("qrc:/qml/pages/subpages/FiscalPurchase.qml")
                            rootStack.currentItem.isCashPay = true
                            rootStack.currentItem.paymentSum = CalcEngine.formatResult(enterPaymentSum.total.replace(/\s/g, ''))
                            rootStack.currentItem.delivery = CalcEngine.formatResult(payPage.deliveryTotal)
                        }
                    }

                    SaleComponents.Button_1 {
                        id: openPurchase

                        width: (parent.width - 3 * parent.spacing) / 3
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        borderWidth: 1
                        backRadius: 5
                        buttonTxt: qsTr("ИТОГО\n" + purchaseTotal + " \u20BD")
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
