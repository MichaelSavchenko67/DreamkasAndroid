import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/content/calculator.js" as CalcEngine

Page {
    id: payPage
    anchors.fill: parent

    property var cash
    property var cashPast: root.cashInDrawer
    property bool isReserveAvailable: true

    property real cashInt: 0.00
    property real cashPastInt: 0.00
    property bool isReserveDisabled: false
    property bool isInsert: false

    onFocusChanged: {
        if (focus) {
            console.log("[InsRes.qml]\tfocus changed: " + focus)
            calcInsRes(isInsert)
        }
    }

    onIsInsertChanged: {
        calcInsRes(isInsert)
    }

    function calcInsRes(isInsertion) {
        var total = CalcEngine.formatCommaResult(calculator.formulaStr)
        cashInt = Number(total.replace(/\s/g, '').replace(',', '.'))
        console.log("cashInt: " + cashInt)
        cashPast = CalcEngine.calc(root.cashInDrawer.replace(/\s/g, '') + (isInsertion ? "+" : "-") + total.replace(/\s/g, '')).replace('.', ',')
        cashPastInt = Number(cashPast.replace(',', '.'))
        console.log("cashPasInt: " + cashPastInt)
        isReserveAvailable = ((cashInt > 0) && (cashPastInt >= 0))
        console.log("isReserveAvailable: " + isReserveAvailable)
        isReserveDisabled = !isInsert && (cashPastInt < 0)
        console.log("isReserveDisabled: " + isReserveDisabled)

        if (isInsert) {
            insResButton.enabled = (cashInt > 0)
        } else {
            insResButton.enabled = isReserveAvailable
        }
    }

    contentData: Rectangle {
        anchors.fill: parent

        Column {
            width: parent.width
            height: parent.height - spacing
            anchors {
                top: parent.top
                topMargin: 2 * spacing
            }

            spacing: 0.5 * (height - 0.4 * calculator.getKeyboardWidth() - calculator.height)

            Rectangle {
                width: 0.92 * parent.width
                height: 0.12 * width
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F6F6F6"
                border.width: 0
                radius: 16

                Label {
                    id: cashInDrawerLabel
                    text: qsTr("Наличных в кассе " + '<b>' + CalcEngine.formatCommaResult(root.cashInDrawer) + " \u20BD" + '<b>')
                    height: 2 * font.pixelSize
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    font {
                        pixelSize: totalTitle.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    leftPadding: totalTitle.font.pixelSize
                }
            }

            Column {
                width: parent.width
                spacing: 0.5 * parent.spacing

                Label {
                    id: totalTitle
                    width: cashInDrawerLabel.width
                    text: qsTr("Сумма " + (isInsert ? "внесения" : "изъятия"))
                    height: 2 * font.pixelSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    font {
                        pixelSize: 0.13 * 0.4 * calculator.getKeyboardWidth()
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }

                Label {
                    id: enterPaymentSum
                    width: parent.width
                    height: totalTitle.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:  CalcEngine.formatCommaResult(calculator.formulaStr) + " \u20BD"
                    font {
                        pixelSize: 1.3 * totalTitle.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Bold
                        bold: true
                    }
                    clip: totalTitle.clip
                    color: "#0064B4"
                    elide: totalTitle.elide
                    horizontalAlignment: totalTitle.horizontalAlignment
                    verticalAlignment: totalTitle.verticalAlignment
                    background: Rectangle {
                        color: "#00FFFFFF"
                        border.width: 0
                    }

                    onTextChanged: {
                        calcInsRes(isInsert)
                    }
                }

                Rectangle {
                    height: 2
                    width: enterPaymentSum.contentWidth + 2 * enterPaymentSum.font.pixelSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#00FFFFFF"
                    border.width: 1
                    border.color: "#E0E0E0"
                }

                Text {
                    id: excessDeliverySum
                    width: totalTitle.width
                    height: totalTitle.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: isReserveDisabled ? "Сумма превышена на " + '<b>' + cashPast.substring(1) + " \u20BD</b>" :
                                              "В кассе станет " + '<b>' + cashPast + " \u20BD</b>"

                    font: totalTitle.font
                    clip: totalTitle.clip
                    color: isReserveDisabled ? "#C62828" : "black"
                    elide: totalTitle.elide
                    horizontalAlignment: totalTitle.horizontalAlignment
                    verticalAlignment: totalTitle.verticalAlignment
                }
            }

            SaleComponents.Calculator {
                id: calculator

                Component.onCompleted: {
                    reset()
                    setKeyboard("keyboardShortest")
                    setPrecDigits(2)
                    setEnable(isGetCash)
                }
            }
        }
    }

    footer: SaleComponents.FooterMain {
        id: footerMain
        height: btnRow.height + 2 * 0.125 * btnRow.height

        Rectangle {
            anchors.fill: parent
            color: "#F6F6F6"

            Row {
                id: btnRow
                width: parent.width
                height: 0.16 * width
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 0.125 * height
                }
                spacing: 0.03 * width
                leftPadding: spacing
                rightPadding: spacing

                SaleComponents.ButtonIcoH {
                    id: insResButton
                    width: parent.width - 2 * parent.spacing
                    height: parent.height
                    anchors.centerIn: parent
                    iconPath: isInsert ? "qrc:/ico/sale/download.png" : "qrc:/ico/sale/upload.png"
                    iconHeight: 0.8 * fontSize
                    buttonTxt: isInsert ? "ВНЕСТИ НАЛИЧНЫЕ" : "ИЗЪЯТЬ НАЛИЧНЫЕ"
                    buttonTxtColor: enabled ? "white" : "#415A77"
                    pushUpColor: enabled ? "#415A77" : "#FFFFFF"
                    pushDownColor: enabled ? "#004075" : "#F2F2F2"
                    enabled: (enterPaymentSum.total !== "0,00")
                }
            }
        }
    }
}
