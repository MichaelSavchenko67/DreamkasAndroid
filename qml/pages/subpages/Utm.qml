import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Page {
    property var utmIp: "" //utmModel.getIp()
    property int utmPort: 0 //utmModel.getPort()
    property bool isUtmSet: ((utmIp.length > 0) && (utmPort !== 0))

    Layout.fillHeight: true
    Layout.fillWidth: true

//    Connections {
//        target: utmModel
//        onFrontUpdateUtmSettings : {
//            utmIp = ip
//            utmPort = port
//            isUtmSet = ((utmIp.length > 0) && (utmPort > 0))
//        }
//    }

    Page {
        id: connectingUTM
        anchors.fill: parent
        visible: !isUtmSet
//        Layout.fillHeight: true
//        Layout.fillWidth: true



    //    property bool isUtmConnected: false

    //    property bool isLoader: false
    //    property bool isLoaded: false

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

        Column {
            id: titleColumn
            width: parent.width
            spacing: titleLabel.font.pixelSize
            leftPadding: 0.7 * spacing
            topPadding: spacing

            Label {
                id: titleLabel
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
                spacing: 0.15 * titleColumn.spacing

                Label {
                    id: ipTitle
                    width: parent.width
                    text: "IP-адрес устройства"
                    font {
                        pixelSize: 0.75 * titleLabel.font.pixelSize
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
                        pixelSize: titleLabel.font.pixelSize
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
        visible: !connectingUTM.visible


    }

}


//onCoreUpdateUtmSettings(const QString &ip, const int port)
//{
//    config_data.utmAddress = ip.toStdString();
//    config_data.utmPort = port;
//    const bool rc {sql && (sql->updateOptimized(SAVE_CFG, UTM_ADDRESS | UTM_PORT, &config_data) == 0)};
//    emit utmModelUpdateSettings(QString::fromStdString(config_data.utmAddress), config_data.utmPort);
//}

//onUtmModelUpdateSettings(const QString &ip, const int port)
//{
//    setIp(ip);
//    setPort(port);
//    emit frontUpdateUtmSettings(ip, port);
//}
