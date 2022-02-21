import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: purchasesPage
    anchors.fill: parent

    onFocusChanged: {
        if (focus) {
            console.log("[Orders.qml]\tfocus changed: " + focus)
            setMainPageTitle("Чеки и заказы")
            setLeftMenuButtonAction(openMenu)
            resetAddRightMenuButton()
            setRightMenuButtonIco("qrc:/ico/menu/delete.png")
            setRightMenuButtonAction(openDeleteMenu)
            setAddRightMenuButtonAction(openCalendar)
            setAddRightMenuButtonIco("qrc:/ico/menu/calendar.png")
//            setAddRightMenuButton2Action()
//            setAddRightMenuButton2ico()
            setToolbarWithoutShadow(true)
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

    function delCheckedPurchases() {
        while (purchasesParamsListView.checkedPurchasesCnt > 0) {
            for (var i = 0; i <= purchasesParamsListModel.rowCount(); i++) {
                console.log("purchasesParamsListModel number " + purchasesParamsListModel.get(i)["number"])
                console.log("purchasesParamsListModel isChecked " + purchasesParamsListModel.get(i)["isChecked"])

                if (purchasesParamsListModel.get(i)["isChecked"]) {
                    purchasesParamsListModel.remove(i)
                    purchasesParamsListView.checkedPurchasesCnt--
                    break
                }
            }
        }
        deleteMenu.checkedPurchasesCnt = purchasesParamsListView.checkedPurchasesCnt
        purchasesParamsListView.checkMode = false
    }

    SettingsComponents.CustomMenu {
        id: deleteMenu
        width: 2 / 3 * toolBar.width
        x: parent.width - width
        property int checkedPurchasesCnt: purchasesParamsListView.checkedPurchasesCnt

        onCheckedPurchasesCntChanged: {
            delPurchases.enabled = (checkedPurchasesCnt > 0)
            delPurchases.text = delPurchases.enabled ? (checkedPurchasesCnt + " чеков") : ""
        }

        onOpened: {
            delPurchases.enabled = (checkedPurchasesCnt > 0)
            delPurchases.text = delPurchases.enabled ? (checkedPurchasesCnt + " чеков") : ""
        }

        SettingsComponents.CustomMenuSubtitle { subtitle: "УДАЛИТЬ" }

        Action { text: qsTr("Выбрать чеки"); checkable: false; enabled: !purchasesParamsListView.checkMode; onTriggered: { purchasesParamsListView.checkMode = true; deleteMenu.close() } }
        Action { id: delPurchases; checkable: false; enabled: (deleteMenu.checkedPurchasesCnt > 0); onTriggered: { openCheckedPurchasesDialog(deleteMenu.checkedPurchasesCnt) } }
        Action { text: qsTr("Все чеки"); checkable: false; onTriggered: { openPurchasesDeleteAllDialog() } }

        MenuSeparator {
            visible: cancelDel.enabled
            contentItem: Rectangle {
                implicitWidth: deleteMenu.width - deleteMenu.leftPadding
                implicitHeight: 1
                color: "#ECECEC"
            }
        }

        Action { id: cancelDel; text: qsTr("Отменить"); checkable: false; enabled: purchasesParamsListView.checkMode; onTriggered: { purchasesParamsListView.checkMode = false; deleteMenu.close() } }
    }

    Action {
        id: openDeleteMenu
        onTriggered: { deleteMenu.open() }
    }

    SettingsComponents.PopupDate {
        id: popupDate
        anchors.centerIn: parent
        isIntervalEnable: true
        minDate: new Date(curDate.getFullYear(), curDate.getMonth() - 3, curDate.getDate())
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
        id: deleteCheckedPurchases
        onTriggered: {
            popupReset()
            delCheckedPurchases()
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
        id: cancelDeletePurchase
        onTriggered: {
            popupReset()
            purchasesParamsListView.currentItem.swipe.close()
            purchasesParamsListView.currentIndex = -1
        }
    }

    function openPurchaseDeleteDialog(index, number, date) {
        popupReset()
        root.popupSetTitle("Удаление чека")
        root.popupSetAddMsg("Вы уверены, что хотите удалить чек № " + number + " от " + date + "?")
        root.popupSetFirstActionName("УДАЛИТЬ")
        deletePurchase.index = index
        root.popupSetFirstAction(deletePurchase)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(cancelDeletePurchase)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    function openCheckedPurchasesDialog(cnt) {
        popupReset()
        root.popupSetTitle("Удаление " + cnt + " чеков")
        root.popupSetAddMsg("Вы уверены, что хотите удалить " + cnt + " чеков")
        root.popupSetFirstActionName("УДАЛИТЬ")
        root.popupSetFirstAction(deleteCheckedPurchases)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(cancelDeletePurchase)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    function openPurchasesDeleteAllDialog() {
        popupReset()
        root.popupSetTitle("Удаление всех чеков")
        root.popupSetAddMsg("Вы уверены, что хотите удалить все чеки")
        root.popupSetFirstActionName("УДАЛИТЬ")
        root.popupSetFirstAction(deleteAllPurchases)
        root.popupSetSecondActionName("ОТМЕНА")
        root.popupSetSecondAction(cancelDeletePurchase)
        root.popupSetClosePolicy(Popup.NoAutoClose)
        root.popupOpen()
    }

    Timer {
        interval: 250
        repeat: true
        running: true

        property int cnt: 1

        onTriggered: {
            if (purchasesParamsListModel.count >= 5) {
                running = false
            } else {
                console.log("purchasesParamsListModel.append")
                purchasesParamsListModel.append({orderStatus: "pending", number: cnt++, date: "24.07.2021", total: "14 230,00", buyersContacts: "+7 921 383-29-39\nvictor_fedorov@gmail.com", isChecked: false})
            }
        }
    }

    header: SaleComponents.MyTextInput {
        id: findPurchaseInput
        visible: purchasesParamsListView.visible
        defaultText: "ФД, ФПД чека или товар"
        onChangeText: {
        }
    }
    contentData: Column {
        width: parent.width
        height: parent.height - parent.header.height
        anchors.fill: parent
        topPadding: 0.025 * parent.width

        ListView {
            id: purchasesParamsListView

            property bool checkMode: false
            property int checkedPurchasesCnt: 0

            onCheckModeChanged: {
                if (!checkMode) {
                    resetCheckedPurchases()
                }
            }

            onVisibleChanged: {
                setRightMenuButtonVisible(visible)
                setAddRightMenuButtonVisible(visible)

                if (visible) {
                    setToolbarWithoutShadow(true)
                } else {
                    checkMode = false
                    setToolbarVisible(true)
                }
            }

            anchors.fill: parent
            visible: (purchasesParamsListModel.count > 0)
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            cacheBuffer: 100 * 0.15 * purchasesParamsListView.height
            add: Transition { NumberAnimation { properties: "scale"; from: 0; to: 1; easing.type: Easing.InOutQuad } }
            model: ListModel { id: purchasesParamsListModel }
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
                    deleteMenu.checkedPurchasesCnt = purchasesParamsListView.checkedPurchasesCnt
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
                        printedPurchase.open()
                    }
                }

                SaleComponents.Line {
                    width: parent.width
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

    Column {
        anchors.fill: parent
        visible: !purchasesParamsListView.visible
        topPadding: 0.21 * parent.height
        spacing: 2 * infoMsg.font.pixelSize

        Label {
            id: infoMsg
            width: 0.72 * parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Здесь будет список заказов отправленных на облачную кассу")
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
                text: qsTr("ПЕРЕЙТИ К ФОРМИРОВАНИЮ ЗАКАЗА")
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
        visible: !purchasesParamsListView.visible
        width: 0.38 * parent.width
        height: 1.45 * width
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        source: "qrc:/ico/settings/girl.png"
        fillMode: Image.PreserveAspectCrop
    }

    SaleComponents.PrintedPurchase { id: printedPurchase }
}
