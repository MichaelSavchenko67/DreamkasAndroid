import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: choosePrinterType
    Layout.fillHeight: true
    Layout.fillWidth: true

    property var printerTypeName: ""

    onFocusChanged: {
        if (focus) {
            setMainPageTitle(printerTypeName)
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    onPrinterTypeNameChanged: {
        setMainPageTitle(printerTypeName)
    }

    contentData: Column {
        anchors.fill: parent
        spacing: title.font.pixelSize

        Label {
            id: title
            width: parent.width
            text: qsTr("Выберите тип подключения")
            font {
                pixelSize: 0.06 * parent.width
                family: "Roboto"
                styleName: "normal"
                weight: Font.Bold
                bold: true
            }
            clip: true
            elide: "ElideRight"
            horizontalAlignment: Label.AlignLeft
            verticalAlignment: Label.AlignVCenter
            topPadding: parent.spacing
            leftPadding: 0.7 * topPadding
        }

        SettingsComponents.InfoButton {
            id: connectionByIp
            width: 0.958 * parent.width
            height: 2.56 * 0.09 * parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            itemLogo: "qrc:/ico/settings/ip.png"
            itemTitle: "По IP-адресу"
            itemSubscription: "Вы можете подключить устройство, введя IP-адрес, если он вам известен"

            onClicked: {
                root.openPage("qrc:/qml/pages/subpages/printer/ConnectionByIp.qml")
            }
        }

        SettingsComponents.InfoButton {
            id: connectionManual
            width: connectionByIp.width
            height: connectionByIp.height
            anchors.horizontalCenter: connectionByIp.horizontalCenter
            itemLogo: "qrc:/ico/settings/manual.png"
            itemTitle: "Вручную"
            itemSubscription: "Мы поможем вам произвести ручную настройку принтера для подключения к приложению. Следуйте, пожалуйста, инструкциям на экране"

            onClicked: {
                root.openPage("qrc:/qml/pages/subpages/printer/ManualConnection.qml")
                rootStack.currentItem.stepValue = 1
            }
        }

        SettingsComponents.InfoButton {
            id: connectionAuto
            width: connectionByIp.width
            height: connectionByIp.height
            anchors.horizontalCenter: connectionByIp.horizontalCenter
            itemLogo: "qrc:/ico/settings/cast.png"
            itemTitle: "Автоматически"
            itemSubscription: "Мы всё сделаем за вас, потребуется только выбрать принтер и домашнюю WiFi сеть"

            onClicked: {
                root.openPage("qrc:/qml/pages/subpages/ScanWiFiNetworks.qml")
            }
        }
    }
}
