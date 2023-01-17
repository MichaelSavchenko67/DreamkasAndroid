import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popup
    property var titleMsg
    property var addMsg
    property var firsButtonName
    property var secondButtonName
    property bool isLoader: false
    property bool isComplite: false
    property bool success: false
    property var resMsg

    function setFirstButtonAction(action) {
        firstButton.action = action
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
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        id: popupFrame
        anchors.fill: parent
        color: "transparent"

        Column {
            width: 0.85 * parent.width
            height: 0.9 * parent.height
            visible: !isComplite
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
                height: 0.6 * parent.height
                visible: !loader.visible
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
                maximumLineCount: 4
                wrapMode: Text.WordWrap
                horizontalAlignment: title.horizontalAlignment
                verticalAlignment: Qt.AlignTop
            }

            BusyIndicator {
                id: loader
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: 0.1 * popupFrame.width
                implicitHeight: implicitWidth
                visible: isLoader
                running: true
                Material.accent: "#5C7490"
            }
        }

        Row {
            width: parent.width
            height: 0.17 * parent.height
            visible: !loader.visible && !compliteMsg.visible
            anchors {
                bottom: popupFrame.bottom
                bottomMargin: 0.05 * popupFrame.height
                right: parent.right
                rightMargin: parent.width - width
            }

            SaleComponents.ButtonPopup {
                id: firstButton
                width: 0.5 * parent.width
                height: parent.height
                visible: (txt !== "undefined") && (txt.length > 0)
                anchors.right: parent.right
                txt: firsButtonName
            }

            SaleComponents.ButtonPopup {
                id: secondButton
                width: firstButton.width
                height: firstButton.height
                visible: (txt !== "undefined") && (txt.length > 0)
                anchors.right: firstButton.visible ? firstButton.left : parent.right
                txt: secondButtonName
            }
        }

        Column {
            id: compliteMsg
            width: 0.85 * parent.width
            height: 0.9 * parent.height
            visible: isComplite
            anchors {
                top: popupFrame.top
                topMargin: 0.5 * resIco.height
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 0.5 * resIco.height

            Image {
                id: resIco
                width: 0.22 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                source: success ? "qrc:/ico/menu/operation_success.png" : "qrc:/ico/menu/operation_failed.png"
            }

            Text {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr((resMsg === "undefined") ? " ": resMsg)
                font: msg.font
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Timer {
                id: skipMsg
                interval: 3000
                running: isComplite
                repeat: false
                onTriggered: {
                    root.popupReset()
                }
            }
        }
    }
}
