import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/pages/subpages" as Subpages

Page {
    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Плати QR от Сбера")
            setLeftMenuButtonAction(back)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            clearContextMenu()
            setToolbarVisible(true)
            footerMainModel.setState("Off")
        }
    }

    header: TabBar {
        id: tabBar
        width: root.width
        height: 0.0898 * width
        currentIndex: tabStack.currentIndex

        contentData: Repeater {
            id: tabs
            model: ["ПОКАЗАТЬ QR", "СЧИТАТЬ QR КЛИЕНТА"]

            TabButton {
                height: parent.height
                width: tabBar.width / 2

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
        }
    }
    contentData: SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        onCurrentIndexChanged: {
            tabBar.currentIndex = currentIndex
        }

        Subpages.PayQrSberbankCreate {

        }

        Page {
            Label {
                anchors.centerIn: parent
                text: "СЧИТАТЬ QR КЛИЕНТА"
            }
        }
    }

    PageIndicator {
        id: indicator
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 0.5 * height
        }
        count: swipeView.count
        currentIndex: swipeView.currentIndex
        delegate: Rectangle {
            id: delegateRect
            implicitWidth: (index === swipeView.currentIndex) ? 10 : 6
            implicitHeight: implicitWidth
            anchors.verticalCenter: parent.verticalCenter
            radius: width / 2
            color: "#0064B4"
            opacity: (index === swipeView.currentIndex) ? 0.95 : pressed ? 0.7 : 0.45

            Behavior on opacity {
                OpacityAnimator {
                    duration: 100
                }
            }
        }
    }
}
