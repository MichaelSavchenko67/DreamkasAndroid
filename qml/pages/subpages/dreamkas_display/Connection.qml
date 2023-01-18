import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Дримкас Дисплей")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
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
            id: connectionByQrCode
            width: 0.958 * parent.width
            height: 0.2304 * parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            itemLogo: "qrc:/ico/sale/carbon_qr_code.png"
            itemTitle: "Считать QR-код"
            itemSubscription: "Отсканируйте код при помощи камеры или сканера штрихкода"
            onClicked: {
            }
        }

        SettingsComponents.InfoButton {
            id: connectionByNsd
            width: connectionByQrCode.width
            height: connectionByQrCode.height
            anchors.horizontalCenter: connectionByQrCode.horizontalCenter
            itemLogo: "qrc:/ico/settings/language.png"
            itemTitle: "Автоматически"
            itemSubscription: "Автоматический поиск в сети доступных устройств"
            onClicked: {
                root.openPage("qrc:/qml/pages/subpages/dreamkas_display/ConnectionByNsd.qml")
            }
        }

        SettingsComponents.InfoButton {
            id: connectionAuto
            width: connectionByQrCode.width
            height: connectionByQrCode.height
            anchors.horizontalCenter: connectionByQrCode.horizontalCenter
            itemLogo: "qrc:/ico/settings/manual.png"
            itemTitle: "Ввести вручную"
            itemSubscription: "Подключить устройство по введённому\nIP-адресу и порту"
            onClicked: {
                root.openPage("qrc:/qml/pages/subpages/dreamkas_display/ConnectionByIpPort.qml")
            }
        }
    }
}
