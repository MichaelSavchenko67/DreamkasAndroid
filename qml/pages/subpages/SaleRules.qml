import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: rootFrameSaleRules

    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            setMainPageTitle("Правила торговли")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
//            resetAddRightButton2()
            setToolbarVisible(true)
//            footerMainModel.setState("Off")
        }
    }

    Column {
        anchors.fill: parent
        spacing: labelFiscalCloud.font.pixelSize
        leftPadding: 0.7 * spacing
        topPadding: spacing

        Row {
            id: fiscalCloud
            width: parent.width
            topPadding: 30

            Label {
                id: labelFiscalCloud
                width: parent.width
                text: qsTr("Облачная касса")
                font {
                    pixelSize: 0.0498 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                clip: true
                elide: "ElideRight"
                //                    anchors.verticalCenter: parent.verticalCenter
                //                    leftPadding: font.pixelSize
            }
        }
    }
}
