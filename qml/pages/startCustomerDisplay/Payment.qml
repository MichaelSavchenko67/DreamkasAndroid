import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Page {
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            root.setMenuEnabled(false)
        }
    }

    states: [
        State {
            name: "payByQrCode"
            PropertyChanges { target: cashPaymentColumn; visible: false }
            PropertyChanges { target: paymentTitleLabel; text: qsTr("Оплата по QR-коду") }
            PropertyChanges { target: cashlessPaymentImage; source: "qrc:/ico/purchase/qr_code_example.png" }
            PropertyChanges { target: cashlessPaymentDescriptionLabel; text: qsTr("Отсканируйте QR-код\nв мобильном приложении банка") }
            PropertyChanges { target: cashlessPaymentColumn; visible: true }
        },
        State {
            name: "payByCard"
            PropertyChanges { target: cashPaymentColumn; visible: false }
            PropertyChanges { target: paymentTitleLabel; text: qsTr("Оплата по карте") }
            PropertyChanges { target: cashlessPaymentImage; source: "qrc:/ico/sale/pinpad.png" }
            PropertyChanges { target: cashlessPaymentDescriptionLabel; text: qsTr("Приложите карту\nк банковскому терминалу") }
            PropertyChanges { target: cashlessPaymentColumn; visible: true }
        },
        State {
            name: "payByCash"
            PropertyChanges { target: cashlessPaymentColumn; visible: false }
            PropertyChanges { target: paymentTitleLabel; text: qsTr("Оплата наличными") }
            PropertyChanges { target: cashPaymentColumn; visible: true }
        }
    ]
    state: "payByQrCode"
    contentData: Column {
        anchors.fill: parent
        topPadding: 0.0275 * width
        bottomPadding: 0.0394 * width
        spacing: height -
                 topPadding -
                 paymentColumn.height -
                 totalFrame.height -
                 bottomPadding

        Column {
            id: paymentColumn
            width: parent.width
            spacing: 2 * paymentTitleLabel.font.pixelSize

            Label {
                id: paymentTitleLabel
                width: 0.8 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    pixelSize: 0.083 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                    bold: true
                }
                color: "#415A77"
                elide: Label.ElideRight
                lineHeight: 1.3
                maximumLineCount: 3
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Column {
                id: cashlessPaymentColumn
                width: parent.width
                visible: false
                spacing: cashlessPaymentDescriptionLabel.font.pixelSize

                Image {
                    id: cashlessPaymentImage
                    width: 0.39 * parent.width
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: cashlessPaymentDescriptionLabel
                    width: 0.8 * parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    font {
                        pixelSize: 0.05 * parent.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    opacity: 0.6
                    lineHeight: 1.4
                    elide: Label.ElideRight
                    maximumLineCount: 5
                    wrapMode: Label.WordWrap
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }
            }

            Column {
                id: cashPaymentColumn
                width: parent.width
                visible: false
                spacing: 2 * cashlessPaymentColumn.spacing

                Column {
                    width: parent.width
                    spacing: 0.5 * cashlessPaymentColumn.spacing

                    Label {
                        width: cashlessPaymentDescriptionLabel.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Принято")
                        font: cashlessPaymentDescriptionLabel.font
                        color: cashlessPaymentDescriptionLabel.color
                        opacity: cashlessPaymentDescriptionLabel.opacity
                        elide: cashlessPaymentDescriptionLabel.elide
                        horizontalAlignment: cashlessPaymentDescriptionLabel.horizontalAlignment
                        verticalAlignment: cashlessPaymentDescriptionLabel.verticalAlignment
                    }

                    SaleComponents.DynamicNumberField {
                        width: cashlessPaymentDescriptionLabel.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        number: 100000.00
                        accuracy: 2
                        ending: "\u20BD"
                        font: paymentTitleLabel.font
                        color: "black"
                        elide: paymentTitleLabel.elide
                        horizontalAlignment: paymentTitleLabel.horizontalAlignment
                        verticalAlignment: paymentTitleLabel.verticalAlignment
                    }
                }

                Column {
                    width: parent.width
                    spacing: 0.5 * cashlessPaymentColumn.spacing

                    Label {
                        width: 0.8 * parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Сдача")
                        font: cashlessPaymentDescriptionLabel.font
                        color: cashlessPaymentDescriptionLabel.color
                        opacity: cashlessPaymentDescriptionLabel.opacity
                        elide: cashlessPaymentDescriptionLabel.elide
                        horizontalAlignment: cashlessPaymentDescriptionLabel.horizontalAlignment
                        verticalAlignment: cashlessPaymentDescriptionLabel.verticalAlignment
                    }

                    SaleComponents.DynamicNumberField {
                        width: cashlessPaymentDescriptionLabel.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        number: 1000.00
                        accuracy: 2
                        ending: "\u20BD"
                        font: paymentTitleLabel.font
                        color: "black"
                        elide: paymentTitleLabel.elide
                        horizontalAlignment: paymentTitleLabel.horizontalAlignment
                        verticalAlignment: paymentTitleLabel.verticalAlignment
                    }
                }
            }

            BusyIndicator {
                id: loaderLogin
                visible: running
                implicitWidth: 0.1 * root.width
                implicitHeight: implicitWidth
                anchors.horizontalCenter: parent.horizontalCenter
                running: true
                Material.accent: "#5C7490"
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
                    font {
                        pixelSize: 0.0525 * parent.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                        bold: true
                    }
                    color: "black"
                    elide: paymentTitleLabel.elide
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: paymentTitleLabel.verticalAlignment
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
                    font: totalTitleLabel.font
                    color: totalTitleLabel.color
                    elide: totalTitleLabel.elide
                    horizontalAlignment: Label.AlignRight
                    verticalAlignment: totalTitleLabel.verticalAlignment
                }
            }
        }
    }
}
