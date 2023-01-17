import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: connectionByNsdPage
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

    states: [
        State {
            name: "offline"
            PropertyChanges { target: title; visible: false }
            PropertyChanges { target: searchingColumn; visible: false }
            PropertyChanges { target: devicesNotFoundColumn; visible: false }
            PropertyChanges { target: devicesColumn; visible: false }
            PropertyChanges { target: offlineColumn; visible: true }
            PropertyChanges { target: openWiFiSettingsButton; visible: true }
        },
        State {
            name: "searching"
            PropertyChanges { target: title; visible: false }
            PropertyChanges { target: offlineColumn; visible: false }
            PropertyChanges { target: openWiFiSettingsButton; visible: false }
            PropertyChanges { target: devicesNotFoundColumn; visible: false }
            PropertyChanges { target: devicesColumn; visible: false }
            PropertyChanges { target: searchingColumn; visible: true }
        },
        State {
            name: "devicesNotFound"
            PropertyChanges { target: title; visible: false }
            PropertyChanges { target: offlineColumn; visible: false }
            PropertyChanges { target: openWiFiSettingsButton; visible: false }
            PropertyChanges { target: searchingColumn; visible: false }
            PropertyChanges { target: devicesColumn; visible: false }
            PropertyChanges { target: devicesNotFoundColumn; visible: true }
        },
        State {
            name: "devicesFound"
            PropertyChanges { target: offlineColumn; visible: false }
            PropertyChanges { target: openWiFiSettingsButton; visible: false }
            PropertyChanges { target: searchingColumn; visible: false }
            PropertyChanges { target: devicesNotFoundColumn; visible: false }
            PropertyChanges { target: title; visible: true }
            PropertyChanges { target: devicesColumn; visible: true }

        }
    ]
    state: "devicesFound"

    contentData: Column {
        anchors.fill: parent
        spacing: title.font.pixelSize

        Label {
            id: title
            visible: false
            width: parent.width
            text: qsTr("Выберите устройство")
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

        Column {
            id: offlineColumn
            visible: false
            width: parent.width
            topPadding: 0.5 * (parent.height -
                               offlineIco.height -
                               spacing -
                               offlineMsgColumn.height -
                               openWiFiSettingsButton.height -
                               openWiFiSettingsButton.anchors.bottomMargin)
            spacing: parent.spacing

            Image {
                id: offlineIco
                width: 0.39 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:/ico/settings/offline.png"
            }

            Column {
                id: offlineMsgColumn
                width: parent.width
                spacing: 0.5 * parent.spacing

                Label {
                    width: parent.width
                    text: "Нет сети"
                    font: searchingTitleLabel.font
                    color: searchingTitleLabel.color
                    clip: searchingTitleLabel.clip
                    elide: searchingTitleLabel.elide
                    horizontalAlignment: searchingTitleLabel.horizontalAlignment
                    verticalAlignment: searchingTitleLabel.verticalAlignment
                }

                Label {
                    width: 0.8 * parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Проверьте подключение устройства к сети WiFi")
                    font {
                        pixelSize: 0.75 * searchingTitleLabel.font.pixelSize
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
        }

        Column {
            id: searchingColumn
            visible: false
            width: parent.width
            anchors.centerIn: parent
            spacing: parent.spacing

            Label {
                id: searchingTitleLabel
                width: parent.width
                text: "Поиск устройств в сети"
                font {
                    pixelSize: 0.75 * title.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                opacity: 0.6
                clip: true
                elide: Label.ElideRight
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            BusyIndicator {
                id: searchingLoader
                implicitWidth: 0.1 * root.width
                implicitHeight: implicitWidth
                visible: searchingColumn.visible
                running: visible
                anchors.horizontalCenter: parent.horizontalCenter
                Material.accent: "#5C7490"
            }
        }

        Timer {
            id: repeatSearchingDelay

            property int cnt: 10

            interval: 1000
            repeat: true
            running: devicesNotFoundColumn.visible
            onTriggered: {
                if (--cnt <= 0) {
                    connectionByNsdPage.state = "searching"
                }
            }
        }

        Column {
            id: devicesNotFoundColumn
            visible: false
            width: parent.width
            anchors.centerIn: parent
            spacing: parent.spacing

            Image {
                width: 0.39 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:/ico/settings/offline.png"
            }

            Label {
                width: parent.width
                text: "Устройства не найдены\nпотвторный поиск через\n" + repeatSearchingDelay.cnt + " секунд"
                font {
                    pixelSize: 0.75 * title.font.pixelSize
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                opacity: 0.6
                clip: true
                lineHeight: 1.3
                elide: Label.ElideRight
                maximumLineCount: 4
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }
        }

        Column {
            id: devicesColumn
            visible: false
            width: parent.width
            height: parent.height -
                    title.contentHeight -
                    2 * parent.spacing
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }

            ListView {
                id: devicesListView
                width: parent.width - title.font.pixelSize
                height: parent.height
                visible: (devicesListModel.count > 0)
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                cacheBuffer: 100 * 0.15 * devicesListView.height
                add: Transition { NumberAnimation { properties: "scale"; from: 0; to: 1; easing.type: Easing.InOutQuad } }
                remove: Transition { NumberAnimation { properties: "scale"; from: 1; to: 0; easing.type: Easing.InOutQuad } }
                model: ListModel {
                    id: devicesListModel

                    ListElement {
                        modelName: "Pixel"
                        ip: "192.168.100.5"
                        isBusy: true
                    }

                    ListElement {
                        modelName: "Pixel"
                        ip: "192.168.100.5"
                        isBusy: false
                    }

                    ListElement {
                        modelName: "Pixel"
                        ip: "192.168.100.5"
                        isBusy: true
                    }

                    ListElement {
                        modelName: "Pixel"
                        ip: "192.168.100.5"
                        isBusy: true
                    }

                    ListElement {
                        modelName: "Pixel"
                        ip: "192.168.100.5"
                        isBusy: false
                    }
                }
                delegate: ItemDelegate {
                    id: deviceDelegate
                    width: parent.width
                    height: deviceRow.height
                    enabled: !isBusy

                    Row {
                        id: deviceRow
                        width: parent.width
                        height: 2.56 * dreamkasDisplayIco.height
                        leftPadding: 0.7 * title.topPadding

                        Image {
                            id: dreamkasDisplayIco
                            anchors.verticalCenter: parent.verticalCenter
                            width: 0.09 * parent.width
                            height: width
                            source: "qrc:/img/dreamkas_display/dreamkas_display_logo.png"
                        }

                        Column {
                            width: parent.width -
                                   dreamkasDisplayIco.width -
                                   (busyIco.visible ? busyIco.width : 0) -
                                   (chooseIco.visible ? chooseIco.width : 0) -
                                   2 * parent.leftPadding
                            anchors.verticalCenter: parent.verticalCenter
                            leftPadding: deviceName.font.pixelSize
                            spacing: 0.5 * deviceIpLabel.font.pixelSize

                            Label {
                                id: deviceName
                                width: parent.width - 2 * parent.leftPadding
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: qsTr(modelName)
                                font {
                                    pixelSize: 0.5 * dreamkasDisplayIco.height
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Normal
                                }
                                color: "black"
                                clip: true
                                elide: Label.ElideRight
                                verticalAlignment: Label.AlignVCenter

                            }

                            Label {
                                id: deviceIpLabel
                                width: deviceName.width
                                anchors.horizontalCenter: deviceName.horizontalCenter
                                text: qsTr(ip)
                                font {
                                    pixelSize: 0.83 * deviceName.font.pixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Normal
                                }
                                color: "#979797"
                                clip: true
                                elide: Label.ElideRight
                                verticalAlignment: Label.AlignVCenter
                            }

                            Label {
                                visible: isBusy
                                text: qsTr("Устройство занято")
                                width: deviceName.width
                                anchors.horizontalCenter: deviceName.horizontalCenter
                                font: deviceIpLabel.font
                                color: deviceIpLabel.color
                                clip: deviceIpLabel.clip
                                elide: deviceIpLabel.elide
                                verticalAlignment: deviceIpLabel.verticalAlignment
                            }
                        }

                        Image {
                            id: busyIco
                            visible: isBusy
                            anchors.verticalCenter: parent.verticalCenter
                            width: dreamkasDisplayIco.width
                            height: width
                            source: "qrc:/ico/settings/lock.png"
                        }

                        Image {
                            id: chooseIco
                            visible: !isBusy
                            anchors.verticalCenter: parent.verticalCenter
                            width: dreamkasDisplayIco.width
                            height: width
                            source: "qrc:/ico/menu/choose_right.png"
                        }
                    }

                    onClicked: {
                    }
                }
                ScrollBar.vertical: ScrollBar {
                    id: scroll
                    policy: ScrollBar.AsNeeded
                    width: 8
                }
            }
        }

        SaleComponents.Button_1 {
            id: openWiFiSettingsButton
            width: 0.9 * parent.width
            height: 0.16 * width
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 1.925 * openWiFiSettingsButton.fontSize
            }
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr("ПЕРЕЙТИ К НАСТРОЙКАМ")
            fontSize: 0.27 * height
            buttonTxtColor: "#415A77"
            pushUpColor: "#F6F6F6"
            pushDownColor: "#B9B9B9"
            onClicked: {
            }
        }
    }
}
