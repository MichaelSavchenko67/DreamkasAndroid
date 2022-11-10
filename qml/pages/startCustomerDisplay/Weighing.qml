import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    width: parent.width
    height: parent.height
    contentData: Column {
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
            spacing: 2.5 * productNameLabel.font.pixelSize

            Column {
                id: productTitleColumn
                width: parent.width
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
                width: parent.width
                spacing: 4 * productTitleColumn.spacing

                Column {
                    width: parent.width
                    spacing: productTitleColumn.spacing

                    Label {
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
                    anchors.horizontalCenter: parent.horizontalCenter
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
        }

        Rectangle {
            id: totalFrame
            width: 0.875 * parent.width
            height: 0.16 * width
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F6F6F6"
            radius: 16

            Row {
                anchors.fill: parent
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
