import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/menu" as MenuComponents
import "qrc:/qml/components/settings" as SettingsComponents
import "qrc:/qml/pages/subpages" as SubPages
import "qrc:/qml/pages/subpages/loading_pages" as LoadingPages

ApplicationWindow {
    id: root
    //    width: Screen.width
    //    height: Screen.height
        // width: 360
        // height: 640
    width: 540
    height: 960
    visible: true
    //    visibility: "FullScreen"

    property int statusBarHeight: /*47*/0
    property bool isPrinterConnected: true
    property bool isShiftOpened: true
    property bool isCabinetEnable: false
    property string cashInDrawer: "100,00"
    property bool is2canLoggedIn: true

    signal mainMenuOpened()

    Action {
        id: openMenu
        onTriggered: {
            console.log("[main.qml]\tOpen menu")
            mainMenuOpened()
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

    SaleComponents.AddPositionPopup {
    }


    SaleComponents.PopupMain {
        id: popup
    }

    SaleComponents.PopupSale {
        id: popupSale
        closePolicy: Popup.NoAutoClose
    }

    SaleComponents.PopupCashlessPay {
        id: popupCashlessPay
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

    function replacePage(page) {
        console.log("[main.qml]\tOpen page: " + page)
        rootStack.replace(page)
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
        }

        return "qrc:/ico/menu/context_menu.png"
    }

    function setLeftMenuButtonAction(action) {
        leftButton.action = action
        leftButton.icon.source = getButtonIco(action)
    }

    function setLeftButtonIco(icon) {
        leftButton.icon.source = icon
        leftButton.visible = true
    }

    function setLeftMenuButtonIco(ico) {
        leftButton.icon.source = ico
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

    function resetAddRightMenuButton2() {
        addRightButton2.action = null
        addRightButton2.visible = false
        setAddRightMenuButton2ico("")
    }

    function setAddRightMenuButton2Action(action) {
        addRightButton2.action = action
    }

    function setAddRightMenuButton2ico(icoPath) {
        addRightButton2.icon.source = icoPath
    }

    function setAddRightMenuButton2visible(visible) {
        addRightButton2.visible = visible
    }

    function setHeaderTitleButtonVisible(visible) {
        contextButton.visible = visible
    }

    function resetHeaderTitleButton() {
        contextButton.visible = false
    }

    function setToolbarShadow(visible) {
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

    function openPopupCheckAge() {
        popupImageInfo.imageSource = "qrc:/img/sale/check_age.png"
        popupImageInfo.textInfo = "Убедитесь, что дата рождения\nпокупателя не позднее"
        popupImageInfo.textNote = "15.04.2003"
        popupImageInfo.open()
    }

    function openPopupClockSale() {
        popupImageInfo.imageSource = "qrc:/img/sale/clock_sale.png"
        popupImageInfo.textInfo = "Продажа алкоголя запрещена"
        popupImageInfo.textNote = ("с %1 до %2 часов").arg(clockSaleSet.finishTime).arg(clockSaleSet.startTime)
        popupImageInfo.open()
    }

    function openPopupCheckAlcoCode() {
        popupImageInfo.imageSource = "qrc:/img/sale/check_alco_code.png"
        popupImageInfo.textInfo = "Отсканируйте"
        popupImageInfo.textNote = "Акцизную марку товара водка очень вкусная и дорогая"
        popupImageInfo.open()
    }

    function openPopupUsersFormSended() {
        popupImageInfo.imageSource = "qrc:/img/sale/michael.png"
        popupImageInfo.textInfo = "Спасибо"
        popupImageInfo.textNote = "Мы свяжемся с вами в рабочее время с 09:00 до 18:00"
        popupImageInfo.titleColor = "black"
        popupImageInfo.isTitleBold = true
        popupImageInfo.subtitleColor = "black"
        popupImageInfo.subtitleOpacity = 0.6
        popupImageInfo.open()
    }

    SaleComponents.PopupImageInfo {
        id: popupImageInfo
    }

    // ---
    SaleComponents.MenuDrawer {
        id: drawer
        width: 0.776 * root.width
        height: root.height
        interactive: (toolBar.visible && (leftButton.action === openMenu))
    }

    SettingsComponents.PopupEnterText {
        id: buyersContactsPopup
        popupTitle: "Контакты покупателя"
        enteredTextTitle: "Телефон или эл. почта"
        enteredValidator: RegularExpressionValidator {regularExpression: /^(?:\d{11}|\S+@\w+\.\w{2,3})$/ }
        buttonText: "Сохранить"
        onEntered: {
            console.info("[Sale.qml]\t\tbuyers contacts: " + textEntered)
        }
    }

    function getInterfaceIco(deviceInterface) {
        if (deviceInterface === "USB") {
            return "qrc:/ico/settings/usb.png"
        } else if (deviceInterface === "Bluetooth") {
            return "qrc:/ico/settings/bluetooth.png"
        }
        return ""
    }

    menuBar: ToolBar {
        id: toolBar
        width: root.width
        height: 0.133 * width + statusBarHeight
        visible: false

        Rectangle {
            id: toolBarFrame
            anchors.fill: parent
            color: "#5C7490"
        }

        DropShadow {
            id: toolBarShadow
            visible: true
            anchors.fill: toolBarFrame
            cached: true
            samples: 1 + 2 * radius
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8
            color: "#D6D6D6"
            source: toolBarFrame
        }

        contentData: Column {
            anchors.fill: parent
            spacing: 0

            Row {
                id: frame
                width: parent.width
                height: parent.height - statusBarHeight
                leftPadding: 0.15 * leftButton.width

                SettingsComponents.ToolButtonCustom {
                    id: leftButton
                    visible: true
                    action: openMenu
                    icon.source: root.getButtonIco(action)
                }

                Label {
                    id: headerTitle
                    anchors.verticalCenter: frame.verticalCenter
                    leftPadding: parent.leftPadding
                    width: parent.width -
                           (leftButton.visible + addRightButton2.visible + addRightButton.visible + rightButton.visible + contextButton.visible) * leftButton.width -
                           parent.leftPadding -
                           leftPadding
                    font {
                        pixelSize: 0.375 * (toolBar.height - statusBarHeight)
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    color: "white"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }

                SettingsComponents.CustomMenu {
                    id: contextMenu
                    width: 2 / 3 * toolBar.width
                    y: -toolBar.y

                    Action { text: qsTr("Продажа"); checkable: true; checked: true; }
                    Action { text: qsTr("Возврат"); checkable: true; checked: false; enabled: true }
                    Action { text: qsTr("Расход"); checkable: true; checked: false; enabled: true }
                    Action { text: qsTr("Возврат расхода"); checkable: true; checked: false; enabled: true }

                    MenuSeparator {
                        contentItem: Rectangle {
                            implicitWidth: contextMenu.width - contextMenu.leftPadding
                            implicitHeight: 1
                            color: "#ECECEC"
                        }
                    }

                    Action { text: qsTr("Контакты покупателя"); checkable: false; onTriggered: { buyersContactsPopup.open() } }
                }

                SettingsComponents.ToolButtonCustom {
                    id: addRightButton2
                    visible: false
                    icon.source: "qrc:/ico/menu/close.png"
                }

                SettingsComponents.ToolButtonCustom { id: addRightButton; visible: false }

                SettingsComponents.ToolButtonCustom { id: rightButton; visible: false }

                SettingsComponents.ToolButtonCustom {
                    id: contextButton
                    visible: false
                    enabled: !contextMenu.opened
                    icon.source: "qrc:/ico/menu/context_menu.png"
                    onClicked: {
                        contextMenu.open()
                    }
                }
            }
        }
    }

    SettingsComponents.PopupUsersForm { onSave: { openPopupUsersFormSended() } }

    SettingsComponents.PopupText {
        id: popupText
        titleStr: "ЗАГОЛОВОК"
        textStr: "     ТЕКСТ     \nПОЛЕ   ЗНАЧЕНИЕ\nПОЛЕ   ЗНАЧЕНИЕ\nПОЛЕ   ЗНАЧЕНИЕ\nПОЛЕ   ЗНАЧЕНИЕ\nПОЛЕ   ЗНАЧЕНИЕ\n"
        confirmButtonAction: Action {
            onTriggered: {
                popupText.close()
            }
        }
        confirmButtonName: "ПЕЧАТЬ"
    }

    SaleComponents.PopupEnterPosName {
        id: popupEnterPosName
        popupTitle: "Введите название"
        enteredTextTitle: "Наименование товара"
        enteredTextPlaceholder: "Введите название"
        isStayLastEntered: true
    }

    contentData: StackView {
        id: rootStack
        // initialItem: "qrc:/qml/pages/subpages/loading_pages/LoadingPage.qml"
//        initialItem: "qrc:/qml/pages/startCustomerDisplay/CashboxWait.qml"
//        initialItem: "qrc:/qml/pages/startCustomerDisplay/Weighing.qml"
//        initialItem: "qrc:/qml/pages/startCustomerDisplay/Payment.qml"
//        initialItem: "qrc:/qml/pages/startCustomerDisplay/PaymentCompleted.qml"
//        initialItem: "qrc:/qml/pages/startCustomerDisplay/Purchase.qml"
//        initialItem: "qrc:/qml/pages/startCustomerDisplay/Gallery.qml"
//        initialItem: "qrc:/qml/pages/startCustomerDisplay/Advertising.qml"
//        initialItem: "qrc:/qml/pages/startCustomerDisplay/MainSettings.qml"
//        initialItem: "qrc:/qml/pages/subpages/dreamkas_display/Connection.qml"
        // initialItem: "qrc:/qml/pages/subpages/Beer.qml"
        initialItem: "qrc:/qml/pages/Sale.qml"
        anchors.fill: parent
    }

    function setMenuEnabled(isEnabled) {
        menuDisplay.interactive = isEnabled
        footerColumn.visible = isEnabled
    }

    MenuComponents.MenuDisplay {
        id: menuDisplay
    }

    Column {
        id: footerColumn
        width: 0.151 * root.width
        visible: false
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
        bottomPadding: 1.167 * menuSwipeButton.height

        Button {
            id: menuSwipeButton
            width: 0.5 * root.width
            height: menuSwipeIco.height
            anchors.horizontalCenter: parent.horizontalCenter
            background: Row {
                anchors.fill: parent
                spacing: menuSwipeIco.width
                leftPadding: 0.5 * (width - menuSwipeIco.width - spacing - menuTitleLabel.contentWidth)

                Image {
                    id: menuSwipeIco
                    width: 0.02 * root.width
                    height: 1.12 * width
                    source: "qrc:/ico/menu/menu_swipe.png"
                    fillMode: Image.PreserveaspectFit
                    scale: menuSwipeButton.pressed ? 0.8 : 1.0
                }

                Label {
                    id: menuTitleLabel
                    text: qsTr("Нажмите, чтобы открыть меню")
                    anchors.verticalCenter: parent.verticalCenter
                    font {
                        pixelSize: 0.028 * root.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#0064B4"
                    elide: Label.ElideRight
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }
            }
            onPressed: {
                menuDisplay.open()
            }
        }
    }

    SettingsComponents.PopupExtended {
        id: popupExtended
        isCancelEnabled: false
        title: "Постановка на кран №1"
        subtitle: "Рубиновый Эль в Бельгийском стиле"
        description: "Выполняется создание документа постановки на кран в ЧЗ"
        onVisibleChanged: {
            if (visible) {
                startTimer.start()
            }
        }
        onCanceled: {

        }

        Action {
            id: cancelAction
            onTriggered: {
                popupExtended.close()
            }
        }

        Timer {
            id: startTimer
            interval: 2500
            repeat: false
            onTriggered: {
                popupExtended.isCancelEnabled = true
                popupExtended.description = "Ожидание завершения создания документа постановки на кран в ЧЗ"
                popupExtended.running = true
                popupExtended.loaderMessage = loaderTimer.cnt + " секунд"
                popupExtended.buttonName = "ОТМЕНА"
                popupExtended.buttonAction = cancelAction
                loaderTimer.start()
            }
        }

        Timer {
            id: loaderTimer
            property int cnt: 120

            interval: 1000
            repeat: true
            running: (cnt > 0)
            onTriggered: {
                popupExtended.loaderMessage = cnt-- + " секунд"
            }
        }
    }
}
