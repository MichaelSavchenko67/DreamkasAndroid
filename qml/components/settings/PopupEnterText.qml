import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: enterTextPopup

    property var popupTitle: ""
    property var enteredTextTitle: ""
    property var enteredTextPlaceholder: ""
    property var buttonText: "ПРОДОЛЖИТЬ"
    property var enteredImh: Qt.ImhNone
    property var enteredValidator: RegExpValidator { }
    property bool isStayLastEntered: false

    onOpened: {
        title.text = popupTitle
        if (!isStayLastEntered)
        {
            enterText.text = ""
        }
    }

    signal entered(string textEntered)

    width: 0.9 * root.width
    height: 0.9 * width
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
            anchors {
                top: parent.top
                topMargin: 0.5 *  0.038 * parent.height
                right: parent.right
                rightMargin: 0.5 *  0.038 * parent.height
            }
            icon {
                color: "#979797"
                height: 0.038 * parent.height
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                enterTextPopup.close()
            }
        }

        Column {
            id: rootColumn
            width: parent.width - exitButton.width
            height: parent.height - exitButton.height
            anchors.top: exitButton.bottom
            spacing: 2 * title.font.pixelSize
            leftPadding: 0.5 * spacing

            Column {
                width: parent.width
                height: parent.height - connectionButton.height - 2 * parent.spacing
                spacing: title.font.pixelSize

                Label {
                    id: title
                    width: parent.width
                    font {
                        pixelSize: 0.08 * enterTextPopup.height
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
                    height: parent.height - title.contentHeight - parent.spacing
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
                        elide: "ElideRight"
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
                            inputMethodHints: enteredImh
                            validator: enteredValidator
                            font {
                                pixelSize: title.font.pixelSize
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "#0064B4"

                            onPressed: {
                                console.log("PopupEnterText onPressed")
                                if (enterText.length > 0)
                                {
                                    enterText.clear()
                                }
                            }
                        }
                    }
                }
            }

            SaleComponents.Button_1 {
                id: connectionButton
                width: enterTextFrame.width
                height: 0.18 * width
                enabled: enterText.acceptableInput && enterText.displayText.length > 1
                opacity: enabled ? 1 : 0.6
                borderWidth: 0
                backRadius: 8
                buttonTxt: buttonText.toUpperCase()
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
