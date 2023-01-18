import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: rootFrame

    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Подключение ККТ")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Column {
        id: titleInputIpPort
        width: rootFrame.width
        height: rootFrame.height - buttonConnectPrinter.height - 2 * buttonConnectPrinter.anchors.bottomMargin
        spacing: titleLabelInput.font.pixelSize
        leftPadding: 0.7 * spacing
        topPadding: spacing

        Rectangle {
            width: 0.92 * parent.width
            height: 0.21 * rootFrame.height
            clip: true
            color: "#F6F6F6"
            radius: 8

            Column {
                width: parent.width - titleInputIpPort.spacing
                height: 0.8 * parent.height
                anchors.centerIn: parent
                topPadding: (height - 2 * installAtolDriver.height) / 3
                spacing: 2 * topPadding

                SettingsComponents.ButtonHyperlink {
                    id: installAtolDriver
                    width: parent.width
                    height: 0.45 * parent.height
                    title: "Установите «‎‎Драйвер АТОЛ»"
                    icoTitle: "Скачать файл"
                    icoPath: "qrc:/ico/settings/download"
                    onGo: {
                        console.info("installAtolDriver onGo")
                    }
                }

                SettingsComponents.ButtonHyperlink {
                    id: youtubeAtolDriver
                    width: installAtolDriver.width
                    height: installAtolDriver.height
                    title: "Посмотрите видеоинструкцию"
                    icoTitle: "Открыть в YouTube"
                    icoPath: "qrc:/ico/settings/youtube"
                    onGo: {
                        console.info("youtubeAtolDriver onGo")
                    }
                }
            }
        }

        Label {
            id: titleLabelInput
            width: parent.width - 2 * parent.leftPadding
            text: qsTr("Введите настройки устройства")
            font {
                pixelSize: 0.06 * parent.width
                family: "Roboto"
                styleName: "normal"
                weight: Font.Bold
                bold: true
            }
            clip: true
            elide: "ElideRight"
            maximumLineCount: 2
            wrapMode: Label.WordWrap
            lineHeight: 1.4
            horizontalAlignment: Label.AlignLeft
            verticalAlignment: Label.AlignVCenter
        }

        Column {
            id: ipColumn
            width: parent.width - 2 * parent.leftPadding
            spacing: 0.15 * titleInputIpPort.spacing

            Label {
                id: ipTitle
                width: parent.width
                text: "IP-адрес"
                font {
                    pixelSize: 0.75 * titleLabelInput.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "#979797"
                clip: true
                elide: "ElideRight"
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }

            TextField {
                id: ipField
                width: parent.width

                placeholderTextColor: "#000000"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: RegularExpressionValidator {regularExpression:  /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ }
                font {
                    pixelSize: titleLabelInput.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "#0064B4"
            }

        }

        Column {
            width: ipColumn.width
            spacing: ipColumn.spacing

            Label {
                id: portTitle
                width: ipTitle.width
                text: "Порт"
                font: ipTitle.font
                color: ipTitle.color
                clip: ipTitle.clip
                elide: ipTitle.elide
                horizontalAlignment: ipTitle.horizontalAlignment
                verticalAlignment: ipTitle.verticalAlignment
            }

            TextField {
                id: portField
                width: ipField.width
                placeholderTextColor: ipField.placeholderTextColor
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegularExpressionValidator {regularExpression:  /^()([1-9]|[1-5]?[0-9]{2,4}|6[1-4][0-9]{3}|65[1-4][0-9]{2}|655[1-2][0-9]|6553[1-5])$/ }
                font: ipField.font
                color: ipField.color
            }
        }
    }

    footer: Rectangle {
        width: parent.width
        height: 0.32 * width
        color: "transparent"

        SaleComponents.Button_1 {
            id: buttonConnectPrinter
            width: 0.92 * parent.width
            height: 0.16 * width
            anchors.centerIn: parent
            enabled: ipField.acceptableInput && portField.acceptableInput
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr("ПОДКЛЮЧИТЬ")
            fontSize: 0.25 * height
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            onClicked: {
            }
        }
    }
}
