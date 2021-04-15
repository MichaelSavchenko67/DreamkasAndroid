import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Popup {
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

        Column {
            id: rootFrame
            anchors.fill: parent

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


            Row {
                width: parent.width
                height: parent.height - exitButton.height - topPadding - buuton.height
                topPadding: 1.5 * exitButton.height

                Column {
                    width: 0.5 * parent.width
                    height: parent.height

                    Row {
                        anchors.centerIn: parent
                        SettingsComponents.CustomTumbler {
                            model: 24
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
                        anchors.centerIn: parent
                        SettingsComponents.CustomTumbler {
                            model: 24
                        }

                        Label {
                            text: ": 00"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }

            SaleComponents.Button_1 {
                id: buuton
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.2 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: "12:00 - 23:00"
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    popupTumbler.close()
                }
            }
        }
    }
}
//}
