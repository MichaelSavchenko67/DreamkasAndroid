import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: root
//    width: Screen.width
//    height: Screen.height
    width: 540
    height: 960
    visible: true

    Action {
        id: openMenu
        onTriggered: {
            console.log("[main.qml]\tOpen menu")
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

    Menu {
        id: rootContextMenu
        x: parent.width - width
        transformOrigin: Menu.TopRight

        onClosed: {
            itemAt(currentIndex).highlighted = false
        }
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

        return ""
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

    function setToolbarVisible(visible) {
        toolBar.visible = visible
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

            Label {
                id: headerTitle
                font {
                    pixelSize: 0.375 * parent.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
                color: "white"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
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
            color: "#4DA13F"
        }
    }

    contentData: StackView {
        id: rootStack
        initialItem: "qrc:/qml/pages/Login.qml"
        anchors.fill: parent
    }
}
