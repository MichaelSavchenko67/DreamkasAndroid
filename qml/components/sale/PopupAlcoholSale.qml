import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    property url imageSource
    property string textInfo
    property string textNote
    property bool alcoCode: false

    onOpened: {
//        setChangeStateScaner(true)
//        setActiveScaner(alcoCode)
//        setAddPosition(false)
    }

    onAboutToHide: {
//        setChangeStateScaner(false)
//        setAddPosition(true)
//        modelUtm.closePopupFromFront()
    }

    id: popupAlcSale
    width: 0.9 * parent.width
    height: 1.3 * width
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
                height: 0.03 * parent.height
                source: "qrc:/ico/menu/close.png"
            }

            onClicked: {
                popupAlcSale.close()
            }
        }

        Column {
            width: parent.width - spacing
            height: parent.height - exitButton.icon.height
            anchors {
                top: exitButton.bottom
                topMargin: 0.5 * exitButton.icon.height
            }
            spacing: 0.6 * exitButton.icon.height


            Image {
                id: image
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.5
                height: width
                fillMode: Image.PreserveAspectFit
                source: imageSource
            }

            Label {
                id: labelTextInfo
                anchors.horizontalCenter: parent.horizontalCenter
                text: (textInfo !== "undefined") ? qsTr(textInfo) : ""
                width: parent.width - (2 * parent.spacing)
                font {
                    pixelSize: buttonEnter.fontSize * 1.05
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                elide: Label.ElideRight
                maximumLineCount: 2
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#555555"

            }

            Label {
                id: labelTextNote
                anchors.horizontalCenter: parent.horizontalCenter
                text: (textNote !== "undefined") ? qsTr(textNote) : ""
                width: parent.width - (2 * parent.spacing)
                font {
                    pixelSize: buttonEnter.fontSize * 1.2
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                elide: Label.ElideRight
                maximumLineCount: 3
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
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
                fontSize: 0.3 * height
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
