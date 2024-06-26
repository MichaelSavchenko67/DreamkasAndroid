import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "qrc:/qml/components/sale" as SaleComponents

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("[Operation.qml]\tfocus changed: " + focus)
            setToolbarVisible(false)
        }
    }

    property var operation          // наименование операции
    property bool finish: false     // флаг окончания выполнения операции
    property bool complite: false   // флаг успешности выполнения операции
    property var resMsg             // сообщение о результате выполнения операции

    Timer {
        interval: 3000
        running: true
        repeat: false
        onTriggered: {
            console.log("Timer finish")
            loader.running = false
            finish = true
        }
    }

    contentData: Item {
        id: operationPage
        implicitHeight: parent.height
        implicitWidth: parent.width
        anchors.fill: parent

        Column {
            id: startMsg
            width: parent.width
            height: 0.475 * parent.width
            anchors {
                top: parent.top
                topMargin: 0.2 * parent.height
                horizontalCenter: parent.horizontalCenter
            }
            transformOrigin: Item.Center

            Rectangle {
                id: loaderFrame
                color: "#00FFFFFF"
                width: operationResImg.width
                height: operationResImg.height
                anchors.centerIn: parent

                BusyIndicator {
                    id: loader
                    anchors.centerIn: parent
                    implicitWidth: 0.1 * operationPage.width
                    implicitHeight: implicitWidth
                    running: true
                    Material.accent: "#5C7490"
                }
            }

            Text {
                onTextChanged: {
                    console.log("onTextChanged : " + text)
                }

                id: operationMsg
                width: parent.width
                anchors {
                    top: loaderFrame.bottom
                    topMargin: 0.25 * operationResImg.height
                    horizontalCenter: parent.horizontalCenter
                }
                text: qsTr((operation === "undefined") ? " ": operation)
                font {
                    pixelSize: 0.04 * operationPage.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            states: State {
                name: "toDisable"; when: finish

                PropertyChanges {
                    target: startMsg;
                    opacity: 0;
                    visible: false;
                }
            }

            transitions: Transition {
                to: "toDisable"

                SequentialAnimation {
                    PropertyAnimation {
                        properties: "opacity"
                        easing.type: Easing.InOutQuad
                        duration: 300
                    }
                    PropertyAnimation { property: "visible" }
                }
            }
        }

        Column {
            id: finishMsg
            visible: !startMsg.visible
            width: startMsg.width
            height: startMsg.height
            anchors {
                top: parent.top
                topMargin: 0.2 * parent.height
            }
            opacity: 1

            Image {
                id: operationResImg
                width: 0.22 * operationPage.width
                height: width
                anchors.centerIn: parent
                source: complite ? "qrc:/ico/menu/operation_success.png" : "qrc:/ico/menu/operation_failed.png"
            }

            Text {
                width: parent.width
                anchors {
                    top: operationResImg.bottom
                    topMargin: 0.25 * operationResImg.height
                }
                text: qsTr((resMsg === "undefined") ? " ": resMsg)
                font {
                    pixelSize: 0.04 * operationPage.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Timer {
                interval: 3000
                running: finishMsg.visible
                repeat: false
                onTriggered: {
                    rootStack.pop(null)
                }
            }
        }
    }
}
