import QtQuick
import QtQuick.Controls

import CustomRolesEnum 1.0

import "qrc:/qml/components/settings" as SettingsComponents

Drawer {
    id: drawer

    property var avatarSource: ""
    property var topSpace: 0.25 * root.statusBarHeight
    property int menuIndentation: 15

    function updateMenu() {
        console.log("[MenuDrawr.qml]\t updateMenu")
        var itemList = []
        cycleAllItem(menuTreeView.rootIndex, itemList)
        menuModelTree.setData(itemList[0], true, ModelEnum.IsFirstHighlighted)
        menuModelTree.setData(itemList[itemList.length - 1], true, ModelEnum.IsLastHighlighted)
        menuModelTree.layoutChanged()
    }

    onOpened: {
        updateMenu()
    }

    function collapseOpenedMenuExcludeRow(excludeRow) {
        console.log("collapseOpenedMenuExcludeRow: " + excludeRow)

        for (var i = 0; i < menuTreeView.rows; ++i) {
            if ((i !== excludeRow) && menuTreeView.isExpanded(i)) {
                console.log("collapse row:" + i)
                menuTreeView.collapseRecursively(i)
                break
            }
        }
    }

    function cycleAllItem(rootIndex, itemList) {
        for (var i = 0; i < menuModelTree.rowCount(rootIndex); ++i) {
            var cycleIndex = menuModelTree.index(i, 0, rootIndex)
            let isHighlighted = menuModelTree.data(menuModelTree.parent(cycleIndex), ModelEnum.IsFirstHighlighted) ||
                menuModelTree.data(menuModelTree.parent(cycleIndex), ModelEnum.IsHighlighted) ||
                menuModelTree.data(menuModelTree.parent(cycleIndex), ModelEnum.IsLastHighlighted)
            menuModelTree.setData(cycleIndex, false, ModelEnum.IsHighlighted)
            menuModelTree.setData(cycleIndex, false, ModelEnum.IsFirstHighlighted)
            menuModelTree.setData(cycleIndex, false, ModelEnum.IsLastHighlighted)

            let isOpened = menuTreeView.isExpanded(cycleIndex.row) ||
                (menuModelTree.isValid(menuModelTree.parent(cycleIndex)) &&
                 (menuTreeView.isExpanded(menuModelTree.parent(cycleIndex).row) ||
                  isHighlighted))

            if (isOpened) {
                itemList.push(cycleIndex)
                menuModelTree.setData(cycleIndex, true, ModelEnum.IsHighlighted)
                cycleAllItem(cycleIndex, itemList)
            }
        }
    }

    contentData: Page {
        id: menuBar
        anchors.fill: parent
        header: Rectangle {
            height: 0.25 * menuBar.height + topSpace
            width: menuBar.width
            color: "#5C7490"

            Column {
                id: menuBarColumn
                anchors.fill: parent
                topPadding: 0.07 * parent.width + topSpace
                leftPadding: 0.08 * parent.width
                spacing: 0.5 * topPadding

                Image {
                    id: logo
                    height: 0.3 * (parent.height - topSpace)
                    width: height
                    source: "qrc:/ico/menu/ico_short.png"
                }

                Row {
                    width: parent.width - 2 * parent.leftPadding

                    Column {
                        width: parent.width - avatar.width
                        height: menuBarColumn.height - topSpace - logo.height - menuBarColumn.spacing - 2 * menuBarColumn.topPadding
                        anchors.verticalCenter: menuBarColumn.verticalCenter

                        Label {
                            id: userName
                            height: 0.3 * (menuBarColumn.height - topSpace)
                            width: parent.width
                            text: qsTr("Савченко Михаил Андреевич")
                            font {
                                pixelSize: 0.38 * height
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Bold
                                bold: true
                            }
                            clip: true
                            color: "white"
                            maximumLineCount: 2
                            wrapMode: Label.WordWrap
                            elide: Label.ElideRight
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignVCenter
                        }

                        Row {
                            width: parent.width
                            spacing: 0.5 * ruleName.font.pixelSize

                            Image {
                                id: ruleIco
                                height: ruleName.font.pixelSize
                                anchors.verticalCenter: ruleName.verticalCenter
                                source: "qrc:/ico/settings/tie.png"
                                fillMode: Image.PreserveAspectFit
                            }

                            Label {
                                id: ruleName
                                width: parent.width - ruleIco.width - parent.spacing
                                text: qsTr("Администратор")
                                font {
                                    pixelSize: 0.83 * userName.font.pixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Bold
                                    bold: true
                                }
                                clip: true
                                color: "white"
                                opacity: 0.75
                                horizontalAlignment: Qt.AlignLeft
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }
                    }

                    Rectangle {
                        id: activeFrame
                        border.width: 3
                        border.color: "#4DA03F"
                        color: "transparent"
                        width: 0.3 * parent.width
                        height: width
                        radius: width
                        anchors.verticalCenter: userName.verticalCenter

                        SettingsComponents.Avatar {
                            id: avatar
                            width: parent.width - 2 * parent.border.width
                            anchors.centerIn: parent
                            avatarSrc: ""
                            userNameFull: "Савченко Михаил Андреевич"
                        }
                    }
                }
            }
        }
        contentData: TreeView {
            id: menuTreeView
            width: parent.width - menuIndentation
            contentWidth: width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            // The model needs to be a QAbstractItemModel
            model: menuModelTree

            property var actions : {
                "Формирование чека":        function() { rootStack.pop(null) },
                "Чеки":                     function() {
                    modelPurchasesStorage.init()
                    root.replacePage("qrc:/qml/pages/subpages/PurchasesStorage.qml")
                },
                "Подключение ККТ":          function() { root.replacePage("qrc:/qml/pages/subpages/printer/ChoosePrinterType.qml") },
                "Подключение сканера":      function() { root.replacePage("qrc:/qml/pages/subpages/settings/BarcodeScannerConnection.qml") },
                "Подключение весов":        function() { console.log("connect scales button was pressed") /*root.replacePage("qrc:/qml/pages/subpages/settings/ScalesConnection.qml")*/ },
                "Дримкас Дисплей":          function() { root.replacePage(dreamkasDisplay.getIsSetUp() ? "qrc:/qml/pages/subpages/dreamkas_display/ConnectionInfo.qml" :
                                                                                                         "qrc:/qml/pages/subpages/dreamkas_display/Welcome.qml") },
                "Открыть смену":            function() { root.openShiftDialog() },
                "Закрыть смену":            function() {
                    root.closeShiftDialog()
                    rootStack.pop(null)
                },
                "Кабинет Дримкас":          function() {
                    if (root.isCabinetEnable) {
                        root.replacePage("qrc:/qml/pages/subpages/cabinet/CabinetConnection.qml")
                    } else {
                        root.openPage("qrc:/qml/pages/subpages/cabinet/CabinetConnectionTypeChoose.qml")
                    }
                },
                "Изъять или внести":        function() { root.replacePage("qrc:/qml/pages/subpages/InsResTabs.qml") },
                "Чек коррекции":            function() { root.replacePage("qrc:/qml/pages/subpages/PurchaseCorrection.qml") },
                "СНО и НДС":                function() { root.replacePage("qrc:/qml/pages/subpages/DefaultSno.qml") },
                "X-отчёт":                  function() { root.openXReportDialog() },
                "Отчёт о тек. расчётах":    function() { root.openCalcStateReportDialog() },
                "Технический отчёт":        function() { root.openTechReportDialog() },
                "Отправка логов":           function() { root.replacePage("qrc:/qml/pages/subpages/SendScreen.qml")  },
                "Пользователи":             function() { root.replacePage("qrc:/qml/pages/subpages/users/UsersPage.qml") },
                "Подключение":              function() { root.replacePage("qrc:/qml/pages/subpages/settings/Multipos.qml") },
                "Сервисные операции":       function() { root.replacePage("qrc:/qml/pages/subpages/settings/MultiposService.qml") },
                "ЕГАИС":                    function() { root.replacePage("qrc:/qml/pages/subpages/Utm.qml") },
                "Разливное пиво":           function() { root.replacePage("qrc:/qml/pages/subpages/Beer.qml") },
                "Правила торговли":         function() { root.replacePage("qrc:/qml/pages/subpages/SaleRules.qml") }
            }

            delegate: Item {
                id: treeDelegate
                implicitWidth: parent.width
                implicitHeight: 0.07 * menuBar.height
                clip: true

                readonly property real indent: 20
                readonly property real padding: 0

                // Assigned to by TreeView:
                required property TreeView treeView
                required property bool isTreeNode
                required property bool expanded
                required property int hasChildren
                required property int depth

                property bool isHighlighted: modelIsHighlighted
                property bool isFirstHighlighted: modelIsFirstHighlighted
                property bool isLastHighlighted: modelIsLastHighlighted

                onIsHighlightedChanged: {
                    itemFrame.color = isHighlighted ? "#F3F4F6" : "transparent"
                    itemFrame.opacity = isHighlighted ? 0.9 : 1
                }

                onIsFirstHighlightedChanged: {
                    itemFrame.radius = (isFirstHighlighted ? 12 : 0)
                    itemFrame.anchors.bottomMargin = (isFirstHighlighted ? -itemFrame.radius : 0)
                    itemFrame.opacity = isFirstHighlighted ? 0.9 : 1
                }

                onIsLastHighlightedChanged: {
                    itemFrame.radius = (isLastHighlighted ? 12 : 0)
                    itemFrame.anchors.topMargin = (isLastHighlighted ? -itemFrame.radius : 0)
                    itemFrame.opacity = isLastHighlighted ? 0.9 : 1
                }

                Rectangle {
                    id: itemFrame
                    anchors.fill: parent

                    Row {
                        id: menuItem
                        leftPadding: 0.5 * menuBarColumn.leftPadding +
                                     padding +
                                     (treeDelegate.isTreeNode ? treeDelegate.depth * treeDelegate.indent : 0)
                        spacing: 0.3 * menuItemFrame.width
                        anchors.verticalCenter: parent.verticalCenter

                        TapHandler {
                            onTapped: {
                                let hasChildren = treeDelegate.hasChildren
                                let curRow = row

                                if (hasChildren) {
                                    if (treeView.isExpanded(curRow)) {
                                        treeView.collapseRecursively(curRow)
                                    } else {
                                        treeView.expand(curRow)

                                        if (modelIsRootItem) {
                                            collapseOpenedMenuExcludeRow(curRow)
                                        }
                                    }
                                } else {
                                    drawer.close()
                                    menuTreeView.actions[menuModelTree.data(menuModelTree.index(curRow, 0), ModelEnum.NameRole)]()

                                    if (modelIsRootItem) {
                                        collapseOpenedMenuExcludeRow(row)
                                    }
                                }

                                updateMenu()
                            }
                        }

                        Rectangle {
                            id: menuItemFrame
                            height: 1.35 * menuItemName.font.pixelSize
                            width: height
                            anchors.verticalCenter: menuItem.verticalCenter
                            color: "transparent"

                            Image {
                                id: icon
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                                source: modelIcon
                            }

                            Rectangle {
                                width: 0.5 * parent.width
                                height: width
                                visible: modelAppliedAvailable
                                radius: width / 2
                                anchors {
                                    right: menuItemFrame.right
                                    bottom: menuItemFrame.bottom
                                }
                                color: modelApplied ? "#4DA03F" : "#F7AA13"
                            }
                        }

                        Label {
                            id: menuItemName
                            width: treeDelegate.width -
                                   treeDelegate.padding -
                                   parent.leftPadding -
                                   menuItemFrame.width -
                                   2 * parent.spacing -
                                   expandArrow.width -
                                   0.5 * menuBarColumn.leftPadding
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr(modelName)
                            font {
                                pixelSize: 0.95 * userName.font.pixelSize
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            clip: true
                            color: "black"
                            elide: Label.ElideRight
                            lineHeight: 1.1
                            maximumLineCount: 2
                            wrapMode: Label.WordWrap
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignVCenter
                        }

                        Image {
                            id: expandArrow
                            width: 25
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            visible: treeDelegate.isTreeNode && treeDelegate.hasChildren
                            source: "qrc:/ico/menu/arrow_down.png"
                            rotation: treeDelegate.expanded ? 180 : 0
                        }
                    }
                }
            }
        }
    }
}
