import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/pages/" as Pages
import "qrc:/qml/pages/subpages" as Subpages

Page {
    onFocusChanged: {
        if (focus) {
            console.log("[Sale.qml]\tfocus changed: " + focus)
            setToolbarVisible(true)
            setToolBarShadow(false)
            setMainPageTitle("Приход" + " • " + "Патент")
            add2HeaderTitleContextMenu(purchaseParams)
            setHeaderTitleButtonVisible(true)
            setLeftMenuButtonAction(openMenu)
            resetAddRightMenuButton()
            setAddRightMenuButtonIco("qrc:/ico/menu/search.png")
            setAddRightMenuButtonAction(searchGoods)
            setAddRightMenuButtonVisible(true)
            setRightMenuButtonVisible(false)
            enterCost.isOpenShiftBannerEnable = !isShiftOpened
//            popupTimer.running = isShiftOpened
        } else {
            resetHeaderTitleButton()
        }
    }

    Action {
        id: purchaseParams
        text: qsTr("Параметры оплаты")

        onTriggered: {
            root.openPage("qrc:/qml/pages/subpages/PurchaseParams.qml")
        }
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
            model: ["ВВОД ЦЕНЫ", "ПЛИТКИ", "ОВОЩИ", "ФРУКТЫ", "МОЛОКО", "АЛКОГОЛЬ"]

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

        Subpages.EnterCost {id: enterCost}
        Subpages.SectionGoods { tilesInRow: 2 }
        Subpages.SectionGoods { tilesInRow: 3 }
        Subpages.SectionGoods { tilesInRow: 4 }
        Subpages.Favorites {pageTitle: "МОЛОКО"}
        Subpages.Favorites {pageTitle: "АЛКОГОЛЬ"}
    }
}
