import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Flickable {
    id: flickable
    contentHeight: pane.height
    width: parent.width

    property int purchaseClcSignTmp
    property int purchaseSnoTmp

    onFocusChanged: {
        if (focus) {
            console.log("[PurchaseParams.qml]\tfocus changed: " + focus)
            setMainPageTitle("Параметры оплаты")
            setLeftMenuButtonAction(close)
            setRightMenuButtonVisible(false)
            resetAddRightMenuButton()
            setToolbarVisible(true)
        }
    }

    Pane {
        id: pane
        width: flickable.width

        Column {
            id: frame
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0.5 * 0.06 * width

            SettingsComponents.PurchaseClcSignChoose { id: purchaseClcSignChoose }

            SettingsComponents.SnoChoose { id: snoChoose }

            SaleComponents.Button_1 {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.9 * parent.width
                height: 0.16 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr("СОХРАНИТЬ")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: enabled ? "#0064B4" : "#BDC3C7"
                pushDownColor: "#004075"
                onClicked: {
                    console.log("Purchase clc sign choosen: " + purchaseClcSignChoose.clcSignChoosen)
                    console.log("SNO choosen: " + snoChoose.snoChoosen)
                    root.closePage()
                }
            }
        }
    }

    ScrollBar.vertical: ScrollBar {
        width: 8
        policy: ScrollBar.AlwaysOn
        onVisualPositionChanged: {
            focus = true
        }
    }
}
