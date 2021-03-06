import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents

ApplicationWindow {
    id: root
//    width: Screen.width
//    height: Screen.height
    width: 720
    height: 1280
//    width: 1080
//    height: 1920
    visible: true

    property bool isPrinterConnected: true
    property bool isShiftOpened: true
    property bool isCabinetEnable: false
    property var cashInDrawer: "100,00"

    Action {
        id: openMenu
        onTriggered: {
            console.log("[main.qml]\tOpen menu")
            drawer.open()
        }
    }

    Action {
        id: back
        onTriggered: {
            closePage()
        }
    }

    Action {
        id: searchGoods
        onTriggered: {
            openPage("qrc:/qml/pages/subpages/SearchGoods.qml")
        }
    }

    Action {
        id: close
        onTriggered: {
            closePage()
        }
    }

    Action {
        id: openContextMenu
        onTriggered: {
            console.log("[main.qml]\tOpen context menu")
            rootContextMenu.open()
        }
    }

    Action {
        id: openShift
        onTriggered: {
            root.openShift()
            isShiftOpened = true
        }
    }

    Action {
        id: closeShift
        onTriggered: {
            root.closeShift()
            isShiftOpened = false
        }
    }

    Action {
        id: disconnectPrinter
        onTriggered: {
            root.disconnectPrinter()
        }
    }

    Action {
        id: popupCancel
        onTriggered: {
            root.popupClose()
        }
    }

    Action {
        id: printXReport
        onTriggered: {
            popupSetLoader(true)
        }
    }

    Menu {
        id: rootContextMenu
        height: toolBar.height
        x: parent.width - width
        y: toolBar.y
        transformOrigin: Menu.TopRight

        onClosed: {
            itemAt(currentIndex).highlighted = false
        }
    }

    SaleComponents.PopupMain {
        id: popup
    }

    SaleComponents.PopupSale {
        id: popupSale
        closePolicy: Popup.NoAutoClose
    }

    function setMainPageTitle(title) {
        headerTitle.text = qsTr(title)
    }

    function openPage(page) {
        console.log("[main.qml]\tOpen page: " + page)
        rootStack.push(page)
    }

    function closePage() {
        console.log("[main.qml]\tClose page")
        if (rootStack.depth === 1) {
            rootStack.replace("qrc:/qml/pages/Sale.qml")
        } else {
            rootStack.pop()
        }
    }

    function getButtonIco(action) {
        if (action === openMenu) {
            return "qrc:/ico/menu/menu.png"
        } else if (action === back) {
            return "qrc:/ico/menu/back.png"
        } else if (action === searchGoods) {
            return "qrc:/ico/menu/search.png"
        } else if (action === close) {
            return "qrc:/ico/menu/close.png"
        } else if (action === openContextMenu) {
            return "qrc:/ico/menu/context_menu.png"
        }

        return "qrc:/ico/menu/context_menu.png"
    }

    function setLeftMenuButtonAction(action) {
        leftButton.action = action
    }

    function setAddRightMenuButtonAction(action) {
        addRightButton.action = action
    }

    function setAddRightMenuButtonIco(icon) {
        addRightButton.icon.source = icon
        addRightButton.visible = true
    }

    function setAddRightMenuButtonVisible(visible) {
        addRightButton.visible = visible
    }

    function setRightMenuButtonIco(icon) {
        rightButton.icon.source = icon
        rightButton.visible = true
    }

    function setRightMenuButtonVisible(visible) {
        rightButton.visible = visible
    }

    function resetAddRightMenuButton() {
        addRightButton.action = null
        addRightButton.visible = false
        addRightButton.icon.source = ""
    }

    function setRightMenuButtonAction(action) {
        rightButton.action = action
    }

    function clearContextMenu() {
        while(rootContextMenu.count) {
            rootContextMenu.removeItem(rootContextMenu.takeAction(0));
        }
    }

    function add2contextMenu(menuAction) {
        rootContextMenu.addAction(menuAction)
    }

    function setHeaderTitleButtonVisible(visible) {
        headerTitleButton.visible = visible
    }

    function add2HeaderTitleContextMenu(menuAction) {
        headerTitleContextMenu.addAction(menuAction)
    }

    function reseHeaderTitleContextMenu() {
        while(headerTitleContextMenu.count) {
            headerTitleContextMenu.removeItem(headerTitleContextMenu.takeAction(0));
        }
    }

    function resetHeaderTitleButton() {
        reseHeaderTitleContextMenu()
        headerTitleButton.visible = false
    }


    function setToolBarShadow(visible) {
        toolBarShadow.visible = visible
    }

    function setToolbarVisible(visible) {
        toolBarShadow.visible = visible
        toolBar.visible = visible
    }
    // MAIN POPUP
    function popupOpen() {
        popup.open()
    }

    function popupClose() {
        popup.close()
    }

    function popupSetTitle(title) {
        popup.titleMsg = title
    }

    function popupSetAddMsg(addMsg) {
        popup.addMsg = addMsg
    }

    function popupSetFirstActionName(name) {
        popup.firsButtonName = name
    }

    function popupSetSecondActionName(name) {
        popup.secondButtonName = name
    }

    function popupSetFirstAction(action) {
        popup.setFirstButtonAction(action)
    }

    function popupSetSecondAction(action) {
        popup.setSecondButtonAction(action)
    }

    function popupSetClosePolicy(closePolicy) {
        popup.closePolicy = closePolicy
    }

    function popupSetLoader(isloader) {
        popupSetClosePolicy(Popup.NoAutoClose)
        popup.isLoader = isloader
    }

    function popupReset() {
        popupClose()
        popupSetTitle("")
        popupSetAddMsg("")
        popupSetLoader(false)
        popup.isComplite = false
        popup.success = false
        popup.resMsg = ""
        popupSetFirstActionName("")
        popupSetSecondActionName("")
        popupSetFirstAction(null)
        popupSetSecondAction(null)
        popupSetClosePolicy(Popup.NoAutoClose)
    }

    function openShiftDialog() {
        popupReset()

        if (!isShiftOpened) {
            root.popupSetTitle("Открытие смены")
            root.popupSetAddMsg("Вы уверены, что хотите открыть смену?")
            root.popupSetFirstActionName("ОТКРЫТЬ СМЕНУ")
            root.popupSetFirstAction(openShift)
            root.popupSetSecondActionName("ОТМЕНА")
            root.popupSetSecondAction(popupCancel)
        } else {
            root.popupSetTitle("Смена уже открыта")
            root.popupSetAddMsg("Проверьте настройки ККТ")
            root.popupSetSecondActionName("ОТМЕНА")
            root.popupSetSecondAction(popupCancel)
        }

        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupOpen()
    }

    function closeShiftDialog() {
        popupReset()

        if (isShiftOpened) {
            root.popupSetTitle("Закрытие смены")
            root.popupSetAddMsg("Вы уверены, что хотите закрыть смену?")
            root.popupSetFirstActionName("ЗАКРЫТЬ СМЕНУ")
            root.popupSetFirstAction(closeShift)
            root.popupSetSecondActionName("ОТМЕНА")
            root.popupSetSecondAction(popupCancel)
        } else {
            root.popupSetTitle("Смена уже закрыта")
            root.popupSetAddMsg("Проверьте настройки ККТ")
            root.popupSetSecondActionName("ОТМЕНА")
            root.popupSetSecondAction(popupCancel)
        }

        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupOpen()
    }

    function openXReportDialog() {
        popupReset()
        root.popupSetTitle("Печать X-отчёта")
        root.popupSetAddMsg("Вы уверены, что хотите распечатать X-отчёт?")
        root.popupSetFirstActionName("ПЕЧАТЬ")
        root.popupSetFirstAction(printXReport)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(popupCancel)
        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupOpen()
    }

    function openDisconnectPrinterDialog() {
        popupReset()
        root.popupSetTitle("Отключение ККТ")
        root.popupSetAddMsg("Вы уверены, что хотите отключить ККТ?")
        root.popupSetFirstActionName("ОТКЛЮЧИТЬ ККТ")
        root.popupSetFirstAction(disconnectPrinter)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(popupCancel)
        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupOpen()
    }
    // SALE POPUP
    function popupSaleOpen() {
        popupSale.open()
    }

    function popupSaleClose() {
        popupSale.close()
    }

    function popupSaleSetTitle(titleStr) {
        popupSale.titleStr = titleStr
    }

    function popupSaleSetSubTitle(subTitleStr) {
        popupSale.subTitleStr = subTitleStr
    }

    function popupSaleSetSubscription(subscriptionStr) {
        popupSale.subscriptionStr = subscriptionStr
    }

    function popupSaleSetPrecision(prec) {
        if (prec > 0) {
            popupSale.prec = prec
        }
    }

    function popupSaleReset() {
        popupSaleClose()
        popupSaleSetTitle("")
        popupSaleSetSubTitle("")
        popupSaleSetSubscription("")
        popupSaleSetPrecision(3)
    }

    function openEnterAmountDialog(goodsName, measure, subscription) {
        popupSaleReset()
        popupSaleSetTitle(goodsName)
        popupSaleSetSubTitle(measure)
        popupSaleSetSubscription(subscription)
        popupSaleOpen()
    }

    function openEnterCostDialog(goodsName, measure, subscription) {
        openEnterAmountDialog(goodsName, measure, subscription)
        popupSaleSetPrecision(2)
    }

    //
    function openShift() {
        console.log("[main.qml]\topen shift ...")
        drawer.close()
        popupReset()
        openPage("qrc:/qml/pages/subpages/OpenShift.qml")
//        rootStack.currentItem.operation = "Открытие смены"
//        rootStack.currentItem.complite = true
//        rootStack.currentItem.resMsg = "Смена открыта"
//        isShiftOpened = true
    }

    function closeShift() {
        console.log("[main.qml]\tclose shift ...")
        drawer.close()
        popupReset()
        openPage("qrc:/qml/pages/subpages/Operation.qml")
        rootStack.currentItem.operation = "Закрытие смены"
        rootStack.currentItem.complite = true
        rootStack.currentItem.resMsg = "Смена закрыта"
        isShiftOpened = false
    }

    function disconnectPrinter() {
        console.log("[main.qml]\tdisconnect printer ...")
        drawer.close()
        popupReset()
        openPage("qrc:/qml/pages/subpages/DisconnectPrinter.qml")
    }
    // ---
    SaleComponents.MenuDrawer {
        id: drawer
        width: 0.776 * root.width
        height: root.height
        interactive: (toolBar.visible && (leftButton.action === openMenu))  
    }

    menuBar: ToolBar {
        id: toolBar
        width: root.width
        height: 0.133 * width
        visible: false

        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: leftButton
                action: openMenu
                icon {
                    color: "white"
                    height: 0.3 * parent.height
                    source: root.getButtonIco(action)
                }
            }

            Row {
                id: titleFrame
                Layout.fillWidth: true
                anchors.verticalCenter: toolBar.verticalCenter

                Label {
                    id: headerTitle
                    anchors.verticalCenter: parent.verticalCenter
                    font {
                        pixelSize: 0.375 * toolBar.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    color: "white"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }

                ToolButton {
                    id: headerTitleButton
                    property bool openContext: false
                    visible: false

                    Menu {
                        id: headerTitleContextMenu
                        width: headerTitle.width
                        height: toolBar.height
                        x: -headerTitle.width
                        y: toolBar.y
                        transformOrigin: Menu.TopRight

                        onClosed: {
                            itemAt(currentIndex).highlighted = false
                        }
                    }

                    icon {
                        source: "qrc:/ico/menu/down.png"
                        color: "white"
                        height: 0.18 * parent.height
                    }

                    onPressed: {
                        openContext = !openContext
                    }

                    onOpenContextChanged: {
                        if (openContext) {
                            headerTitleContextMenu.open()
                        }
                    }

                    states: State {
                        name: "toPressed"; when: headerTitleContextMenu.opened
                        PropertyChanges {
                            target: headerTitleButton
                            rotation: 180
                        }
                    }

                    transitions: Transition {
                        to: "toPressed"
                        reversible: true

                        PropertyAnimation {
                            properties: "rotation"
                            easing.type: Easing.InOutQuad
                            duration: 100
                        }
                    }
                }
            }

            ToolButton {
                id: addRightButton
                visible: false
                icon {
                    color: "white"
                    height: 0.35 * parent.height
                }
            }

            ToolButton {
                id: rightButton
                action: searchGoods
                icon {
                    source: root.getButtonIco(action)
                    color: "white"
                    height: 0.35 * parent.height
                }
            }
        }

        background: Rectangle {
            anchors.fill: parent
            color: "#5C7490"

            DropShadow {
                id: toolBarShadow
                visible: true
                anchors.fill: parent
                cached: true
                samples: 1 + 2 * radius
                horizontalOffset: 0
                verticalOffset: 2
                radius: 8
                color: "#D6D6D6"
                source: parent
            }
        }
    }

    contentData: StackView {
        id: rootStack
        initialItem: "qrc:/qml/pages/Login.qml"
        anchors.fill: parent
    }
}
