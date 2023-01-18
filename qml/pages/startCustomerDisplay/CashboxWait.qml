import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: cashboxWaitPage
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            root.setMenuEnabled(true)
        }
    }

    Action {
        id: openManualSettings
        onTriggered: {
            root.openPage("qrc:/qml/pages/startCustomerDisplay/ManualSettings.qml")
        }
    }

    Action {
        id: openWiFiSettings
        onTriggered: {
        }
    }

    states: [
        State {
            name: "offline"
            PropertyChanges { target: connectionStatusImage; source: "qrc:/ico/settings/offline.png" }
            PropertyChanges { target: connectionStatusTitleLabel; text: qsTr("Сеть не найдена") }
            PropertyChanges { target: connectionStatusDescriptionLabel; text: qsTr("Подключите устройство к сети Wi-Fi") }
            PropertyChanges { target: connectActionButton; buttonTxt: qsTr("ПЕРЕЙТИ К НАСТРОЙКАМ") }
            PropertyChanges { target: connectActionButton; buttonTxtColor: "white" }
            PropertyChanges { target: connectActionButton; pushUpColor: "#415A77" }
            PropertyChanges { target: connectActionButton; pushDownColor: "#004075" }
            PropertyChanges { target: connectActionButton; action: openWiFiSettings }
        },
        State {
            name: "online"
            PropertyChanges { target: connectionStatusImage; source: "qrc:/ico/purchase/qr_code_example.png" }
            PropertyChanges { target: connectionStatusTitleLabel; text: qsTr("Отсканируйте QR-код") }
            PropertyChanges { target: connectionStatusDescriptionLabel; text: qsTr("Подключите дисплей к кассе\nпри помощи сканера или введите данные вручную") }
            PropertyChanges { target: connectActionButton; buttonTxt: qsTr("ВВЕСТИ ВРУЧНУЮ") }
            PropertyChanges { target: connectActionButton; buttonTxtColor: "#0064B4" }
            PropertyChanges { target: connectActionButton; pushUpColor: "white" }
            PropertyChanges { target: connectActionButton; pushDownColor: "#F6F6F6" }
            PropertyChanges { target: connectActionButton; action: openManualSettings }
        }
    ]
    state: "online"
    contentData: Column {
        anchors.fill: parent
        topPadding: 0.6 * connectionStatusImage.height
        bottomPadding: connectionInfoColumn.spacing
        spacing: height -
                 topPadding -
                 connectionInfoColumn.height -
                 connectActionButton.height -
                 bottomPadding

        Column {
            id: connectionInfoColumn
            width: parent.width
            height: connectionStatusImage.height +
                    connectionStatusTitleLabel.contentHeight +
                    connectionStatusDescriptionLabel.height +
                    2 * spacing
            spacing: 0.75 * connectionStatusTitleLabel.font.pixelSize

            Image {
                id: connectionStatusImage
                width: 0.39 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }

            Label {
                id: connectionStatusTitleLabel
                width: 0.6 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    pixelSize: 0.0525 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                    bold: true
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Label {
                id: connectionStatusDescriptionLabel
                width: 0.8 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    pixelSize: 0.75 * connectionStatusTitleLabel.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                opacity: 0.6
                lineHeight: 1.4
                elide: Label.ElideRight
                maximumLineCount: 5
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }
        }

        SaleComponents.Button_1 {
            id: connectActionButton
            width: 0.5 * parent.width
            height: 0.112 * parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            borderWidth: 0
            backRadius: 8
            fontSize: 0.028 * parent.width
        }
    }
}
