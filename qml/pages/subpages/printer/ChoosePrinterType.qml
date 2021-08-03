import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: choosePrinterType
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            setMainPageTitle("Подключение ККТ")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Column {
        anchors.fill: parent
        spacing: title.font.pixelSize

        Column {
            id: connectedPrinter
            visible: isPrinterConnected
            width: parent.width
            height: connectedPrinterTitle.contentHeight + connectedPrinterDelegate.height + spacing
            spacing: title.font.pixelSize

            Label {
                id: connectedPrinterTitle
                width: parent.width
                text: qsTr("Подключенное устройство")
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

            SettingsComponents.ChoosenItemDelegate {
                id: connectedPrinterDelegate
                width: parent.width - 0.7 * parent.spacing
                height: 2.56 * 0.09 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                buttonTitle: "VIKI PRINT 57 283733"
                connectedMsgTitle: "Подключено"
            }
        }

        Column {
            width: parent.width
            height: parent.height - (isPrinterConnected ? connectedPrinter.height : 0) - parent.spacing
            spacing: title.font.pixelSize

            Label {
                id: title
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

            ListView {
                id: printerTypes
                width: parent.width
                height: parent.height - title.height
                clip: true
                model: ListModel {
                    id: printerTypesList

                    ListElement {
                        manufacturer: "Дримкас"
                        models: "Вики Принт 57, Вики Принт 57+, Вики Принт 80"
                        logo: "qrc:/ico/printer/dreamkas.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }

                    ListElement {
                        manufacturer: "Атол"
                        models: "АТОЛ 15Ф, АТОЛ 55Ф, АТОЛ 25Ф, АТОЛ 77Ф, АТОЛ 30Ф, АТОЛ 11Ф, АТОЛ 20Ф, АТОЛ 50Ф, АТОЛ 91Ф"
                        logo: "qrc:/ico/printer/atol.png"
                    }
                }

                delegate: SettingsComponents.InfoButton {
                    id: printerTypeDelegate
                    width: 0.958 * parent.width
                    height: 2.56 * 0.09 * parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    itemLogo: logo
                    itemTitle: manufacturer
                    itemSubscription: "Поддерживаемые устройства: " + models

                    onClicked: {
                        root.openPage("qrc:/qml/pages/subpages/printer/ChooseConnectionType.qml")
                        rootStack.currentItem.printerTypeName = manufacturer
                    }
                }

                ScrollBar.vertical: ScrollBar {
                    id: scroll
                    policy: ScrollBar.AsNeeded
                    width: 8
                }
            }
        }
    }
}
