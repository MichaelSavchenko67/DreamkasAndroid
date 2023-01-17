import QtQml 2.12
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: multiposService
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Банковский терминал")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: 0

        Column {
            id: rootColumn
            anchors.fill: parent
            spacing: operationName.font.pixelSize

            Label {
                id: operationName
                width: parent.width
                text: qsTr("Сервисные операции")
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
                topPadding: 0.042 * parent.width
                leftPadding: 0.7 * topPadding
            }

            ScrollView {
                width: parent.width
                height: parent.height - operationName.height - parent.spacing
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.vertical.width: 8

                Column {
                    width: parent.width
                    spacing: rootColumn.spacing

                    SettingsComponents.ServiceItemDelegate {
                        title: "Тест соединения с банком"
                        ico: "qrc:/ico/settings/responsive.png"
                    }

                    SettingsComponents.ServiceItemDelegate {
                        title: "Открыть меню на терминале"
                        ico: "qrc:/ico/settings/responsive.png"
                    }

                    SettingsComponents.ServiceItemDelegate {
                        title: "Отправка логов"
                        ico: "qrc:/ico/settings/responsive.png"
                    }

                    SettingsComponents.ServiceItemDelegate {
                        title: "Активация терминала"
                        ico: "qrc:/ico/settings/responsive.png"
                    }

                    SettingsComponents.ServiceItemDelegate {
                        title: "Сессия ТМС"
                        ico: "qrc:/ico/settings/responsive.png"
                    }

                    SettingsComponents.ServiceItemDelegate {
                        title: "Краткий отчёт"
                        ico: "qrc:/ico/settings/responsive.png"
                    }

                    SettingsComponents.ServiceItemDelegate {
                        title: "Полный отчёт"
                        ico: "qrc:/ico/settings/responsive.png"
                    }

                    SettingsComponents.ServiceItemDelegate {
                        title: "Отмена последней операции"
                        ico: "qrc:/ico/settings/responsive.png"
                    }
                }
            }
        }
    }
}
