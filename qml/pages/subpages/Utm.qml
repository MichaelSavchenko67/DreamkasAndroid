import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
//import QtQuick.Extras 1.4

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: rootFrame
    property var utmIp: "" //utmModel.getIp()
    property int utmPort: 0 //utmModel.getPort()
    property bool isUtmSet: true//((utmIp.length > 0) && (utmPort !== 0))
    property bool isConnectedUtm: false

    property bool isSetPrintSlip: false
    property bool isSetClock: false
    property bool isSetCheckAge: false

    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("[Connect2printer.qml]\tfocus changed: " + focus)
            setMainPageTitle("ЕГАИС")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
            switchPrintSlip.checked = isSetPrintSlip
            switchClockSale.checked = isSetClock
            switchCheckAge.checked  = isSetCheckAge
        }
    }

    //    Connections {
    //        target: utmModel
    //        onFrontUpdateUtmSettings : {
    //            utmIp = ip
    //            utmPort = port
    //            isUtmSet = ((utmIp.length > 0) && (utmPort > 0))
    //        }
    //    }

    Column {
        id: titleInputIpPortUTM
        anchors.fill: parent
        visible: !isUtmSet
        spacing: titleLabelInput.font.pixelSize
        leftPadding: 0.7 * spacing
        topPadding: spacing

        Label {
            id: titleLabelInput
            width: parent.width
            text: qsTr("Введите настройки УТМ")
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
        }

        Column {
            id: ipColumn
            width: parent.width - 2 * parent.leftPadding
            spacing: 0.15 * titleInputIpPortUTM.spacing

            Label {
                id: ipTitle
                width: parent.width
                text: "IP-адрес устройства"
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
                validator: RegExpValidator {regExp:  /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ }
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
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: RegExpValidator {regExp:  /^()([1-9]|[1-5]?[0-9]{2,4}|6[1-4][0-9]{3}|65[1-4][0-9]{2}|655[1-2][0-9]|6553[1-5])$/ }
                font: ipField.font
                color: ipField.color
            }

        }

        Timer { id: connectToUtmDelay; interval: 300; repeat: false; onTriggered: { console.log("HELLO")/*model.connect2utm()*/ } }

        SaleComponents.Button_1 {
            id: buttonConnectUtm
            anchors.horizontalCenter: parent.horizontalCenter
            width: ipColumn.width
            height: 0.16 * width
            enabled: ipField.acceptableInput && portField.acceptableInput
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr("ПОДКЛЮЧИТЬ УСТРОЙСТВО")
            fontSize: 0.25 * height
            buttonTxtColor: "white"
            pushUpColor: enabled ? "#415A77" : "#BDC3C7"
            pushDownColor: "#004075"
            onClicked: {
                //root.connectToUtm()
                root.popupReset()
                root.popupSetTitle("Подключение к УТМ")
                root.popupOpen()
                root.popupSetLoader(true)
                connectToUtmDelay.running = true
            }
        }
    }

    Column {
        anchors.fill: parent
        visible: !titleInputIpPortUTM.visible

        ScrollView {
            id: scroll
            width: parent.width
            height: parent.height
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.width: 8
            leftPadding: 0.7 * columnContentInfoUTM.spacing
            rightPadding: 0.7 * columnContentInfoUTM.spacing

            Column {
                id: columnContentInfoUTM
                width: parent.width
                spacing: titleLabelInfo.font.pixelSize
                topPadding: spacing
                bottomPadding: spacing

                Label {
                    id: titleLabelInfo
                    width: parent.width - leftPadding
                    text: qsTr("Настройки")
                    font: titleLabelInput.font
                    clip: true
                    elide: "ElideRight"
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }

                Rectangle {
                    id: infoIpPort
                    width: parent.width
                    height: 0.46 * width
                    color: "#F6F6F6"
                    radius: 16

                    Column {
                        id: ipColumnInfo
                        width: parent.width
                        height: parent.height
                        topPadding: 0.5 * scroll.leftPadding

                        Rectangle {
                            width: parent.width
                            height: 0.15 * parent.height
                            color: "transparent"

                            Row {
                                anchors.fill: parent
                                leftPadding: 0.75 * scroll.leftPadding
                                spacing: 0.25 * connectedMsg.font.pixelSize

                                Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: connectedMsg.font.pixelSize
                                    height: width
                                    source: isConnectedUtm ? "qrc:/ico/utm/connect.png" : "qrc:/ico/utm/disconnect.png"
                                }

                                Label {
                                    id: connectedMsg
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: qsTr((isConnectedUtm) ? "Подключено" : "Отключено")
                                    font {
                                        pixelSize: 0.83 * infoIpLabel.font.pixelSize
                                        family: "Roboto"
                                        styleName: "normal"
                                        weight: Font.Normal
                                    }
                                    color: "#979797"
                                    clip: true
                                    elide: "ElideRight"
                                    verticalAlignment: Label.AlignBottom
                                }
                            }
                        }

                        Rectangle {
                            id: rectIpPort
                            width: parent.width
                            height: 0.4 * parent.height
                            color: "transparent"

                            Row {
                                id: infoIp
                                anchors.fill: parent
                                leftPadding: scroll.leftPadding

                                Image {
                                    id: infoIpIco
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: imagePrintSlip.width
                                    height: width
                                    source: "qrc:/ico/utm/ip.png"
                                }

                                Column {
                                    width: parent.width - infoIpIco.width - 2 * parent.leftPadding
                                    spacing: 0.1 * titleLabelInfo.font.pixelSize
                                    anchors.verticalCenter: parent.verticalCenter

                                    Label {
                                        id: infoIpLabel
                                        width: parent.width
                                        text: qsTr("IP-адрес устройства")
                                        font {
                                            pixelSize: 0.6 * infoIpIco.height
                                            family: "Roboto"
                                            styleName: "normal"
                                            weight: Font.Normal
                                        }
                                        color: "black"
                                        clip: true
                                        elide: "ElideRight"
                                        leftPadding: font.pixelSize
                                        verticalAlignment: Label.AlignTop
                                    }

                                    Label {
                                        width: parent.width
                                        text: qsTr(utmIp)
                                        font: connectedMsg.font
                                        color: connectedMsg.color
                                        clip: true
                                        elide: "ElideRight"
                                        leftPadding: infoIpLabel.leftPadding
                                        verticalAlignment: Label.AlignBottom
                                    }
                                }
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 0.4 * parent.height
                            color: "transparent"

                            Row {
                                id: infoPort
                                anchors.fill: parent
                                leftPadding: infoIp.leftPadding
                                spacing: infoIp.spacing

                                Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: infoIpIco.width
                                    height: width
                                    source: "qrc:/ico/utm/port.png"
                                }

                                Column {
                                    width: parent.width - infoIpIco.width - 2 * parent.leftPadding
                                    anchors.verticalCenter: parent.verticalCenter

                                    Label {
                                        width: parent.width
                                        text: qsTr("Порт")
                                        font: infoIpLabel.font
                                        color: "black"
                                        clip: true
                                        elide: "ElideRight"
                                        leftPadding: font.pixelSize
                                        verticalAlignment: Label.AlignTop
                                    }

                                    Label {
                                        width: parent.width
                                        text: qsTr(utmPort.toString())
                                        font: connectedMsg.font
                                        color: connectedMsg.color
                                        clip: true
                                        elide: "ElideRight"
                                        leftPadding: infoIpLabel.leftPadding
                                        verticalAlignment: Label.AlignBottom
                                    }
                                }
                            }
                        }
                    }
                }


                Row {
                    id: printSlip
                    width: parent.width

                    Image {
                        id: imagePrintSlip
                        anchors.verticalCenter: parent.verticalCenter
                        width: 0.09 * parent.width
                        height: width
                        source: "qrc:/ico/utm/print_slip.png"
                    }

                    Label {
                        id: labelPrintSlip
                        width: parent.width - imagePrintSlip.width - switchPrintSlip.width
                        text: qsTr("Печатать слип")
                        font {
                            pixelSize: 0.83 * titleLabelInfo.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "black"
                        clip: true
                        elide: "ElideRight"
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: font.pixelSize
                    }

                    Switch {
                        id: switchPrintSlip
                        anchors.verticalCenter: parent.verticalCenter
                        onCheckedChanged: {
                            isSetPrintSlip = checked
                        }
                    }
                }

                Row {
                    id: clockSale
                    width: printSlip.width

                    Image {
                        id: imageClockSale
                        anchors.verticalCenter: parent.verticalCenter
                        width: imagePrintSlip.width
                        height: width
                        source: "qrc:/ico/utm/clock.png"
                    }

                    Label {
                        id: labelClockSale
                        width: labelPrintSlip.width
                        text: qsTr("Указать время продажи")
                        font {
                            pixelSize: labelPrintSlip.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "black"
                        clip: true
                        elide: "ElideRight"
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: font.pixelSize
                    }

                    Switch {
                        id: switchClockSale
                        anchors.verticalCenter: parent.verticalCenter
                        onCheckedChanged: {
                            isSetClock = checked
                        }
                    }
                }

                SettingsComponents.PopupTumbler {
                    id: popupEnterTime

                    onEntered: {
                        clockSaleSet.startTime = startTime
                        clockSaleSet.finishTime = finishTime

                        //Call signal to model set time!
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: clockSaleSet.height
                    visible: isSetClock

                    SettingsComponents.ClockSale {
                        id: clockSaleSet
                        width: 0.6 * parent.width
                        height: 0.54 * width
                        anchors.horizontalCenter: parent.horizontalCenter

                        startTime: 11   //utmmodel.getStartTime()
                        finishTime: 22  //utmmodel.getFinishTime()

                        onClicked: {
                            popupEnterTime.finishTime = clockSaleSet.finishTime
                            popupEnterTime.startTime = clockSaleSet.startTime
                            popupEnterTime.open()
                        }
                    }
                }

                Row {
                    id: checkAge
                    width: printSlip.width

                    Image {
                        id: imageCheckAge
                        anchors.verticalCenter: parent.verticalCenter
                        width: imagePrintSlip.width
                        height: width
                        source: "qrc:/ico/utm/check_age.png"
                    }

                    Label {
                        id: labelCheckAge
                        width: labelPrintSlip.width
                        text: qsTr("Проверять возраст")
                        font {
                            pixelSize: labelPrintSlip.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "black"
                        clip: true
                        elide: "ElideRight"
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: font.pixelSize
                    }

                    Switch {
                        id: switchCheckAge
                        anchors.verticalCenter: parent.verticalCenter
                        onCheckedChanged: {
                            isSetCheckAge = checked
                        }
                    }
                }

                SaleComponents.Button_1 {
                    id: buttonDisconnectUtm
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: 0.16 * width
                    borderWidth: 0
                    backRadius: 8
                    buttonTxt: qsTr("ОТКЛЮЧИТЬ УСТРОЙСТВО")
                    fontSize: 0.23 * height
                    buttonTxtColor: "#415A77"
                    pushUpColor: "#F6F6F6"
                    onClicked: {

//                        openPopupCheckAge()
//                        openPopupClockSale()
                        openPopupCheckAlcoCode()

//                        isUtmSet = false
                        //! Signal onModel off device UTM.
                    }
                }
            }
        }
    }
}
