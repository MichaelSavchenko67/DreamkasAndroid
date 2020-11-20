import QtQuick 2.12
import QtQuick.Controls 2.3

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    property var titleMsg
    property var addMsg
    property var firsButtonName
    property var secondButtonName

    function setFirstButtonAction(action) {
        fisrtButton.action = action
    }

    function setSecondButtonAction(action) {
        secondButton.action = action
    }

    width: 0.9 * parent.width
    height: 0.5 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    background: Rectangle {
        id: popupFrame
        radius: 8
        color: "#FFFFFF"

        Column {
            width: 0.85 * parent.width
            height: 0.9 * parent.height
            anchors.centerIn: parent
            spacing: 0.25 * msg.font.pixelSize

            Text {
                id: title
                width: parent.width
                height: 0.3 * parent.height
                text: (titleMsg !== "undefined") ? qsTr(titleMsg) : ""
                clip: true
                font {
                    pixelSize: 0.15 * parent.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }

            Text {
                id: msg
                width: title.width
                height: 0.4 * parent.height
                clip: title.clip
                text: (addMsg !== "undefined") ? qsTr(addMsg) : ""
                font {
                    pixelSize: 0.67 * title.font.pixelSize
                    family: title.font.family
                    styleName: title.font.styleName
                    weight: Font.Normal
                }
                color: "#AA000000"
                elide: title.elide
                maximumLineCount: 3
                wrapMode: Text.WordWrap
                horizontalAlignment: title.horizontalAlignment
                verticalAlignment: Qt.AlignTop
            }
        }

        Row {
            width: 0.9 * parent.width
            height: 0.17 * parent.height
            anchors {
                bottom: popupFrame.bottom
                bottomMargin: 0.183 * popupFrame.height
                right: parent.right
                rightMargin: parent.width - width
            }

            SaleComponents.ButtonPopup {
                id: fisrtButton
                width: 0.5 * parent.width
                height: parent.height
                visible: (txt !== "undefined") && (txt.length > 0)
                anchors.right: parent.right
                txt: firsButtonName
            }

            SaleComponents.ButtonPopup {
                id: secondButton
                width: fisrtButton.width
                height: fisrtButton.height
                visible: (txt !== "undefined") && (txt.length > 0)
                anchors.right: fisrtButton.visible ? fisrtButton.left : parent.right
                txt: secondButtonName
            }
        }
    }
}
