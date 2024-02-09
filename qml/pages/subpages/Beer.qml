import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Разливное пиво")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    function closeAllMenus() {
        tapsListView.tapMenuOpened(-1)
    }

    Connections {
        target: root
        onMainMenuOpened: {
            closeAllMenus()
        }
    }

    contentData: Column {
        anchors.fill: parent
        leftPadding: 0.05 * width
        rightPadding: leftPadding
        topPadding: leftPadding
        bottomPadding: 0.5 * topPadding
        spacing: bottomPadding

        Row {
            id: isCheckExpirationRow
            width: addTapButton.width
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0.75 * isCheckExpirationTitle.font.pixelSize

            Column {
                id: isCheckExpirationColumn
                width: parent.width - switchPrintReports.width
                spacing: 0.5 * isCheckExpirationDescription.font.pixelSize

                Label {
                    id: isCheckExpirationTitle
                    text: qsTr("Проверять срок годности")
                    font {
                        pixelSize: 0.0498 * isCheckExpirationRow.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    clip: true
                    elide: Label.ElideRight
                }

                Label {
                    id: isCheckExpirationDescription
                    width: parent.width
                    text: qsTr("Запрещать продажу разливного алкоголя с истекшим сроком годности")
                    font {
                        pixelSize: 0.8 * isCheckExpirationTitle.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    elide: Label.ElideRight
                    maximumLineCount: 10
                    wrapMode: Text.WordWrap
                }
            }

            Switch {
                id: switchPrintReports
                anchors.verticalCenter: parent.verticalCenter
                onCheckedChanged: {
                    closeAllMenus()
                }
            }
        }

        ListView {
            id: tapsListView

            signal tapMenuOpened(int index)

            width: addTapButton.width
            height: parent.height -
                    isCheckExpirationRow.height -
                    addTapButton.height -
                    2 * parent.spacing -
                    parent.topPadding -
                    parent.bottomPadding
            visible: (count > 0)
            anchors.horizontalCenter: parent.horizontalCenter
            cacheBuffer: 10 * 1.75 * addTapButton.height
            clip: true
            interactive: (count * addTapButton.height > height)
            model: ListModel {
                id: tapsModel

                ListElement {
                    name: "1"
                    img: "qrc:/ico/tiles/tileGoods1.png"
                    itemName: "Мистер сидр 1 Мистер сидр 1 Мистер сидр 1 Мистер сидр 1"
                    litersLeft: 10
                    litersSold: 20
                    litersLeftPercent: 50.00
                    expireDate: "12.01.2024"
                }

                ListElement {
                    name: "2"
                    itemName: "Пиво разливное Lager"
                    litersLeft: 5
                    litersSold: 15
                    litersLeftPercent: 25
                    expireDate: "12.02.2024"
                }

                ListElement {
                    name: "3"
                    img: "qrc:/ico/tiles/tileGoods2.png"
                    itemName: "Василеостровское нефильтрованное отечественное"
                    litersLeft: 3
                    litersSold: 20
                    litersLeftPercent: 13.04
                    expireDate: "12.03.2024"
                }

                ListElement {
                    name: "4"
                    itemName: "Мистер сидр 4"
                    litersLeft: 0
                    litersSold: 24
                    litersLeftPercent: 0
                    expireDate: "12.04.2024"
                    isEmpty: true
                }

                ListElement {
                    name: "5"
                    img: "qrc:/ico/tiles/tileGoods3.png"
                    itemName: "Мистер сидр 5"
                    litersLeft: 5
                    litersSold: 25
                    litersLeftPercent: 16.67
                    expireDate: "12.05.2024"
                    isExpired: true
                }

                ListElement {
                    name: "6"
                    itemName: "Мистер сидр 6"
                    litersLeft: 6
                    litersSold: 24
                    litersLeftPercent: 20
                    expireDate: "12.06.2024"
                }

                ListElement {
                    name: "7"
                    itemName: "Мистер сидр 7"
                    litersLeft: 7
                    litersSold: 21
                    litersLeftPercent: 25
                    expireDate: "12.07.2024"
                }

                ListElement {
                    name: "8"
                    itemName: "Мистер сидр 8"
                    litersLeft: 8
                    litersSold: 16
                    litersLeftPercent: 33.33
                    expireDate: "12.08.2024"
                }

                ListElement {
                    name: "9"
                    itemName: "Мистер сидр 9"
                    litersLeft: 9
                    litersSold: 9
                    litersLeftPercent: 50
                    expireDate: "12.09.2024"
                }

                ListElement {
                    name: "10"
                    itemName: "Мистер сидр 10"
                    litersLeft: 100
                    litersSold: 0
                    litersLeftPercent: 100
                    expireDate: "12.10.2024"
                }
            }
            delegate: Rectangle {
                id: tapDelegate
                width: tapsListView.width - scroll.width
                height: 1.75 * addTapButton.height
                color: "transparent"
                radius: addTapButton.backRadius
                clip: true

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    radius: addTapButton.backRadius
                    clip: true

                    Rectangle {
                        width: parent.width
                        height: 0.9 * parent.height
                        anchors.centerIn: parent
                        radius: addTapButton.backRadius
                        clip: true

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onClicked: {
                                tapsListView.tapMenuOpened(model.index)
                                tapMenu.triggered()
                            }
                        }

                        color: mouseArea.pressed ? "#D6D6D6" : "transparent"

                        SettingsComponents.CustomProgressBar {
                            anchors.fill: parent
                            accentColor: model.isEmpty ? "#D6D6D6" : "#FFC600"
                            backgroundColor: model.isEmpty ? "#D6D6D6" : "#D8EEFF"
                            opacity: 0.5
                            radius: addTapButton.backRadius
                            value: Number(dynamicLitersLeftPercentField.text.replace(/\s/g, '').replace(',', '.'))

                            SaleComponents.DynamicNumberField {
                                id: dynamicLitersLeftPercentField
                                visible: false
                                accuracy: 2
                                number: model.litersLeftPercent / 100
                            }
                        }

                        Row {
                            id: tapInfoRow
                            width: parent.width - spacing
                            height: 0.9 * parent.height
                            anchors.centerIn: parent
                            spacing: 0.2 * parent.height

                            Column {
                                id: tapInfoColumn
                                width: parent.width -
                                       tapVolumeCurrentLabel.width -
                                       tileFrame.width -
                                       2 * parent.spacing
                                height: parent.height
                                spacing: (parent.height -
                                          tapNameLabel.contentHeight -
                                          tapItemNameLabel.contentHeight -
                                          tapDescriptionColumn.height) / 2

                                Label {
                                    id: tapNameLabel
                                    width: parent.width
                                    text: qsTr("Кран №" + model.name)
                                    horizontalAlignment: Label.AlignLeft
                                    verticalAlignment: Label.AlignVCenter
                                    font: isCheckExpirationDescription.font
                                    elide: Label.ElideRight
                                }

                                Label {
                                    id: tapItemNameLabel
                                    width: parent.width
                                    text: qsTr(model.itemName)
                                    horizontalAlignment: tapNameLabel.horizontalAlignment
                                    verticalAlignment: tapNameLabel.verticalAlignment
                                    font: tapVolumeLabel.font
                                    elide: Label.ElideRight
                                    maximumLineCount: 3
                                    wrapMode: Label.WordWrap
                                }

                                Column {
                                    id: tapDescriptionColumn
                                    width: parent.width
                                    spacing: 0.5 * parent.spacing

                                    Label {
                                        id: tapVolumeLabel
                                        width: parent.width
                                        text: qsTr("Объём: " + (model.litersLeft + model.litersSold) + " л")
                                        horizontalAlignment: tapNameLabel.horizontalAlignment
                                        verticalAlignment: tapNameLabel.verticalAlignment
                                        font {
                                            pixelSize: 0.8 * isCheckExpirationDescription.font.pixelSize
                                            family: "Roboto"
                                            styleName: "normal"
                                            weight: Font.Normal
                                        }
                                        color: isCheckExpirationDescription.color
                                        elide: Label.ElideRight
                                    }

                                    Label {
                                        id: tapExpireDateLabel
                                        width: parent.width
                                        text: qsTr("Годен до: " + model.expireDate + (model.isExpired ? " (истёк)" : ""))
                                        horizontalAlignment: tapNameLabel.horizontalAlignment
                                        verticalAlignment: tapNameLabel.verticalAlignment
                                        font: tapVolumeLabel.font
                                        color: model.isExpired ? "red" : tapVolumeLabel.color
                                        elide: Label.ElideRight
                                    }
                                }
                            }

                            Label {
                                id: tapVolumeCurrentLabel
                                width: 0.15 * parent.width
                                text: qsTr(model.litersLeft + " / " + (model.litersLeft + model.litersSold) + " л\n" +
                                           model.litersLeftPercent + "%")
                                anchors.verticalCenter: parent.verticalCenter
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: tapNameLabel.verticalAlignment
                                font {
                                    pixelSize: 1.2 * isCheckExpirationDescription.font.pixelSize
                                    family: tapVolumeLabel.font.family
                                    styleName: tapVolumeLabel.font.styleName
                                    weight: Font.DemiBold
                                }
                                lineHeight: 1.5
                                color: tapVolumeLabel.color
                                elide: Label.ElideRight
                            }

                            Rectangle {
                                id: tileFrame
                                color: "transparent"
                                height: 0.75 * parent.height
                                width: height
                                anchors.verticalCenter: parent.verticalCenter

                                Rectangle {
                                    anchors.fill: parent
                                    radius: addTapButton.backRadius
                                    color: parent.color

                                    Rectangle {
                                        id: tile
                                        anchors.centerIn: parent
                                        width: 0.9 * parent.width
                                        height: width
                                        color: parent.color
                                        radius: parent.radius
                                        layer.enabled: true
                                        layer.effect: OpacityMask {
                                            maskSource: Item {
                                                width: tile.width
                                                height: tile.height
                                                Rectangle {
                                                    anchors.centerIn: parent
                                                    width: tile.adapt ? tile.width : Math.min(tile.width, tile.height)
                                                    height: tile.adapt ? tile.height : width
                                                    radius: tile.radius
                                                }
                                            }
                                        }

                                        Image {
                                            id: tileSubstrate
                                            visible: false
                                            anchors.fill: parent
                                            source: "qrc:/ico/tiles/tileSubstrate.png"
                                            fillMode: Image.PreserveAspectFit
                                        }

                                        Column {
                                            id: tileColumn
                                            anchors.fill: parent

                                            Image {
                                                id: tileImg
                                                anchors.fill: parent
                                                source: (model.img.length > 0) ? model.img : "qrc:/img/sale/keg.png"
                                                fillMode: Image.PreserveAspectFit
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: tapMenu

                            property bool isOpened: false

                            Connections {
                                target: tapsListView
                                onTapMenuOpened: {
                                    if (tapMenu.isOpened && (model.index !== index)) {
                                        tapMenu.triggered()
                                    }
                                }
                            }

                            width: parent.width -
                                   tapInfoColumn.width -
                                   tapInfoRow.spacing
                            height: parent.height
                            x: parent.width
                            color: addTapButton.pushUpColor
                            radius: addTapButton.backRadius
                            opacity: 0.9

                            function triggered() {
                                if (isOpened) {
                                    closeAnimation.start()
                                } else {
                                    openAnimation.start()
                                }
                            }

                            NumberAnimation on x {
                                id: openAnimation
                                running: false
                                alwaysRunToEnd: true
                                from: tapDelegate.width
                                to: tapDelegate.width - tapMenu.width
                                duration: 150
                                easing.type: Easing.Linear
                                onStarted: {
                                    closeAnimation.stop()
                                }
                                onFinished: {
                                    tapMenu.isOpened = true
                                }
                            }

                            NumberAnimation on x {
                                id: closeAnimation
                                running: false
                                alwaysRunToEnd: openAnimation.alwaysRunToEnd
                                from: tapDelegate.width - tapMenu.width
                                to: tapDelegate.width
                                duration: openAnimation.duration
                                easing.type: openAnimation.easing.type
                                onStarted: {
                                    openAnimation.stop()
                                }
                                onFinished: {
                                    tapMenu.isOpened = false
                                }
                            }

                            Row {
                                height: 0.133 * root.width
                                anchors.centerIn: parent

                                Action {
                                    id: editTapAction
                                    onTriggered: {
                                        popupEditTapName.index = model.index
                                        popupEditTapName.enteredText = model.name
                                        popupEditTapName.open()
                                    }
                                }

                                SettingsComponents.ToolButtonCustom {
                                    id: editTapButton
                                    visible: true
                                    action: editTapAction
                                    icon.source: "qrc:/ico/settings/edit.png"
                                    onClicked: {
                                        closeAllMenus()
                                    }
                                }

                                Action {
                                    id: reportTapAction
                                    onTriggered: {
                                        popupText.open()
                                    }
                                }

                                SettingsComponents.ToolButtonCustom {
                                    id: reportTapButton
                                    visible: true
                                    action: reportTapAction
                                    icon.source: "qrc:/ico/menu/print_tool.png"
                                    onClicked: {
                                        closeAllMenus()
                                    }
                                }

                                Action {
                                    id: closeTapDialogAction
                                    onTriggered: {
                                        popupReset()
                                        root.popupSetTitle("Списание остатка")
                                        root.popupSetAddMsg("Вы уверены, что хотите списать остаток с крана №" + model.name + ": " + model.itemName + "?")
                                        root.popupSetFirstActionName("СПИСАТЬ")
                                        root.popupSetFirstAction(closeTapAction)
                                        root.popupSetSecondActionName("ОТМЕНА")
                                        root.popupSetSecondAction(popupCancel)
                                        root.popupSetClosePolicy(Popup.CloseOnPressOutside)
                                        root.popupOpen()
                                    }
                                }

                                Action {
                                    id: closeTapAction
                                    onTriggered: {

                                    }
                                }

                                SettingsComponents.ToolButtonCustom {
                                    id: closeTapButton
                                    visible: (model.litersLeft > 0)
                                    action: closeTapDialogAction
                                    icon.source: "qrc:/ico/menu/close.png"
                                    onClicked: {
                                        closeAllMenus()
                                    }
                                }

                                Action {
                                    id: deleteTapDialogAction
                                    onTriggered: {
                                        popupReset()
                                        root.popupSetTitle("Удаление крана №" + model.name)
                                        root.popupSetAddMsg("Вы уверены, что хотите удалить кран №" + model.name + "?")
                                        root.popupSetFirstActionName("УДАЛИТЬ")
                                        root.popupSetFirstAction(deleteTapAction)
                                        root.popupSetSecondActionName("ОТМЕНА")
                                        root.popupSetSecondAction(popupCancel)
                                        root.popupSetClosePolicy(Popup.CloseOnPressOutside)
                                        root.popupOpen()
                                    }
                                }

                                Action {
                                    id: deleteTapAction
                                    onTriggered: {

                                    }
                                }

                                SettingsComponents.ToolButtonCustom {
                                    id: deleteTapButton
                                    visible: (model.litersLeft === 0)
                                    action: deleteTapDialogAction
                                    icon.source: "qrc:/ico/menu/delete.png"
                                    onClicked: {
                                        closeAllMenus()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            ScrollBar.vertical: ScrollBar {
                id: scroll
                policy: ScrollBar.AsNeeded
                width: 8
                onPositionChanged: {
                    closeAllMenus()
                }
            }
        }

        Label {
            id: tapsNotFound
            height: tapsListView.height
            anchors.horizontalCenter: parent.horizontalCenter
            visible: !tapsListView.visible
            text: qsTr("Краны не найдены")
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            font {
                pixelSize: tapNameLabel.font.pixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            color: "#979797"
            elide: Label.ElideRight
        }

        SaleComponents.Button_1 {
            id: addTapButton
            width: 0.9 * parent.width
            height: 0.16 * width
            anchors.horizontalCenter: parent.horizontalCenter
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr("Постановка на кран")
            fontSize: 0.27 * height
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            onClicked: {
                closeAllMenus()
                popupChooseTap.open()
            }
        }

        SettingsComponents.PopupEnterText {
            id: popupEditTapName

            property int index: -1

            popupTitle: "Номер крана"
            enteredTextTitle: "Введите номер крана"
            isStayLastEntered: true
            enteredValidator: RegularExpressionValidator {regularExpression: /^\d{1,}$/ }
            enteredImh: Qt.ImhDigitsOnly
            buttonText: "Сохранить"
            onEntered: {
            }
        }

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

        SettingsComponents.PopupChooseTap {
            id: popupChooseTap
            popupModel: tapsModel
            onTapChoosen: {
                if (index < 0) {
                    popupEditTapName.index = index
                    popupEditTapName.enteredText = ""
                    popupEditTapName.open()
                } else {

                }
            }
        }
    }
}
