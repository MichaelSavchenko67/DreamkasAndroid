import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/pages/subpages" as Subpages

Page {
    onFocusChanged: {
        if (focus) {
            console.log("[InsResTabs.qml]\tfocus changed: " + focus)
            setMainPageTitle("Изъятие")
            setLeftMenuButtonAction(back)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            clearContextMenu()
            setToolbarVisible(true)
        }
    }

    header: TabBar {
        id: tabBar
        width: root.width
        height: 0.0898 * width
        currentIndex: tabStack.currentIndex

        contentData: Repeater {
            id: tabs
            model: ["ИЗЪЯТИЕ", "ВНЕСЕНИЕ"]

            TabButton {
                height: parent.height
                width: abBar.width / 2

                Label {
                    anchors.fill: parent
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
            let isInsert = (currentIndex != 0)
            setMainPageTitle(isInsert ? "Внесение" : "Изъятие")
            insResPage.isInsert = isInsert
        }
    }

    contentData: Subpages.InsRes {
        id: insResPage
        isInsert: false
    }
}
