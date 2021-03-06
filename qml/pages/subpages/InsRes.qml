import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/content/calculator.js" as CalcEngine

Page {
    id: payPage

    property var cash
    property var cashPast: root.cashInDrawer
    property bool isReserveAvailable: true

    property real cashInt: 0.00
    property real cashPastInt: 0.00
    property bool isReserveDisabled: false

    onFocusChanged: {
        if (focus) {
            console.log("[InsRes.qml]\tfocus changed: " + focus)
            setMainPageTitle("Изъять или внести")
            setLeftMenuButtonAction(back)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            clearContextMenu()
            setToolbarVisible(true)
            calcInsRes(insert.checked)
        }
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
        isReserveDisabled = !insert.checked && (cashPastInt < 0)
        console.log("isReserveDisabled: " + isReserveDisabled)

        if (insert.checked) {
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

            spacing: 0.5 * (height - cashSums.height - calculator.height)

            Row {
                id: cashSums
                width: calculator.getKeyboardWidth()
                height: 0.4 * width
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    width: 0.5 * parent.width
                    height: parent.height

                    Text {
                        id: cashTitle
                        width: parent.width
                        height: parent.height / 3
                        text: "Сумма"
                        font {
                            pixelSize: 0.13 * cashSums.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        color: "black"
                        elide: Text.ElideRight
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Label {
                        id: enterCashSum
                        width: cashTitle.width
                        height: cashTitle.height

                        text:  CalcEngine.formatCommaResult(calculator.formulaStr) + " \u20BD"

                        font {
                            pixelSize: 1.3 * cashTitle.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Bold
                            bold: true
                        }
                        clip: cashTitle.clip
                        color: cashTitle.color
                        elide: cashTitle.elide
                        horizontalAlignment: cashTitle.horizontalAlignment
                        verticalAlignment: cashTitle.verticalAlignment
                        leftPadding: font.pixelSize
                        background: Rectangle {
                            border {
                                color: "#5C7490"
                                width: 2
                            }
                            radius: 5
                        }

                        onTextChanged: {
                            calcInsRes(insert.checked)
                        }
                    }

                    Text {
                        id: cashPastSum
                        width: 1.1 * cashTitle.width
                        height: cashTitle.height
                        text: isReserveDisabled ? "Сумма превышена" : "Наличных будет"
                        lineHeight: 1.5
                        font: cashTitle.font
                        clip: cashTitle.clip
                        color: isReserveDisabled ? "red" : cashTitle.color
                        elide: cashTitle.elide
                        horizontalAlignment: cashTitle.horizontalAlignment
                        verticalAlignment: cashTitle.verticalAlignment
                    }
                }

                Column {
                    width: 0.5 * parent.width
                    height: parent.height

                    Text {
                        id: cashCurrentTitle
                        width: cashTitle.width
                        height: cashTitle.height
                        anchors.verticalCenter: cashTitle.verticalCenter
                        text: "Наличных сейчас"
                        font: cashTitle.font
                        clip: cashTitle.clip
                        color: cashTitle.color
                        elide: cashTitle.elide
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                        topPadding: cashTitle.topPadding
                    }

                    Text {
                        width: cashCurrentTitle.width
                        height: cashCurrentTitle.height
                        text: CalcEngine.formatCommaResult(root.cashInDrawer) + " \u20BD"
                        font: enterCashSum.font
                        clip: cashCurrentTitle.clip
                        color: cashCurrentTitle.color
                        elide: cashCurrentTitle.elide
                        horizontalAlignment: cashCurrentTitle.horizontalAlignment
                        verticalAlignment: cashCurrentTitle.verticalAlignment
                        leftPadding: cashCurrentTitle.leftPadding
                    }

                    Text {
                        width: cashCurrentTitle.width
                        height: cashCurrentTitle.height
                        text: CalcEngine.formatCommaResult(((cashPastInt >= 0) ? cashPast : cashPast.substring(1))) + " \u20BD"
                        font: enterCashSum.font
                        clip: cashCurrentTitle.clip
                        color: cashPastSum.color
                        elide: cashCurrentTitle.elide
                        horizontalAlignment: cashCurrentTitle.horizontalAlignment
                        verticalAlignment: cashCurrentTitle.verticalAlignment
                        leftPadding: cashCurrentTitle.leftPadding
                    }
                }

            }

            SaleComponents.Calculator {
                id: calculator

                Component.onCompleted: {
                    reset()
                    setKeyboard("keyboardShortest")
                    setPrecDigits(2)
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
                height: 0.2 * width
                anchors {
                    bottom: parent.bottom
                    bottomMargin:  0.125 * height
                }
                spacing: 0.044 * width
                leftPadding: spacing
                rightPadding: spacing

                SaleComponents.Button_1 {
                    id: insResButton
                    width: 2 / 3 * (parent.width - 3 * parent.spacing)
                    height: btnRow.height
                    anchors.verticalCenter: parent.verticalCenter
                    borderWidth: 1
                    backRadius: 5
                    buttonTxt: qsTr(insert.checked ? "ВНЕСТИ" : "ИЗЪЯТЬ")
                    fontSize: 0.23 * height
                    buttonTxtColor: "#FFFFFF"
                    pushUpColor: "#415A77"
                    pushDownColor: "#004075"
                    enabled: false

                    onClicked: {
                        if (insert.checked) {
                            console.log("[InsRes.qml]\t insertion: " + cashInt + " RUB")
                        } else {
                            console.log("[InsRes.qml]\t reserve: " + cashInt + " RUB")
                        }
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter

                    SaleComponents.RadioButtonCursor {
                        id: reserve
                        checked: true
                        text: qsTr("Изъять")
                        font: cashTitle.font
                    }

                    SaleComponents.RadioButtonCursor {
                        id: insert
                        text: qsTr("Внести")
                        font: reserve.font

                        onCheckedChanged: {
                            calcInsRes(checked)
                        }
                    }
                }
            }
        }
    }
}
