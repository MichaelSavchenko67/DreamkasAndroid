import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/content/calculator.js" as CalcEngine
import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupCashlessPay
    width: 0.9 * parent.width
    height: 0.69 * width + 2 * exitButton.height
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle {
        id: popupFrame
        radius: 8
        color: "#FFFFFF"

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
                popupCashlessPay.close()
            }
        }

        Column {
            id: rootColumn
            width: 0.8 * parent.width
            anchors {
                top: exitButton.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: qsTr("Безналичный платёж")
                font {
                    pixelSize: 0.074 * popupCashlessPay.width
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
                    text: "Способ оплаты"
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

                Column {
                    width: parent.width
                    spacing: 0

                    ComboBox {
                        id: control
                        width: parent.width

                        font: {
                            pixelSize: 0.09 * width
                            family: "Roboto"
                            styleName: "medium"
                            weight: Font.Medium
                            bold: true
                        }

                        model: ListModel {
                            id: model
                            ListElement { payType: "Банковская карта" }
                        }

                        delegate: ItemDelegate {
                            width: control.width
                            contentItem: Row {
                                width: parent.width

                                Text {
                                    width: parent.width - checkStatus.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: payType
                                    color: "black"
                                    font: control.font
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                }

                                Image {
                                    id: checkStatus
                                    width: control.font.pixelSize
                                    height: width
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "qrc:/ico/settings/check_blue.png"
                                }
                            }
                        }

                        indicator: Canvas {
                            id: canvas
                            x: control.width - width - control.rightPadding
                            y: control.topPadding + (control.availableHeight - height) / 2
                            width: 12
                            height: 8
                            contextType: "2d"

                            Connections {
                                target: control
                                function onPressedChanged() { canvas.requestPaint(); }
                            }

                            onPaint: {
                                context.reset();
                                context.moveTo(0, 0);
                                context.lineTo(width, 0);
                                context.lineTo(width / 2, height);
                                context.closePath();
                                context.fillStyle = "#0064B4";
                                context.fill();
                            }
                        }

                        contentItem: Text {
                            leftPadding: 0
                            rightPadding: control.indicator.width + control.spacing
                            text: control.displayText
                            font: control.font
                            color: "#0064B4"
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }

                        background: Rectangle {
                            implicitWidth: 120
                            implicitHeight: 40
                            border.color: "#0064B4"
                            border.width: 0
                        }

                        popup: Popup {
                            y: control.height - 1
                            width: control.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 1

                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                model: control.popup.visible ? control.delegateModel : null
                                currentIndex: control.currentIndex
                                ScrollIndicator.vertical: ScrollIndicator { }
                            }

                            background: Rectangle {
                                color: popupFrame.color
                                border.width: 0
                                radius: popupFrame.radius
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#0064B4"
                    }
                }
            }
        }

        SaleComponents.Button_1 {
            width: rootColumn.width
            height: 0.2 * width
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: rootColumn.spacing
            }
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr("ПРИНЯТЬ ОПЛАТУ")
            fontSize: 0.27 * height
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            onClicked: {
                popupCashlessPay.close()
            }
        }
    }
}
