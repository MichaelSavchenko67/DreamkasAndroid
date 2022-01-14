import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupText
    property var titleStr: "ЗАГОЛОВОК"
    property var textStr: ""
    property var confirmButtonAction

    width: 0.963 * parent.width
    height: 1.5 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    background: Rectangle {
        id: popupFrame
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"

        ColumnLayout {
            width: popupText.width
            height: popupText.height
            Layout.alignment: Qt.AlignCenter
            spacing: 0.25 * exitButton.icon.height

            ToolButton {
                id: exitButton
                Layout.alignment: Qt.AlignRight
                Layout.topMargin: 2 * parent.spacing
                icon {
                    color: "#979797"
                    height: 0.038 * parent.height
                    source: "qrc:/ico/menu/close.png"
                }
                onClicked: {
                    popupText.close()
                }
            }

            Label {
                id: titleLabel
                visible: (text.length > 0)
                Layout.preferredWidth: 0.9 * popupText.width
                Layout.alignment: Qt.AlignCenter
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
                Layout.preferredWidth: titleLabel.width
                Layout.preferredHeight: parent.height -
                                        titleLabel.contentHeight -
                                        exitButton.height -
                                        confirmButton.height -
                                        (titleLabel.visible ? 7 : 6) * parent.spacing
                Layout.alignment: Qt.AlignCenter
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.vertical.width: 8

                Label {
                    id: textLabel
                    width: titleLabel.width
                    topPadding: font.pixelSize
                    text: qsTr(textStr)
                    elide: Label.ElideRight
                    maximumLineCount: 1000
                    wrapMode: Label.WordWrap
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    color: "black"
                    font {
                        pixelSize: 0.8 * confirmButton.fontSize
                        weight: Font.Normal
                    }
                }
            }

            SaleComponents.Button_1 {
                id: confirmButton
                Layout.preferredWidth: titleLabel.width
                Layout.preferredHeight: 0.18 * width
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 2 * parent.spacing
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr(action.text)
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: enabled ? "#415A77" : "#BDC3C7"
                pushDownColor: "#004075"
                action: confirmButtonAction
            }
        }
    }
}
