import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: enterCostChoose
    implicitHeight: parent.height
    implicitWidth: parent.width
    anchors.fill: parent

    contentData: Item {
        anchors.fill: parent

//        Rectangle {
//            id: calcMsgRec
//            width: 0.918 * parent.width
//            height: 0.23 * width
//            anchors {
//                top: parent.top
//                topMargin: 0.03 * parent.height
//                horizontalCenter: parent.horizontalCenter
//            }
//            color: "#00FFFFFF"
//            border {
//                color: "#C2C2C2"
//                width: 1
//            }
//            radius: 7

//            Row {
//                anchors.fill: parent

//                Text {
//                    id: positionName
//                    text: qsTr("Товар по свободной цене")
//                    font {
//                        pixelSize: 0.18 * parent.height
//                        family: "Roboto"
//                        styleName: "normal"
//                        weight: Font.DemiBold
//                    }
//                    width: 0.5 * parent.width - font.pixelSize
//                    clip: true
//                    color: "black"
//                    elide: Text.ElideRight
//                    maximumLineCount: 4
//                    wrapMode: Text.WordWrap
//                    lineHeight: 1.5
//                    horizontalAlignment: Qt.AlignLeft
//                    verticalAlignment: Qt.AlignVCenter
//                    anchors {
//                        left: parent.left
//                        leftMargin: font.pixelSize
//                        verticalCenter: parent.verticalCenter
//                    }
//                }

//                Text {
//                    id: positionQtyCost
//                    width: positionName.width
//                    text: qsTr("1" + " x " + openPurchase.total + "  \u20BD\n= " + openPurchase.total + "  \u20BD")
//                    font {
//                        pixelSize: positionName.font.pixelSize
//                        family: positionName.font.family
//                        styleName: positionName.font.styleName
//                        weight: positionName.font.weight
//                    }
//                    clip: true
//                    color: positionName.color
//                    elide: Text.ElideLeft
//                    wrapMode: Text.WordWrap
//                    maximumLineCount: 4
//                    horizontalAlignment: Qt.AlignRight
//                    verticalAlignment: Qt.AlignVCenter
//                    anchors {
//                        right: parent.right
//                        rightMargin: positionName.font.pixelSize
//                        verticalCenter: positionName.verticalCenter
//                        bottomMargin: 0.265 * parent.height
//                    }
//                }
//            }


//            Label {
//                height: parent.height
//                width: parent.width - 0.5 * parent.height
//                anchors {
//                    left: parent.left
//                    leftMargin: 0.5 * parent.height
//                }

//                text: qsTr("Ввести стоимость вручную")
//                font {
//                    pixelSize: 0.5 * parent.height
//                    family: "Roboto"
//                    styleName: "normal"
//                    weight: Font.Normal
//                }
//                color: "black"
//                elide: Label.ElideRight
//                horizontalAlignment: Qt.AlignLeft
//                verticalAlignment: Qt.AlignVCenter
//            }
//        }

        SaleComponents.Calculator {
            id: calculator

            property bool isEnable: false

            Component.onCompleted: {
                calculator.reset()
            }

            onAdd2purchase: {
                openPurchase.total = calculator.formulaTotal
                calculator.reset()
            }
        }

//        Rectangle {
//            id: totalSumMsg
//            height: 0.06 * parent.height
//            width: parent.width
//            color: "#FFFFFF"
//            anchors {
//                top: scanBarcode.bottom
//                topMargin: 0.5 * height
//            }

//            visible: (openPurchase.total != "0,00")

//            Label {
//                height: parent.height
//                width: parent.width - 0.5 * parent.height
//                anchors {
//                    left: parent.left
//                    leftMargin: 0.5 * parent.height
//                }

//                text: qsTr("Итого, чек")
//                font {
//                    pixelSize: 0.5 * parent.height
//                    family: "Roboto"
//                    styleName: "normal"
//                    weight: Font.Bold
//                    bold: true
//                }
//                color: "black"
//                elide: Label.ElideRight
//                horizontalAlignment: Qt.AlignLeft
//                verticalAlignment: Qt.AlignVCenter
//            }

//            Button {
//                id: openPurchase
//                height: 1.5 * parent.height
//                width: 2.82 * height

//                property var total: "0,00"

//                anchors{
//                    right: parent.right
//                    rightMargin: 0.5 * parent.height
//                    verticalCenter: parent.verticalCenter
//                }
//                background: Rectangle {
//                    border.width: 0
//                    color: openPurchase.pressed ? "#B2BFB0" : "#E7FFE3"

//                    Text {
//                        id: totalSum
//                        anchors.centerIn: parent
//                        text: openPurchase.total + "  \u20BD"
//                        font {
//                            pixelSize: 0.5 * totalSumMsg.height
//                            family: "Roboto"
//                            styleName: "normal"
//                            weight: Font.DemiBold
//                        }
//                        color: "#4DA03F"
//                        elide: Label.ElideRight
//                        horizontalAlignment: Qt.AlignRight
//                        verticalAlignment: Qt.AlignVCenter

//                        onContentWidthChanged: {
//                            if (contentWidth > 6 * height) {
//                                openPurchase.width = 1.2 * contentWidth
//                            }
//                        }
//                    }
//                }

//                onClicked: {
//                    openPage("qrc:/qml/pages/subpages/Purchase.qml")
//                }
//            }
//        }

//        SaleComponents.CircleButton {
//            id: payButton
//            buttonWidth: 0.2 * parent.width
//            anchors {
//                right: parent.right
//                bottom: parent.bottom
//            }
//            enabled: totalSumMsg.visible
//            onPressed: {
//                rootStack.push("qrc:/qml/pages/subpages/Pay.qml")
//                rootStack.currentItem.purchaseTotal = openPurchase.total
//            }
//        }

        Rectangle {
            width: parent.width
            height: parent.height - calculator.height - 2 * 0.06 * parent.height
            anchors.bottom: parent.bottom
            color: "#F2F3F5"

            Row {
                width: parent.width
                height: 0.7 * parent.height
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0.044 * width
                leftPadding: spacing
                rightPadding: spacing

                SaleComponents.Button_1 {
                    width: (parent.width - 4 * parent.spacing) / 3
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    borderWidth: 1
                    backRadius: 5
                    buttonTxt: qsTr("НАЛИЧНЫЕ")
                    fontSize: 0.23 * height
                    buttonTxtColor: "#0064B4"
                    pushUpColor: "#FFFFFF"
                    pushDownColor: "#C2C2C2"
                    enabled: openPurchase.enabled

                    onClicked: {
                        root.openPage("qrc:/qml/pages/subpages/Pay.qml")
                        rootStack.currentItem.cashPay = true
                        rootStack.currentItem.purchaseTotal = openPurchase.total
                    }
                }

                SaleComponents.Button_1 {
                    width: (parent.width - 4 * parent.spacing) / 3
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    borderWidth: 1
                    backRadius: 5
                    buttonTxt: qsTr("БЕЗНАЛ")
                    fontSize: 0.23 * height
                    buttonTxtColor: "#0064B4"
                    pushUpColor: "#FFFFFF"
                    pushDownColor: "#C2C2C2"
                    enabled: openPurchase.enabled

                    onClicked: {
                        root.openPage("qrc:/qml/pages/subpages/Pay.qml")
                        rootStack.currentItem.cashPay = false
                        rootStack.currentItem.purchaseTotal = openPurchase.total
                    }
                }

                SaleComponents.Button_1 {
                    id: openPurchase
                    property var total: "0,00"

                    width: (parent.width - 4 * parent.spacing) / 3
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    borderWidth: 1
                    backRadius: 5
                    buttonTxt: qsTr("ИТОГО\n" + total + " \u20BD")
                    fontSize: 0.23 * height
                    buttonTxtColor: "#FFFFFF"
                    pushUpColor: "#0064B4"
                    pushDownColor: "#004075"
                    enabled: (total != "0,00")

                    onClicked: {
                        root.openPage("qrc:/qml/pages/subpages/Purchase.qml")
                    }
                }
            }

//            DropShadow {
//                visible: true
//                anchors.fill: parent
//                cached: true
//                verticalOffset: -8
//                radius: 8
//                samples: 1 + 2 * radius
//                source: parent
//                color: "#EBEBEB"
//            }
        }
    }
}
