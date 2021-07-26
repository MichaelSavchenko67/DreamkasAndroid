import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: purchasePage
    Layout.fillHeight: true
    Layout.fillWidth: true

    property bool checkOn: false
    property int curPos: -1

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            console.log("[Purchase.qml]\tfocus changed: " + focus)
            setMainPageTitle("Чек")
            resetAddRightMenuButton()
            setRightMenuButtonIco("qrc:/ico/menu/delete.png")
            setRightMenuButtonVisible(true)
            setLeftMenuButtonAction(back)
            setToolbarVisible(true)
        }
    }

    function resetQtyEditOn() {
        for (var i = 0; i < purchaseView.count; i++) {
            purchaseView.contentItem.children[i].editOn = false;
        }
    }

    contentData: ListView {
        id: purchaseView
        anchors.fill: parent
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
        }
        delegate: ItemDelegate {
            id: position
            height: positionColumn.topPadding +
                    4 * positionColumn.spacing +
                    goodsNameLabel.contentHeight +
                    positionCostQtyTotalRow.height +
                    (discountRow.visible ? (discountRow.height + positionColumn.spacing) : 0) +
                    (markedRow.visible ? (markedRow.height + positionColumn.spacing) : 0) +
                    positionSeparator.height
            width: purchaseView.width

            property bool editOn: false
            property bool isChecked: false

            onEditOnChanged: {
                quantityField.focus = editOn
            }

            onPressAndHold: {
                checkOn = true
            }

            transformOrigin: Item.Center

            ListView.onRemove: SequentialAnimation {
                PropertyAction {
                    target: position
                    property: "ListView.delayRemove"
                    value: true
                }
                NumberAnimation {
                    target: position
                    property: "scale"
                    to: 0
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
                PropertyAction {
                    target: position
                    property: "ListView.delayRemove"
                    value: false
                }
            }

            Column {
                id: positionColumn
                width: parent.width
                leftPadding: goodsNameLabel.font.pixelSize
                rightPadding: leftPadding
                topPadding: ((model.index === 0) ? 1.7 * rightPadding : 0)
                spacing: 0.5 * rightPadding

                Row {
                    id: positionTitleRow
                    width: parent.width - 2 * parent.leftPadding
                    spacing: delPosButton.width

                    Label {
                        id: goodsNameLabel
                        width: parent.width - parent.spacing - delPosButton.width
                        text: qsTr(goodsName)
                        font {
                            pixelSize: 0.025 * purchasePage.height
                            family: "Roboto"
                            styleName: "bold"
                            weight: Font.Bold
                            bold: true
                        }
                        color: "black"
                        elide: Label.ElideRight
                        maximumLineCount: 4
                        wrapMode: Label.WordWrap
                        lineHeight: 1.2
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignTop
                    }

                    ToolButton {
                        id: delPosButton
                        width: 1.5 * goodsNameLabel.font.pixelSize
                        height: width
                        icon.source: "qrc:/ico/menu/close_grey.png"
                    }
                }

                Row {
                    id: positionCostQtyTotalRow
                    width: positionTitleRow.width
                    height: quantityFieldFrame.height
                    spacing: positionCostRow.spacing

                    Row {
                        id: positionCostRow
                        width: 0.35 * parent.width
                        height: parent.height
                        spacing: 0.5 * positionUnitPrice.font.pixelSize

                        Label {
                            id: positionUnitPrice
                            width: parent.width - 2 * parent.spacing
                            anchors.verticalCenter: parent.verticalCenter
                            text: cost + " \u20BD / " + measure
                            font {
                                pixelSize: 0.9 * goodsNameLabel.font.pixelSize
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "black"
                            elide: Label.ElideRight
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignVCenter
                        }

                        Label {
                            text: "x"
                            anchors.verticalCenter: parent.verticalCenter
                            font: positionUnitPrice.font
                            color: "#979797"
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignVCenter
                        }
                    }

                    Row {
                        id: positionQtyRow
                        width: (parent.width - 2 * positionCostRow.width - 2 * parent.spacing)
                        height: parent.height
                        spacing: 0.5 * positionUnitPrice.font.pixelSize

                        Rectangle {
                            id: quantityFieldFrame
                            width: parent.width - positionUnitPrice.font.pixelSize - parent.spacing
                            height: 3.5 * positionUnitPrice.font.pixelSize
                            border.width: 0
                            color: "transparent"

                            TextField {
                                id: quantityField
                                property var defaultFontPixelSize: 0.5 * parent.height
                                property var prevContentLength: text.length
                                anchors.fill: parent
                                text: quantity
                                placeholderText: text
                                placeholderTextColor: "black"
                                font {
                                    pixelSize: defaultFontPixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.DemiBold
                                }
                                color: "#0064B4"
                                clip: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignBottom
                                inputMethodHints: Qt.ImhFormattedNumbersOnly
                                validator: RegExpValidator { regExp: /[0-9]{1,},[0-9]{1,3}/ }
                                onFocusChanged: {
                                    position.editOn = focus
                                }
                                onContentWidthChanged: {
                                    if (contentWidth > width) {
                                        font.pixelSize--
                                    }
                                }
                                onTextChanged: {
                                    if ((prevContentLength >= text.length) && (font.pixelSize < defaultFontPixelSize)) {
                                        font.pixelSize = defaultFontPixelSize
                                    }
                                    prevContentLength = text.length
                                }
                            }
                        }

                        Label {
                            text: measure
                            anchors.verticalCenter: parent.verticalCenter
                            font: positionUnitPrice.font
                            color: "black"
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignVCenter
                        }
                    }

                    Row {
                        id: positionTotalRow
                        width: positionCostRow.width
                        height: parent.height

                        Label {
                            id: equalsLabel
                            text: "= "
                            anchors.verticalCenter: parent.verticalCenter
                            font: positionUnitPrice.font
                            color: "#979797"
                            clip: true
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignVCenter
                        }

                        Label {
                            id: totalLabel
                            width: parent.width - equalsLabel.contentWidth
                            text: total + " \u20BD"
                            anchors.verticalCenter: parent.verticalCenter
                            font {
                                pixelSize: 0.9 * goodsNameLabel.font.pixelSize
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "black"
                            clip: true
                            elide: Label.ElideRight
                            horizontalAlignment: Label.AlignRight
                            verticalAlignment: Label.AlignVCenter
                        }
                    }
                }

                Row {
                    id: discountRow
                    width: positionCostRow.width
                    height: discountIco.height
                    visible: (Number((discount.replace(',', '.')).replace(' ', '')) > 0)
                    spacing: 0.5 * discountIco.width

                    Image {
                        id: discountIco
                        width: positionUnitPrice.font.pixelSize
                        height: width
                        source: "qrc:/ico/sale/discount.png"
                    }

                    Label {
                        id: discountLabel
                        width: parent.width - discountIco.width - parent.spacing
                        anchors.verticalCenter: discountIco.verticalCenter
                        text: "-" + discount + " \u20BD"
                        font {
                            pixelSize: 0.83 * positionUnitPrice.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#5C7490"
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }
                }

                Row {
                    id: markedRow
                    width: discountRow.width
                    height: discountRow.height
                    visible: isMarked
                    spacing: discountRow.spacing

                    Image {
                        id: markedIco
                        width: discountIco.width
                        height: width
                        source: "qrc:/ico/sale/discount.png"
                    }

                    Label {
                        id: markedLabel
                        width: discountLabel.width
                        anchors.verticalCenter: markedIco.verticalCenter
                        text: "марка"
                        font: discountLabel.font
                        color: discountLabel.color
                        elide: discountLabel.elide
                        horizontalAlignment: discountLabel.horizontalAlignment
                        verticalAlignment: discountLabel.verticalAlignment
                    }
                }

                SaleComponents.Line {
                    id: positionSeparator
                    width: positionTitleRow.width
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
                resetQtyEditOn()
            }
        }
    }
}
