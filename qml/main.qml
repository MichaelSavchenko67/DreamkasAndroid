import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

ApplicationWindow {
    id: root

//    width: Screen.width
//    height: Screen.height
    width: 360
    height: 640
//    width: 1080
//    height: 1920
    visible: true
//    visibility: "FullScreen"

    property bool isOnboadingModeEnabled: false
    property int statusBarHeight: /*47*/0
    property bool isPrinterConnected: true
    property bool isShiftOpened: true
    property bool isCabinetEnable: false
    property var cashInDrawer: "100,00"

    Action {
        id: skipOnboarding
        onTriggered: {
            console.log("[main.qml]\we are going to skip onboarding")
            root.isOnboadingModeEnabled = false
            rootStack.clear()
            rootStack.replace("qrc:/qml/pages/Sale.qml")
        }
    }
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
    id:openShiftOnBoarding
    onTriggered: {
        root.openShift()
        isShiftOpened = true
        ++toolBar.onboardingPageIndex
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
    function isOnBoardingMode()
    {
        return root.isOnboadingModeEnabled
    }

    function enterOnbordingMode()
    {
        root.isOnboadingModeEnabled = true
        isShiftOpened = false
        rootStack.clear()
        rootStack.push("qrc:/qml/pages/Sale.qml")
    }
    function setVisibleForOnbordingProgressBar(visible)
    {
        //progressElementPage.visible = visible
    }

    function incrementOnboardingProgressIndicator()
   {
        ++toolBar.onboardingPageIndex
        console.log("[main.qml]\tINCREAMENTED PAGE NUMBER NOW IS: " + toolBar.onboardingPageIndex)
    }
    function getOnboardingCurrentPageIndex()
   {
        return toolBar.onboardingPageIndex
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
    function setRightMenuButtonEnabled(enabled) {
        rightButton.enabled = enabled
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
    function setToolbarEnabled(enabled) {
        toolBar.enabled = enabled
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
        enteredValidator: RegExpValidator {regExp: /^(?:\d{11}|\S+@\w+\.\w{2,3})$/ }
        buttonText: "Сохранить"
        onEntered: {
            console.info("[Sale.qml]\t\tbuyers contacts: " + textEntered)
        }
    }
    menuBar: ToolBar {
        states:
        [
            State
            {
                name: "onBoarding"
                when: root.isOnboadingModeEnabled === true
                PropertyChanges {target: toolBarMainRectColor; color: Qt.rgba(0.39,0.39,0.39,0.75)}
                PropertyChanges {target: toolBarMainRectColor; z:3}
                PropertyChanges {target: leftButton; enabled: false}
                PropertyChanges {target: leftButton; opacity: 0.1}
                PropertyChanges {target: addRightButton; enabled: false}
                PropertyChanges {target: addRightButton2; enabled: false}
                PropertyChanges {target: rightButton; enabled: false}
                PropertyChanges {target: onboardingRow; visible: true}
                PropertyChanges {target: onboardingProgressIndicator; z: 100}
                PropertyChanges {target: skipOnboardingBtn; visible: toolBar.onboardingPageIndex===0}
                PropertyChanges {target: contextButton; enabled: false}
                PropertyChanges {target: frame; z: -1}

            },
            State
            {
                name: "normal"
                when: root.isOnboadingModeEnabled === false
                PropertyChanges {target: toolBarMainRectColor; color: "transparent"}
                PropertyChanges {target: toolBarMainRectColor; z:0}
                PropertyChanges {target: leftButton; enabled: true}
                PropertyChanges {target: leftButton; opacity: 1}
                PropertyChanges {target: addRightButton; enabled: true}
                PropertyChanges {target: addRightButton2; enabled: true}
                PropertyChanges {target: rightButton; enabled: true}
                PropertyChanges {target: onboardingRow; visible: false}
                PropertyChanges {target: onboardingProgressIndicator; z: 0}
                PropertyChanges {target: skipOnboardingBtn; visible: false}
                PropertyChanges {target: contextButton; enabled: true}
                PropertyChanges {target: frame; z: 1}

            }
        ]
        id: toolBar
        width: root.width
        height: 0.133 * width + statusBarHeight
        visible: true
        property int onboardingPageIndex: 0
        contentData:
        Item
        {

             Rectangle
             {
                 id: toolBarMainRectColor
                 anchors.fill: parent
                 z:3
             }

             visible:true
             anchors.fill: parent
             SettingsComponents.ToolButtonCustom {

                 id: skipOnboardingBtn
                 x: leftButton.x
                 y: leftButton.y
                 z: 100
                 visible: true
                 action: skipOnboarding
                 icon.source: "qrc:/ico/menu/close.png"
             }
             Rectangle /// индикатор прогресса(плитки)
             {
                 id: onboardingProgressIndicatorRect
                 width:parent.width
                 x: parent.x
                 y: parent.y
                 z:100
                 Row
                 {
                     id: onboardingRow
                     width: parent.width
                     height: 2
                     spacing: 2
                     visible: true
                     leftPadding: 20
                     rightPadding: 20
                     topPadding: 5

                     Repeater
                     {
                         id: onboardingProgressIndicator
                         z:400
                         model:13
                         visible: true
                         anchors.fill: parent

                         delegate:Rectangle
                         {
                             height: 2
                             width: (onboardingRow.width - onboardingRow.leftPadding - onboardingRow.rightPadding -
                                     (onboardingRow.spacing * (onboardingProgressIndicator.count - 1)))
                                    / onboardingProgressIndicator.count
                             color: "#FFFFFF"
                             visible: true
                             opacity: toolBar.onboardingPageIndex >= index ? 1  : 0.5
                         }

                     }
                 }
             }

             Column {
                     anchors.fill: parent
                     spacing: 0
                     Row {
                         z:2
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
                             x: parent.width - width
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


        background: Rectangle
        {
            z:0
            anchors.fill: parent
            color: "#5C7490"
            DropShadow {
                id: toolBarShadow
                visible: true
                anchors.fill: parent
                cached: true
                samples: 1 + 2 * radius
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8
                color: "#D6D6D6"
                source: parent
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
        initialItem: "qrc:/qml/pages/Login.qml"
        anchors.fill: parent
    }
}
