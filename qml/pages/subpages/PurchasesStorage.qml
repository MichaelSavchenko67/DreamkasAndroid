import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: purchasesPage
    anchors.fill: parent
    states: [
        State {
            name: "loading"
            PropertyChanges { target: progressBarFrame; visible: true }
            PropertyChanges { target: progressBar; isRunning: true }
            PropertyChanges { target: findPurchaseInput; visible: false }
            PropertyChanges { target: purchasesParamsListView; visible: false }
            PropertyChanges { target: purchasesNotFoundColumn; visible: false }
            PropertyChanges { target: girl; visible: false }
        },
        State {
            name: "viewPurchases"
            PropertyChanges { target: progressBarFrame; visible: true }
            PropertyChanges { target: progressBar; isRunning: false }
            PropertyChanges { target: purchasesNotFoundColumn; visible: false }
            PropertyChanges { target: girl; visible: false }
            PropertyChanges { target: findPurchaseInput; visible: true }
            PropertyChanges { target: purchasesParamsListView; visible: true }
        },
        State {
            name: "emptyPurchasesDb"
            PropertyChanges { target: progressBar; isRunning: false }
            PropertyChanges { target: progressBarFrame; visible: false }
            PropertyChanges { target: findPurchaseInput; visible: false }
            PropertyChanges { target: purchasesParamsListView; visible: false }
            PropertyChanges { target: infoMsg; text: qsTr("Здесь будет список " + (purchasesParamsListView.isOrders ? "заказов" : "чеков")) }
            PropertyChanges { target: go2saleButton; visible: true }
            PropertyChanges { target: purchasesNotFoundColumn; visible: true }
            PropertyChanges { target: girl; visible: true }
        },
        State {
            name: "purchasesNotFound"
            PropertyChanges { target: progressBar; isRunning: false }
            PropertyChanges { target: progressBarFrame; visible: false }
            PropertyChanges { target: findPurchaseInput; visible: false }
            PropertyChanges { target: purchasesParamsListView; visible: false }
            PropertyChanges { target: infoMsg; text: qsTr((purchasesParamsListView.isOrders ? "Заказы" : "Чеки") + " с заданными параметрами не найдены") }
            PropertyChanges { target: go2saleButton; visible: false }
            PropertyChanges { target: purchasesNotFoundColumn; visible: true }
            PropertyChanges { target: girl; visible: false }
        }
    ]
    state: "loading"
    onFocusChanged: {
        if (focus) {
            console.log("[Orders.qml]\tfocus changed: " + focus)
            setMainPageTitle("Чеки и заказы")
            setLeftMenuButtonAction(openMenu)
            resetAddRightMenuButton()
            setRightMenuButtonIco("qrc:/ico/menu/context_menu.png")
            setRightMenuButtonAction(openContextMenu)
            setAddRightMenuButtonAction(openCalendar)
            setAddRightMenuButtonIco("qrc:/ico/menu/calendar.png")
            setToolbarVisible(true)
            setToolbarShadow(false)
        }
    }

    function getStatusMsg(status) {
        if (status === "success") {
            return "Фискализирован"
        } else if (status === "pending") {
            return "Не фискализирован"
        } else if (status === "failed") {
            return "Не фискализирован"
        }
    }

    function getStatusIco(status) {
        if (status === "success") {
            return "qrc:/ico/menu/operation_success.png"
        } else if (status === "pending") {
            return "qrc:/ico/menu/operation_pending.png"
        } else if (status === "failed") {
            return "qrc:/ico/menu/operation_failed.png"
        }
    }

    function resetCheckedPurchases() {
        for (var i = 0; i <= purchasesParamsListView.count; i++) {
            purchasesParamsListView.contentItem.children[i].isChecked = false;
        }
        purchasesParamsListView.checkedPurchasesCnt = 0
    }

    function execForCheckedPurchases(isDelete) {
        while (purchasesParamsListView.checkedPurchasesCnt > 0) {
            for (var i = 0; i <= purchasesParamsListModel.rowCount(); i++) {
                console.log("purchasesParamsListModel number " + purchasesParamsListModel.get(i)["number"])
                console.log("purchasesParamsListModel isChecked " + purchasesParamsListModel.get(i)["isChecked"])

                if (purchasesParamsListModel.get(i)["isChecked"]) {

                    if (isDelete) {
                        purchasesParamsListModel.remove(i)
                    }
                    purchasesParamsListView.checkedPurchasesCnt--
                    break
                }
            }
        }
        purchasesParamsListView.checkMode = false
    }

    SettingsComponents.CustomMenu {
        id: contextMenu
        width: 2 / 3 * toolBar.width
        y: toolBar.height -
           findPurchaseInput.height -
           progressBar.height -
           tabBar.height

        property bool isOrders: purchasesParamsListView.isOrders

        Action { text: qsTr("Удалить " + (contextMenu.isOrders ? "заказы" : "чеки")); checkable: false; onTriggered: { openDeleteDialog() } }
        Action { text: qsTr("Оформить чеки"); checkable: false; enabled: contextMenu.isOrders && isPrinterConnected; onTriggered: { openPrintOrdersDialog() } }
    }

    Action {
        id: openContextMenu
        onTriggered: { contextMenu.open() }
    }

    SettingsComponents.PopupDate {
        id: popupDate
        anchors.centerIn: parent
        isIntervalEnable: true
        minDate: new Date(curDate.getFullYear(), curDate.getMonth() - 3, curDate.getDate())
        onClosed: {
            periodLabelRow.visible = !(isNaN(popupDate.beginDate) || isNaN(popupDate.endDate))
            periodLabel.text = (periodLabelRow.visible ? popupDate.getConfirmButtonTxt() : "")
        }
    }

    Action {
        id: openCalendar
        onTriggered: { popupDate.open() }
    }

    Action {
        id: deletePurchase
        property int index: -1
        onTriggered: {
            popupReset()
            purchasesParamsListModel.remove(index)
        }
    }

    Action {
        id: deletePurchasesDialog
        enabled: (purchasesParamsListView.checkedPurchasesCnt > 0)
        onTriggered: {
            openDeleteCheckedPurchasesDialog(purchasesParamsListView.checkedPurchasesCnt)
        }
    }

    Action {
        id: printCheckedOrdersDialog
        enabled: (purchasesParamsListView.checkedPurchasesCnt > 0)
        onTriggered: {
            openPrintCheckedOrdersDialog(purchasesParamsListView.checkedPurchasesCnt)
        }
    }

    Action {
        id: execCheckedPurchases

        property bool isDelete: true

        onTriggered: {
            popupReset()
            execForCheckedPurchases(isDelete)
        }
    }

    Action {
        id: deleteAllPurchases
        onTriggered: {
            popupReset()
            purchasesParamsListModel.clear()
        }
    }

    Action {
        id: printAllOrders
        onTriggered: {
            popupReset()
            purchasesParamsListModel.clear()
        }
    }

    Action {
        id: cancelDeletePurchase
        onTriggered: {
            popupReset()
            purchasesParamsListView.currentItem.swipe.close()
            purchasesParamsListView.currentIndex = -1
        }
    }

    Action {
        id: startCheckMode

        property bool isDelete: true

        onTriggered: {
            popupReset()
            contextMenu.close()
            purchasesParamsListView.checkMode = true;
        }
    }

    Action {
        id: cancelCheckMode
        onTriggered: {
            purchasesParamsListView.checkMode = false
        }
    }

    function openPurchaseDeleteDialog(index, number, date) {
        popupReset()
        root.popupSetTitle("Удаление " + (purchasesParamsListView.isOrders ? "заказа" : "чека"))
        root.popupSetAddMsg("Вы уверены, что хотите удалить " + (purchasesParamsListView.isOrders ? "заказ" : "чек") + " № " + number + " от " + date + "?")
        root.popupSetFirstActionName("УДАЛИТЬ")
        deletePurchase.index = index
        root.popupSetFirstAction(deletePurchase)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(cancelDeletePurchase)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    function openDeleteCheckedPurchasesDialog(cnt) {
        popupReset()
        root.popupSetTitle("Удаление " + cnt + (purchasesParamsListView.isOrders ? " заказов" : " чеков"))
        root.popupSetAddMsg("Вы уверены, что хотите удалить " + cnt + (purchasesParamsListView.isOrders ? " заказов?" : " чеков?"))
        root.popupSetFirstActionName("УДАЛИТЬ")
        execCheckedPurchases.isDelete = true
        root.popupSetFirstAction(execCheckedPurchases)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(cancelDeletePurchase)
        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupOpen()
    }

    function openPrintCheckedOrdersDialog(cnt) {
        popupReset()
        root.popupSetTitle("Оформление чеков")
        root.popupSetAddMsg("Вы уверены, что хотите оформить чеки по " + cnt + " заказам?")
        root.popupSetFirstActionName("ОФОРМИТЬ")
        execCheckedPurchases.isDelete = false
        root.popupSetFirstAction(execCheckedPurchases)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(cancelDeletePurchase)
        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupOpen()
    }

    function openDeleteDialog() {
        popupReset()
        root.popupSetTitle("Удаление " + (purchasesParamsListView.isOrders ? "заказов" : "чеков"))
        root.popupSetAddMsg("Выбрать несколько " + (purchasesParamsListView.isOrders ? "заказов" : "чеков") + " или удалить все?")
        root.popupSetFirstActionName("УДАЛИТЬ ВСЕ")
        root.popupSetFirstAction(deleteAllPurchases)
        root.popupSetSecondActionName("ВЫБРАТЬ")
        startCheckMode.isDelete = true
        root.popupSetSecondAction(startCheckMode)
        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupOpen()
    }

    function openPrintOrdersDialog() {
        popupReset()
        root.popupSetTitle("Оформление чеков")
        root.popupSetAddMsg("Выбрать несколько заказов или оформить чеки по всем заказам?")
        root.popupSetFirstActionName("ОФОРМИТЬ ВСЕ")
        root.popupSetFirstAction(printAllOrders)
        root.popupSetSecondActionName("ВЫБРАТЬ")
        startCheckMode.isDelete = false
        root.popupSetSecondAction(startCheckMode)
        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupOpen()
    }

    function openOrdersPrintAllDialog() {
        popupReset()
        root.popupSetTitle("Оформить чеки по всем заказам")
        root.popupSetAddMsg("Вы уверены, что хотите оформить чеки по всем заказам?")
        root.popupSetFirstActionName("ОФОРМИТЬ")
        root.popupSetFirstAction(deleteAllPurchases)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(cancelDeletePurchase)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    Timer {
        id: loadingTimer
        interval: 2000
        running: true
        onTriggered: {
            state = "viewPurchases"
            appendPurchasesTimer.running = true
            //            state = "purchasesNotFound"
            //            state = "emptyPurchasesDb"
        }
    }

    Timer {
        id: appendPurchasesTimer
        interval: 250
        repeat: true
        running: false

        property int cnt: 1

        onTriggered: {
            if (purchasesParamsListModel.count >= 3) {
                running = false
            } else {
                console.log("purchasesParamsListModel.append")
                purchasesParamsListModel.append({orderStatus: "pending", number: cnt++, date: "24.07.2021", total: "14 230,00", buyersContacts: "+7 921 383-29-39\nvictor_fedorov@gmail.com", isChecked: false})
            }
        }
    }

    header: SaleComponents.MyTextInput {
        id: findPurchaseInput
        visible: false
        isUseShadow: false
        defaultText: (purchasesParamsListView.isOrders ? "Наименование товара" : "ФД, ФПД чека или товар")
        onChangeText: {
        }
    }
    contentData: Column {
        width: parent.width
        height: parent.height -
                findPurchaseInput.height
        spacing: 0

        Rectangle {
            id: progressBarFrame
            color: "#5C7490"
            implicitWidth: parent.width
            implicitHeight: 12

            SettingsComponents.CustomProgressBar { id: progressBar }
        }

        TabBar {
            id: tabBar
            width: parent.width
            height: 0.0898 * width
            currentIndex: 0
            contentData: Repeater {
                id: tabs
                model: ["ЧЕКИ", "ЗАКАЗЫ"]

                TabButton {
                    height: parent.height
                    width: tabBar.width / 2

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
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
            onCurrentIndexChanged: {
                console.log("onCurrentIndexChanged: " + currentIndex)
                purchasesParamsListView.isOrders = (currentIndex === 1)
            }
        }

        Column {
            width: parent.width
            height: parent.height - progressBar.height - tabBar.height
            spacing: 0
            topPadding: (periodLabelRow.visible ? 0 : 0.025 * parent.width)

            Row {
                id: periodLabelRow
                width: purchaseParamsColumn.width
                height: periodLabel.contentHeight + 0.0756 * parent.width
                leftPadding: 0.05 * parent.width
                visible: false
                spacing: 0.5 * periodLabel.font.pixelSize

                onVisibleChanged: {
                    parent.topPadding = (periodLabelRow.visible ? 0 : 0.025 * parent.width)
                    purchasesParamsListView.height = parent.height - (periodLabelRow.visible ? periodLabelRow.height : 0)
                }

                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    height: periodLabel.font.pixelSize
                    width: height
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/ico/menu/calendar_grey.png"
                }

                Label {
                    id: periodLabel
                    anchors.verticalCenter: parent.verticalCenter
                    font: numberLabel.font
                    color: "#000000"
                    opacity: 0.54
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                }
            }

            ListView {
                id: purchasesParamsListView

                property bool isOrders: false
                property bool checkMode: false
                property int checkedPurchasesCnt: 0

                onIsOrdersChanged: {
                    contextMenu.isOrders = isOrders
                }

                onCheckModeChanged: {
                    console.log("onCheckModeChanged: " + checkMode)

                    if (checkMode) {
                        setMainPageTitle(checkedPurchasesCnt + " Выбрано")
                        setLeftMenuButtonAction(cancelCheckMode)
                        setLeftButtonIco("qrc:/ico/menu/close.png")
                        resetAddRightMenuButton()
                        setRightMenuButtonIco(startCheckMode.isDelete ? "qrc:/ico/menu/delete.png" : "qrc:/ico/menu/print_tool.png")
                        setRightMenuButtonAction(startCheckMode.isDelete ? deletePurchasesDialog : printCheckedOrdersDialog)
                    } else {
                        resetCheckedPurchases()
                        setMainPageTitle("Чеки и заказы")
                        setLeftMenuButtonAction(openMenu)
                        setRightMenuButtonIco("qrc:/ico/menu/context_menu.png")
                        setRightMenuButtonAction(openContextMenu)
                        setAddRightMenuButtonAction(openCalendar)
                        setAddRightMenuButtonIco("qrc:/ico/menu/calendar.png")
                    }
                }

                onCheckedPurchasesCntChanged: {
                    if (checkMode && (checkedPurchasesCnt >= 0)) {
                        setMainPageTitle(checkedPurchasesCnt + " Выбрано")
                    }
                }

                onVisibleChanged: {
                    console.log("THIS onVisibleChanged: " + visible)
                    setRightMenuButtonVisible(visible)
                    setAddRightMenuButtonVisible(visible)

                    if (visible) {
                        periodLabelRow.visible = !(isNaN(popupDate.beginDate) || isNaN(popupDate.endDate))
                    } else {
                        checkMode = false
                        periodLabelRow.visible = false
                        popupDate.reset()
                    }
                }

                width: parent.width
                height: parent.height -
                        (periodLabelRow.visible ? periodLabelRow.height : 0) -
                        parent.topPadding
                visible: (purchasesParamsListModel.count > 0)
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                cacheBuffer: 100 * 0.15 * purchasesParamsListView.height
                add: Transition { NumberAnimation { properties: "scale"; from: 0; to: 1; easing.type: Easing.InOutQuad } }
                model: ListModel {
                    id: purchasesParamsListModel
                    onCountChanged: {
                        if (count <= 0) {
                            state = "emptyPurchasesDb"
                        }
                    }
                }
                delegate: SwipeDelegate {
                    id: swipeDelegate

                    property bool isChecked: false

                    onIsCheckedChanged: {
                        model.isChecked = isChecked

                        if (isChecked) {
                            purchasesParamsListView.checkedPurchasesCnt++
                        } else {
                            purchasesParamsListView.checkedPurchasesCnt--
                        }
                        contextMenu.checkedPurchasesCnt = purchasesParamsListView.checkedPurchasesCnt
                    }

                    width: parent.width
                    height: purchaseParamsColumn.height
                    ListView.onRemove: SequentialAnimation {
                        PropertyAction {
                            target: swipeDelegate
                            property: "ListView.delayRemove"
                            value: true
                        }
                        NumberAnimation {
                            target: swipeDelegate
                            property: "height"
                            to: 0
                            easing.type: Easing.InOutQuad
                        }
                        PropertyAction {
                            target: swipeDelegate
                            property: "ListView.delayRemove"
                            value: false
                        }
                    }
                    swipe.enabled: !purchasesParamsListView.checkMode
                    swipe.right: Rectangle {
                        id: deleteFrame
                        width: parent.width
                        height: parent.height
                        anchors.right: parent.right
                        clip: true
                        color: "red"

                        Image {
                            height: 0.3 * parent.height
                            width: height
                            anchors.centerIn: parent
                            source: "qrc:/ico/menu/delete.png"
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                    swipe.onCompleted: {
                        purchasesParamsListView.currentIndex = index
                        openPurchaseDeleteDialog(index, number, date)
                    }
                    onClicked: {
                        if (purchasesParamsListView.checkMode) {
                            purchasesParamsListView.currentIndex = index
                            purchasesParamsListView.currentItem.isChecked = !purchasesParamsListView.currentItem.isChecked
                        } else {
                            qrCodePopup.open()
                        }
                    }

                    SaleComponents.Line {
                        width: purchaseParamsColumn.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: (model.index === 0)
                        color: "#E0E0E0"
                    }

                    Column {
                        id: purchaseParamsColumn
                        width: parent.width - 0.1 * parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 0.021 * width
                        topPadding: 2 * spacing
                        clip: true
                        opacity: 1 + swipeDelegate.swipe.position

                        Row {
                            width: parent.width

                            Row {
                                id: statusRow
                                width: 0.6 * parent.width
                                spacing: 0.5 * 0.021 * purchaseParamsColumn.width

                                Image {
                                    id: statusImage
                                    height: statusLabel.font.pixelSize
                                    width: height
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: getStatusIco(orderStatus)
                                    fillMode: Image.PreserveAspectFit
                                }

                                Label {
                                    id: statusLabel
                                    text: qsTr(getStatusMsg(orderStatus))
                                    width: parent.width - statusImage.width - parent.spacing
                                    anchors.verticalCenter: parent.verticalCenter
                                    font {
                                        pixelSize: 0.055 * parent.width
                                        family: "Roboto"
                                        styleName: "normal"
                                    }
                                    color: "#979797"
                                    elide: Label.ElideRight
                                    horizontalAlignment: Qt.AlignLeft
                                    verticalAlignment: Qt.AlignVCenter
                                }
                            }

                            Row {
                                id: retryRow
                                width: parent.width - statusRow.width
                                spacing: statusRow.spacing
                                anchors.verticalCenter: statusRow.verticalCenter
                                visible: (orderStatus === "failed")
                                leftPadding: width - (retryImage.width + retryLabel.contentWidth + spacing)

                                Button {
                                    background: Row {
                                        spacing: statusRow.spacing
                                        anchors.verticalCenter: statusRow.verticalCenter

                                        Image {
                                            id: retryImage
                                            width: statusImage.width
                                            height: width
                                            anchors.verticalCenter: parent.verticalCenter
                                            source: "qrc:/ico/settings/update_blue.png"
                                            fillMode: Image.PreserveAspectFit
                                        }

                                        Label {
                                            id: retryLabel
                                            text: qsTr("ПОВТОРИТЬ ПОПЫТКУ")
                                            anchors.verticalCenter: parent.verticalCenter
                                            font {
                                                pixelSize: 0.0336 * purchaseParamsColumn.width
                                                family: "Roboto"
                                                styleName: "normal"
                                            }
                                            color: "#0064B4"
                                            elide: Label.ElideRight
                                            horizontalAlignment: Qt.AlignRight
                                            verticalAlignment: Qt.AlignVCenter
                                        }
                                    }
                                    onClicked: {
                                        console.info("[Orders.qml]\t\tretry order")
                                    }
                                }
                            }
                        }

                        Row {
                            width: parent.width

                            Column {
                                width: 0.5 * parent.width
                                spacing: 0.5 * purchaseParamsColumn.spacing
                                anchors.verticalCenter: totalLabel

                                Row {
                                    width: parent.width

                                    Label {
                                        id: numberLabel
                                        text: qsTr("№ " + number + " ")
                                        font {
                                            pixelSize: 0.0462 * purchaseParamsColumn.width
                                            family: "Roboto"
                                            styleName: Font.DemiBold
                                        }
                                        color: "black"
                                        elide: Label.ElideRight
                                        horizontalAlignment: Qt.AlignLeft
                                        verticalAlignment: Qt.AlignBottom
                                    }

                                    Label {
                                        height: numberLabel.contentHeight
                                        text: qsTr("от " + date)
                                        font {
                                            pixelSize: 0.7 * numberLabel.font.pixelSize
                                            family: "Roboto"
                                            styleName: "normal"
                                        }
                                        color: "black"
                                        elide: Label.ElideRight
                                        horizontalAlignment: Qt.AlignLeft
                                        verticalAlignment: Qt.AlignBottom
                                    }
                                }

                                Label {
                                    text: qsTr(buyersContacts)
                                    width: parent.width
                                    font {
                                        pixelSize: 0.0336 * purchaseParamsColumn.width
                                        family: "Roboto"
                                        styleName: "normal"
                                    }
                                    lineHeight: 1.3
                                    color: statusLabel.color
                                    horizontalAlignment: statusLabel.horizontalAlignment
                                    verticalAlignment: statusLabel.verticalAlignment
                                }
                            }

                            Label {
                                id: totalLabel
                                width: 0.5 * parent.width
                                text: total + "&nbsp;\u20BD"
                                textFormat: Label.RichText
                                font: numberLabel.font
                                color: "black"
                                elide: Label.ElideRight
                                maximumLineCount: 2
                                wrapMode: Label.WordWrap
                                horizontalAlignment: Qt.AlignRight
                                verticalAlignment: Qt.AlignBottom
                            }
                        }

                        SaleComponents.Line {
                            width: parent.width
                            color: "#E0E0E0"
                        }
                    }

                    Column {
                        id: checkColumn
                        width: swipeDelegate.width
                        height: 0.95 * swipeDelegate.height
                        anchors.centerIn: parent
                        visible: purchasesParamsListView.checkMode

                        Rectangle {
                            id: checkRect
                            anchors.fill: parent
                            visible: swipeDelegate.isChecked
                            color: "#C4C4C4"
                            radius: 8
                            opacity: 0
                            states: State {
                                name: "enable"; when: purchasesParamsListView.checkMode
                                PropertyChanges {
                                    target: checkRect
                                    opacity: 0.4
                                }
                            }
                            transitions: Transition {
                                from: ""; to: "enable"
                                reversible: true

                                PropertyAnimation {
                                    properties: "opacity"
                                    easing.type: Easing.InOutQuad
                                    duration: 500
                                }
                            }
                        }

                        Image {
                            id: tileCheckIco
                            width: 0.075 * parent.width
                            height: width
                            transformOrigin: Item.Center
                            scale: 0
                            anchors {
                                right: parent.right
                                rightMargin: 0.5 * width
                                top: parent.top
                                topMargin: 0.15 * width
                            }
                            source: swipeDelegate.isChecked ? "qrc:/ico/tiles/tileCheckOn" : "qrc:/ico/tiles/tileCheckOff"
                            states: State {
                                name: "enable"; when: purchasesParamsListView.checkMode
                                PropertyChanges {
                                    target: tileCheckIco
                                    scale: 1.0
                                }
                            }
                            transitions: Transition {
                                from: ""; to: "enable"
                                reversible: true

                                PropertyAnimation {
                                    properties: "scale"
                                    easing.type: Easing.InOutQuad
                                    duration: 500
                                }
                            }
                        }
                    }
                }

                ScrollBar.vertical: ScrollBar {
                    id: scroll
                    policy: ScrollBar.AsNeeded
                    width: 4
                }
            }
        }
    }

    Column {
        id: purchasesNotFoundColumn
        anchors.fill: parent
        visible: false
        topPadding: 0.21 * parent.height
        spacing: 2 * infoMsg.font.pixelSize

        Label {
            id: infoMsg
            width: 0.72 * parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            font {
                pixelSize: 0.04 * parent.width
                family: "Roboto"
                styleName: "normal"
            }
            color: "#979797"
            elide: Label.ElideRight
            maximumLineCount: 3
            wrapMode: Label.WordWrap
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        Button {
            id: go2saleButton
            height: 2 * go2saleMsg.contentHeight
            width: infoMsg.width
            anchors.horizontalCenter: infoMsg.horizontalCenter
            background: Label {
                id: go2saleMsg
                width: parent.width
                text: qsTr("ПЕРЕЙТИ К ФОРМИРОВАНИЮ " + (purchasesParamsListView.isOrders ? "ЗАКАЗА" : "ЧЕКА"))
                font {
                    pixelSize: 0.8 * infoMsg.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                }
                color: "#0064B4"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }
            onClicked: { rootStack.pop(null) }
        }
    }

    Image {
        id: girl
        visible: false
        width: 0.38 * parent.width
        height: 1.45 * width
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        source: "qrc:/ico/settings/girl.png"
        fillMode: Image.PreserveAspectCrop
    }

    SaleComponents.QrCodePopup {
        id: qrCodePopup
        src: "qrc:/ico/purchase/qr_code_example.png"
        onOpenPrintedPurchase: {
            close()
            printedPurchase.open()
        }
    }

    SaleComponents.PrintedPurchase { id: printedPurchase }
}
