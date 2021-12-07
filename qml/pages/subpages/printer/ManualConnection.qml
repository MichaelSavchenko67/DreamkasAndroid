import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: rootFrame
    Layout.fillHeight: true
    Layout.fillWidth: true

    property int stepValue: 1

    Action {
        id: prevStep
        onTriggered: {
            if (stepValue === 1) {
                root.closePage()
            } else {
                stepValue--
            }
        }
    }

    Action {
        id: connect2printerWiFi
        text: qsTr("ПОДКЛЮЧИТЬ")
        onTriggered: {
        }
    }

    Action {
        id: connect2printerLocalhost
        text: qsTr("ПОДКЛЮЧИТЬ")
        onTriggered: {
        }
    }

    Action {
        id: setPrinterHomeNetwrok
        text: qsTr("НАСТРОИТЬ")
        onTriggered: {
        }
    }

    Action {
        id: connect2homeNetworkWiFi
        text: qsTr("ПОДКЛЮЧИТЬ")
        onTriggered: {
        }
    }

    Action {
        id: connect2printerByIp
        text: qsTr("ПОДКЛЮЧИТЬ")
        onTriggered: {
        }
    }

    function setStep(step) {
        console.debug("[ManualConnection.qml]\t\tinitpPage step: " + step)
        stepNumber.text = step + "/5"

        switch (step) {
            case 1:
                title.text = qsTr("Подключение к Wi-Fi сети принтера")
                subTitle.text = qsTr("Необходимо подключиться к WiFi сети принтера <b>viki_print_wifi_</b>")
                description.text = qsTr("После нажатия на кнопку <b>«Подключить»</b> откроется список сетей Wi-FI в новом окне. Вы сможете выбрать сеть из списка или подключить новую. После подключения вернитесь в приложение.")
                stepButton.action = connect2printerWiFi
                break
            case 2:
                title.text = qsTr("Подключение к принтеру")
                subTitle.text = qsTr("Необходимо подключиться к принтеру <b>VikiPrint WiFi</b>")
                description.text = qsTr("После нажатия на кнопку <b>«Подключить»</b> мы подключим принтер к приложению для дальнейшей его настройки.")
                stepButton.action = connect2printerLocalhost
                break
            case 3:
                title.text = qsTr("Выбор домашней сети")
                subTitle.text = qsTr("Необходимо настроить сеть принтера <b>VikiPrint WiFi</b>")
                description.text = qsTr("После нажатия на кнопку <b>«Настроить»</b> мы предложим вам список доступных <b>сетей WiFi</b>. При необходимости нужно ввести пароль сети. Выбранная сеть будет использоваться принтером в качестве домашней сети. После настройки распечатается <b>ip адрес</b> принтера.")
                stepButton.action = setPrinterHomeNetwrok
                break
            case 4:
                title.text = qsTr("Подключение к домашней WiFi сети")
                subTitle.text = qsTr("Необходимо подключиться к WiFi сети <b>WiFi сеть</b>")
                description.text = qsTr("После нажатия на кнопку <b>«Подключить»</b> откроется список <b>сетей Wi-FI</b> в новом окне. Вы сможете выбрать сеть из списка или подключить новую. После подключения вернитесь в приложение.")
                stepButton.action = connect2homeNetworkWiFi
                break
            case 5:
                title.text = qsTr("Подключение к принтеру по Ip")
                subTitle.text = qsTr("Необходимо подключиться по <b>ip адресу</b> к принтеру <b>VikiPrint WiFi</b>")
                description.text = qsTr("После нажатия на кнопку <b>«Подключить»</b> мы откроем экран подключения по <b>ip адресу</b>. <b>ip адрес</b> принтера напечатан на чеке.")
                stepButton.action = connect2printerByIp
                setLeftMenuButtonAction(close)
                break
            case 6:
                rootStack.replace("qrc:/qml/pages/subpages/printer/ConnectionByIp.qml")
                break
            default:
                root.closePage()
                break
        }
    }

    onStepValueChanged: {
        console.debug("[ManualConnection.qml]\t\tonStepValueChanged step: " + stepValue)
        setStep(stepValue)
    }

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Подключение вручную")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(prevStep)
            setLeftButtonIco("qrc:/ico/menu/back.png")
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
            setStep(stepValue)
        }
    }

    contentData: Column {
        id: rootColumn
        width: rootFrame.width
        spacing: title.font.pixelSize
        leftPadding: 0.7 * spacing
        topPadding: spacing

        Row {
            id: titleRow
            width: parent.width - 2 * parent.leftPadding
            spacing: 0.5 * title.font.pixelSize

            Label {
                id: stepNumber
                font {
                    pixelSize: 0.06 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "#5C7490"
                clip: title.clip
                elide: title.elide
                lineHeight: title.lineHeight
                horizontalAlignment: title.horizontalAlignment
                verticalAlignment: title.verticalAlignment
            }

            Label {
                id: title
                width: parent.width - stepNumber.contentWidth
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
                lineHeight: 1.4
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }
        }

        Label {
            id: subTitle
            width: titleRow.width
            font {
                pixelSize: 0.8 * title.font.pixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            clip: title.clip
            elide: title.elide
            maximumLineCount: 3
            lineHeight: title.lineHeight
            wrapMode: title.wrapMode
            horizontalAlignment: title.horizontalAlignment
            verticalAlignment: title.verticalAlignment
        }

        Label {
            id: description
            width: subTitle.width
            font: subTitle.font
            opacity: 0.6
            clip: subTitle.clip
            elide: subTitle.elide
            maximumLineCount: 8
            wrapMode: subTitle.wrapMode
            lineHeight: title.lineHeight
            horizontalAlignment: subTitle.horizontalAlignment
            verticalAlignment: subTitle.verticalAlignment
        }
    }

    footer: Rectangle {
        width: parent.width
        height: 0.32 * width
        color: "transparent"

        SaleComponents.Button_1 {
            id: stepButton
            width: 0.92 * parent.width
            height: 0.16 * width
            anchors.centerIn: parent
            borderWidth: 0
            backRadius: 8
            buttonTxt: action.text
            fontSize: 0.25 * height
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            onClicked: {
                stepValue++
            }
        }
    }
}
