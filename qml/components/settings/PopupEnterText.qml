import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: enterTextPopup

    property var popupTitle: ""
    property var enteredTextTitle: ""
    property var enteredTextPlaceholder: ""
    property var buttonText: "ПРОДОЛЖИТЬ"
    property var enteredImh: Qt.ImhNone
    property var enteredValidator: RegularExpressionValidator { }
    property bool isStayLastEntered: false
    property var ico: ""

    onOpened: {
        title.text = popupTitle
        if (!isStayLastEntered)
        {
            enterText.text = ""
        }
    }

    signal entered(string textEntered)

    width: 0.9 * parent.width
    height: (ico.length > 0) ? parent.height : 0.9 * width
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
            spacing: 2 * title.font.pixelSize

            Column {
                width: parent.width
                spacing: title.font.pixelSize

                Label {
                    id: title
                    width: parent.width
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

                Image {
                    id: icoImage
                    height: enterTextPopup.height -
                            exitButton.height -
                            exitButton.anchors.topMargin -
                            connectionButton.height -
                            rootColumn.spacing -
                            title.contentHeight -
                            enterTextFrame.height -
                            2 * parent.spacing
                    width: 0.75 * height
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: ico
                    fillMode: Image.PreserveAspectFit
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
