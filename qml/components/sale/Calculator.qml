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
    anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }

    color: "#00FFFFFF"

    property string formulaStr
    property string formulaTotal: CalcEngine.getRes(/*formulaStr*/)

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
    }

    Column {
        anchors.fill: parent
        spacing: 0.06 * height
        anchors {
            top: parent.top
            topMargin: 0.06 * height
            horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: calcMsgRec
            width: 0.918 * parent.width
            height: 0.23 * width
            anchors.horizontalCenter: parent.horizontalCenter
            color: calculatorPage.color
            border {
                color: "#C4C4C4"
                width: 1
            }
            radius: 7

            ScrollView {
                id: formulaView
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                visible: (formulaStr.length > 0)

                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                contentWidth: width
                contentData: Text {
                    id: formula
                    width: formulaView.width
                    height: formulaView.height
                    font: positionName.font
                    text: formulaStr + "\n= " + formulaTotal + "  \u20BD"
                    horizontalAlignment: Text.AlignRight
                    wrapMode: Text.WrapAnywhere
                    lineHeight: 1.5
                    leftPadding: font.pixelSize
                    rightPadding: font.pixelSize
                    topPadding: font.pixelSize
                    bottomPadding: font.pixelSize
                }
            }

            Row {
                anchors.fill: parent
                visible: !formulaView.visible

                Text {
                    id: positionName
                    text: qsTr("Товар по свободной цене")
                    font {
                        pixelSize: 0.211 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    width: 0.5 * parent.width - font.pixelSize
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    maximumLineCount: 4
                    wrapMode: Text.WordWrap
                    lineHeight: 1.5
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    anchors {
                        left: parent.left
                        leftMargin: font.pixelSize
                        verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    id: positionQtyCost
                    width: positionName.width
                    text: qsTr("1" + " x " + openPurchase.total + "  \u20BD\n= " + openPurchase.total + "  \u20BD")
                    visible: (openPurchase.total != "0,00")
                    font {
                        pixelSize: positionName.font.pixelSize
                        family: positionName.font.family
                        styleName: positionName.font.styleName
                        weight: positionName.font.weight
                    }
                    lineHeight: 1.5
                    clip: true
                    color: positionName.color
                    elide: Text.ElideLeft
                    wrapMode: Text.WordWrap
                    maximumLineCount: 4
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    anchors {
                        right: parent.right
                        rightMargin: positionName.font.pixelSize
                        verticalCenter: positionName.verticalCenter
                        bottomMargin: 0.265 * parent.height
                    }
                }
            }
        }

        Rectangle {
            id: calcKeyboard
            width: calcMsgRec.width
            height: 0.81 * width
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: "#C4C4C4"
            border.width: 1
            color: "#f2f2f2"

            GridLayout {
               id: calculatorButtonsGrid
               width: parent.width - 2 * parent.border.width
               height: parent.height - 2 * parent.border.width
               anchors.centerIn: parent
               columnSpacing: 0
               rowSpacing: 0

               SaleComponents.ButtonClc {btnX: 1; btnY: 1; txt: "7"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 1; txt: "8"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 1; txt: "9"}
               SaleComponents.ButtonClc {btnX: 4; btnY: 1; txt: "backspace"; txtVisible: false; operator: true;
                                         enabled: (formulaStr.length > 0)
                                         ico: enabled ? "qrc:/ico/calculator/del_en.png" : "qrc:/ico/calculator/del_dis.png"
                                         icoSize: 0.9 * width}

               SaleComponents.ButtonClc {btnX: 1; btnY: 2; txt: "4"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 2; txt: "5"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 2; txt: "6"}
               SaleComponents.ButtonClc {btnX: 4; btnY: 2; txt: "*"; txtVisible: false; operator: true;
                                         ico: "qrc:/ico/calculator/+.png"; icoRotation: 45
                                         icoSize: 0.2 * width}

               SaleComponents.ButtonClc {btnX: 1; btnY: 3; txt: "1"}
               SaleComponents.ButtonClc {btnX: 2; btnY: 3; txt: "2"}
               SaleComponents.ButtonClc {btnX: 3; btnY: 3; txt: "3"}
               SaleComponents.ButtonClc {btnX: 4; btnY: 3; txt: "+"; txtVisible: false; operator: true;
                                         ico: "qrc:/ico/calculator/+.png"
                                         icoSize: 0.2 * width}

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
        }
    }
}
