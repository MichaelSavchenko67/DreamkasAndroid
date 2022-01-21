import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    anchors.fill: parent

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("СНО и НДС")
            setLeftMenuButtonAction(back)
            setLeftMenuButtonIco("qrc:/ico/menu/back.png")
            setRightMenuButtonVisible(false)
            resetAddRightMenuButton()
            setToolbarVisible(true)
        }
    }

    contentData: Column {
        id: contentColumn
        width: 0.9 * parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0.5 * (parent.width - width)
        topPadding: spacing
        bottomPadding: topPadding

        ScrollView {
            width: parent.width
            height: parent.height -
                    parent.topPadding -
                    parent.bottomPadding -
                    parent.spacing -
                    saveBtn.height
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.vertical.width: 8
            contentWidth: width
            contentData: Column {
                width: parent.width
                spacing: contentColumn.spacing

                SettingsComponents.SnoChoose { id: snoChoose; spacing: 0.25 * parent.spacing }

                SaleComponents.Line { color: "#E0E0E0" }

                SettingsComponents.NdsChoose { id: ndsChoose; spacing: snoChoose.spacing }
            }
        }

        SaleComponents.Button_1 {
            id: saveBtn
            width: parent.width
            height: 0.16 * width
            borderWidth: 0
            backRadius: 5
            buttonTxt: qsTr("СОХРАНИТЬ")
            fontSize: 0.27 * height
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            onClicked: {
                root.closePage()
            }
        }
    }
}
