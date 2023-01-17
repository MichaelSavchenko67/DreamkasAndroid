import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            root.setMenuEnabled(false)
        }
    }

    contentData: Column {
        id: mainColumn
        anchors.fill: parent
        topPadding: 1.1 * productNameLabel.font.pixelSize
        bottomPadding: 0.0394 * width
        spacing: height -
                 topPadding -
                 weighingInfoColumn.height -
                 totalFrame.height -
                 bottomPadding

        Column {
            id: weighingInfoColumn
            width: parent.width
            height: productTitleColumn.height + spacing + weightColumn.height
            spacing: 2.5 * productNameLabel.font.pixelSize

            Column {
                id: productTitleColumn
                width: parent.width
                height: productNameLabel.contentHeight + spacing + productMeasureLabel.contentHeight
                spacing: 0.6 * productNameLabel.font.pixelSize

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

                Label {
                    id: productMeasureLabel
                    width: productNameLabel.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("123,45 \u20BD/кг")
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
            }

            Column {
                id: weightColumn
                width: parent.width
                height: weightTitleLabel.contentHeight + spacing + weightField.contentHeight
                spacing: productTitleColumn.spacing

                Label {
                    id: weightTitleLabel
                    width: productMeasureLabel.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Вес")
                    font: productMeasureLabel.font
                    color: productMeasureLabel.color
                    opacity: productMeasureLabel.opacity
                    elide: productMeasureLabel.elide
                    horizontalAlignment: productMeasureLabel.horizontalAlignment
                    verticalAlignment: productMeasureLabel.verticalAlignment
                }

                SaleComponents.DynamicNumberField {
                    id: weightField
                    width: productMeasureLabel.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    accuracy: 3
                    ending: "кг"
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
            width: parent.width

            Rectangle {
                id: totalFrame
                width: 0.875 * parent.width
                height: totalsColumn.height
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F6F6F6"
                radius: 16

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
    }

    Timer {
        interval: 1000
        repeat: false
        running: true
        onTriggered: {
            weightField.number = 2.500
            totalNumber.number = 308.625
            weighingTimer.start()
        }
    }

    Timer {
        id: weighingTimer
        interval: 7
        repeat: true
        onTriggered: {
            if (control.value < 1) {
                control.value = control.value + 0.01
            } else {
                stop()
            }
        }
    }

    ProgressBar {
        id: control
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 0.5 * mainColumn.spacing + mainColumn.bottomPadding + mainColumn.topPadding
        }
        value: 0
        rotation: -90
        background: Rectangle {
            implicitWidth: 7 * productNameLabel.font.pixelSize
            implicitHeight: 0.683 * implicitWidth
            color: "transparent"
        }
        contentItem: Item {
            implicitWidth: 200
            implicitHeight: 4

            Rectangle {
                width: control.visualPosition * parent.width
                height: parent.height
                color: "#72E9C5"
            }

            Image {
                width: 0.5 * parent.width
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                source: "qrc:/ico/settings/check_in_white.png"
                rotation: -control.rotation
            }
        }
    }
}
