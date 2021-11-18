import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: page

    Timer {
        id: create
        running: true
        interval: 3000
        onTriggered: {
            page.state = "created"
        }
    }

    states: [
        State {
            name: "creating"
            PropertyChanges { target: loader; visible: true }
            PropertyChanges { target: title; visible: true }
            PropertyChanges { target: title; text: qsTr("QR-код\nформируется") }
            PropertyChanges { target: total; visible: false }
            PropertyChanges { target: description; visible: false }
            PropertyChanges { target: qrCode; visible: false }
            PropertyChanges { target: qrCodeBackgroundFrame; visible: false }
            PropertyChanges { target: actionButton; state: "disable" }
        },
        State {
            name: "created"
            PropertyChanges { target: loader; visible: false }
            PropertyChanges { target: title; visible: false }
            PropertyChanges { target: total; visible: true }
            PropertyChanges { target: total; text: qsTr("15 374 123 456 789 012" + "&nbsp;\u20BD") }
            PropertyChanges { target: description; visible: true }
            PropertyChanges { target: description; text: qsTr("Отсканируйте QR-код\nв мобильном приложении «Сбербанк»") }
            PropertyChanges { target: qrCode; visible: true }
            PropertyChanges { target: qrCode; source: "qrc:/ico/purchase/qr_code_example.png" }
            PropertyChanges { target: qrCodeBackgroundFrame; visible: true }
            PropertyChanges { target: actionButton; state: "cancel" }
        },
        State {
            name: "failed"
            PropertyChanges { target: loader; visible: false }
            PropertyChanges { target: title; visible: true }
            PropertyChanges { target: title; text: qsTr("Не удалось создать QR-код") }
            PropertyChanges { target: total; visible: false }
            PropertyChanges { target: description; visible: true }
            PropertyChanges { target: description; text: qsTr("Попробуйте ещё раз или выберите\nдругой способ оплаты") }
            PropertyChanges { target: qrCode; visible: true }
            PropertyChanges { target: qrCode; source: "qrc:/img/sale/warning.png" }
            PropertyChanges { target: qrCodeBackgroundFrame; visible: false }
            PropertyChanges { target: actionButton; state: "repeat" }
        }
    ]
    state: "creating"

    Column {
        width: parent.width
        topPadding: 0.8 * loader.height

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

                BusyIndicator {
                    id: loader
                    implicitWidth: 0.1 * page.width
                    implicitHeight: implicitWidth
                    anchors.centerIn: parent
                    running: true
                    Material.accent: "#5C7490"
                    onVisibleChanged: {
                        running = visible
                    }
                }

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
            spacing: title.font.pixelSize

            Label {
                id: title
                width: parent.width
                font {
                    pixelSize: 0.5 * loader.height
                    family: "Roboto"
                    styleName: "bold"
                    weight: Font.Bold
                    bold: true
                }
                color: "black"
                clip: true
                elide: "ElideRight"
                maximumLineCount: 2
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Label {
                id: total
                width: title.width
                font {
                    pixelSize: 1.6 * title.font.pixelSize
                    family: title.font.family
                    styleName: title.font.styleName
                    weight: title.font.weight
                    bold: title.font.bold
                }
                textFormat: Label.RichText
                color: title.color
                clip: title.clip
                elide: title.elide
                maximumLineCount: title.maximumLineCount
                wrapMode: title.wrapMode
                horizontalAlignment: title.horizontalAlignment
                verticalAlignment: title.verticalAlignment
            }

            Label {
                id: description
                width: title.width
                font {
                    pixelSize: 0.8 * title.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: title.color
                lineHeight: 1.5
                opacity: 0.6
                clip: title.clip
                elide:title.elide
                maximumLineCount: title.maximumLineCount
                wrapMode: title.wrapMode
                horizontalAlignment: title.horizontalAlignment
                verticalAlignment: title.verticalAlignment
            }
        }
    }

    Action {
        id: repeat
        onTriggered: {
            console.log("Repeat")
        }
    }

    Action {
        id: cancel
        onTriggered: {
            console.log("Cancel")
        }
    }

    SaleComponents.Button_1 {
        id: actionButton
        width: 0.907 * parent.width
        height: 0.15 * width
        states: [
            State {
                name: "disable"
                PropertyChanges { target: actionButton; visible: false }
            },
            State {
                name: "repeat"
                PropertyChanges { target: actionButton; visible: true }
                PropertyChanges { target: actionButton; buttonTxt: qsTr("ПОПРОБОВАТЬ ЕЩЁ РАЗ") }
                PropertyChanges { target: actionButton; buttonTxtColor: "white" }
                PropertyChanges { target: actionButton; pushUpColor: "#415A77" }
                PropertyChanges { target: actionButton; pushDownColor: "#004075" }
                PropertyChanges { target: actionButton; action: repeat }
            },
            State {
                name: "cancel"
                PropertyChanges { target: actionButton; visible: true }
                PropertyChanges { target: actionButton; buttonTxt: qsTr("ОТМЕНИТЬ ОПЛАТУ ПО QR-КОДУ") }
                PropertyChanges { target: actionButton; buttonTxtColor: "#0064B4" }
                PropertyChanges { target: actionButton; pushUpColor: "#FFFFFF" }
                PropertyChanges { target: actionButton; pushDownColor: "#F2F2F2" }
                PropertyChanges { target: actionButton; action: cancel }
            }
        ]
        state: "disable"
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: height
        }
        borderWidth: 0
        backRadius: 8
        fontSize: 0.27 * height
        fontBold: false
    }
}
