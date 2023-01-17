import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: purchasePage
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            root.setMenuEnabled(false)
        }
    }

    property string lastPositionImageSrc: "qrc:/ico/tiles/tileGoods6.png"

    function choosePaymentType(id) {
        cashlessButton.isChoosen = (id === cashlessButton)
        cashButton.isChoosen = (id === cashButton)
        qrCodeButton.isChoosen = (id === qrCodeButton)
    }

    Timer {
        id: appendPositionsTimer
        interval: 250
        repeat: true
        running: false

        property int cnt: 1

        onTriggered: {
            if (positionModel.count >= 10) {
                stop()
            } else {
                console.log("positionModel.append")
                positionModel.append({goodsName: "Виноград",
                                     cost: "100,00",
                                     total: "1 000,00",
                                     quantity: 1,
                                     measure: "шт"})
            }
        }
    }

    states: [
        State {
            name: "lastPosition"
            PropertyChanges { target: borderRect; visible: false }
            PropertyChanges { target: productTitleColumn; visible: true }
            PropertyChanges { target: lastPositionImage; visible: (lastPositionImage.avatarSrc.length > 0) }
            PropertyChanges { target: purchaseColumn; visible: false }
        },
        State {
            name: "purchase"
            PropertyChanges { target: productTitleColumn; visible: false }
            PropertyChanges { target: lastPositionImage; visible: false }
            PropertyChanges { target: purchaseColumn; visible: true }
            PropertyChanges { target: borderRect; visible: true }
        }
    ]
    state: "lastPosition"
    contentData: Column {
        id: mainColumn
        anchors.fill: parent
        topPadding: ((purchasePage.state === "lastPosition") ? 1.1 * productNameLabel.font.pixelSize : 0)
        bottomPadding: 0.0394 * width
        spacing: height -
                 topPadding -
                 ((purchasePage.state === "lastPosition") ? productTitleColumn.height : purchaseColumn.height) -
                 footerColumn.height -
                 bottomPadding

        Column {
            id: productTitleColumn
            width: parent.width
            visible: false
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
                topPadding: (lastPositionImage.visible ? 0 : 0.5 * (mainColumn.height -
                                                                    mainColumn.topPadding -
                                                                    footerColumn.height -
                                                                    productNameLabel.contentHeight -
                                                                    lastPositionImage.height -
                                                                    footerColumn.spacing -
                                                                    parent.spacing))
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
                        pixelSize: (lastPositionImage.visible ? 1.5 : 2) * productNameLabel.font.pixelSize
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
            id: purchaseColumn
            width: totalFrame.width
            height: mainColumn.height -
                    footerColumn.height -
                    mainColumn.bottomPadding -
                    0.5 * totalFrame.radius -
                    mainColumn.spacing +
                    0.25 * openPurchaseButton.height
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: mainColumn.bottomPadding
            visible: false

            ListView {
                id: purchaseView
                width: parent.width
                height: parent.height - parent.topPadding
                anchors.bottom: parent.bottom
                clip: true
                cacheBuffer: 100 * 0.15 * purchaseView.height
                add: Transition { NumberAnimation { properties: "scale"; from: 0; to: 1; easing.type: Easing.InOutQuad } }
                remove: Transition { NumberAnimation { properties: "scale"; from: 1; to: 0; easing.type: Easing.InOutQuad } }
                model: ListModel {
                    id: positionModel

//                    ListElement {
//                        goodsName: "Яблоки красные, вкусные красные"
//                        cost: "100,00"
//                        total: "1 000,00"
//                        quantity: 1
//                        measure: "шт"
//                    }

//                    ListElement {
//                        goodsName: "Коньки хоккейные Bauer Suprime мужские"
//                        cost: "1 000,00"
//                        total: "10 000,00"
//                        quantity: 2
//                        measure: "шт"
//                    }

//                    ListElement {
//                        goodsName: "Шоколад Милка с лесным орехом очень очень очень очень очень вкусный"
//                        cost: "10 000,00"
//                        total: "100 000,00"
//                        quantity: 3.456
//                        measure: "кг"
//                    }

//                    ListElement {
//                        goodsName: "Шоколад Милка с лесным орехом очень очень очень очень очень очень очень очень очень очень вкусный"
//                        cost: "100 000,00"
//                        total: "1 000 000,00"
//                        quantity: 3.456
//                        measure: "кг"
//                    }

//                    ListElement {
//                        goodsName: "Шоколад Милка с лесным орехом очень очень очень очень очень очень очень очень очень очень вкусный"
//                        cost: "100 000 000,00"
//                        total: "1 000 000 000,00"
//                        quantity: 3.456
//                        measure: "кг"
//                    }

//                    ListElement {
//                        goodsName: "Шоколад Милка с лесным орехом очень очень очень очень очень очень очень очень очень очень вкусный"
//                        cost: "100 000 000 000,00"
//                        total: "1 000 000 000 000,00"
//                        quantity: 3.456
//                        measure: "кг"
//                    }
                }
                delegate: Item {
                    id: position
                    height: positionColumn.height
                    width: purchaseView.width - scroll.width
                    transformOrigin: Item.Center

                    Column {
                        id: positionColumn
                        width: parent.width - 2 * scroll.width
                        height: topPadding +
                                positionRow.height +
                                spacing +
                                positionSeparator.height +
                                bottomPadding
                        topPadding: 0.25 * positionNameLabel.font.pixelSize
                        bottomPadding: topPadding
                        spacing: 2 * topPadding
                        anchors.horizontalCenter: parent.horizontalCenter

                        Row {
                            id: positionRow
                            width: parent.width
                            height: positionNameLabel.contentHeight +
                                    spacing +
                                    positionCostColumn.height
                            spacing: parent.spacing

                            Label {
                                id: positionNameLabel
                                width: 0.5 * parent.width
                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: scroll.width
                                text: qsTr(goodsName)
                                font {
                                    pixelSize: 0.667 * productNameLabel.font.pixelSize
                                    family: productNameLabel.font.family
                                    styleName: productNameLabel.font.styleName
                                    weight: Font.Normal
                                }
                                color: "black"
                                elide: Label.ElideRight
                                lineHeight: 1.4
                                maximumLineCount: 6
                                wrapMode: Label.WordWrap
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }

                            Column {
                                id: positionCostColumn
                                width: parent.width - positionNameLabel.width - parent.spacing
                                height: positionUnitPrice.contentHeight +
                                        spacing +
                                        positionTotalPriceLabel.contentHeight
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: positionUnitPrice.font.pixelSize

                                Label {
                                    id: positionUnitPrice
                                    width: parent.width
                                    text: cost + "&nbsp;\u20BD&nbsp;x&nbsp;" + quantity + "&nbsp;" + measure
                                    textFormat: Label.RichText
                                    font {
                                        pixelSize: 0.75 * positionNameLabel.font.pixelSize
                                        family: positionNameLabel.font.family
                                        styleName: positionNameLabel.font.styleName
                                        weight: positionNameLabel.font.weight
                                    }
                                    color: positionNameLabel.color
                                    opacity: 0.6
                                    elide: positionNameLabel.elide
                                    maximumLineCount: 2
                                    wrapMode: Label.WordWrap
                                    horizontalAlignment: Qt.AlignRight
                                    verticalAlignment: Qt.AlignVCenter
                                }

                                Label {
                                    id: positionTotalPriceLabel
                                    width: parent.width
                                    text: total + "&nbsp;\u20BD"
                                    textFormat: Label.RichText
                                    font {
                                        pixelSize: positionNameLabel.font.pixelSize
                                        family: positionNameLabel.font.family
                                        styleName: "Normal"
                                        weight: Font.DemiBold
                                        bold: true
                                    }
                                    color: positionNameLabel.color
                                    elide: positionNameLabel.elide
                                    maximumLineCount: 2
                                    wrapMode: positionUnitPrice.wrapMode
                                    horizontalAlignment: positionUnitPrice.horizontalAlignment
                                    verticalAlignment: positionUnitPrice.verticalAlignment
                                }
                            }
                        }

                        SaleComponents.Line {
                            id: positionSeparator
                            width: parent.width
                            color: "#E0E0E0"
                            visible: model.index < (purchaseView.count - 1)
                        }
                    }
                }
                ScrollBar.vertical: ScrollBar {
                    id: scroll
                    policy: ScrollBar.AsNeeded
                    width: 8

                    onVisualPositionChanged: {
                    }
                }
            }
        }

        Column {
            id: footerColumn
            width: parent.width
            spacing: mainColumn.bottomPadding + 0.6 * openPurchaseButton.height

            SettingsComponents.Avatar {
                id: lastPositionImage
                width: 0.3 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                avatarSrc: lastPositionImageSrc
                visible: false
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

                        Rectangle {
                            id: borderRect
                            width: parent.width - 2 * scroll.width
                            height: 0.2 * openPurchaseButton.height
                            visible: false
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                                bottom: openPurchaseButton.verticalCenter
                            }
                            color: "white"
                            opacity: 0.75
                        }

                        FastBlur {
                            anchors.fill: borderRect
                            source: borderRect
                            visible: borderRect.visible
                            radius: 32
                            opacity: 0.75
                        }

                        SaleComponents.RoundButtonCustom {
                            id: openPurchaseButton
                            width: 0.175 * parent.width
                            height: width
                            anchors.verticalCenter: totalsColumn.top
                            iconPath: (purchasePage.state === "lastPosition") ? "qrc:/ico/menu/purchase.png" : "qrc:/ico/sale/basket.png"
                            buttonTxt: (purchasePage.state === "lastPosition") ? "Чек" : "Товар"
                            buttonTxtColor: "black"
                            fontSize: 0.195 * height
                            fontBold: false
                            backRadius: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                purchasePage.state = ((purchasePage.state === "lastPosition") ? "purchase" : "lastPosition")

                                if (purchasePage.state === "purchase") {
                                    appendPositionsTimer.start()
                                }
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
