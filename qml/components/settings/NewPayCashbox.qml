import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Item {
    id: cashboxItem
    property string cashboxName: ""
    property string cashboxKey: ""
    property bool isActive: false

    signal cashboxChecked()

    onCashboxKeyChanged: {
        if (cashboxKey.length > 0) {
            state = "view"
        }
    }

    Timer {
        id: updateDelay
        interval: 3000
        repeat: false
        onTriggered: {
            //            cashboxItem.state = "error"
            cashboxItem.state = "success"
        }
    }

    Action {
        id: cancelAction
        onTriggered: {
            cashboxItem.state = ((cashboxKey.length > 0) ? "view" : "add")
        }
    }

    Action {
        id: updateAction
        onTriggered: {
            cashboxButton.state = "loading"
            updateDelay.restart()
        }
    }

    Action {
        id: editAction
        onTriggered: {
            cashboxItem.state = "edit"
        }
    }

    states: [
        State {
            name: "add"
            PropertyChanges { target: errorColumn; visible: false }
            PropertyChanges { target: cashboxDataRow; visible: false }
            PropertyChanges { target: cashboxEditColumn; visible: false }
            PropertyChanges { target: cashboxButton; state: "disable" }
            PropertyChanges { target: cancelButton; visible: false }
            PropertyChanges { target: addCashboxButton; visible: true }
        },
        State {
            name: "edit"
            PropertyChanges { target: errorColumn; visible: false }
            PropertyChanges { target: addCashboxButton; visible: false }
            PropertyChanges { target: cashboxDataRow; visible: false }
            PropertyChanges { target: cashboxEditColumn; visible: true }
            PropertyChanges { target: cancelButton; visible: true }
            PropertyChanges { target: cashboxButton; state: "edit" }
        },
        State {
            name: "view"
            PropertyChanges { target: errorColumn; visible: false }
            PropertyChanges { target: addCashboxButton; visible: false }
            PropertyChanges { target: cashboxEditColumn; visible: false }
            PropertyChanges { target: cashboxDataRow; visible: true }
            PropertyChanges { target: cancelButton; visible: false }
            PropertyChanges { target: cashboxButton; state: "view" }
        },
        State {
            name: "error"
            PropertyChanges { target: addCashboxButton; visible: false }
            PropertyChanges { target: cashboxEditColumn; visible: false }
            PropertyChanges { target: cashboxDataRow; visible: false }
            PropertyChanges { target: cancelButton; visible: false }
            PropertyChanges { target: cashboxButton; state: "disable" }
            PropertyChanges { target: errorIco; source: "qrc:/ico/menu/operation_failed.png" }
            PropertyChanges { target: errorMsg; text: qsTr("Ошибка Ошибка Ошибка Ошибка Ошибка Ошибка Ошибка Ошибка Ошибка Ошибка") }
            PropertyChanges { target: errorColumn; visible: true }
        },
        State {
            name: "success"
            PropertyChanges { target: addCashboxButton; visible: false }
            PropertyChanges { target: cashboxEditColumn; visible: false }
            PropertyChanges { target: cashboxDataRow; visible: false }
            PropertyChanges { target: cancelButton; visible: false }
            PropertyChanges { target: cashboxButton; state: "disable" }
            PropertyChanges { target: errorIco; source: "qrc:/ico/menu/operation_success.png" }
            PropertyChanges { target: errorMsg; text: qsTr("Данные сохранены") }
            PropertyChanges { target: errorColumn; visible: true }
        }
    ]
    state: "add"
    onStateChanged: {
        cashboxNameField.focus = (state === "edit")
    }
    scale: addCashboxButton.pressed ? 1.025 : 1.0

    DropShadow {
        anchors.fill: contentRect
        cached: true
        horizontalOffset: 0
        verticalOffset: 2
        radius: 8.0
        samples: 16
        color: "#d6d6d6"
        source: contentRect
    }

    Rectangle {
        id: contentRect
        anchors.fill: parent
        radius: 8
        color: "white"

        Column {
            id: cashboxEditColumn
            width: 0.9 * parent.width
            height: parent.height
            anchors.horizontalCenter: parent
            spacing: cashboxDataRow.spacing
            topPadding: 2 * spacing
            leftPadding: topPadding

            Label {
                width: parent.width
                text: "Введите наименование кассы"
                font {
                    pixelSize: cashboxTitleLabel.font.pixelSize
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
                id: cashboxNameField
                width: parent.width
                text: cashboxName
                placeholderText: (text.length === 0) ? "Наименование кассы" : text
                placeholderTextColor: "#979797"
                font {
                    pixelSize: 0.06 * cashboxItem.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "#0064B4"
            }
        }

        Row {
            id: cashboxDataRow
            width: 0.9 * parent.width
            anchors.horizontalCenter: parent

            spacing: 0.5 * cashboxTitleLabel.font.pixelSize
            topPadding: 2 * spacing
            leftPadding: topPadding

            Column {
                width: parent.width - switchActive.implicitContentWidth - parent.spacing
                anchors.verticalCenter: parent.verticalCenter
                spacing: parent.spacing

                Label {
                    id: cashboxTitleLabel
                    width: parent.width
                    text: qsTr(cashboxName)
                    font {
                        pixelSize: 0.0498 * cashboxDataRow.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    clip: true
                    elide: "ElideRight"
                    maximumLineCount: 2
                    wrapMode: Label.WordWrap
                    verticalAlignment: Label.AlignTop
                }

                Label {
                    id: cashboxKeyLabel
                    width: parent.width
                    text: qsTr(cashboxKey)
                    font {
                        pixelSize: 0.8 * cashboxTitleLabel.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    clip: true
                    elide: "ElideRight"
                    maximumLineCount: 4
                    wrapMode: Label.WrapAnywhere
                    verticalAlignment: Label.AlignBottom
                }
            }

            Switch {
                id: switchActive
                anchors.verticalCenter: parent.verticalCenter
                checked: isActive
                onCheckedChanged: {
                    if (checked) {
                        cashboxChecked()
                    }
                }
            }
        }

        Button {
            id: addCashboxButton
            anchors.fill: parent
            background: Rectangle {
                Column {
                    width: 0.5 * parent.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: (height - addCashboxIco.height - addTileMsg2user.contentHeight) / 3
                    topPadding: spacing

                    Image {
                        id: addCashboxIco
                        width: 0.2 * parent.width
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "qrc:/ico/tiles/addTile.png"
                    }

                    Label {
                        id: addTileMsg2user
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Добавить")
                        font {
                            pixelSize: 1.2 * cashboxTitleLabel.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#979797"
                        lineHeight: 1.2
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }
                }
            }
            onClicked: {
                cashboxItem.state = "edit"
            }
        }

        Column {
            id: errorColumn
            width: parent.width
            height: errorIco.height + spacing + errorMsg.contentHeight
            anchors.centerIn: parent
            spacing: cashboxEditColumn.spacing

            Timer {
                running: errorColumn.visible
                repeat: false
                interval: 2000
                onTriggered: {
                    cashboxItem.state = (cashboxKey.length === 0) ? "add" : "view"
                }
            }

            Image {
                id: errorIco
                width: 0.15 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: errorMsg
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                font: cashboxTitleLabel.font
                elide: Label.ElideRight
                maximumLineCount: 2
                wrapMode: Label.WordWrap
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }
        }

        Row {
            width: parent.width
            anchors.bottom: parent.bottom
            leftPadding: (width - (cancelButton.visible ? cancelButton.width : cancelButton.implicitBackgroundWidth) - cashboxButton.width)

            SaleComponents.Button_1 {
                id: cancelButton
                width: 0.3 * parent.width
                height: cashboxButton.height
                buttonTxt: qsTr("ОТМЕНА")
                action: cancelAction
                borderWidth: cashboxButton.borderWidth
                fontSize: cashboxButton.fontSize
                buttonTxtColor: pressed ? "#004075" : "#415A77"
                pushUpColor: cashboxButton.pushUpColor
                pushDownColor: cashboxButton.pushDownColor
            }

            SaleComponents.Button_1 {
                id: cashboxButton
                width: ((state === "view") ? 0.45 : 0.35) * parent.width
                height: 0.15 * parent.width
                borderWidth: 0
                fontSize: 0.27 * height
                buttonTxtColor: pressed ? "#004075" : "#415A77"
                pushUpColor: "transparent"
                pushDownColor: pushUpColor

                states: [
                    State {
                        name: "disable"
                        PropertyChanges { target: cashboxButton; action: null }
                        PropertyChanges { target: cashboxButton; buttonTxt: qsTr("") }
                        PropertyChanges { target: loader; visible: false }
                        PropertyChanges { target: cashboxButton; visible: false }
                    },
                    State {
                        name: "edit"
                        PropertyChanges { target: cashboxButton; action: updateAction }
                        PropertyChanges { target: cashboxButton; buttonTxt: qsTr("СОХРАНИТЬ") }
                        PropertyChanges { target: loader; visible: false }
                        PropertyChanges { target: cashboxButton; visible: true }
                    },
                    State {
                        name: "view"
                        PropertyChanges { target: cashboxButton; action: editAction }
                        PropertyChanges { target: cashboxButton; buttonTxt: qsTr("РЕДАКТИРОВАТЬ") }
                        PropertyChanges { target: loader; visible: false }
                        PropertyChanges { target: cashboxButton; visible: true }
                    },
                    State {
                        name: "loading"
                        PropertyChanges { target: cashboxButton; action: null }
                        PropertyChanges { target: cashboxButton; buttonTxt: qsTr("") }
                        PropertyChanges { target: cashboxButton; visible: true }
                        PropertyChanges { target: loader; visible: true }
                    }
                ]

                onStateChanged: {
                    if (state === "loading") {
                        cancelButton.visible = false
                    }
                }

                BusyIndicator {
                    id: loader
                    visible: false
                    implicitHeight: 0.7 * parent.height
                    running: visible
                    anchors.centerIn: parent
                    Material.accent: "#5C7490"
                }
            }
        }
    }
}
