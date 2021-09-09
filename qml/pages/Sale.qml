import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/pages/" as Pages
import "qrc:/qml/pages/subpages" as Subpages
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    onFocusChanged: {
        if (focus) {
            console.log("[Sale.qml]\tfocus changed: " + focus)
            setToolbarVisible(true)
            setToolBarShadow(false)
            setMainPageTitle("Приход" + " • " + "Патент")
            add2HeaderTitleContextMenu(purchaseParams)
            add2HeaderTitleContextMenu(buyersData)
            setHeaderTitleButtonVisible(true)
            setLeftMenuButtonAction(openMenu)
            resetAddRightMenuButton()
            setAddRightMenuButtonIco("qrc:/ico/menu/search.png")
            setAddRightMenuButtonAction(searchGoods)
            setAddRightMenuButtonVisible(true)

            setRightMenuButtonAction(openSectionMenu)
            setRightMenuButtonIco("qrc:/ico/settings/edit.png")
            sectionMenu.addAction(renameSection)
            sectionMenu.addAction(delSection)
            sectionMenu.addAction(tilesInRow)
            sectionMenu.addAction(delTiles)

            enterCost.isOpenShiftBannerEnable = !isShiftOpened
//            popupTimer.running = isShiftOpened
        } else {
            resetHeaderTitleButton()
        }
    }

    SettingsComponents.PopupEnterText {
        id: buyersContactsPopup
        popupTitle: "Контакты покупателя"
        enteredTextTitle: "Телефон или эл. почта"
        enteredValidator: RegExpValidator {regExp: /^(?:\d{11}|\S+@\w+\.\w{2,3})$/ }
        buttonText: "Сохранить"
//        ico: "qrc:/ico/sale/rrn.png"
        onEntered: {
            console.info("[Sale.qml]\t\tbuyers contacts: " + textEntered)
        }
    }

    Action {
        id: purchaseParams
        text: qsTr("Параметры оплаты")
        onTriggered: { root.openPage("qrc:/qml/pages/subpages/PurchaseParams.qml") }
    }

    Action {
        id: buyersData
        text: qsTr("Контакты покупателя")
        onTriggered: { buyersContactsPopup.open() }
    }

    Action {
        id: openSectionMenu
        onTriggered: {
            sectionMenu.open()
        }
    }

    Action {
        id: renameSection
        text: qsTr("Переименовать")
        icon.source: "qrc:/ico/settings/text_size.png"
        onTriggered: {
            console.log("renameSection")
        }
    }

    Action {
        id: delSection
        text: qsTr("Удалить весь раздел")
        icon.source: "qrc:/ico/settings/delete_all.png"
        onTriggered: {
            console.log("delSection")
        }
    }

    Action {
        id: tilesInRow
        text: qsTr("Масштаб")
        icon.source: "qrc:/ico/settings/2_tiles_in_row.png"
    }

    Action {
        id: delTiles
        text: qsTr("Удалить выборочно")
        icon.source: "qrc:/ico/settings/delete_selection.png"
    }

    SettingsComponents.ContextMenu {
        id: sectionMenu
        width: parent.width / 2
        x: parent.width - width
    }

    Timer {
        id: popupTimer
        interval: 20000
        running: false
        repeat: false
        onTriggered: {
            root.popupReset()
            root.popupSetTitle("Смена превысила 24 часа")
            root.popupSetAddMsg("Операция недопустима, т.к.смена превысила 24 часа.")
            root.popupSetFirstActionName("ЗАКРЫТЬ СМЕНУ")
            root.popupSetFirstAction(closeShift)
            root.popupSetClosePolicy(Popup.NoAutoClose)
            root.popupOpen()
        }
    }

    header: TabBar {
        id: tabBar
        width: root.width
        height: 0.0898 * width
        currentIndex: tabStack.currentIndex

        contentData: Repeater {
            id: tabs
            model: ["ВВОД ЦЕНЫ", "ПЛИТКИ", "ОВОЩИ", "ФРУКТЫ", "+ РАЗДЕЛ"]

            TabButton {
                height: parent.height
                width: Math.max(100, tabBar.width / ((tabs.count > 4) ? 4.5 : 4))

                Label {
                    anchors.fill: parent
                    text: qsTr(modelData)
                    font {
                        pixelSize: 0.4 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    color: "#5C7490"
                    opacity: parent.focus ? 1 : 0.74
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }
        }

        background: Rectangle {
            color: "#FFFFFF"
        }
    }

    contentData: StackLayout {
        id: tabStack
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        SaleComponents.PopupEnterSectionName {
            id: popupEnterSectionName
        }

        onCurrentIndexChanged: {
            if (currentIndex === 4) {
                popupEnterSectionName.open()
            }
        }

        Subpages.EnterCost {id: enterCost}
        Subpages.SectionGoods { tilesInRow: 2 }
        Subpages.SectionGoods { tilesInRow: 3 }
        Subpages.SectionGoods { tilesInRow: 4 }
        Subpages.Favorites { pageTitle: "+ РАЗДЕЛ"}
    }
}
