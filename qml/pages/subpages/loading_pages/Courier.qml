import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: parent.width
    height: parent.height
    x: -parent.width
    color: "transparent"

    property bool isRunning: false
    signal complited()

    Image {
        id: road
        source: "qrc:/img/loading_page/road.png"
        width: 0.95 * parent.width
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit

        Column {
            id: cloudsColumn
            width: road.width
            spacing: 0.1 * cloud.height
            topPadding: 2 * spacing
            opacity: 0.0

            Image {
                id: cloud
                source: "qrc:/img/loading_page/cloud_1.png"
                width: 0.3 * parent.width
                fillMode: Image.PreserveAspectFit
            }

            Image {
                source: "qrc:/img/loading_page/cloud_2.png"
                width: 0.2 * parent.width
                x: 0.8 * parent.width
                fillMode: Image.PreserveAspectFit
            }

            Image {
                source: "qrc:/img/loading_page/cloud_3.png"
                width: 0.1 * parent.width
                x: 0.5 * parent.width
                fillMode: Image.PreserveAspectFit
            }

            OpacityAnimator {
                target: cloudsColumn
                from: 0.0;
                to: 1.0;
                duration: 300
                running: isRunning
            }

            NumberAnimation on x
            {
                loops: Animation.Infinite
                from: root.width
                to: -root.width
                duration: 2500
                easing.type: Easing.Linear
            }
        }
    }

    Rectangle {
        id: bikeFrame
        width: 0.7 * parent.width
        height: bike.height + 0.05 * leftWheel.height
        anchors.centerIn: parent
        color: "transparent"

        Image {
            id: leftWheel
            source: "qrc:/img/loading_page/left_wheel.png"
            width: 0.212 * bikeFrame.width
            fillMode: Image.PreserveAspectFit
            anchors {
                bottom: bikeFrame.bottom
                left: bikeFrame.left
                leftMargin: 0.3 * width
            }

            RotationAnimation on rotation {
                loops: Animation.Infinite
                duration: 300
                from: 0
                to: 360
                easing.type: Easing.Linear
            }
        }

        Image {
            id: rightWheel
            source: "qrc:/img/loading_page/right_wheel.png"
            width: 0.223 * bikeFrame.width
            fillMode: Image.PreserveAspectFit
            anchors {
                bottom: bikeFrame.bottom
                right: bikeFrame.right
            }

            RotationAnimation on rotation {
                loops: Animation.Infinite
                duration: 300
                from: 0
                to: 360
                easing.type: Easing.Linear
            }
        }

        Timer {
            interval: bikeRotation.duration
            repeat: true
            running: isRunning
            onTriggered: {
                complited()
            }
        }

        Image {
            id: bike
            source: "qrc:/img/loading_page/bike_without_wheels.png"
            width: parent.width
            fillMode: Image.PreserveAspectFit

            RotationAnimation on rotation
            {
                id: bikeRotation
                loops: Animation.Infinite
                from: -0.05 * leftWheel.height
                to: 0.05 * leftWheel.height
                duration: 1500
                easing.type: Easing.CosineCurve
            }
        }
    }
}
