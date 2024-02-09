import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Popup {
    id: popupChooseTap

    property var popupModel

    signal tapChoosen(int index)

    width: 0.9 * parent.width
    height: ((tapsListView.visible && (popupModel.count > 1)) ? 1.35 : 0.775) * width
    parent: Overlay.overlay
    x: Math.round((root.width - width) / 2)
    y: Math.round((root.height - height) / 2)
    modal: true
    focus: true
    closePolicy: Popup.CloseOnPressOutside
    background: Rectangle {
        id: popupFrame
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
                topMargin: 0.5 *  0.038 * parent.height
                right: parent.right
                rightMargin: 0.5 *  0.038 * parent.height
            }
            icon {
                color: "#979797"
                height: 0.038 * 0.9 * parent.width
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                popupChooseTap.close()
            }
        }

        Column {
            id: mainColumn
            width: parent.width - 2 * titleLabel.font.pixelSize
            height: parent.height -
                    exitButton.height -
                    exitButton.anchors.topMargin
            anchors {
                top: exitButton.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: titleLabel.font.pixelSize
            bottomPadding: spacing

            Label {
                id: titleLabel
                width: tapsListView.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Выберите кран")
                font {
                    pixelSize: 0.08 * 0.9 * enterTextPopup.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                clip: true
                elide: "ElideRight"
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }

            ListView {
                id: tapsListView
                width: 0.9 * parent.width
                height: parent.height -
                        titleLabel.contentHeight -
                        buttonsColumn.height -
                        3 * parent.spacing
                visible: (count > 0)
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                interactive: (count * tapDelegate.height > height)
                model: popupModel
                delegate: ItemDelegate {
                    width: tapsListView.width - scroll.width
                    height: tapDelegate.height

                    Column {
                        id: tapDelegate
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter

                        Column {
                            id: tapInfoColumn
                            width: parent.width
                            spacing: 0.5 * tapNameLabel.font.pixelSize
                            topPadding: spacing
                            bottomPadding: topPadding

                            Label {
                                id: tapNameLabel
                                width: parent.width
                                text: qsTr("Кран №" + model.name)
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                font {
                                    pixelSize: 0.8 * titleLabel.font.pixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Bold
                                    bold: true
                                }
                                elide: Label.ElideRight
                            }

                            Label {
                                id: tapItemNameLabel
                                width: parent.width
                                text: qsTr(model.itemName)
                                horizontalAlignment: tapNameLabel.horizontalAlignment
                                verticalAlignment: tapNameLabel.verticalAlignment
                                font {
                                    pixelSize: 0.8 * tapNameLabel.font.pixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Bold
                                    bold: true
                                }
                                maximumLineCount: 3
                                elide: Label.ElideRight
                                wrapMode: Label.WordWrap
                            }

                            Column {
                                id: tapDescriptionColumn
                                width: parent.width
                                spacing: 0.5 * parent.spacing

                                Label {
                                    id: tapVolumeLabel
                                    width: parent.width
                                    text: qsTr("Объём: " + (model.litersLeft + model.litersSold) + " л")
                                    horizontalAlignment: tapNameLabel.horizontalAlignment
                                    verticalAlignment: tapNameLabel.verticalAlignment
                                    font {
                                        pixelSize: 0.8 * tapNameLabel.font.pixelSize
                                        family: "Roboto"
                                        styleName: "normal"
                                        weight: Font.Normal
                                    }
                                    color: "#979797"
                                    elide: Label.ElideRight
                                }

                                Label {
                                    id: tapVolumeLeftLabel
                                    width: parent.width
                                    text: qsTr("Остаток в кеге: " + model.litersLeft + " л")
                                    horizontalAlignment: tapNameLabel.horizontalAlignment
                                    verticalAlignment: tapNameLabel.verticalAlignment
                                    font: tapVolumeLabel.font
                                    color: tapVolumeLabel.color
                                    elide: tapVolumeLabel.elide
                                }

                                Label {
                                    id: tapExpireDateLabel
                                    width: parent.width
                                    text: qsTr("Годен до: " + model.expireDate + (model.isExpired ? " (истёк)" : ""))
                                    horizontalAlignment: tapNameLabel.horizontalAlignment
                                    verticalAlignment: tapNameLabel.verticalAlignment
                                    font: tapVolumeLabel.font
                                    color: model.isExpired ? "red" : tapVolumeLabel.color
                                    elide: Label.ElideRight
                                }
                            }
                        }

                        SaleComponents.Line {
                            visible: model.index < (tapsListView.count - 1)
                        }
                    }

                    onClicked: {
                        tapChoosen(model.index)
                        popupChooseTap.close()
                    }
                }
                ScrollBar.vertical: ScrollBar {
                    id: scroll
                    policy: ScrollBar.AsNeeded
                    width: 8
                }
            }

            Label {
                id: tapsNotFound
                height: tapsListView.height
                anchors.horizontalCenter: parent.horizontalCenter
                visible: !tapsListView.visible
                text: qsTr("Краны не найдены")
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                font {
                    pixelSize: titleLabel.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "#979797"
                elide: Label.ElideRight
            }

            Column {
                id: buttonsColumn
                width: 0.9 * parent.width
                spacing: 0.5 * parent.spacing
                anchors.horizontalCenter: parent.horizontalCenter

                SaleComponents.Button_1 {
                    id: createTapButton
                    width: cancelButton.width
                    height: cancelButton.height
                    borderWidth: 1
                    backRadius: cancelButton.backRadius
                    buttonTxt: qsTr("НОВЫЙ КРАН")
                    fontSize: cancelButton.fontSize
                    buttonTxtColor: "#415A77"
                    pushUpColor: "#FFFFFF"
                    pushDownColor: "#F2F2F2"
                    onClicked: {
                        tapChoosen(-1)
                        popupChooseTap.close()
                    }
                }

                SaleComponents.Button_1 {
                    id: cancelButton
                    width: parent.width
                    height: 0.16 * width
                    borderWidth: 0
                    backRadius: 8
                    buttonTxt: qsTr("ОТМЕНА")
                    fontSize: 0.27 * height
                    buttonTxtColor: "white"
                    pushUpColor: "#415A77"
                    pushDownColor: "#004075"
                    onClicked: {
                        popupChooseTap.close()
                    }
                }
            }
        }
    }
}
