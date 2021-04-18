import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Popup {

    property var imageSource
    property var textInfo
    property var textNote

    id: popupAlcSale
    width: 0.963 * parent.width
    height: 1.2 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle {
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"

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
            spacing: 0.6 * exitButton.icon.height


            Image {
                id: image
//                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.5
                height: width
                fillMode: Image.PreserveAspectFit
                source: imageSource
            }

            Label {
                text: textInfo
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    pixelSize: 0.67 * titleLabelInfo.font.pixelSize
                }
                horizontalAlignment: Text.AlignHCenter
                color: "#555555"

            }

            Label {
                text: textNote
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    pixelSize: 1.2 * titleLabelInfo.font.pixelSize
                }
                horizontalAlignment: Text.AlignHCenter
                color: "#0064B4"

            }

            SaleComponents.Button_1 {
                id: buttonEnter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.25 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: "Продолжить"
                fontSize: 0.2 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    popupAlcSale.close()
                }
            }
        }
    }
}
