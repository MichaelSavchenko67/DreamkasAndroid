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
            setMainPageTitle("Формирование чека")
            setLeftMenuButtonAction(openMenu)
            resetAddRightMenuButton()
            setRightMenuButtonAction(searchGoods)
            setRightMenuButtonVisible(true)
            clearContextMenu()
            enterCost.isOpenShiftBannerEnable = !isShiftOpened
//            popupTimer.running = isShiftOpened
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
            model: ["ВВОД ЦЕНЫ", "ПЛИТКИ"]

            TabButton {
                height: parent.height

                Label {
                    anchors.fill: parent
                    text: qsTr(modelData)
                    font {
                        pixelSize: 0.5 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    color: parent.focus ? "white" : "#d6d6d6"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }
        }

        background: Rectangle {
            color: "#4DA13F"

            DropShadow {
                visible: true
                anchors.fill: parent
                cached: true
                verticalOffset: 8
                radius: verticalOffset
                samples: 1 + 2 * radius
                source: parent
                color: "#d1d1d1"
            }
        }
    }

    contentData: StackLayout {
        id: tabStack
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Subpages.EnterCost {id: enterCost}
        Subpages.Favorites {}
    }
}
