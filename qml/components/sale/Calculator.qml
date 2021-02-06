import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/content/calculator.js" as CalcEngine

Rectangle {
    id: calculatorPage
    width: parent.width
    height: 0.7 * parent.height
    anchors.horizontalCenter: parent.horizontalCenter

    color: "#00FFFFFF"

    property string formulaStr
    property string formulaTotal: CalcEngine.getRes()
    property var enterCostTitle: "Яблоки красные"
    property var enterCostSubTitle: "Цена, \u20BD/кг"
    property var enterCostSubscription: "Неправильное значение, введите снова"
    property var footerH: 0
    property var parentPageH: parent.height

    signal add2purchase()

    onFormulaStrChanged: {
        formulaTotal = CalcEngine.getRes()
    }

    function operatorPressed(operator) {
        CalcEngine.operatorPressed(operator)
    }

    function digitPressed(digit) {
        CalcEngine.digitPressed(digit)
    }

    function reset() {
        CalcEngine.reset()
        formulaStr = ""
        formulaTotal = CalcEngine.getRes()
        fullDisplayReset()
    }

    function fullDisplayInit(enterTitle, enterSubTitle, enterSubscription) {
        enterCostTitle = enterTitle
        enterCostSubTitle = enterSubTitle
        enterCostSubscription = enterSubscription
    }

    function fullDisplayReset() {
        enterCostTitle = ""
        enterCostSubTitle = ""
        enterCostSubscription = ""
    }

    function setDisplay(state) {
        display.state = state
    }

    function setKeyboard(state) {
        keyboard.state = state
    }

    function getKeyboardWidth() {
        return keyboard.width
    }

    function setPrecDigits(precDigits) {
        CalcEngine.setPrecDigits(precDigits)
    }

    function setInitValue(initValue) {
        formulaStr = initValue
        CalcEngine.parseFormula()
    }

    function getHeight() {
        return calcMsgRec.height + keyboard.height
    }

    function setFooterHeight(footerHeight) {
        footerH = footerHeight
    }

    function setEnable(isEnable) {
        keyboardShortest.setEnable(isEnable)
    }

    Column {
        id: display
        anchors.fill: parent
        spacing: 0.03 * height
        anchors {
            top: parent.top
            topMargin: 0.03 * height
            horizontalCenter: parent.horizontalCenter
        }

        states: [
            State {
                name: "saleDisplay"
                PropertyChanges { target: calcMsgRec; visible: true }
                PropertyChanges { target: fullDisplay; visible: false }
            },
            State {
                name: "enterAmountDisplay"
                PropertyChanges { target: fullDisplay; visible: true }
                PropertyChanges { target: calcMsgRec; visible: false }
            },
            State {
                name: "withoutDisplay"
                PropertyChanges { target: calcMsgRec; visible: false }
                PropertyChanges { target: fullDisplay; visible: false }
            }
        ]

        Rectangle {
            id: calcMsgRec
            width: 0.918 * parent.width
            height: 0.2 * width + (parentPageH - keyboard.height - footerH)
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            color: calculatorPage.color
            border {
                color: "#ECECEC"
                width: 1
            }
            radius: 7

            Column {
                width: parent.width
                height: parent.height - formula.leftPadding
                topPadding: 0.5 * formula.leftPadding

                Text {
                    id: positionName
                    height: 0.06 * parent.width
                    text: "Товар по свободной цене"
                    font {
                        pixelSize: 0.8 * height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    maximumLineCount: 2
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    leftPadding: formula.leftPadding
                }

                ScrollView {
                    id: formulaView
                    width: parent.width
                    height: parent.height - positionName.height
                    anchors.top: positionName.bottom
                    visible: (formulaStr.length > 0)

                    clip: true
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded

                    contentWidth: width
                    contentData: Text {
                        id: formula
                        width: formulaView.width
                        height: formulaView.height
                        anchors.top: positionName.bottom
                        font: positionName.font
                        text: (formulaStr.split('*').join(' x ')).split('+').join(' + ') + "\n= " + formulaTotal + "  \u20BD"
                        color: "#0064B4"
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Qt.AlignTop
                        wrapMode: Text.WrapAnywhere
                        lineHeight: 1.25
                        leftPadding: font.pixelSize
                        rightPadding: font.pixelSize
                        topPadding: 0.5 * font.pixelSize
                        bottomPadding: font.pixelSize
                    }
                }

                ScrollView {
                    id: positionQtyCost
                    width: formulaView.width
                    height: formulaView.height
                    anchors.top: positionName.bottom
                    visible: !formulaView.visible && (openPurchase.total !== "0,00")
                    clip: true
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded

                    contentWidth: width
                    contentData: Text {
                        width: positionQtyCost.width
                        height: positionQtyCost.height
                        anchors.top: positionName.bottom
                        font: positionName.font
                        text: qsTr("1" + " x " + openPurchase.total + "  \u20BD\n= " + openPurchase.total + "  \u20BD")
                        color: "#0064B4"
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Qt.AlignTop
                        wrapMode: Text.WrapAnywhere
                        lineHeight: 1.25
                        leftPadding: font.pixelSize
                        rightPadding: font.pixelSize
                        topPadding: 0.5 * font.pixelSize
                        bottomPadding: font.pixelSize
                    }
                }
            }
        }

        Rectangle {
            id: fullDisplay
            width: 0.918 * parent.width
            height: 0.43 * keyboardFull.height
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false

            Column {
                id: fullDisplayFrame
                anchors.fill: parent
                spacing: 0.1 * height

                Text {
                    id: titleStr
                    text: qsTr(enterCostTitle)
                    font {
                        pixelSize: 0.18 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Bold
                        bold: true
                    }
                    width: parent.width
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    topPadding: 0.5 * font.pixelSize
                    leftPadding: topPadding
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }

                Text {
                    id: subtitleStr
                    text: qsTr(enterCostSubTitle)
                    font {
                        pixelSize: 0.7 * titleStr.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    width: parent.width
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    rightPadding: 0.5 * font.pixelSize
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                }

                Text {
                    text: qsTr(CalcEngine.formatCommaResult(formulaStr) + "  \u20BD")
                    font {
                        pixelSize: 0.18 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    width: parent.width
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    rightPadding: 0.5 * font.pixelSize
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                }

                Text {
                    id: subscriptionStr
                    text: qsTr(enterCostSubscription)
                    font: subtitleStr.font
                    width: parent.width
                    clip: true
                    color: "red"
                    elide: Text.ElideRight
                    rightPadding: 0.5 * font.pixelSize
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                }
            }
        }

        Rectangle {
            id: keyboard
            width: calcMsgRec.width
            height: 0.81 * width
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: "#ECECEC"
            border.width: 0
            color: "#f2f2f2"

            states: [
                State {
                    name: "keyboardFull"
                    PropertyChanges { target: keyboardFull; visible: true }
                    PropertyChanges { target: keyboardShort; visible: false }
                    PropertyChanges { target: keyboardShortest; visible: false }
                },
                State {
                    name: "keyboardShort"
                    PropertyChanges { target: keyboardFull; visible: false }
                    PropertyChanges { target: keyboardShort; visible: true }
                    PropertyChanges { target: keyboardShortest; visible: false }
                },
                State {
                    name: "keyboardShortest"
                    PropertyChanges { target: keyboardFull; visible: false }
                    PropertyChanges { target: keyboardShort; visible: false }
                    PropertyChanges { target: keyboardShortest; visible: true }
                    PropertyChanges { target: keyboard; height: 0.85 * calculatorPage.height; width: 1.123 * height }
                }
            ]

            GridLayout {
               id: keyboardFull
               width: parent.width - 2 * parent.border.width
               height: parent.height - 2 * parent.border.width
               anchors.centerIn: parent
               visible: false
               columnSpacing: 0
               rowSpacing: 0

               SaleComponents.ButtonClc {btnX: 1; btnY: 1; txt: "7"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 1; txt: "8"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 1; txt: "9"}
               SaleComponents.ButtonClc {btnX: 4; btnY: 1; txt: "backspace"; txtVisible: false; operator: true;
                                         enabled: (formulaStr.length > 0)
                                         ico: enabled ? "qrc:/ico/calculator/del_en.png" : "qrc:/ico/calculator/del_dis.png"
                                         icoSize: 0.9 * width
                                         colorUp: "#F7F7F7"}

               SaleComponents.ButtonClc {btnX: 1; btnY: 2; txt: "4"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 2; txt: "5"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 2; txt: "6"}
               SaleComponents.ButtonClc {btnX: 4; btnY: 2; txt: "*"; txtVisible: false; operator: true;
                                         ico: "qrc:/ico/calculator/+.png"; icoRotation: 45
                                         icoSize: 0.2 * width
                                         colorUp: "#F7F7F7"}

               SaleComponents.ButtonClc {btnX: 1; btnY: 3; txt: "1"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 3; txt: "2"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 3; txt: "3"}
               SaleComponents.ButtonClc {btnX: 4; btnY: 3; txt: "+"; txtVisible: false; operator: true;
                                         ico: "qrc:/ico/calculator/+.png"
                                         icoSize: 0.2 * width
                                         colorUp: "#F7F7F7"}

               SaleComponents.ButtonClc {btnX: 1; btnY: 4; txt: "0"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 4; txt: ","}
               SaleComponents.ButtonClc {
                   id: add2purchase
                   btnX: 3; btnY: 4; txt: "add2purchase"; txtVisible: false; btnW: 2; operator: true;
                   enabled: formulaTotal != "0,00"
                   ico: enabled ? "qrc:/ico/calculator/add2purchaseEn.png" : "qrc:/ico/calculator/add2purchaseDis.png";
                   icoSize: 0.9 * width
                   onClicked: {
                       calculatorPage.add2purchase()
                   }
               }
            }

            GridLayout {
               id: keyboardShort
               width: parent.width - 2 * parent.border.width
               height: parent.height - 2 * parent.border.width
               anchors.centerIn: parent
               visible: false
               columnSpacing: 0
               rowSpacing: 0

               SaleComponents.ButtonClc {btnX: 1; btnY: 1; txt: "7"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 1; txt: "8"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 1; txt: "9"}
               SaleComponents.ButtonClc {btnX: 4; btnY: 1; txt: "backspace"; txtVisible: false; btnH: 3; operator: true;
                                         enabled: (formulaStr.length > 0)
                                         ico: enabled ? "qrc:/ico/calculator/del_en.png" : "qrc:/ico/calculator/del_dis.png"
                                         icoSize: 0.9 * width
                                         colorUp: "#F7F7F7"}

               SaleComponents.ButtonClc {btnX: 1; btnY: 2; txt: "4"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 2; txt: "5"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 2; txt: "6"}

               SaleComponents.ButtonClc {btnX: 1; btnY: 3; txt: "1"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 3; txt: "2"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 3; txt: "3"}

               SaleComponents.ButtonClc {btnX: 1; btnY: 4; txt: "0"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 4; txt: ","}
               SaleComponents.ButtonClc {
                   btnX: 3; btnY: 4; txt: "add2purchase"; txtVisible: false; btnW: 2; operator: true;
                   enabled: formulaTotal != "0,00"
                   ico: enabled ? "qrc:/ico/calculator/add2purchaseEn.png" : "qrc:/ico/calculator/add2purchaseDis.png";
                   icoSize: 0.9 * width
                   onClicked: {
                       calculatorPage.add2purchase()
                   }
               }
            }

            GridLayout {
               id: keyboardShortest
               width: parent.width - 2 * parent.border.width
               height: parent.height - 2 * parent.border.width
               anchors.centerIn: parent
               visible: false
               columnSpacing: 0
               rowSpacing: 0

               function setEnable(isEnable) {
                   one.enabled = isEnable
                   two.enabled = isEnable
                   three.enabled = isEnable
                   four.enabled = isEnable
                   five.enabled = isEnable
                   six.enabled = isEnable
                   seven.enabled = isEnable
                   eight.enabled = isEnable
                   nine.enabled = isEnable
                   zero.enabled = isEnable
                   backspace.enabled = isEnable
                   comma.enabled = isEnable
               }

               SaleComponents.ButtonClc {id: seven; btnX: 1; btnY: 1; txt: "7"}
               SaleComponents.ButtonClc {id: eight; btnX: 2; btnY: 1; txt: "8"}
               SaleComponents.ButtonClc {id: nine; btnX: 3; btnY: 1; txt: "9"}

               SaleComponents.ButtonClc {id: four; btnX: 1; btnY: 2; txt: "4"}
               SaleComponents.ButtonClc {id: five; btnX: 2; btnY: 2; txt: "5"}
               SaleComponents.ButtonClc {id: six; btnX: 3; btnY: 2; txt: "6"}

               SaleComponents.ButtonClc {id: one; btnX: 1; btnY: 3; txt: "1"}
               SaleComponents.ButtonClc {id: two; btnX: 2; btnY: 3; txt: "2"}
               SaleComponents.ButtonClc {id: three; btnX: 3; btnY: 3; txt: "3"}

               SaleComponents.ButtonClc {id: zero; btnX: 1; btnY: 4; txt: "0"}
               SaleComponents.ButtonClc {id: comma; btnX: 2; btnY: 4; txt: ","}
               SaleComponents.ButtonClc {id: backspace; btnX: 3; btnY: 4; txt: "backspace"; txtVisible: false; operator: true;
                                         enabled: (formulaStr.length > 0)
                                         ico: enabled ? "qrc:/ico/calculator/del_en.png" : "qrc:/ico/calculator/del_dis.png"
                                         icoSize: 0.9 * width
                                         colorUp: "#F7F7F7"}
            }
        }
    }
}
