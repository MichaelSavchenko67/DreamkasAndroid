import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/content/calculator.js" as CalcEngine

Page {
    id: payPage
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("[Pay.qml]\tfocus changed: " + focus)
            setMainPageTitle("Оплата")
            setLeftMenuButtonAction(back)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            clearContextMenu()
            setToolbarVisible(true)
        }
    }

    property var pageIndex: "payPage"
    property var purchaseTotal: "0,00"
    property var excessTotal: "0,00"
    property var deliveryTotal: "0,00"
    property bool cashPay: true

    contentData: Item {
        id: content
        implicitHeight: parent.height
        implicitWidth: parent.width
        anchors.fill: parent

        RowLayout {
            id: totalSums
            width: 0.91 * parent.width
            height: 0.18 * parent.height
            anchors {
                top: parent.top
                topMargin: 0.3 * height
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 0

            ColumnLayout {
                id: totalSumsField
                width: 0.5 * parent.width
                height: parent.height
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                spacing: 0.5 * totalTitle.font.pixelSize

                Column {
                    id: total
                    width: parent.width
                    height: 0.5 * parent.height
                    Layout.alignment: Qt.AlignTop
                    spacing: 0

                    Text {
                        id: totalTitle
                        width: parent.width
                        height: 0.5 * total.height
                        text: qsTr("Получено")
                        font {
                            pixelSize: 0.6 * height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        clip: true
                        color: "black"
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignTop
                    }

                    Text {
                        id: enterPaymentSum
                        width: parent.width
                        height: total.height - totalTitle.height
                        text: enterSumField.displayText
                        font {
                            pixelSize: 0.8 * height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                            bold: true
                        }
                        clip: true
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        color: enterSumField.focus ? "green" : "black"
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignBottom
                        Button {
                            id: enterSumFieldButton
                            anchors.fill: parent
                            enabled: cashPay
                            background: Item {}
                            onClicked: {
                                enterSumField.focus = true
                            }
                        }
                    }

                    TextField {
                        id: enterSumField
                        width: enterPaymentSum.width
                        height: parent.height
                        text: purchaseTotal
                        visible: false
                        enabled: cashPay
                        focus: cashPay
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        validator: RegExpValidator { regExp: /[0-9]{1,},[0-9]{1,2}/ }

                        property var difference

                        onDisplayTextChanged: {
                            enterPaymentSum.text = ((displayText.length > 0) ? CalcEngine.formatResult(displayText) : "0,00") + " \u20BD"
                            difference = CalcEngine.calc(displayText.replace(/\s/g, '') + "-" + purchaseTotal.replace(/\s/g, ''))
                            if (Number(difference) >= 0) {
                                payPage.deliveryTotal = difference.replace(".", ",")
                                payPage.excessTotal = "0,00"
                            } else {
                                payPage.excessTotal = difference.replace(".", ",").substring(1)
                                payPage.deliveryTotal = "0,00"
                            }
                        }

                        onEnabledChanged: {
                            if (!enabled && !cashPay) {
                                displayText = purchaseTotal
                                enterPaymentSum.text = purchaseTotal + " \u20BD"
                            }
                        }
                    }
                }

                Column {
                    id: delivery
                    width: parent.width
                    height: 0.5 * parent.height
                    Layout.alignment: Qt.AlignBottom
                    spacing: 0

                    Text {
                        id: deliveryTitle
                        width: parent.width
                        height: 0.5 * delivery.height
                        text: qsTr("Сдача")
                        font {
                            pixelSize: 0.6 * height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        clip: true
                        color: "black"
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignTop
                    }

                    Text {
                        width: parent.width
                        height: total.height - deliveryTitle.height
                        text: (cashPay ? qsTr(CalcEngine.formatResult(payPage.deliveryTotal)) : "0,00") + " \u20BD"
                        font {
                            pixelSize: 0.8 * height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                            bold: true
                        }
                        clip: true
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        color: "black"
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignBottom
                    }
                }
            }

            Column {
                id: excess
                width: 0.5 * parent.width
                height: 0.5 * parent.height
                Layout.alignment: Qt.AlignRight | Qt.AlignTop
                spacing: 0

                Text {
                    id: excessTitle
                    width: parent.width
                    height: 0.5 * excess.height
                    text: qsTr("Доплата")
                    font {
                        pixelSize: 0.6 * height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    clip: true
                    color: "black"
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignTop
                }

                Text {
                    id: excessSum
                    width: parent.width
                    height: excess.height - excessTitle.height
                    text: (cashPay ? qsTr(CalcEngine.formatResult(excessTotal)) : "0,00") + " \u20BD"
                    font {
                        pixelSize: 0.8 * height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                        bold: true
                    }
                    clip: true
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    color: (excessTotal === "0,00") ? "black" : "red"
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignBottom
                }
            }
        }

        Rectangle {
            id: totalSumMsg
            height: 0.06 * parent.height
            width: parent.width
            anchors {
                top: totalSums.bottom
                topMargin: 0.5 * height
            }

            Label {
                height: parent.height
                width: parent.width - 0.5 * parent.height
                anchors {
                    left: parent.left
                    leftMargin: 0.5 * parent.height
                }

                text: qsTr("Итого, чек")
                font {
                    pixelSize: 0.5 * parent.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }

            Button {
                id: openPurchase
                height: 1.5 * parent.height
                width: 2.82 * height

                property var total: purchaseTotal

                anchors{
                    right: parent.right
                    rightMargin: 0.5 * parent.height
                    verticalCenter: parent.verticalCenter
                }
                background: Rectangle {
                    border.width: 0
                    color: openPurchase.pressed ? "#B2BFB0" : "#E7FFE3"

                    Text {
                        id: totalSum
                        anchors.centerIn: parent
                        text: openPurchase.total + "  \u20BD"
                        font {
                            pixelSize: 0.5 * totalSumMsg.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        color: "#4DA03F"
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter

                        onContentWidthChanged: {
                            if (contentWidth > 6 * height) {
                                openPurchase.width = 1.2 * contentWidth
                            }
                        }
                    }
                }

                onClicked: {
                    openPage("qrc:/qml/pages/subpages/Purchase.qml")
                }
            }
        }

        ColumnLayout {
            width: totalSums.width
            height: 0.2 * parent.height
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: totalSumMsg.bottom
                topMargin: 0.5 * totalSumMsg.height
            }

            Row {
                width: parent.width
                height: parent.height - payTypesTitle.height

                Rectangle {
                    width: 0.2 * content.width
                    height: width
                    border.width: 0
                    border.color: "blue"
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    SaleComponents.CircleButton {
                        id: payButton
                        buttonWidth: parent.width
                        anchors.fill: parent
                        enabled: !cashPay ? true : (payPage.excessTotal === "0,00")
                        enabledIcon: "qrc:/ico/menu/circle_en_violet.png"
                        onClicked: {
                            openPage("qrc:/qml/pages/subpages/FiscalPurchase.qml")
                            rootStack.currentItem.isCashPay = cashPay
                            if (cashPay) {
                                rootStack.currentItem.paymentSum = CalcEngine.formatResult(enterSumField.displayText)
                                rootStack.currentItem.delivery = CalcEngine.formatResult(payPage.deliveryTotal)
                            } else {
                                rootStack.currentItem.paymentSum = CalcEngine.formatResult(purchaseTotal)
                            }
                        }
                    }
                }
            }
        }
    }
}
