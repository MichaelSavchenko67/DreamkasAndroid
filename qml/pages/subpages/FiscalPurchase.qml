import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("[FiscalPurchase.qml]\tfocus changed: " + focus)
            setToolbarVisible(false)
        }
    }

    property bool isCashPay: true
    property var paymentSum: "0,00"
    property var delivery: "0,00"
    property bool changeMsg: false
    property var cashlessPaymentName: ""

    function getTitle() {
        if (isCashPay) {
            return qsTr("Оплата " + "наличными\n" + paymentSum + "  \u20BD")
        } else if (cashlessPaymentName === "Картой") {
            return qsTr("Оплата " + "картой\n" + paymentSum + "  \u20BD")
        } else if (cashlessPaymentName === "Аванс") {
            return qsTr("Аванс\n" + paymentSum + "  \u20BD")
        } else if (cashlessPaymentName === "Кредит") {
            return qsTr("Кредит\n" + paymentSum + "  \u20BD")
        } else if (cashlessPaymentName === "Иная форма") {
            return qsTr("Иная форма оплаты\n" + paymentSum + "  \u20BD")
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: false
        onTriggered: {
            loader.running = false
            changeMsg = true
        }
    }

    contentData: Item {
        id: fiscalPurchasePage
        implicitHeight: parent.height
        implicitWidth: parent.width
        anchors.fill: parent

        Column {
            id: prevMsg
            width: parent.width
            height: 0.475 * parent.width
            anchors {
                horizontalCenter:  parent.horizontalCenter
                top: parent.top
                topMargin: 0.2 * parent.height
            }
            spacing: payMsg.font.pixelSize
            transformOrigin: Item.Center

            BusyIndicator {
                id: loader
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: 0.1 * fiscalPurchasePage.width
                implicitHeight: implicitWidth
                running: true
                Material.accent: "#5C7490"
            }

            Text {
                id: payMsg
                width: parent.width
                anchors.horizontalCenter: fiscalPurchasePage.horizontalCenter
                text: getTitle()
                font {
                    pixelSize: 0.04 * fiscalPurchasePage.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Text {
                width: parent.width
                anchors.horizontalCenter: fiscalPurchasePage.horizontalCenter
                visible: (!isCashPay && (cashlessPaymentName === "Картой"))
                text: qsTr("Следуйте инструкциям\nна терминале")
                font {
                    pixelSize: 0.03 * fiscalPurchasePage.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            states: State {
                name: "toDisable"; when: changeMsg

                PropertyChanges {
                    target: prevMsg;
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
            id: pastMsg
            visible: !prevMsg.visible
            width: parent.width
            height: 0.475 * parent.width
            anchors {
                horizontalCenter:  parent.horizontalCenter
                top: parent.top
                topMargin: 0.2 * parent.height
            }
            spacing: payMsg.font.pixelSize
            opacity: 1

            Image {
                width: 0.22 * fiscalPurchasePage.width
                height: width
                anchors.horizontalCenter:  parent.horizontalCenter
                source: "qrc:/ico/menu/operation_success.png"
            }

            Text {
                width: parent.width
                anchors.horizontalCenter: fiscalPurchasePage.horizontalCenter
                text: qsTr("Успешно")
                font {
                    pixelSize: 0.04 * fiscalPurchasePage.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Text {
                width: parent.width
                anchors.horizontalCenter: fiscalPurchasePage.horizontalCenter
                text: qsTr("Выдайте покупателю чек" + ((delivery === "0,00") ? "" : ("\nи сдачу " + delivery + "  \u20BD")))
                font {
                    pixelSize: 0.03 * fiscalPurchasePage.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            SaleComponents.Button_1 {
                anchors.horizontalCenter:  parent.horizontalCenter
                width: 0.44 * fiscalPurchasePage.width
                height: 0.4 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr("Продолжить")
                fontSize: 0.03 * fiscalPurchasePage.height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    rootStack.pop(null)
                }
            }
        }
    }
}
