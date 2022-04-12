import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: page
    anchors.fill: parent

    property string totalSum: qsTr("15 374 123 456 789 012 000 000 000" + "&nbsp;\u20BD")

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Оплата на Р/С")
            setLeftMenuButtonAction(back)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
            footerMainModel.setState("Off")
        }
    }

    Column {
        width: parent.width
        topPadding: 0.15 * qrCodeBackgroundFrame.height

        Rectangle {
            width: 0.6 * parent.width
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"

            Rectangle {
                id: qrCodeBackgroundFrame
                width: qrCodeFrame.width
                height: width
                anchors {
                    right: parent.right
                    top: parent.top
                }
                color: "transparent"

                Image {
                    anchors.fill: parent
                    source: "qrc:/img/sale/blot.png"
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle {
                id: qrCodeFrame
                width: 0.46 * page.width
                height: width
                anchors.centerIn: parent
                color: "transparent"

                Image {
                    id: qrCode
                    anchors.fill: parent
                    source: "qrc:/ico/purchase/qr_code_example.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Column {
            id: msgColumn
            width: parent.width
            spacing: 0.05 * page.width

            Label {
                id: total
                width: parent.width
                text: totalSum
                font {
                    pixelSize: 1.6 * 0.05 * page.width
                    family: "Roboto"
                    styleName: "bold"
                    weight: Font.Bold
                    bold: true
                }
                textFormat: Label.RichText
                color: "black"
                clip: true
                elide: "ElideRight"
                maximumLineCount: 2
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Label {
                id: description
                width: total.width
                text: qsTr("Покажите QR-код покупателю\nдля оплаты на расчётный счёт.\nПокупателю необходимо в банковском\nприложении выбрать оплату по QR\nи отсканировать код")
                font {
                    pixelSize: 0.8 * 0.05 * page.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                lineHeight: 1.5
                opacity: 0.6
                clip: true
                elide: "ElideRight"
                maximumLineCount: 8
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }
        }
    }

    Action {
        id: proceed
        onTriggered: {
            console.log("Proceed")
            root.closePage()
        }
    }

    Action {
        id: cancel
        onTriggered: {
            console.log("Cancel")
            root.closePage()
        }
    }

    Column {
        width: parent.width
        anchors {
            bottom: parent.bottom
            bottomMargin: spacing
        }
        spacing: 0.1 * msgColumn.spacing

        SaleComponents.Button_1 {
            id: proceedButton
            width: 0.907 * parent.width
            height: 0.15 * width
            anchors.horizontalCenter: parent.horizontalCenter
            buttonTxt: qsTr("ОПЛАТА ПРОШЛА")
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            action: proceed
            borderWidth: 0
            backRadius: 8
            fontSize: 0.27 * height
            fontBold: false
        }

        SaleComponents.Button_1 {
            width: proceedButton.width
            height: proceedButton.height
            anchors.horizontalCenter: parent.horizontalCenter
            buttonTxt: qsTr("ОТМЕНИТЬ ОПЛАТУ НА Р/С")
            buttonTxtColor: "#0064B4"
            pushUpColor: "#FFFFFF"
            pushDownColor: "#F2F2F2"
            action: cancel
            borderWidth: proceedButton.borderWidth
            backRadius: proceedButton.backRadius
            fontSize: proceedButton.fontSize
            fontBold: proceedButton.fontBold
        }
    }
}
