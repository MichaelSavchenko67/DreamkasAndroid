import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popup
    width: 0.9 * parent.width
    height: 0.916 * parent.height
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    onOpened: {
        contentRect.state = "loading"
        loadingTimer.running = true
    }
    onClosed: {
        purchaseView.visible = false
        loadingTimer.running = false
    }
    background: Rectangle {
        id: contentRect
        anchors.fill: parent
        radius: 8
        color: "transparent"
    }
    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"

        Timer {
            id: loadingTimer
            interval: 1000
            running: false
            onTriggered: {
                parent.state = "loaded"
            }
        }

        states: [
            State {
                name: "loading"
                PropertyChanges { target: purchaseView; visible: false }
                PropertyChanges { target: loaderColumn; visible: true }
            },
            State {
                name: "loaded"
                PropertyChanges { target: loaderColumn; visible: false }
                PropertyChanges { target: purchaseView; visible: true }
            },
            State {
                name: "failed"
                PropertyChanges { target: loaderColumn; visible: false }
                PropertyChanges { target: purchaseView; visible: false }
            }
        ]
        state: "loading"

        Rectangle {
            id: contentFrame
            anchors.fill: parent
            color: parent.color
            radius: parent.radius
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: contentFrame.width
                    height: contentFrame.height

                    Rectangle {
                        anchors.fill: parent
                        width: contentFrame.adapt ? contentFrame.width : Math.min(contentFrame.width, contentFrame.height)
                        height: contentFrame.adapt ? contentFrame.height : width
                        radius: contentFrame.radius
                    }
                }
            }

            Image {
                anchors.fill: parent
                source: "qrc:/ico/purchase/purchase_layout.jpeg"
                fillMode: Image.PreserveAspectCrop
                clip: true

                Column {
                    anchors.fill: parent

                    Rectangle {
                        id: exitButtonFrame
                        width: parent.width
                        height: 3 * 0.049 * width
                        color: "transparent"

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
                                popup.close()
                            }
                        }
                    }

                    Column {
                        id: loaderColumn
                        width: purchaseView.width
                        height: purchaseView.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: false
                        spacing: loader.height
                        topPadding: (height - (loader.height + loaderMsg.contentHeight + spacing)) / 2

                        BusyIndicator {
                            id: loader
                            implicitWidth: 0.1 * parent.width
                            implicitHeight: implicitWidth
                            anchors.horizontalCenter: parent.horizontalCenter
                            running: loaderColumn.visible
                            Material.accent: "#5C7490"
                        }

                        Label {
                            id: loaderMsg
                            width: 0.72 * parent.width
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("Загрузка данных\nчека")
                            font {
                                pixelSize: goodsNameLabel.font.pixelSize
                                family: "Roboto"
                                styleName: "normal"
                            }
                            color: "black"
                            elide: Label.ElideRight
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                    }

                    ListView {
                        id: purchaseView
                        width: parent.width - 0.5 * exitButton.width
                        height: parent.height - exitButton.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: false
                        clip: true
                        cacheBuffer: 100 * 0.15 * purchaseView.height
                        model: ListModel {
                            id: positionModel

                            ListElement {
                                goodsName: "Яблоки красные, вкусные красные"
                                cost: "100,00"
                                discount: "0,00"
                                total: "1 000,00"
                                quantity: 1
                                measure: "шт"
                                isMarked: false
                            }

                            ListElement {
                                goodsName: "Коньки хоккейные Bauer Suprime мужские"
                                cost: "1 000,00"
                                discount: "1 000,00"
                                total: "10 000,00"
                                quantity: 2
                                measure: "шт"
                                isMarked: true
                            }

                            ListElement {
                                goodsName: "Шоколад Милка с лесным орехом очень очень очень очень очень вкусный"
                                cost: "10 000,00"
                                discount: "0,00"
                                total: "100 000,00"
                                quantity: 3.456
                                measure: "кг"
                                isMarked: true
                            }

                            ListElement {
                                goodsName: "Шоколад Милка с лесным орехом очень очень очень очень очень очень очень очень очень очень вкусный"
                                cost: "100 000,00"
                                discount: "0,00"
                                total: "1 000 000,00"
                                quantity: 3.456
                                measure: "кг"
                                isMarked: false
                            }

                            ListElement {
                                goodsName: "Шоколад Милка с лесным орехом очень очень очень очень очень очень очень очень очень очень вкусный"
                                cost: "100 000 000,00"
                                discount: "0,00"
                                total: "1 000 000 000,00"
                                quantity: 3.456
                                measure: "кг"
                                isMarked: true
                            }

                            ListElement {
                                goodsName: "Шоколад Милка с лесным орехом очень очень очень очень очень очень очень очень очень очень вкусный"
                                cost: "100 000 000 000,00"
                                discount: "0,00"
                                total: "1 000 000 000 000,00"
                                quantity: 3.456
                                measure: "кг"
                                isMarked: true
                            }
                        }
                        delegate: Column {
                            id: position
                            width: purchaseView.width
                            height: ((headerColumn.visible ? (headerColumn.height + spacing) : 0) +
                                     goodsNameLabel.contentHeight +
                                     costQuantityRow.height +
                                     ndsLabel.height +
                                     goodsClcTypeRow.height +
                                     goodsTypeRow.height +
                                     positionSeparator.height +
                                     3 * goodsParamColumn.spacing +
                                     (purchaseTotalColumn.visible ? (purchaseTotalColumn.height + goodsColumn.spacing) : 0) +
                                     3 * goodsColumn.spacing)
                            spacing: 2 * exitButton.icon.height

                            Column {
                                id: headerColumn
                                width: parent.width
                                height: purchaseTitleColumn.height +
                                        purchaseTypeLabel.contentHeight +
                                        purchaseTypeLabel.topPadding +
                                        2 * spacing
                                visible: (model.index === 0)

                                Column {
                                    id: purchaseTitleColumn
                                    width: parent.width - 2 * 0.025 * popup.height - scroll.width
                                    height: purchaseTitleRow.height +
                                            shiftRow.height +
                                            cashierRow.height +
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
                                                pixelSize: 0.025 * popup.height
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
                                }

                                Label {
                                    id: purchaseTypeLabel
                                    text: "ПРИХОД"
                                    width: parent.width
                                    topPadding: position.spacing - parent.spacing
                                    font {
                                        pixelSize: 0.04 * popup.height
                                        family: "Roboto"
                                        weight: Font.DemiBold
                                    }
                                    color: "#0064B4"
                                    horizontalAlignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter
                                }

                            }

                            Column {
                                id: goodsColumn
                                width: purchaseTitleColumn.width
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 0.8 * goodsNameLabel.font.pixelSize

                                Label {
                                    id: goodsNameLabel
                                    text: qsTr((index + 1) + ".&nbsp;" + goodsName)
                                    textFormat: Label.RichText
                                    width: parent.width
                                    font {
                                        pixelSize: 0.025 * popup.height
                                        family: "Roboto"
                                        weight: Font.DemiBold
                                    }
                                    color: "#0064B4"
                                    elide: Label.ElideRight
                                    maximumLineCount: 4
                                    wrapMode: Label.WordWrap
                                    horizontalAlignment: Qt.AlignLeft
                                    verticalAlignment: Qt.AlignVCenter
                                }

                                Column {
                                    id: goodsParamColumn
                                    width: parent.width
                                    spacing: 0.5 * parent.spacing

                                    Row {
                                        id: costQuantityRow
                                        width: parent.width
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Label {
                                            id: costQoantityLabel
                                            text: cost + "&nbsp;\u20BD x&nbsp;" + quantity + "&nbsp;/&nbsp;" + measure
                                            textFormat: Label.RichText
                                            width: 0.5 * parent.width
                                            font {
                                                pixelSize: 0.7 * goodsNameLabel.font.pixelSize
                                                family: "Roboto"
                                                styleName: "normal"
                                            }
                                            color: "black"
                                            elide: Label.ElideRight
                                            maximumLineCount: 2
                                            wrapMode: Label.WordWrap
                                            horizontalAlignment: Qt.AlignLeft
                                            verticalAlignment: Qt.AlignVCenter
                                        }

                                        Label {
                                            width: parent.width - costQoantityLabel.width
                                            text: total + "&nbsp;\u20BD"
                                            textFormat: Label.RichText
                                            anchors.verticalCenter: costQoantityLabel.verticalCenter
                                            font {
                                                pixelSize: 1.1 * costQoantityLabel.font.pixelSize
                                                family: "Roboto"
                                                weight: Font.DemiBold
                                            }
                                            color: "#0064B4"
                                            elide: Label.ElideRight
                                            maximumLineCount: 2
                                            wrapMode: Label.WordWrap
                                            horizontalAlignment: Qt.AlignRight
                                            verticalAlignment: Qt.AlignVCenter
                                        }
                                    }

                                    Label {
                                        id: ndsLabel
                                        text: "НДС 20%"
                                        textFormat: Label.RichText
                                        font: costQoantityLabel.font
                                        color: costQoantityLabel.color
                                        elide: Label.ElideRight
                                        horizontalAlignment: Qt.AlignLeft
                                        verticalAlignment: Qt.AlignVCenter
                                    }

                                    Row {
                                        id: goodsClcTypeRow
                                        width: parent.width
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Label {
                                            id: goodsParam
                                            text: "Признак способа расчёта"
                                            width: 0.5 * parent.width
                                            font: costQoantityLabel.font
                                            color: costQoantityLabel.color
                                            elide: Label.ElideRight
                                            horizontalAlignment: Qt.AlignLeft
                                            verticalAlignment: Qt.AlignVCenter
                                        }

                                        Label {
                                            text: "ПОЛНЫЙ РАСЧЁТ"
                                            width: parent.width - goodsParam.width
                                            font: costQoantityLabel.font
                                            color: costQoantityLabel.color
                                            elide: Label.ElideRight
                                            horizontalAlignment: Qt.AlignRight
                                            verticalAlignment: Qt.AlignVCenter
                                        }
                                    }

                                    Row {
                                        id: goodsTypeRow
                                        width: parent.width
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Label {
                                            text: "Признак предмета расчёта"
                                            width: 0.5 * parent.width
                                            font: costQoantityLabel.font
                                            color: costQoantityLabel.color
                                            elide: Label.ElideRight
                                            horizontalAlignment: Qt.AlignLeft
                                            verticalAlignment: Qt.AlignVCenter
                                        }

                                        Label {
                                            text: "УСЛУГА"
                                            width: parent.width - goodsParam.width
                                            font: costQoantityLabel.font
                                            color: costQoantityLabel.color
                                            elide: Label.ElideRight
                                            horizontalAlignment: Qt.AlignRight
                                            verticalAlignment: Qt.AlignVCenter
                                        }
                                    }
                                }

                                SaleComponents.Line {
                                    id: positionSeparator
                                    width: parent.width
                                    color: "#979797"
                                }

                                Column {
                                    id: purchaseTotalColumn
                                    width: parent.width
                                    visible: (model.index === (purchaseView.count - 1))
                                    spacing: 0.5 * 1.5 * 0.025 * popup.height
                                    topPadding: spacing

                                    Row {
                                        id: totalRow
                                        width: parent.width

                                        Label {
                                            id: totalLabel
                                            text: "ИТОГО:"
                                            width: 0.5 * parent.width
                                            anchors.verticalCenter: totalPurchaseLabel.verticalCenter
                                            font {
                                                pixelSize: 0.03 * popup.height
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

                                    Column {
                                        width: parent.width
                                        spacing: 0.5 * parent.spacing

                                        Row {
                                            width: parent.width

                                            Label {
                                                id: cashLabel
                                                text: "НАЛИЧНЫМИ"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: cashValueLabel.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: cashValueLabel
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - cashLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                id: cashlessLabel
                                                text: "БЕЗНАЛИЧНЫМИ"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: cashlessValueLabel.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: cashlessValueLabel
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - cashlessLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                id: advanceLabel
                                                text: "АВАНС"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: advanceValueLabel.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: advanceValueLabel
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - advanceLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                id: creditLabel
                                                text: "КРЕДИТ"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: creditValueLabel.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: creditValueLabel
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - creditLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                id: exchangeLabel
                                                text: "ИНАЯ ФОРМА"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: exchangeValueLabel.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: exchangeValueLabel
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - exchangeLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "НДС 10%"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: nds10.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: nds10
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - exchangeLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "НДС 10/110"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: nds10_110.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: nds10_110
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - exchangeLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "НДС 20%"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: nds20.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: nds20
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - exchangeLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "НДС 20/120"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: nds20_120.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: nds20_120
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - exchangeLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "НДС 0%"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: nds0.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: nds0
                                                text: "1 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - exchangeLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "БЕЗ НДС"
                                                width: 0.5 * parent.width
                                                anchors.verticalCenter: nds_no.verticalCenter
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                id: nds_no
                                                text: "1 000 000 000,00" + "&nbsp;\u20BD"
                                                width: parent.width - exchangeLabel.width
                                                textFormat: Label.RichText
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                maximumLineCount: 2
                                                wrapMode: Label.WordWrap
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }
                                    }

                                    SaleComponents.Line {
                                        width: parent.width
                                        visible: (model.index === (purchaseView.count - 1))
                                        color: "#E0E0E0"
                                    }

                                    Column {
                                        width: parent.width
                                        spacing: 0.5 * parent.spacing

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "СНО"
                                                width: 0.5 * parent.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                text: "ОСН"
                                                width: parent.width - cashLabel.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "ЗН ККТ"
                                                width: 0.5 * parent.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                text: "0005079043032132"
                                                width: parent.width - cashLabel.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "ФН"
                                                width: 0.5 * parent.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                text: "9280440301302574"
                                                width: parent.width - cashLabel.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "ФД"
                                                width: 0.5 * parent.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                text: "35208"
                                                width: parent.width - cashLabel.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }

                                        Row {
                                            width: parent.width

                                            Label {
                                                text: "ФП"
                                                width: 0.5 * parent.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignLeft
                                                verticalAlignment: Qt.AlignVCenter
                                            }

                                            Label {
                                                text: "1845609902"
                                                width: parent.width - cashLabel.width
                                                font: costQoantityLabel.font
                                                color: costQoantityLabel.color
                                                elide: Label.ElideRight
                                                horizontalAlignment: Qt.AlignRight
                                                verticalAlignment: Qt.AlignVCenter
                                            }
                                        }
                                    }

                                    Image {
                                        id: qrCode
                                        width: 0.5 * parent.width
                                        height: width
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        source: "qrc:/ico/purchase/qr_code_example.png"
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }
                            }
                        }
                        ScrollBar.vertical: ScrollBar {
                            id: scroll
                            policy: ScrollBar.AsNeeded
                            width: 4
                        }
                    }
                }
            }
        }
    }
}
