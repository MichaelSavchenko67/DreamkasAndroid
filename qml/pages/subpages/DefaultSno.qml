import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    anchors.fill: parent

    onFocusChanged: {
        if (focus) {
            console.log("[PurchaseParams.qml]\tfocus changed: " + focus)
            setMainPageTitle("Система налогооблажения")
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            resetAddRightMenuButton()
            setToolbarVisible(true)
        }
    }

    contentData: Rectangle {
        anchors.fill: parent

        Column {
            id: sno
            width: parent.width
            spacing: snoChoose.topPadding

            SettingsComponents.SnoChoose {
                id: snoChoose
                topPadding: 0.5 * 0.06 * parent.width
            }
        }

        SaleComponents.Button_1 {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: sno.spacing
            }
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
                root.closePage()
            }
        }
    }
}
