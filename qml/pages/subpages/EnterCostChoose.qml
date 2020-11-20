import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: enterCostChoose
    implicitHeight: parent.height
    implicitWidth: parent.width
    anchors.fill: parent

    contentData: Item {
        anchors.fill: parent

        Rectangle {
            id: calcMsgRec
            height: 0.06 * parent.height
            width: parent.width
            color: "#FFFFFF"
            anchors {
                top: parent.top
                topMargin: 0.3 * parent.height
            }

            states: State {
                name: "toTop"; when: calculator.isEnable
                PropertyChanges { target: calcMsgRec; anchors.topMargin: 0.015 * parent.height }
            }

            transitions: Transition {
                to: "toTop"
                PropertyAnimation { properties: "anchors.topMargin"; easing.type: Easing.InOutQuad; duration: 100 }
                reversible: true
            }

            Label {
                height: parent.height
                width: parent.width - 0.5 * parent.height
                anchors {
                    left: parent.left
                    leftMargin: 0.5 * parent.height
                }

                text: qsTr("Ввести стоимость вручную")
                font {
                    pixelSize: 0.5 * parent.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }

            Action {
                id: openCalculator
                onTriggered: {
                    buttonCalculator.action = closeCalculator
                    calculator.isEnable = true
                }
            }

            Action {
                id: closeCalculator
                onTriggered: {
                    buttonCalculator.action = openCalculator
                    calculator.isEnable = false
                }
            }

            ToolButton {
                id: buttonCalculator
                anchors{
                    right: parent.right
                    rightMargin: 0.5 * parent.height
                    verticalCenter: parent.verticalCenter
                }
                action: openCalculator
                icon {
                    source: (action == openCalculator) ? "qrc:/ico/menu/down.png" : "qrc:/ico/menu/up.png"
                    height: 0.25 * parent.height
                }
            }
        }

        Rectangle {
            id: line
            height: 0.05 * calcMsgRec.height
            width: calcMsgRec.width - calcMsgRec.height
            opacity: 1
            anchors {
                top: calcMsgRec.bottom
                topMargin: calcMsgRec.height
                horizontalCenter: calcMsgRec.horizontalCenter
            }
            color: "#C2C2C2"

            states: State {
                name: "toDisable"; when: calculator.isEnable
                PropertyChanges { target: line; anchors.top: calculator.top; opacity: 0 }
            }

            transitions: Transition {
                to: "toDisable"
                reversible: true

                PropertyAnimation {
                    properties: "anchors.top,opacity"
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
            }
        }

        SaleComponents.Calculator {
            id: calculator

            Component.onCompleted: {
                calculator.reset()
            }

            visible: false
            opacity: 0
            width: line.width
            height: 0.375 * parent.height
            color: calcMsgRec.color
            scale: 0.0
            transformOrigin: Item.Center
            anchors.top: calcMsgRec.bottom

            property bool isEnable: false

            states: State {
                name: "toEnable"; when: calculator.isEnable
                PropertyChanges {
                    target: calculator;
                    visible: true;
                    scale: 1;
                    opacity: 1;
                }
            }

            transitions: Transition {
                to: "toEnable"
                reversible: true

                SequentialAnimation {
                    PropertyAnimation { property: "visible" }
                    PropertyAnimation {
                        properties: "scale,opacity"
                        easing.type: Easing.InOutQuad
                        duration: 200
                    }
                }
            }

            onAdd2purchase: {
                openPurchase.total = calculator.formulaTotal
                calculator.reset()
            }
        }

        SaleComponents.Button_1 {
            id: scanBarcode
            width: line.width
            height: 2.5 * calcMsgRec.height
            anchors {
                bottom: parent.bottom
                bottomMargin: 0.35 * parent.height
                horizontalCenter: calcMsgRec.horizontalCenter
            }
            visible: !totalSumMsg.visible
            backRadius: 3
            borderWidth: 0
            buttonTxt: qsTr("ОТСКАНИРУЙТЕ ШТРИХКОД")
            buttonTxtColor: "#4DA03F"
            pushUpColor: "#E7FFE3"
            pushDownColor: "#B2BFB0"
            fontBold: false
            fontSize: 0.2 * height
            iconPath: "qrc:/ico/menu/scan_barcode.png"
            enabled: false

            states: State {
                name: "toBottom"; when: calculator.isEnable
                PropertyChanges { target: scanBarcode; anchors.bottomMargin: 0.265 * parent.height }
            }

            transitions: Transition {
                to: "toBottom"
                PropertyAnimation { properties: "anchors.bottomMargin"; easing.type: Easing.InOutQuad; duration: 350 }
                reversible: true
            }
        }

        Rectangle {
            id: lastPosData
            width: line.width
            height: 2.5 * calcMsgRec.height
            anchors {
                bottom: parent.bottom
                bottomMargin: 0.35 * parent.height
                horizontalCenter: calcMsgRec.horizontalCenter
            }
            visible: totalSumMsg.visible
            radius: 3
            border.width: 1
            border.color: "#DADADA"
            color: "#FFFFFF"

            Row {
                anchors.fill: parent
                Text {
                    id: positionName
                    text: qsTr("Товар по свободной цене")
                    font {
                        pixelSize: 0.18 * parent.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.DemiBold
                    }
                    width: 0.5 * parent.width - font.pixelSize
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    maximumLineCount: 4
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    anchors {
                        left: parent.left
                        leftMargin: font.pixelSize
                        verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    id: positionQtyCost
                    width: positionName.width
                    text: qsTr("1" + " x " + openPurchase.total + "  \u20BD\n= " + openPurchase.total + "  \u20BD")
                    font {
                        pixelSize: positionName.font.pixelSize
                        family: positionName.font.family
                        styleName: positionName.font.styleName
                        weight: positionName.font.weight
                    }
                    clip: true
                    color: positionName.color
                    elide: Text.ElideLeft
                    wrapMode: Text.WordWrap
                    maximumLineCount: 4
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    anchors {
                        right: parent.right
                        rightMargin: positionName.font.pixelSize
                        verticalCenter: positionName.verticalCenter
                    }
                }
            }

            states: State {
                name: "toBottom"; when: calculator.isEnable
                PropertyChanges { target: lastPosData; anchors.bottomMargin: 0.265 * parent.height }
            }

            transitions: Transition {
                to: "toBottom"
                PropertyAnimation { properties: "anchors.bottomMargin"; easing.type: Easing.InOutQuad; duration: 350 }
                reversible: true
            }
        }

        Rectangle {
            id: totalSumMsg
            height: 0.06 * parent.height
            width: parent.width
            color: "#FFFFFF"
            anchors {
                top: scanBarcode.bottom
                topMargin: 0.5 * height
            }

            visible: (openPurchase.total != "0,00")

            Label {
                height: parent.height
                width: parent.width - 0.5 * parent.height
                anchors {
                    left: parent.left
                    leftMargin: 0.5 * parent.height
                }

                text: qsTr("Итого, чек")
                font {
                    pixelSize: 0.5 * parent.height
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

            Button {
                id: openPurchase
                height: 1.5 * parent.height
                width: 2.82 * height

                property var total: "0,00"

                anchors{
                    right: parent.right
                    rightMargin: 0.5 * parent.height
                    verticalCenter: parent.verticalCenter
                }
                background: Rectangle {
                    border.width: 0
                    color: openPurchase.pressed ? "#B2BFB0" : "#E7FFE3"

                    Text {
                        id: totalSum
                        anchors.centerIn: parent
                        text: openPurchase.total + "  \u20BD"
                        font {
                            pixelSize: 0.5 * totalSumMsg.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.DemiBold
                        }
                        color: "#4DA03F"
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter

                        onContentWidthChanged: {
                            if (contentWidth > 6 * height) {
                                openPurchase.width = 1.2 * contentWidth
                            }
                        }
                    }
                }

                onClicked: {
                    openPage("qrc:/qml/pages/subpages/Purchase.qml")
                }
            }
        }

        SaleComponents.CircleButton {
            id: payButton
            buttonWidth: 0.2 * parent.width
            anchors {
                right: parent.right
                bottom: parent.bottom
            }
            enabled: totalSumMsg.visible
            onPressed: {
                rootStack.push("qrc:/qml/pages/subpages/Pay.qml")
                rootStack.currentItem.purchaseTotal = openPurchase.total
            }
        }
    }
}
