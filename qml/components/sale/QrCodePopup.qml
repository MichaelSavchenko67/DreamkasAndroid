import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupQrCode

    property string src: ""

    signal openPrintedPurchase()
    signal revertPurchase()

    width: 0.898 * parent.width
    height: 0.916 * parent.height
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        anchors.fill: parent
        radius: 8
        color: "white"

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                topMargin: 0.5 *  0.038 * exitButton.height
                right: parent.right
                rightMargin: 0.5 *  0.038 * exitButton.height
            }
            icon {
                color: "#979797"
                height: 0.038 * 0.9 * parent.width
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                popupQrCode.close()
            }
        }

        Column {
            width: parent.width
            height: parent.height - 2 * exitButton.height
            topPadding: exitButton.height
            spacing: (height + exitButton.height - (purchaseTitleColumn.height + qrCode.height + buttonsColumn.height)) / 2

            Column {
                id: purchaseTitleColumn
                width: parent.width - exitButton.width
                height: purchaseTitleRow.height +
                        shiftRow.height +
                        cashierRow.height +
                        totalRow.height +
                        2 * spacing
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: purchaseTitleLabel.font.pixelSize

                Row {
                    id: purchaseTitleRow
                    width: parent.width
                    height: purchaseTitleLabel.contentHeight

                    Label {
                        id: purchaseTitleLabel
                        text: "КАССОВЫЙ ЧЕК №218"
                        width: 0.6 * parent.width
                        font {
                            pixelSize: 0.025 * popupQrCode.height
                            family: "Roboto"
                            weight: Font.DemiBold
                        }
                        color: "#0064B4"
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Label {
                        text: "27.05.21 06:03"
                        width: parent.width - purchaseTitleLabel.width
                        font: purchaseTitleLabel.font
                        color: purchaseTitleLabel.color
                        elide: purchaseTitleLabel.elide
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: purchaseTitleLabel.verticalAlignment
                    }
                }

                Row {
                    id: shiftRow
                    width: parent.width
                    height: shiftNumberTitleLabel.contentHeight

                    Label {
                        id: shiftNumberTitleLabel
                        text: "СМЕНА"
                        width: 0.6 * parent.width
                        font {
                            pixelSize: 0.9 * purchaseTitleLabel.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                        }
                        color: "black"
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Label {
                        id: shiftNumberValueLabel
                        text: "79"
                        width: parent.width - purchaseTitleLabel.width

                        font {
                            pixelSize: 0.9 * purchaseTitleLabel.font.pixelSize
                            family: "Roboto"
                            weight: Font.DemiBold
                        }
                        color: "black"
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                Row {
                    id: cashierRow
                    width: shiftRow.width
                    height: cashierTitleLabel.contentHeight

                    Label {
                        id: cashierTitleLabel
                        text: "КАССИР"
                        width: parent.width - buyerNameLabel.width
                        font: shiftNumberTitleLabel.font
                        color: shiftNumberTitleLabel.color
                        elide: shiftNumberTitleLabel.elide
                        horizontalAlignment: shiftNumberTitleLabel.horizontalAlignment
                        verticalAlignment: shiftNumberTitleLabel.verticalAlignment
                    }

                    Label {
                        id: buyerNameLabel
                        text: "Савченко Михаил Андреевич"
                        width: 0.75 * parent.width
                        font: shiftNumberValueLabel.font
                        color: shiftNumberValueLabel.color
                        elide: shiftNumberValueLabel.elide
                        horizontalAlignment: shiftNumberValueLabel.horizontalAlignment
                        verticalAlignment: shiftNumberValueLabel.verticalAlignment
                    }
                }

                Row {
                    id: totalRow
                    width: parent.width

                    Label {
                        id: totalLabel
                        text: "ИТОГО"
                        width: 0.5 * parent.width
                        anchors.verticalCenter: totalPurchaseLabel.verticalCenter
                        font {
                            pixelSize: 1.35 * purchaseTitleLabel.font.pixelSize
                            family: "Roboto"
                            weight: Font.DemiBold
                        }
                        color: "#0064B4"
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Label {
                        id: totalPurchaseLabel
                        text: "100 000,00" + "&nbsp;\u20BD"
                        width: parent.width - totalLabel.width
                        textFormat: Label.RichText
                        font: totalLabel.font
                        color: totalLabel.color
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                        maximumLineCount: 2
                        wrapMode: Label.WordWrap
                    }
                }
            }

            Image {
                id: qrCode
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.763 * parent.width
                height: width
                fillMode: Image.PreserveAspectFit
                source: src
            }

            Column {
                id: buttonsColumn
                width: 0.92 * parent.width
                height: 2 * openPrintedPurchaseButton.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0

                SaleComponents.Button_1 {
                    id: openPrintedPurchaseButton
                    width: parent.width
                    height: 0.16 * width
                    borderWidth: 0
                    backRadius: 8
                    buttonTxt: qsTr("ПОКАЗАТЬ СПИСОК ТОВАРОВ")
                    fontSize: 0.27 * height
                    buttonTxtColor: "white"
                    pushUpColor: "#415A77"
                    pushDownColor: "#004075"
                    onClicked: {
                        openPrintedPurchase()
                    }
                }

                SaleComponents.Button_1 {
                    id: revertPurchaseButton
                    width: openPrintedPurchaseButton.width
                    height: openPrintedPurchaseButton.height
                    borderWidth: openPrintedPurchaseButton.borderWidth
                    backRadius: openPrintedPurchaseButton.backRadius
                    buttonTxt: qsTr("ВЫПОЛНИТЬ ВОЗВРАТ")
                    fontSize: openPrintedPurchaseButton.fontSize
                    buttonTxtColor: "#0064B4"
                    pushUpColor: "white"
                    pushDownColor: "#F6F6F6"
                    onClicked: {
                        popupQrCode.close()
                    }
                }
            }
        }
    }
}
