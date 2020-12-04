import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/pages/subpages" as Subpages

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("[CabinetConnection.qml]\tfocus changed: " + focus)
            setMainPageTitle("Подключение к Кабинету")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    Subpages.CabinetCodeEnter {id: cabinetCodeEnter; visible: !isCabinetEnable}
    Subpages.CabinetConnectedBanner {visible: !cabinetCodeEnter.visible}
}
