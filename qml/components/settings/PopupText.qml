import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupText
    property var titleStr: ""
    property var textStr: ""
    property var confirmButtonAction
    property var confirmButtonName: ""

    width: 0.963 * parent.width
    height: 1.5 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    closePolicy: Popup.NoAutoClose
    modal: true
    focus: true
    background: Rectangle {
        id: popupFrame
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                topMargin: 0.019 * parent.width
                right: parent.right
                rightMargin: 0.019 * parent.width
            }
            icon {
                color: "#979797"
                height: 0.049 * parent.width
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                popupText.close()
            }
        }

        Column {
            width: 0.9 * parent.width
            anchors {
                top: exitButton.bottom
                horizontalCenter: parent.horizontalCenter
            }
            height: parent.height - exitButton.height - 2 * 0.019 * parent.width
            spacing: 0.25 * exitButton.height

            Label {
                id: titleLabel
                visible: (text.length > 0)
                width: 0.8 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr(titleStr)
                elide: Label.ElideRight
                maximumLineCount: 2
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                color: "black"
                font {
                    pixelSize: confirmButton.fontSize
                    weight: Font.DemiBold
                    bold: true
                }
            }

            ScrollView {
                width: textLabel.contentWidth
                contentWidth: width
                height: popupText.height -
                        titleLabel.contentHeight -
                        confirmButton.height -
                        (titleLabel.visible ? 7 : 6) * parent.spacing
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.vertical.width: 8

                Label {
                    id: textLabel
                    topPadding: font.pixelSize
                    text: "<pre>" + qsTr(textStr) + "</pre>"
                    font {
                        family: fixedFont
                        pixelSize: 0.75 * confirmButton.fontSize
                        weight: Font.Normal
                    }
                    elide: Label.ElideRight
                    maximumLineCount: 1000
                    wrapMode: Label.WordWrap
                    color: "black"
                    horizontalAlignment: Label.AlignLeft
                }
            }

            SaleComponents.Button_1 {
                id: confirmButton
                width: parent.width
                height: 0.18 * width
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 2 * parent.spacing
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr(confirmButtonName)
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: enabled ? "#415A77" : "#BDC3C7"
                pushDownColor: "#004075"
                action: confirmButtonAction
            }
        }
    }
}
