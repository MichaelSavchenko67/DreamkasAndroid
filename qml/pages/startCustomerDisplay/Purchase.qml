import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    width: parent.width
    height: parent.height

    function choosePaymentType(id) {
        cashlessButton.isChoosen = (id === cashlessButton)
        cashButton.isChoosen = (id === cashButton)
        qrCodeButton.isChoosen = (id === qrCodeButton)
    }

    contentData: Column {
        id: mainColumn
        anchors.fill: parent
        topPadding: 1.1 * productNameLabel.font.pixelSize
        bottomPadding: 0.0394 * width
        spacing: height -
                 topPadding -
                 productTitleColumn.height -
                 footerColumn.height -
                 bottomPadding

        Column {
            id: productTitleColumn
            width: parent.width
            spacing: 2 * productNameLabel.font.pixelSize

            Label {
                id: productNameLabel
                width: 0.8 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Виноград Кишмиш, без косточки")
                font {
                    pixelSize: 0.0525 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                    bold: true
                }
                color: "black"
                elide: Label.ElideRight
                lineHeight: 1.3
                maximumLineCount: 3
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Column {
                width: parent.width
                spacing: 0.5 * productMeasureLabel.font.pixelSize

                Label {
                    id: productMeasureLabel
                    width: productNameLabel.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("200 \u20BD x 2,500 кг")
                    font {
                        pixelSize: 0.83 * productNameLabel.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: productNameLabel.color
                    opacity: 0.6
                    elide: productNameLabel.elide
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: productNameLabel.verticalAlignment
                }

                SaleComponents.DynamicNumberField {
                    width: productMeasureLabel.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    number: 500.00
                    accuracy: 2
                    ending: "\u20BD"
                    font {
                        pixelSize: 1.5 * productNameLabel.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                        bold: true
                    }
                    color: productMeasureLabel.color
                    elide: productMeasureLabel.elide
                    horizontalAlignment: productMeasureLabel.horizontalAlignment
                    verticalAlignment: productMeasureLabel.verticalAlignment
                }
            }
        }

        Column {
            id: footerColumn
            width: parent.width
            spacing: mainColumn.bottomPadding + 0.6 * openPurchaseButton.height

            SettingsComponents.Avatar {
                width: 0.3 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                avatarSrc: "qrc:/ico/tiles/tileGoods6.png"
            }

            Column {
                id: mainFooterColumn
                width: parent.width
                spacing: mainColumn.bottomPadding

                Column {
                    width: parent.width

                    Rectangle {
                        id: totalFrame
                        width: 0.875 * parent.width
                        height: totalsColumn.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#F6F6F6"
                        radius: 16

                        SaleComponents.RoundButtonCustom {
                            id: openPurchaseButton
                            width: 0.175 * parent.width
                            height: width
                            anchors.verticalCenter: totalsColumn.top
                            iconPath: "qrc:/ico/menu/purchase.png"
                            buttonTxt: "ЧЕК"
                            buttonTxtColor: "black"
                            backRadius: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                            }
                        }

                        Column {
                            id: totalsColumn
                            width: parent.width
                            topPadding: discountRow.leftPadding
                            bottomPadding: topPadding
                            spacing: topPadding

                            Row {
                                id: discountRow
                                width: parent.width
                                leftPadding: 0.035 * width
                                rightPadding: leftPadding

                                Label {
                                    id: discountTitleLabel
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: qsTr("Скидка")
                                    font {
                                        pixelSize: 0.67 * productNameLabel.font.pixelSize
                                        family: "Roboto"
                                        styleName: "normal"
                                        weight: Font.Normal
                                    }
                                    color: productMeasureLabel.color
                                    opacity: productMeasureLabel.opacity
                                    elide: productMeasureLabel.elide
                                    horizontalAlignment: productMeasureLabel.horizontalAlignment
                                    verticalAlignment: productMeasureLabel.verticalAlignment
                                }

                                SaleComponents.DynamicNumberField {
                                    width: parent.width -
                                           2 * parent.leftPadding -
                                           discountTitleLabel.contentWidth
                                    anchors.verticalCenter: parent.verticalCenter
                                    number: 1000.00
                                    accuracy: 2
                                    ending: "\u20BD"
                                    font: discountTitleLabel.font
                                    color: productMeasureLabel.color
                                    opacity: productMeasureLabel.opacity
                                    elide: productMeasureLabel.elide
                                    horizontalAlignment: totalNumber.horizontalAlignment
                                    verticalAlignment: productMeasureLabel.verticalAlignment
                                }
                            }

                            Row {
                                id: totalRow
                                width: parent.width
                                leftPadding: 0.035 * width
                                rightPadding: leftPadding

                                Label {
                                    id: totalTitleLabel
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: qsTr("Итого")
                                    font: productNameLabel.font
                                    color: productMeasureLabel.color
                                    elide: productMeasureLabel.elide
                                    horizontalAlignment: productMeasureLabel.horizontalAlignment
                                    verticalAlignment: productMeasureLabel.verticalAlignment
                                }

                                SaleComponents.DynamicNumberField {
                                    id: totalNumber
                                    width: parent.width -
                                           2 * parent.leftPadding -
                                           totalTitleLabel.contentWidth
                                    anchors.verticalCenter: parent.verticalCenter
                                    number: 99000.00
                                    accuracy: 2
                                    ending: "\u20BD"
                                    font: productNameLabel.font
                                    color: productMeasureLabel.color
                                    elide: productMeasureLabel.elide
                                    horizontalAlignment: Label.AlignRight
                                    verticalAlignment: productMeasureLabel.verticalAlignment
                                }
                            }
                        }
                    }
                }

                Label {
                    width: totalFrame.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Выберите способ оплаты")
                    font: discountTitleLabel.font
                    color: discountTitleLabel.color
                    elide: discountTitleLabel.elide
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: discountTitleLabel.verticalAlignment
                }

                Row {
                    width: totalFrame.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 0.5 * (width - 3 * cashlessButton.width)

                    SaleComponents.ButtonIcoH {
                        id: cashlessButton
                        width: 0.311 * parent.width
                        height: 0.5 * width
                        borderWidth: isChoosen ? 3 : 2
                        borderColor: isChoosen ? "#08966B" : "#F6F6F6"
                        buttonTxt: qsTr("Карта")
                        buttonTxtColor: "black"
                        fontSize: 0.9 * discountTitleLabel.font.pixelSize
                        fontBold: false
                        pushUpColor: "white"
                        pushDownColor: "transparent"
                        iconPath: "qrc:/ico/sale/cashless_blue.png"
                        iconHeight: 2 * fontSize
                        gradientParams: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: "#1AE6A8" }
                            GradientStop { position: 1.0; color: "#55C4DC" }
                        }
                        opacityParam: 0.35
                        onClicked: {
                            choosePaymentType(cashlessButton)
                        }
                    }

                    SaleComponents.ButtonIcoH {
                        id: cashButton
                        width: cashlessButton.width
                        height: cashlessButton.height
                        borderWidth: isChoosen ? 3 : 2
                        borderColor: isChoosen ? "#08966B" : "#F6F6F6"
                        buttonTxt: qsTr("Наличные")
                        buttonTxtColor: cashlessButton.buttonTxtColor
                        fontSize: cashlessButton.fontSize
                        fontBold: cashlessButton.fontBold
                        pushUpColor: cashlessButton.pushUpColor
                        pushDownColor: cashlessButton.pushDownColor
                        iconPath: "qrc:/ico/sale/cash_rub.png"
                        iconHeight: cashlessButton.iconHeight
                        gradientParams: cashlessButton.gradientParams
                        opacityParam: cashlessButton.opacityParam
                        onClicked: {
                            choosePaymentType(cashButton)
                        }
                    }

                    SaleComponents.ButtonIcoH {
                        id: qrCodeButton
                        width: cashlessButton.width
                        height: cashlessButton.height
                        borderWidth: isChoosen ? 3 : 2
                        borderColor: isChoosen ? "#08966B" : "#F6F6F6"
                        buttonTxt: qsTr("QR-код")
                        buttonTxtColor: cashlessButton.buttonTxtColor
                        fontSize: cashlessButton.fontSize
                        fontBold: cashlessButton.fontBold
                        pushUpColor: cashlessButton.pushUpColor
                        pushDownColor: cashlessButton.pushDownColor
                        iconPath: "qrc:/ico/sale/carbon_qr_code.png"
                        iconHeight: cashlessButton.iconHeight
                        gradientParams: cashlessButton.gradientParams
                        opacityParam: cashlessButton.opacityParam
                        onClicked: {
                            choosePaymentType(qrCodeButton)
                        }
                    }
                }
            }
        }
    }
}
