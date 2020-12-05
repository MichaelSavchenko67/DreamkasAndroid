import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    property var titleStr
    property var subTitleStr
    property var subscriptionStr
    property bool isEnterQuantity: false

    onOpened: {
        calculator.reset()
        calculator.fullDisplayInit(titleStr, subTitleStr, subscriptionStr)
        calculator.enterQuantity = isEnterQuantity
    }

    onClosed: {
        calculator.reset()
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
