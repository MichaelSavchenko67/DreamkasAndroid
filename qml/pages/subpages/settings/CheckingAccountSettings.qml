import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: checkingAccountSettings

    property string organizationInn: ""
    property string organizationName: ""
    property string bankBik: ""
    property string bankName: ""
    property string bankCorespondentAccount: ""
    property string bankCheckingAccount: ""

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Оплата на расчётный счёт")
            resetAddRightMenuButton()
            resetAddRightMenuButton2()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    Timer {
        id: loadOrganizationNameTimer
        interval: 3000
        repeat: false
        running: false
        onTriggered: {
            innField.enabled = true
            organizationNameFieldColumn.visible = true
        }
    }

    Timer {
        id: loadBankDataTimer
        interval: 3000
        repeat: false
        running: false
        onTriggered: {
            bankBikField.enabled = true
            bankNameFieldColumn.visible = true
            corespondentAccountNumberFieldColumn.visible = true
            checkingAccountNumberFieldColumn.visible = true
        }
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
            spacing: innField.font.pixelSize
            topPadding: spacing
            leftPadding: 0.08 * parent.width
            clip: true

            Column {
                id: innColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: innFieldTitle
                    width: parent.width
                    text: "ИНН"
                    font {
                        pixelSize: 0.67 * innField.font.pixelSize
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
                    id: innFieldRow
                    width: parent.width
                    spacing: 0.5 * innFieldTitle.font.pixelSize

                    TextField {
                        id: innField
                        width: parent.width - parent.spacing
                        placeholderText: (organizationInn.length === 0) ? "ИНН организации" : organizationInn
                        placeholderTextColor: "#979797"
                        font {
                            pixelSize: 0.06 * parent.width
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#0064B4"
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: RegularExpressionValidator { regularExpression: /^([1-9]{1}([0-9]{9}|[0-9]{11}))$/}
                        onTextChanged: {
                            organizationInn = text
                            console.log("[CheckingAccountSettings]\t\torganizationInn: " + organizationInn)
                        }
                        onEditingFinished: {
                            if (acceptableInput && !organizationNameFieldColumn.visible) {
                                innField.enabled = false
                                loadOrganizationNameTimer.running = true
                            }
                        }
                        onAcceptableInputChanged: {
                            if (!acceptableInput) {
                                organizationNameFieldColumn.visible = false
                            } else if ((text.length === 12) && !organizationNameFieldColumn.visible) {
                                innField.enabled = false
                                loadOrganizationNameTimer.running = true
                            }
                        }
                    }
                }
            }

            BusyIndicator {
                id: loaderOrganizationName
                visible: running
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: 0.1 * parent.width
                implicitHeight: implicitWidth
                running: loadOrganizationNameTimer.running
                Material.accent: "#5C7490"
            }

            Column {
                id: organizationNameFieldColumn
                width: innColumn.width
                visible: false
                anchors.horizontalCenter: innColumn.horizontalCenter
                spacing: innColumn.spacing

                Label {
                    id: organizationNameFieldTitle
                    width: innFieldTitle.width
                    text: "Название организации"
                    font: innFieldTitle.font
                    color: innFieldTitle.color
                    clip: innFieldTitle.clip
                    elide: innFieldTitle.elide
                    horizontalAlignment: innFieldTitle.horizontalAlignment
                    verticalAlignment: innFieldTitle.verticalAlignment
                }

                Row {
                    id: organizationNameFieldRow
                    width: innFieldRow.width
                    spacing: innFieldRow.spacing

                    TextField {
                        id: organizationNameField
                        width: parent.width - parent.spacing
                        placeholderText: (organizationName.length === 0) ? "Наименование юр. лица" : organizationName
                        placeholderTextColor: innField.placeholderTextColor
                        font: innField.font
                        color: innField.color
                        onTextChanged: {
                            organizationName = text
                            console.log("[CheckingAccountSettings]\torganizationName: " + organizationName)
                        }
                    }
                }
            }

            Column {
                id: bankBikFieldColumn
                width: innColumn.width
                anchors.horizontalCenter: innColumn.horizontalCenter
                spacing: innColumn.spacing

                Label {
                    id: bankBikFieldTitle
                    width: innFieldTitle.width
                    text: "БИК"
                    font: innFieldTitle.font
                    color: innFieldTitle.color
                    clip: innFieldTitle.clip
                    elide: innFieldTitle.elide
                    horizontalAlignment: innFieldTitle.horizontalAlignment
                    verticalAlignment: innFieldTitle.verticalAlignment
                }

                Row {
                    id: bankBikFieldRow
                    width: innFieldRow.width
                    spacing: innFieldRow.spacing

                    TextField {
                        id: bankBikField
                        width: parent.width - parent.spacing
                        placeholderText: (bankBik.length === 0) ? "БИК банка" : bankBik
                        placeholderTextColor: innField.placeholderTextColor
                        font: innField.font
                        color: innField.color
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: RegularExpressionValidator { regularExpression: /^(04[0-9]{7})$/}
                        onTextChanged: {
                            bankBik = text
                            console.log("[CheckingAccountSettings]\tbankBik: " + bankBik)
                        }
                        onAcceptableInputChanged: {
                            if (acceptableInput) {
                                bankBikField.enabled = false
                                loadBankDataTimer.running = true
                            } else {
                                bankNameFieldColumn.visible = false
                                corespondentAccountNumberFieldColumn.visible = false
                                checkingAccountNumberFieldColumn.visible = false
                            }
                        }
                    }
                }
            }

            BusyIndicator {
                id: loaderBankData
                visible: running
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: 0.1 * parent.width
                implicitHeight: implicitWidth
                running: loadBankDataTimer.running
                Material.accent: "#5C7490"
            }

            Column {
                id: bankNameFieldColumn
                width: innColumn.width
                visible: false
                anchors.horizontalCenter: innColumn.horizontalCenter
                spacing: innColumn.spacing

                Label {
                    id: bankNameFieldTitle
                    width: innFieldTitle.width
                    text: "Название банка"
                    font: innFieldTitle.font
                    color: innFieldTitle.color
                    clip: innFieldTitle.clip
                    elide: innFieldTitle.elide
                    horizontalAlignment: innFieldTitle.horizontalAlignment
                    verticalAlignment: innFieldTitle.verticalAlignment
                }

                Row {
                    id: bankNameFieldRow
                    width: innFieldRow.width
                    spacing: innFieldRow.spacing

                    TextField {
                        id: bankNameField
                        width: parent.width - parent.spacing
                        placeholderText: (bankName.length === 0) ? "Полное наименование банка" : bankName
                        placeholderTextColor: innField.placeholderTextColor
                        font: innField.font
                        color: innField.color
                        onTextChanged: {
                            bankName = text
                            console.log("[CheckingAccountSettings]\tbankName: " + bankName)
                        }
                    }
                }
            }

            Column {
                id: corespondentAccountNumberFieldColumn
                width: innColumn.width
                anchors.horizontalCenter: innColumn.horizontalCenter
                spacing: innColumn.spacing
                visible: false

                Label {
                    id: corespondentAccountNumberFieldTitle
                    width: innFieldTitle.width
                    text: "Номер К/С"
                    font: innFieldTitle.font
                    color: innFieldTitle.color
                    clip: innFieldTitle.clip
                    elide: innFieldTitle.elide
                    horizontalAlignment: innFieldTitle.horizontalAlignment
                    verticalAlignment: innFieldTitle.verticalAlignment
                }

                Row {
                    id: corespondentAccountNumberFieldRow
                    width: innFieldRow.width
                    spacing: innFieldRow.spacing

                    TextField {
                        id: corespondentAccountNumberField
                        width: parent.width - parent.spacing
                        placeholderText: (bankCorespondentAccount.length === 0) ? "Корреспондентский счёт" : bankCorespondentAccount
                        placeholderTextColor: innField.placeholderTextColor
                        font: innField.font
                        color: innField.color
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: RegularExpressionValidator { regularExpression: /^(301[0-9]{17})$/}
                        onTextChanged: {
                            bankCorespondentAccount = text
                            console.log("[CheckingAccountSettings]\tbankCorespondentAccount: " + bankCorespondentAccount)
                        }
                    }
                }
            }

            Column {
                id: checkingAccountNumberFieldColumn
                width: innColumn.width
                anchors.horizontalCenter: innColumn.horizontalCenter
                spacing: innColumn.spacing
                visible: false

                Label {
                    id: checkingAccountNumberFieldTitle
                    width: innFieldTitle.width
                    text: "Номер Р/С"
                    font: innFieldTitle.font
                    color: innFieldTitle.color
                    clip: innFieldTitle.clip
                    elide: innFieldTitle.elide
                    horizontalAlignment: innFieldTitle.horizontalAlignment
                    verticalAlignment: innFieldTitle.verticalAlignment
                }

                Row {
                    id: checkingAccountNumberFieldRow
                    width: innFieldRow.width
                    spacing: innFieldRow.spacing

                    TextField {
                        id: checkingAccountNumberField
                        width: parent.width - parent.spacing
                        placeholderText: (bankCheckingAccount.length === 0) ? "Расчётный счёт" : bankCheckingAccount
                        placeholderTextColor: innField.placeholderTextColor
                        font: innField.font
                        color: innField.color
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: RegularExpressionValidator { regularExpression: /^(1[0-9]{19})$/}
                        onTextChanged: {
                            bankCheckingAccount = text
                            console.log("[CheckingAccountSettings]\tbankCheckingAccount: " + bankCheckingAccount)
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
        enabled: innField.acceptableInput &&
                 (organizationName.length > 0) &&
                 bankBikField.acceptableInput &&
                 (bankName.length > 0) &&
                 corespondentAccountNumberField.acceptableInput &&
                 checkingAccountNumberField.acceptableInput
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
            root.closePage()
        }
    }
}
