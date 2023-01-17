import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12

import "qrc:/content/calculator.js" as CalcEngine
import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: addPositionPopup

    property var goodsName: "Картофель свежий урожай 2021, Россия"
    property var unitPrice: ""
    property var totalPrice: "0,00"
    property var quantity: ""
    property var measure: "шт"
    property bool isCostEdit: true
    property bool isQuantityEdit: true

    property var costMask: RegularExpressionValidator { regularExpression: /^(0|[1-9]\d*)([.]|[,]\d{1,2})?$/ }
    property var countMask: RegularExpressionValidator { regularExpression: /[1-9]\d*/ }
    property var scaleMask: RegularExpressionValidator { regularExpression: /^(0|[1-9]\d*)([.]|[,]\d{1,3})?$/ }

    onOpened: {
        costField.focus = false
        quantityField.focus = false

        isCostEdit = (CalcEngine.getNumber(unitPrice) === 0)
        isQuantityEdit = (isQuantityEdit || (CalcEngine.getNumber(quantity) === 0))

        if (isCostEdit) {
            unitPrice = ""
            costField.focus = true
        } else if (isQuantityEdit) {
            quantityField.focus = true
        }

        calcTotalPrice()
    }

    function calcTotalPrice() {
        if ((unitPrice.length > 0) && (quantity.length > 0)) {
            totalPrice = CalcEngine.calc(unitPrice.replace(',', '.') + " * " + quantity.replace(',', '.'))
        } else {
            totalPrice = "0,00"
        }
        console.log("totalPrice changed: " + totalPrice)
        add2purchaseButton.enabled = (CalcEngine.getNumber(totalPrice) > 0)
    }

    width: 0.9 * parent.width
    height: 2 * exitButton.height + rootColumn.height
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle {
        id: popupFrame
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        anchors.fill: parent

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                topMargin: 0.5 *  0.038 * parent.height
                right: parent.right
                rightMargin: 0.5 *  0.038 * parent.height
            }
            icon {
                color: "#979797"
                height: 0.049 * parent.width
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                addPositionPopup.close()
            }
        }

        Column {
            id: rootColumn
            width: 0.8 * parent.width
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: qsTr(goodsName)
                font {
                    pixelSize: 0.074 * addPositionPopup.width
                    family: "Roboto"
                    styleName: "medium"
                    weight: Font.Medium
                    bold: true
                }
                color: "black"
                clip: true
                elide: "ElideRight"
                maximumLineCount: 2
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }

            Column {
                id: costColumn
                width: parent.width
                spacing: 0.15 * rootColumn.spacing

                Label {
                    id: costTitle
                    width: parent.width
                    text: "Цена"
                    font {
                        pixelSize: 0.75 * title.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    clip: true
                    elide: "ElideRight"
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }

                Row {
                    width: parent.width

                    TextField {
                        id: costField
                        width: parent.width - costMeasure.width
                        anchors.verticalCenter: parent.verticalCenter
                        enabled: isCostEdit
                        placeholderText: CalcEngine.formatResult(unitPrice)
                        placeholderTextColor: "#000000"
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        validator: costMask
                        font {
                            pixelSize: title.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#0064B4"
                        onTextChanged: {
                            unitPrice = text
                            console.log("unitPrice changed: " + unitPrice)
                            calcTotalPrice()
                            text = text.replace('.', ',')
                        }
                    }

                    Label {
                        id: costMeasure
                        text: qsTr(" \u20BD/" + measure)
                        anchors.verticalCenter: parent.verticalCenter
                        font {
                            pixelSize: title.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: title.color
                        clip: title.clip
                        elide: title.elide
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                    }
                }
            }

            Column {
                width: costColumn.width
                spacing: costColumn.spacing

                Label {
                    id: quantityTitle
                    width: costTitle.width
                    text: "Количество"
                    font: costTitle.font
                    color: costTitle.color
                    clip: costTitle.clip
                    elide: costTitle.elide
                    horizontalAlignment: costTitle.horizontalAlignment
                    verticalAlignment: costTitle.verticalAlignment
                }

                Row {
                    width: parent.width

                    TextField {
                        id: quantityField
                        width: costField.width
                        enabled: isQuantityEdit
                        placeholderText: CalcEngine.formatResult(quantity)
                        placeholderTextColor: costField.placeholderTextColor
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        validator: (measure === "шт") ? countMask : scaleMask
                        font: costField.font
                        color: costField.color
                        onTextChanged: {
                            quantity = text
                            console.log("quantity changed: " + quantity)
                            calcTotalPrice()
                            text = text.replace('.', ',')
                        }
                    }

                    Label {
                        text: qsTr(measure)
                        width: costMeasure.width
                        anchors.verticalCenter: parent.verticalCenter
                        font: costMeasure.font
                        color: costMeasure.color
                        clip: costMeasure.clip
                        elide: costMeasure.elide
                        horizontalAlignment: costMeasure.horizontalAlignment
                        verticalAlignment: costMeasure.verticalAlignment
                    }
                }
            }

            Column {
                id: add2PurchaseColumn
                width: parent.width
                spacing: 0.1 * rootColumn.spacing

                Label {
                    width: parent.width
                    text: qsTr("Сумма за товар <b>" + CalcEngine.formatCommaResult(totalPrice.replace('.', ',')) + " \u20BD</b>")
                    font: costTitle.font
                    color: add2purchaseButton.enabled ? "black" : "#979797"
                    clip: costTitle.clip
                    elide: costTitle.elide
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: costTitle.verticalAlignment
                }

                SaleComponents.Button_1 {
                    id: add2purchaseButton
                    width: parent.width
                    height: 0.2 * width
                    enabled: false
                    opacity: enabled ? 1 : 0.6
                    borderWidth: 0
                    backRadius: 8
                    buttonTxt: qsTr("ДОБАВИТЬ В ЧЕК")
                    fontSize: 0.27 * height
                    buttonTxtColor: "white"
                    pushUpColor: "#415A77"
                    pushDownColor: "#004075"
                    onClicked: {
                        addPositionPopup.close()
                        console.log(CalcEngine.getNumber(unitPrice) + " x " + CalcEngine.getNumber(quantity) + " = " + CalcEngine.getNumber(totalPrice))
                    }
                }
            }
        }
    }
}
