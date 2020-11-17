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
    anchors.horizontalCenter: parent.horizontalCenter
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

    ScrollView {
        id: formulaView
        width: parent.width
        height: 0.32 * parent.height
        anchors.top: parent.top
        clip: true

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        contentWidth: width
        contentData: Text {
            id: formula
            width: formulaView.width
            height: formulaView.height
            font.pixelSize: 0.3 * formulaView.height
            text: formulaStr + "\n= " + formulaTotal + "  \u20BD"
            horizontalAlignment: Text.AlignRight
            wrapMode: Text.WrapAnywhere
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        anchors.top: formulaView.bottom
        border.color: "#c2c2c2"
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
