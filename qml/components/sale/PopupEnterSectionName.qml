import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.13

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: enterSectionName

    property var sectionName: "Новый раздел"

    signal entered()

    width: 0.9 * parent.width
    height: 0.75 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle {
        id: popupFrame
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                anchors.fill: popupFrame
                width: popupFrame.width
                height: popupFrame.height
                Rectangle {
                    anchors.fill: parent
                    radius: popupFrame.radius
                }
            }
        }

        Image {
            id: girl
            height: 0.9 * parent.height
            width: 0.69 * height
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            source: "qrc:/ico/settings/girl.png"
            fillMode: Image.PreserveAspectFit
        }

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                topMargin: 0.5 *  0.038 * parent.height
                right: parent.right
                rightMargin: 0.5 *  0.038 * parent.height
            }
            icon {
                color: "#979797"
                height: 0.073 * parent.height
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                enterSectionName.close()
            }
        }

        Column {
            id: rootColumn
            width: 0.618 * parent.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2.5 * title.font.pixelSize
            leftPadding: 0.5 * spacing

            Label {
                id: title
                width: parent.width
                text: qsTr(sectionName)
                font {
                    pixelSize: 0.09 * enterSectionName.height
                    family: "Roboto"
                    styleName: "medium"
                    weight: Font.Medium
                    bold: true
                }
                color: "black"
                clip: true
                elide: "ElideRight"
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }

            Column {
                width: parent.width
                spacing: title.font.pixelSize

                TextField {
                    id: valueField
                    width: parent.width
                    placeholderText: "Введите название"
                    placeholderTextColor: "#979797"
                    font {
                        pixelSize: 0.8 * title.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#0064B4"
                }

                SaleComponents.Button_1 {
                    id: connectionButton
                    width: parent.width
                    height: 0.25 * width
                    enabled: (valueField.text.length > 0)
                    opacity: enabled ? 1 : 0.6
                    borderWidth: 0
                    backRadius: 8
                    buttonTxt: qsTr("СОЗДАТЬ")
                    fontSize: 0.27 * height
                    buttonTxtColor: "white"
                    pushUpColor: "#415A77"
                    pushDownColor: "#004075"
                    onClicked: {
                        sectionName = valueField.text
                        entered()
                        enterSectionName.close()
                    }
                }
            }
        }
    }
}
