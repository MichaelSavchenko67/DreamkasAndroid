import QtQuick
import QtQuick.Controls

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"

    property bool isRunning: false
    signal complited()

    Timer {
        id: exitDelay
        interval: 300
        repeat: false
        running: false
        onTriggered: {
            complited()
        }
    }

    Image {
        id: phoneMarket
        source: "qrc:/img/loading_page/phone_market.png"
        width: 0.8 * parent.width
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit

        Row {
            id: food
            width: cartFrame.width
            anchors.horizontalCenter: cart.horizontalCenter
            x: 0.36 * phoneMarket.width

            Image {
                id: food_2
                source: "qrc:/img/loading_page/food_2.png"
                width: 0.3 * parent.width
                fillMode: Image.PreserveAspectFit
                y: 0.35 * phoneMarket.height
                opacity: 0.0

                OpacityAnimator {
                    target: food_2
                    from: 0.0;
                    to: 1.0;
                    duration: 200
                    running: isRunning
                }

                NumberAnimation on y
                {
                    running: (food_2.opacity == 1.0)
                    from: 0.35 * phoneMarket.height
                    to: phoneMarket.height - 1.325 * cart.height
                    duration: 500
                    easing.type: Easing.Linear
                    onFinished: {
                        createFood_3.start()
                    }
                }
            }

            Image {
                id: food_3
                source: "qrc:/img/loading_page/food_3.png"
                width: 0.2 * parent.width
                fillMode: Image.PreserveAspectFit
                y: 0.35 * phoneMarket.height
                opacity: 0.0

                OpacityAnimator {
                    id: createFood_3
                    running: false
                    target: food_3
                    from: 0.0;
                    to: 1.0;
                    duration: 200
                }

                NumberAnimation on y
                {
                    running: (food_3.opacity == 1.0)
                    from: 0.35 * phoneMarket.height
                    to: phoneMarket.height - 1.325 * cart.height
                    duration: 500
                    easing.type: Easing.Linear
                    onFinished: {
                        createFood_1.start()
                    }
                }
            }

            Image {
                id: food_1
                source: "qrc:/img/loading_page/food_1.png"
                width: 0.2 * parent.width
                fillMode: Image.PreserveAspectFit
                y: 0.35 * phoneMarket.height
                opacity: 0.0

                OpacityAnimator {
                    id: createFood_1
                    running: false
                    target: food_1
                    from: 0.0;
                    to: 1.0;
                    duration: 200
                }

                NumberAnimation on y
                {
                    running: (food_1.opacity == 1.0)
                    from: 0.35 * phoneMarket.height
                    to: phoneMarket.height - 1.3 * cart.height
                    duration: 500
                    easing.type: Easing.Linear
                    onFinished: {
                        exitDelay.start()
                    }
                }
            }
        }

        Rectangle {
            id: cartFrame
            width: 0.5 * parent.width
            height: cart.height + 0.5 * leftWheel.height
            anchors {
                left: parent.left
                leftMargin: 0.425 * width
                bottom: parent.bottom
                bottomMargin: 0.15 * phoneMarket.height
            }
            color: "transparent"

            Image {
                id: cart
                source: "qrc:/img/loading_page/cart_without_wheels.png"
                width: parent.width
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: leftWheel
                source: "qrc:/img/loading_page/cart_left_wheel.png"
                width: 0.177 * cartFrame.width
                fillMode: Image.PreserveAspectFit
                anchors {
                    bottom: cartFrame.bottom
                    left: cartFrame.left
                    leftMargin: 0.325 * cartFrame.width
                }

                RotationAnimation on rotation {
                    loops: Animation.Infinite
                    duration: 700
                    from: 0
                    to: 360
                    easing.type: Easing.Linear
                }
            }

            Image {
                id: rightWheel
                source: "qrc:/img/loading_page/cart_right_wheel.png"
                width: 0.152 * cartFrame.width
                fillMode: Image.PreserveAspectFit
                anchors {
                    bottom: cartFrame.bottom
                    right: cartFrame.right
                    rightMargin: 0.1 * cartFrame.width
                }

                RotationAnimation on rotation {
                    loops: Animation.Infinite
                    duration: 700
                    from: 0
                    to: 360
                    easing.type: Easing.Linear
                }
            }
        }
    }
}
