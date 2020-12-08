import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: purchasePage
    Layout.fillHeight: true
    Layout.fillWidth: true

    property bool checkOn: false
    property int curPos: -1

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            console.log("[Purchase.qml]\tfocus changed: " + focus)
            setMainPageTitle("Чек")
            resetAddRightMenuButton()
            setAddRightMenuButtonIco("qrc:/ico/menu/delete.png")
            setAddRightMenuButtonAction(deletePosition)
            setAddRightMenuButtonVisible(false)
            setLeftMenuButtonAction(close)
            setRightMenuButtonAction(openContextMenu)
            setRightMenuButtonVisible(true)
            add2contextMenu(clearPurchase)
            setToolbarVisible(true)
        }
    }

    Action {
        id: confirmDelPurchase
        onTriggered: {
            console.log("[Purchase.qml]\tDelete purchase")
            positionModel.clear()
            setAddRightMenuButtonVisible(false)
            root.popupClose()
            rootStack.pop()
        }
    }

    Action {
        id: confirmDelPositions
        onTriggered: {
            console.log("[Login.qml]\Delete selected position")
            delCheckedPos()
            setAddRightMenuButtonVisible(false)
            root.popupClose()
            if (positionModel.count === 0) {
                rootStack.pop()
            }
        }
    }

    Action {
        id: clearPurchase
        text: qsTr("Удалить чек")

        onTriggered: {
            root.popupReset()
            root.popupSetTitle("Удаление")
            root.popupSetAddMsg("Удалить чек?")
            root.popupSetFirstActionName("УДАЛИТЬ")
            root.popupSetFirstAction(confirmDelPurchase)
            root.popupSetSecondActionName("ОТМЕНА")
            root.popupSetSecondAction(popupCancel)
            root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
            root.popupOpen()
        }
    }

    Action {
        id: deletePosition
        onTriggered: {
            root.popupReset()
            root.popupSetTitle("Удаление")
            root.popupSetAddMsg("Удалить выбранные позиции?")
            root.popupSetFirstActionName("УДАЛИТЬ")
//            root.popupSetFirstAction(confirmDelPositions)
            root.popupSetSecondActionName("ОТМЕНА")
            root.popupSetSecondAction(popupCancel)
            root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
            root.popupOpen()
        }
    }

    Action {
        id: deletePositionFromMenu
        onTriggered: {
            root.popupReset()
            root.popupSetTitle("Удаление")
            root.popupSetAddMsg("Удалить позицию?")
            root.popupSetFirstActionName("УДАЛИТЬ")
            root.popupSetFirstAction(confirmDelPositions)
            root.popupSetSecondActionName("ОТМЕНА")
            root.popupSetSecondAction(popupCancel)
            root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
            root.popupOpen()
        }
    }

    function resetQtyEditOn() {
        for (var i = 0; i < purchaseView.count; i++) {
            purchaseView.contentItem.children[i].editOn = false;
        }
    }

    function isAnyPosChecked() {
        for (var i = 0; i < purchaseView.count; i++) {
            if (purchaseView.contentItem.children[i].isChecked) {
                return true
            }
        }
        return false
    }

    function delCheckedPos()
    {
        for (var i= (positionModel.count - 1); i >= 0; --i)
        {
            if (purchaseView.contentItem.children[i].isChecked){
                positionModel.remove(i);
            }
        }
    }

    header: Row {
        id: head
        width: parent.width
        height: 0.08 * parent.height

        Text {
            id: titleLeft
            width: 0.45 * parent.width
            anchors.verticalCenter: parent.verticalCenter
            text: "НАИМЕНОВАНИЕ"
            clip: true
            font {
                pixelSize: 0.3 * parent.height
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
            }
            color: "#5E5E61"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
            leftPadding: font.pixelSize
        }

        Text {
            id: titleCenter
            width: 0.6 * (parent.width - titleLeft.width)
            anchors.verticalCenter: titleLeft.verticalCenter
            text: "ЦЕНА"
            clip: titleLeft.clip
            font: titleLeft.font
            color: titleLeft.color
            elide: titleLeft.elide
            horizontalAlignment: titleLeft.horizontalAlignment
            verticalAlignment: titleLeft.verticalAlignment
        }

        Text {
            id: titleRight
            width: parent.width - (titleLeft.width + titleCenter.width)
            anchors.verticalCenter: titleLeft.verticalCenter
            text: "КОЛ-ВО"
            clip: titleLeft.clip
            font: titleLeft.font
            color: titleLeft.color
            elide: titleLeft.elide
            horizontalAlignment: titleLeft.horizontalAlignment
            verticalAlignment: titleLeft.verticalAlignment
        }
    }

    contentData: ListView {
        id: purchaseView
        anchors.fill: parent
        clip: true
        spacing: 0.35 * head.height

        cacheBuffer: 100 * 0.15 * purchaseView.height

        model: ListModel {
            id: positionModel

            ListElement {
                goodsName: "Товар 1"
                cost: "11 650,00"
                discount: "1 000,00"
                total: "10 650,00"
                quantity: 1
                measure: "шт"
            }

            ListElement {
                goodsName: "Товар 2"
                cost: "50,00"
                total: "50,00"
                quantity: 2
                measure: "шт"
            }

            ListElement {
                goodsName: "Товар 3"
                cost: "123,45"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 4"
                cost: "555,55"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 5"
                cost: "777,77"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 6"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 7"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 8"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 9"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 10"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 10"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 10"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 10"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 10"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }

            ListElement {
                goodsName: "Товар 10"
                cost: "888,88"
                total: "50,00"
                quantity: 3.456
                measure: "кг"
            }
        }
        delegate: ItemDelegate {
            id: position
            height: 0.15 * purchaseView.height
            width: purchaseView.width

            property bool editOn: false
            property bool isChecked: false

            onEditOnChanged: {
                quantityField.focus = editOn
            }

            onPressAndHold: {
                checkOn = true
            }

            transformOrigin: Item.Center

            ListView.onRemove: SequentialAnimation {
                PropertyAction {
                    target: position
                    property: "ListView.delayRemove"
                    value: true
                }
                NumberAnimation {
                    target: position
                    property: "scale"
                    to: 0
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
                PropertyAction {
                    target: position
                    property: "ListView.delayRemove"
                    value: false
                }
            }

            Row {
                anchors.fill: parent

                Row {
                    height: parent.height
                    width: titleLeft.width

                    AbstractButton {
                        id: check
                        visible: checkOn
                        width: 1.5 * titleLeft.leftPadding
                        height: parent.height
                        anchors {
                            left: parent.left
                            leftMargin: 0.5 * width
                        }
                        checkable: true
                        display: AbstractButton.IconOnly
                        indicator: Rectangle {
                            width: check.width
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            border.width: 1
                            border.color: check.checked ? "green" : "black"
                            Image {
                                anchors.fill: parent
                                source: "qrc:/ico/menu/check.png"
                                visible: check.checked
                            }
                        }

                        onCheckedChanged: {
                            console.log("onCheckedChanged: " + checked)
                            position.isChecked = checked
                            setAddRightMenuButtonVisible(isAnyPosChecked())
                        }
                    }

                    Text {
                        height: parent.height
                        width: titleLeft.width

                        text: qsTr(goodsName)
                        font {
                            pixelSize: 0.25 * parent.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        color: "black"
                        elide: Text.ElideRight
                        wrapMode: Text.WordWrap
                        maximumLineCount: 3
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignTop
                        leftPadding: check.visible ? (2 * check.width) : titleLeft.leftPadding
                        rightPadding: titleLeft.leftPadding
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    width: titleCenter.width
                    height: parent.height

                    Text {
                        width: parent.width
                        height: 0.33 * parent.height

                        text: qsTr(cost) + " \u20BD"
                        font {
                            pixelSize: 0.25 * parent.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        color: "black"
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignTop
                    }

                    Text {
                        width: parent.width
                        height: 0.33 * parent.height

                        visible: (typeof discount != 'undefined')
                        text: qsTr("Скидка: " + discount) + " \u20BD"
                        font {
                            pixelSize: 0.20 * parent.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        color: "black"
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                    }

                    Text {
                        width: parent.width
                        height: 0.33 * parent.height

                        text: qsTr("Итого: " + total) + " \u20BD"
                        font {
                            pixelSize: 0.20 * parent.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        color: "black"
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignBottom
                    }
                }

                Row {
                    height: parent.height
                    width: titleRight.width
                    anchors.verticalCenter: parent.verticalCenter

                    TextField {
                        id: quantityField
                        width: 0.5 * parent.width
                        anchors.top: parent.top
                        text: quantity
                        placeholderText: text
                        placeholderTextColor: "black"
                        font {
                            pixelSize: 0.2 * parent.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        clip: true
                        color: "black"
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        validator: RegExpValidator { regExp: /[0-9]{1,},[0-9]{1,3}/ }
                        cursorDelegate: Rectangle {
                            visible: quantityField.cursorVisible
                            color: "green"
                            width: 2 * quantityField.cursorRectangle.width
                        }
                        background: Rectangle {
                            border.width: 1
                            border.color: quantityField.focus ? "green" : "gray"
                            color: "#FFFFFF"
                            radius: 5
                        }

                        onFocusChanged: {
                            position.editOn = focus
                        }
                    }

                    Text {
                        id: measureField
                        width: parent.width - quantityField.width
                        height: parent.height
                        anchors.verticalCenter: quantityField.verticalCenter
                        text: measure
                        font: quantityField.font
                        clip: quantityField.clip
                        color: quantityField.color
                        horizontalAlignment: quantityField.horizontalAlignment
                        verticalAlignment: quantityField.verticalAlignment
                    }


                    Menu {
                        id: positionContextMenu
                        x: parent.width - quantityField.width - measureField.width
                        y: parent.height
                        transformOrigin: Menu.TopRight

                        onClosed: {
                            itemAt(currentIndex).highlighted = false
                        }

                        MenuItem {
                            text: "Удалить"
                            action: deletePositionFromMenu
                        }
                        MenuItem {text: "Добавить скидку"}
                    }
                }
            }

            onPressYChanged: {
                resetQtyEditOn()
            }

            onClicked: {
                check.checked = check.visible && !check.checked
                if (!check.visible) {
                    positionContextMenu.open()
                }
                resetQtyEditOn()
            }
        }
        ScrollBar.vertical: ScrollBar {
            id: scroll
            policy: ScrollBar.AsNeeded
            width: 5

            onVisualPositionChanged: {
                resetQtyEditOn()
            }
        }
    }

    footer: Column {
        id: foot
        width: parent.width
        height: parent.height / 5

        Rectangle {
            id: line
            width: foot.width
            height: 2
            border.color: "#C2C2C2"
            border.width: 1
            anchors.top: foot.top
        }

        Rectangle {
            id: totalSumsWithDiscounts
            width: line.width
            height: 0.5 * (foot.height - line.height)
            anchors {
                top: line.bottom
                horizontalCenter: foot.horizontalCenter
            }
            border.width: 0
            color: "#FFFFFF"

            Row {
                anchors.fill: parent
                Text {
                    id: discountsTitle
                    text: qsTr("Скидка:")
                    font {
                        pixelSize: 0.3 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    width: 0.5 * parent.width - font.pixelSize
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    topPadding: font.pixelSize
                    anchors {
                        left: parent.left
                        leftMargin: titleLeft.leftPadding
                        verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    id: totalSumWithDiscounts
                    width: discountsTitle.width
                    text: qsTr("9 999,99"+ " \u20BD")
                    font: discountsTitle.font
                    clip: discountsTitle.clip
                    color: discountsTitle.color
                    elide: Text.ElideLeft
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: discountsTitle.verticalAlignment
                    topPadding: discountsTitle.topPadding
                    anchors {
                        right: parent.right
                        rightMargin: discountsTitle.anchors.leftMargin
                        verticalCenter: discountsTitle.verticalCenter
                    }
                }
            }
        }

        Rectangle {
            id: totalSumsWithoutDiscounts
            width: line.width
            height: 0.5 * (foot.height - line.height)
            anchors {
                bottom: parent.bottom
                horizontalCenter: foot.horizontalCenter
            }
            border.width: 0
            color: "#FFFFFF"

            Row {
                anchors.fill: parent
                Text {
                    id: withoutDiscountsTitle
                    text: qsTr("Сумма без скидки:")
                    font {
                        pixelSize: 0.3 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    width: 0.5 * parent.width - font.pixelSize
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    bottomPadding: font.pixelSize
                    anchors {
                        left: parent.left
                        leftMargin: titleLeft.leftPadding
                        verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    id: totalSumWithoutDiscounts
                    width: withoutDiscountsTitle.width
                    text: qsTr("9 999 999 999,99"+ " \u20BD")
                    font: withoutDiscountsTitle.font
                    clip: withoutDiscountsTitle.clip
                    color: withoutDiscountsTitle.color
                    elide: withoutDiscountsTitle.elide
                    wrapMode: withoutDiscountsTitle.wrapMode
                    maximumLineCount: withoutDiscountsTitle.maximumLineCount
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: withoutDiscountsTitle.verticalAlignment
                    bottomPadding: withoutDiscountsTitle.bottomPadding
                    anchors {
                        right: parent.right
                        rightMargin: withoutDiscountsTitle.anchors.leftMargin
                        verticalCenter: withoutDiscountsTitle.verticalCenter
                    }
                }
            }
        }
    }
}
