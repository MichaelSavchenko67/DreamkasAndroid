import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: payQrSberbankSettings

    property bool clientSecretView: false

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Плати QR (Сбербанк)")
            resetAddRightMenuButton()
            resetAddRightMenuButton2()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    Timer {
        id: connectingTimer
        interval: 3000
        repeat: false
        onTriggered: {
            root.popupReset()
            root.closePage()
        }
    }

    function openConnectingDialog() {
        popupReset()
        root.popupSetTitle("Подключение")
        root.popupSetClosePolicy(Popup.CloseOnPressOutside | Popup.CloseOnEscape)
        root.popupSetLoader(true)
        root.popupOpen()
        connectingTimer.running = true
    }

    ScrollView {
        width: parent.width
        height: parent.height - saveData.height - dataColumn.topPadding
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.vertical.width: 8

        contentData: Column {
            id: dataColumn
            width: parent.width
            spacing: tidField.font.pixelSize
            topPadding: 0.5 * spacing
            leftPadding: 0.08 * parent.width
            clip: true

            Column {
                id: tidColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: tidFieldTitle
                    width: parent.width
                    text: "Идентификатор терминала"
                    font {
                        pixelSize: 0.67 * tidField.font.pixelSize
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

                Row {
                    id: tidFieldRow
                    width: parent.width
                    spacing: 0.5 * tidFieldHelpButton.width

                    TextField {
                        id: tidField
                        width: parent.width - tidFieldHelpButton.width - parent.spacing
                        placeholderText: (text.length === 0) ? "TID" : text
                        placeholderTextColor: "#979797"
                        inputMethodHints: Qt.ImhDigitsOnly
                        font {
                            pixelSize: 0.06 * parent.width
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#0064B4"
                        onEditingFinished: {
                        }
                    }

                    SettingsComponents.ToolTipButton {
                        id: tidFieldHelpButton
                    }

                    SettingsComponents.ToolTipPopup {
                        visible: tidFieldHelpButton.isHelpVisible
                        text: qsTr("Здесь могла бы быть ваша реклама")
                        x: tidField.x
                        y: tidField.y + tidField.height
                        onClosed: {
                            tidFieldHelpButton.isHelpVisible = false
                        }
                    }
                }
            }

            Column {
                id: idQrFieldColumn
                width: tidColumn.width
                anchors.horizontalCenter: tidColumn.horizontalCenter
                spacing: tidColumn.spacing

                Label {
                    id: idQrFieldTitle
                    width: tidFieldTitle.width
                    text: "Идентификатор QR-устройства"
                    font: tidFieldTitle.font
                    color: tidFieldTitle.color
                    clip: tidFieldTitle.clip
                    elide: tidFieldTitle.elide
                    horizontalAlignment: tidFieldTitle.horizontalAlignment
                    verticalAlignment: tidFieldTitle.verticalAlignment
                }

                Row {
                    id: idQrFieldRow
                    width: tidFieldRow.width
                    spacing: tidFieldRow.spacing

                    TextField {
                        id: idQrField
                        width: parent.width - idQrFieldHelpButton.width - parent.spacing
                        placeholderText: (text.length === 0) ? "idQR" : text
                        placeholderTextColor: tidField.placeholderTextColor
                        font: tidField.font
                        color: tidField.color
                        maximumLength: 20
                        onEditingFinished: {
                        }
                    }

                    SettingsComponents.ToolTipButton {
                        id: idQrFieldHelpButton
                    }

                    SettingsComponents.ToolTipPopup {
                        visible: idQrFieldHelpButton.isHelpVisible
                        text: qsTr("Здесь могла бы быть ваша реклама")
                        x: idQrField.x
                        y: idQrField.y + idQrField.height
                        onClosed: {
                            idQrFieldHelpButton.isHelpVisible = false
                        }
                    }
                }
            }
        }
    }

    SaleComponents.Button_1 {
        id: saveData
        width: 0.92 * dataColumn.width
        height: 0.16 * width
        enabled: ((tidField.text.length > 0) && (idQrField.text.length > 0))
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 0.5 * dataColumn.spacing
        }
        opacity: enabled ? 1 : 0.6
        borderWidth: 0
        backRadius: 8
        buttonTxt: qsTr("СОХРАНИТЬ")
        fontSize: 0.27 * height
        buttonTxtColor: "white"
        pushUpColor: "#415A77"
        pushDownColor: "#004075"
        onClicked: {
            openConnectingDialog()
        }
    }
}
