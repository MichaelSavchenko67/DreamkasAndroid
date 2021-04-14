import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
//import QtQuick.Extras 1.4

import "qrc:/qml/components/sale" as SaleComponents

Page {
    property var utmIp: "" //utmModel.getIp()
    property int utmPort: 0 //utmModel.getPort()
    property bool isUtmSet: true//((utmIp.length > 0) && (utmPort !== 0))
    property bool isConnectedUtm: false

    property bool isSetPrintSlip: false
    property bool isSetClock: false

    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            console.log("[Connect2printer.qml]\tfocus changed: " + focus)
            setMainPageTitle("ЕГАИС")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
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

//    Timer { id: delay; interval: 15000; repeat: false; running: true; onTriggered: { console.log("Transform widget")
//        isUtmSet: true
//        } }

    Page {
        id: inputIpPortUTM
        anchors.fill: parent
        visible: !isUtmSet
//        Layout.fillHeight: true
//        Layout.fillWidth: true

        Column {
            id: titleInputIpPortUTM
            width: parent.width
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

            SaleComponents.Button_1 {
                anchors.horizontalCenter: parent.horizontalCenter
                width: ipColumn.width
                height: 0.16 * width
                enabled: ipField.acceptableInput && portField.acceptableInput
                borderWidth: 0
                backRadius: 8
                buttonTxt: qsTr("ПОДКЛЮЧИТЬ УСТРОЙСТВО")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: enabled ? "#415A77" : "#BDC3C7"
                pushDownColor: "#004075"
                onClicked: {
                    root.connectToUtm()
                }
            }
        }
    }


    Page {
        id: infoUTM
        anchors.fill: parent
        visible: !inputIpPortUTM.visible


        Column {
            id: titleInfoUTM
            width: parent.width
            spacing: titleLabelInfo.font.pixelSize
            leftPadding: 0.7 * spacing
            topPadding: spacing

            Label {
                id: titleLabelInfo
                width: parent.width
                text: qsTr("Настройки")
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

            Rectangle {
                id: infoIpPort
                width: parent.width - 2 * parent.leftPadding
                height: 100
                color: "#F6F6F6"
                radius: 16

                Column {
                    id: ipColumnInfo
                    width: parent.width
                    spacing: 0.15 * titleInfoUTM.spacing

//                    Row {
//                        width: parent.width
//                        leftPadding: titleLabelInfo.leftPadding
//                        spacing: 0.25 * connectedMsg.font.pixelSize

//                        Image {
//                            anchors.verticalCenter: parent.verticalCenter
//                            width: connectedMsg.font.pixelSize
//                            height: width
//                            source: isConnectedUtm ? "qrc:/ico/utm/connect.png" : "qrc:/ico/utm/disconnect.png"
//                        }

//                        Label {
//                            id: connectedMsg
//                            text: qsTr((isConnectedUtm) ? "Подключено" : "Отключено")
//                            font {
//                                pixelSize: 0.83 * infoIpLabel.font.pixelSize
//                                family: "Roboto"
//                                styleName: "normal"
//                                weight: Font.Normal
//                            }
//                            color: "#979797"
//                            clip: true
//                            elide: "ElideRight"
//                            verticalAlignment: Label.AlignBottom
//                        }
//                    }


//                    Row {
//                        id: infoIp
//                        width: parent.width
//                        height: 2.56 * infoIpIco.height
//                        leftPadding: 0.7 * title.topPadding

//                        Image {
//                            id: infoIpIco
//                            anchors.verticalCenter: parent.verticalCenter
//                            width: 0.09 * parent.width
//                            height: width
//                            source: "qrc:/ico/utm/ip.png"
//                        }

//                        Column {
//                            width: parent.width - infoIpIco.width - 2 * parent.leftPadding
//                            height: infoIpIco.height
//                            anchors.verticalCenter: parent.verticalCenter

//                            Label {
//                                id: infoIpLabel
//                                width: parent.width
//                                text: qsTr("IP-адрес устройства")
//                                font {
//                                    pixelSize: 0.5 * infoIpIco.height
//                                    family: "Roboto"
//                                    styleName: "normal"
//                                    weight: Font.Normal
//                                }
//                                color: "black"
//                                clip: true
//                                elide: "ElideRight"
//                                verticalAlignment: Label.AlignTop
//                                leftPadding: font.pixelSize
//                            }
//                        }
//                    }

                }
            }

            Row {
                id: printSlip
                width: parent.width - 2 * parent.leftPadding

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
//                    horizontalAlignment: Label.AlignLeft
//                    verticalAlignment: Label.AlignVCenter
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
                    width: parent.width - imageClockSale.width - switchClockSale.width
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
//                    verticalAlignment: Label.AlignTop
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

            Row {
                id: tumblerClock
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelClockSale.width
                visible: isSetClock
                spacing: 10//titleInputIpPortUTM.spacing //ipColumn.spacing


                TextMetrics {
                    id: textMetric
                    font: startTimeField.font
                    text: "00:00"
                }

                TextField {
                    id: startTimeField
                    width: textMetric.tightBoundingRect.width + 2

                    placeholderTextColor: "#000000"
                    horizontalAlignment: TextInput.AlignHCenter
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    validator: RegExpValidator {regExp:  /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/ }
                    font: labelClockSale.font
                    color: "#0064B4"
                }

                Label {
//                    width: textMetric.tightBoundingRect.width
                    text: qsTr("–")
                    font: startTimeField.font
                    color: "black"
                    clip: true
                    elide: "ElideRight"
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: font.pixelSize
                }

                TextField {
                    id: endTimeField
                    width: textMetric.tightBoundingRect.width + 2

                    placeholderTextColor: "#000000"
                    horizontalAlignment: TextInput.AlignHCenter
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    validator: RegExpValidator {regExp:  /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/ }
                    font: labelClockSale.font
                    color: "#0064B4"
                }

//                Tumbler {
//                    id: startTumblerHours
//                    height: imageClockSale.height * 2
//                    font: labelClockSale.font
//                    visibleItemCount: 3
//                }

            }

        }
    }
}
