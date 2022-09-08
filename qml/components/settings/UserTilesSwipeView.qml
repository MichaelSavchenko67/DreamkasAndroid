import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import "qrc:/qml/components/settings" as SettingsComponents

Column {
    id: userTiles
    width: parent.width
    spacing: indicator.implicitHeight

    signal createUser()
    signal userChoosen()

    function goIn() {
        userTilesSwipeViewGoIn.start()
    }

    function getCount() {
        return userTilesSwipeView.count
    }

    Rectangle {
        id: frame
        width: parent.width
        height: parent.height - indicator.implicitHeight - parent.spacing

        Timer {
            id: initUserTileDelay
            interval: 300
            running: false
            repeat: false
            onTriggered: {
                userTilesSwipeView.currentIndex = userTilesSwipeView.count / 2
            }
        }

        SwipeView {
            id: userTilesSwipeView
            width: parent.width - 5 * 0.0625 * 0.741 * frame.width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.0
            currentIndex: 0

            Repeater {
                model: modelDemoSwipe

                Rectangle {
                    border.width: 0.5 * 0.0625 * 0.741 * frame.width
                    border.color: "transparent"
                    color: "transparent"

                    SettingsComponents.UserTile {
                        width: parent.width - 2 * parent.border.width
                        height: 0.67 * width
                        anchors.centerIn: parent
                        onCreateUser: {
                            userTiles.createUser()
                        }
                        onUserChoosen: {
                            userTiles.userChoosen()
                        }
                    }
                }
            }

            OpacityAnimator {
                id: userTilesSwipeViewGoIn
                target: userTilesSwipeView
                running: false
                duration: 350
                from: 0.0
                to: 1.0
                onFinished: {
                    initUserTileDelay.start()
                }
            }
        }
    }

    PageIndicator {
        id: indicator
        anchors.horizontalCenter: parent.horizontalCenter
        count: userTilesSwipeView.count
        visible: (count > 1)
        currentIndex: userTilesSwipeView.currentIndex
        delegate: Rectangle {
            id: delegateRect
            implicitWidth: (index === userTilesSwipeView.currentIndex) ? 10 : 6
            implicitHeight: implicitWidth
            anchors.verticalCenter: parent.verticalCenter
            radius: width / 2
            color: "#0064B4"
            opacity: (index === userTilesSwipeView.currentIndex) ? 0.95 : pressed ? 0.7 : 0.45

            Behavior on opacity {
                OpacityAnimator {
                    duration: 100
                }
            }
        }
    }
}


