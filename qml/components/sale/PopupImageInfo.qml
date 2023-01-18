import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupImageInfo

    property url imageSource: ""
    property string textInfo: ""
    property string textNote: ""
    property color titleColor: "#555555"
    property var isTitleBold: false
    property color subtitleColor: "#0064B4"
    property real subtitleOpacity: 0.0

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
                height: 0.038 * 0.9 * parent.width
                source: "qrc:/ico/menu/close.png"
            }

            onClicked: {
                popupImageInfo.close()
            }
        }

        Column {
            width: parent.width - 2 * spacing
            height: parent.height - exitButton.icon.height
            anchors {
                top: exitButton.bottom
                topMargin: 0.5 * exitButton.icon.height
                horizontalCenter: parent.horizontalCenter
            }
            spacing: labelTextInfo.font.pixelSize


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
                width: parent.width - 2 * parent.spacing
                font {
                    pixelSize: 1.25 * buttonEnter.fontSize
                    family: "Roboto"
                    styleName: isTitleBold ? "bold" : "normal"
                    weight: Font.Normal
                    bold: isTitleBold
                }
                elide: Label.ElideRight
                maximumLineCount: 2
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: titleColor

            }

            Label {
                id: labelTextNote
                anchors.horizontalCenter: parent.horizontalCenter
                text: (textNote !== "undefined") ? qsTr(textNote) : ""
                width: parent.width - (2 * parent.spacing)
                font {
                    pixelSize: 0.9 * labelTextInfo.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                elide: Label.ElideRight
                maximumLineCount: 3
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: subtitleColor
                opacity: subtitleOpacity
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
                    popupImageInfo.close()
                }
            }
        }
    }
}
