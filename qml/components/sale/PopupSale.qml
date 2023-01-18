import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    property var titleStr
    property var subTitleStr
    property var subscriptionStr
    property int prec: 3

    onOpened: {
        calculator.reset()
        calculator.setDisplay("enterAmountDisplay")
        calculator.setKeyboard("keyboardShort")
        calculator.fullDisplayInit(titleStr, subTitleStr, subscriptionStr)
        calculator.setPrecDigits(prec)
    }

    onClosed: {
        calculator.reset()
    }

    onPrecChanged: {
        calculator.setPrecDigits(prec)
    }

    width: 0.963 * parent.width
    height: 1.386 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    background: Rectangle {
        id: popupFrame
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"

        Column {
            anchors.fill: parent

            ToolButton {
                id: exitButton
                anchors {
                    top: parent.top
                    right: parent.right
                }
                icon {
                    color: "#979797"
                    height: 0.038 * parent.height
                    source: "qrc:/ico/menu/close.png"
                }
                onClicked: {
                    popupSaleClose()
                }
            }

            SaleComponents.Calculator {
                id: calculator
                anchors.top: exitButton.bottom
                onAdd2purchase: {
                    console.log("[PopupSale.qml]\tonAdd2purchase: " + calculator.formulaTotal)
                    popupSaleClose()
                }
            }
        }
    }
}
