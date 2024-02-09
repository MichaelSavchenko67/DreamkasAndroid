import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupExtended

    property alias isCancelEnabled: exitButton.enabled
    property alias title: titleLabel.text
    property alias subtitle: subtitleLabel.text
    property alias description: descriptionLabel.text
    property alias running: loader.running
    property alias loaderMessage: loaderMessageLabel.text
    property alias buttonName: buttonPopup.buttonTxt
    property alias buttonAction: buttonPopup.action

    signal canceled()

    width: 0.9 * parent.width
    height: mainColumn.height + 0.1 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    background: Rectangle {
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        id: popupFrame
        anchors.fill: parent
        color: "transparent"

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                right: parent.right
            }
            icon {
                color: "#979797"
                height: 0.038 * 0.9 * popupExtended.width
                source: "qrc:/ico/menu/close.png"
            }
            opacity: enabled ? 1.0 : 0.0
            onClicked: {
                popupExtended.close()
            }
        }

        Column {
            id: mainColumn
            width: 0.9 * parent.width
            anchors.centerIn: parent
            spacing: 0.7 * titleLabel.font.pixelSize
            topPadding: 0.5 * exitButton.height

            Label {
                id: titleLabel
                visible: (text.length > 0)
                width: parent.width
                font {
                    pixelSize: 0.08 * 0.9 * popupExtended.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                elide: Label.ElideRight
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Column {
                width: parent.width
                spacing: 0.3 * parent.spacing

                Label {
                    id: subtitleLabel
                    visible: (text.length > 0)
                    width: parent.width
                    font {
                        pixelSize: 0.7 * titleLabel.font.pixelSize
                        family: titleLabel.font.family
                        styleName: titleLabel.font.styleName
                        weight: Font.DemiBold
                    }
                    elide: titleLabel.elide
                    maximumLineCount: 4
                    wrapMode: Label.WordWrap
                    lineHeight: 1.15
                    horizontalAlignment: titleLabel.horizontalAlignment
                    verticalAlignment: titleLabel.verticalAlignment
                }

                Label {
                    id: descriptionLabel
                    visible: (text.length > 0)
                    width: parent.width
                    font {
                        pixelSize: 0.5 * titleLabel.font.pixelSize
                        family: titleLabel.font.family
                        styleName: titleLabel.font.styleName
                        weight: Font.Normal
                    }
                    color: "#AA000000"
                    elide: titleLabel.elide
                    maximumLineCount: 4
                    wrapMode: Label.WordWrap
                    lineHeight: 1.25
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }
            }

            BusyIndicator {
                id: loader
                visible: running
                implicitWidth: 0.1 * popupFrame.width
                implicitHeight: implicitWidth
                anchors.horizontalCenter: parent.horizontalCenter
                running: false
                Material.accent: "#5C7490"
            }

            Label {
                id: loaderMessageLabel
                visible: (loader.visible && (text.length > 0))
                width: parent.width
                font: descriptionLabel.font
                color: descriptionLabel.color
                elide: descriptionLabel.elide
                horizontalAlignment: descriptionLabel.horizontalAlignment
                verticalAlignment: descriptionLabel.verticalAlignment
            }

            SaleComponents.Button_1 {
                id: buttonPopup
                visible: (buttonTxt.length > 0)
                width: parent.width
                height: 0.16 * width
                anchors.horizontalCenter: parent.horizontalCenter
                borderWidth: 0
                backRadius: 8
                fontSize: 0.27 * height
                buttonTxtColor: "#415A77"
                pushUpColor: "#F6F6F6"
                pushDownColor: "#B9B9B9"
            }
        }
    }
}
