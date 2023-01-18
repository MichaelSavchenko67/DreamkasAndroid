import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Popup {

    property int startTime
    property int finishTime

    signal entered(int start, int finish)

    function verifyTimeSet() {
        if (startTime === 0 && finishTime === 0)
            return

        if (finishTime >= 0 && finishTime < 10)
            finishTime = 23

        if (startTime >= finishTime) {

            if (finishTime === 0 ) {
                startTime = 23
            }
            else {
                startTime = (finishTime - 1)
            }

            tumblerStart.currentIndex = startTime
        }
    }

    id: popupTumbler
    width: 0.963 * parent.width
    height: width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle {
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                topMargin: 0.5 * 0.038 * parent.height
                right: parent.right
                rightMargin: 0.5 *  0.038 * parent.height
            }
            icon {
                color: "#979797"
                height: 0.05 * parent.height
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                popupTumbler.close()
            }
        }

        Column {
            width: parent.width
            height: parent.height - exitButton.icon.height
            anchors {
                top: exitButton.bottom
                topMargin: 0.5 * exitButton.icon.height
            }
            spacing: exitButton.icon.height

            Row {
                width: parent.width
                height: parent.height - 2 * buttonEnter.height - parent.spacing

                Column {
                    width: 0.5 * parent.width
                    height: parent.height

                    Row {
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }

                        SettingsComponents.CustomTumbler {
                            id: tumblerStart
                            model: 24
                            currentIndex: startTime

                            onCurrentIndexChanged: {
                                console.log("RECEIVE INDEX: " + currentIndex)
                                startTime = currentIndex
                                verifyTimeSet()
                            }
                        }

                        Label {
                            text: ": 00"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                Column {
                    width: 0.5 * parent.width
                    height: parent.height

                    Row {
                        anchors {
                            left: parent.left
                            leftMargin: 0.15 * parent.width
                            verticalCenter: parent.verticalCenter
                        }
                        SettingsComponents.CustomTumbler {
                            id: tumblerFinish
                            model: 24
                            currentIndex: finishTime
                            onCurrentIndexChanged: {
                                finishTime = currentIndex
                                verifyTimeSet()
                            }
                        }

                        Label {
                            text: ": 00"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }

            SaleComponents.Button_1 {
                id: buttonEnter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.25 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt:
                {
                    ("Установить время\n"
                     + (startTime < 10 ? "0%1" : "%1") + ":00 - " + (finishTime < 10 ? "0%2" : "%2") + ":00").arg(startTime).arg(finishTime)
                }
                fontSize: 0.2 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    entered(startTime, finishTime)
                    popupTumbler.close()
                }
            }
        }
    }
}
