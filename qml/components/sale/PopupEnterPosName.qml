import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Popup {
    id: enterTextPopup

    property string popupTitle: ""
    property string enteredText: ""
    property string enteredTextTitle: ""
    property string enteredTextPlaceholder: ""
    property string buttonText: "ДОБАВИТЬ В ЧЕК"
    property bool isStayLastEntered: false
    property bool isClearOnTap: true
    property bool isService: true
    property string cost: "4 455,00 \u20BD"

    function reset() {
        enterText.text = ""
    }

    onOpened: {
        closeAllMenus()
        title.text = popupTitle

        if (!isStayLastEntered) {
            enterText.text = ""
        }
    }

    signal entered(string textEntered)

    width: 0.9 * parent.width
    height: rootColumn.height + exitButton.height + 0.5 * exitButton.icon.height + rootColumn.spacing
    parent: Overlay.overlay
    x: Math.round((root.width - width) / 2)
    y: Math.round(0.3 * (root.height - height))

    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        id: popupFrame
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"

        ToolButton {
            id: exitButton
            visible: !root.isOnboardingModeEnabled
            anchors {
                top: parent.top
                topMargin: 0.5 * exitButton.icon.height
                right: parent.right
                rightMargin: 0.5 * exitButton.icon.height
            }
            icon {
                color: "#979797"
                height: 0.038 * 0.9 * parent.width
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                enterTextPopup.close()
            }
        }

        Column {
            id: rootColumn
            width: parent.width - 2 * title.font.pixelSize
            anchors {
                top: exitButton.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                text: popupTitle
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

            Column {
                id: enterTextFrame
                width: parent.width
                spacing: 0.25 * parent.spacing

                Label {
                    id: enterTextTitle
                    width: parent.width
                    text: qsTr(enteredTextTitle)
                    font {
                        pixelSize: 0.67 * title.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    clip: true
                    elide: Label.ElideRight
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }

                Row {
                    width: parent.width

                    TextField {
                        id: enterText
                        width: parent.width
                        focus: true
                        placeholderText: qsTr(enteredTextPlaceholder)
                        placeholderTextColor: "#979797"
                        inputMethodHints: Qt.ImhNone
                        text: enteredText
                        font {
                            pixelSize: title.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#0064B4"
                        onPressed: {
                            console.log("PopupEnterText onPressed")
                            if (isClearOnTap && (enterText.text.length > 0))
                            {
                                enterText.text = ""
                            }
                        }
                    }
                }

                Label {
                    width: parent.width
                    text: qsTr("Тип")
                    font: enterTextTitle.font
                    color: "#979797"
                    clip: true
                    elide: Label.ElideRight
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }

                Row {
                    width: parent.width
                    spacing: 2 * parent.spacing

                    SettingsComponents.ButtonSet {
                        id: buttonGoods
                        width: 0.5 * (parent.width - parent.spacing)
                        height: 1.183 * confirmButton.height
                        buttonTxt: "Товар"
                        isSetUp: !isService
                        onIsSetUpChanged: {
                            buttonService.isSetUp = !isSetUp
                        }
                    }

                    SettingsComponents.ButtonSet {
                        id: buttonService
                        width: buttonGoods.width
                        height: buttonGoods.height
                        buttonTxt: "Услуга"
                        isSetUp: isService
                        onIsSetUpChanged: {
                            buttonGoods.isSetUp = !isSetUp
                            isService = isSetUp
                        }
                    }
                }
            }

            Column {
                width: parent.width
                spacing: 0.25 * title.font.pixelSize

                Label {
                    width: parent.width
                    text: qsTr("Сумма за " + (isService ? "услугу " : "товар ") + cost)
                    font: enterTextTitle.font
                    color: "black"
                    clip: true
                    elide: Label.ElideRight
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }

                SaleComponents.Button_1 {
                    id: confirmButton
                    width: enterTextFrame.width
                    height: 0.18 * width
                    enabled: enterText.acceptableInput && enterText.displayText.length > 1
                    opacity: enabled ? 1 : 0.6
                    borderWidth: 0
                    backRadius: 8
                    buttonTxt: buttonText
                    fontSize: 0.27 * height
                    buttonTxtColor: "white"
                    pushUpColor: enabled ? "#415A77" : "#BDC3C7"
                    pushDownColor: "#004075"
                    onClicked: {
                        entered(enterText.text)
                        enterTextPopup.close()
                    }
                }
            }
        }
    }
}
