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

            switchFiscalCloud.checked = root.isFiscalCloud
        }
    }

    Column {
        id: columnItemsSaleRules
        anchors.fill: parent
        spacing: labelFiscalCloud.font.pixelSize
        leftPadding: 0.7 * spacing
        topPadding: 1.5 * spacing

        Row {
            id: fiscalCloud
            width: parent.width
            spacing: 0.5 * parent.spacing

            Column {
                width: parent.width - switchFiscalCloud.width - 2 * parent.spacing

                Label {
                    id: labelFiscalCloud
                    text: qsTr("Облачная касса")
                    font {
                        pixelSize: 0.0498 * fiscalCloud.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    clip: true
                    elide: "ElideRight"
                }

                Label {
                    id: labelFiscalCloudInfo
                    text: qsTr("Фискализация чеков будет происходить\nна облачной кассе, подключенной к\nвашему Кабинету Дримкас")
                    font {
                        pixelSize: 0.83 * labelFiscalCloud.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    clip: true
                    elide: "ElideRight"
                }
            }

            Switch {
                id: switchFiscalCloud
                anchors.verticalCenter: labelFiscalCloud.verticalCenter
                onCheckedChanged: {
                    root.isFiscalCloud = checked
                }
            }
        }
    }
}
