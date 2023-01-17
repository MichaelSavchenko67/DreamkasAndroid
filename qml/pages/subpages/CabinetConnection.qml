import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts

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
