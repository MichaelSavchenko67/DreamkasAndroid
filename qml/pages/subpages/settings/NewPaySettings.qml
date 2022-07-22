import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: newPaySettings

    property string choosenCashboxKey: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgA"

    onChoosenCashboxKeyChanged: {
        updateActiveCashbox()
    }

    function updateActiveCashbox() {
        for (var i = 0; i <= cashboxesModel.rowCount(); i++) {
            cashboxesModel.get(i)["isActive_"] = (cashboxesModel.get(i)["cashboxKey_"] === choosenCashboxKey);
        }
    }

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("СБП от NewPay")
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
            spacing: userTokenField.font.pixelSize
            topPadding: 0.5 * spacing
            leftPadding: 0.08 * parent.width
            clip: true

            Column {
                id: userTokenColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: userTokenFieldTitle
                    width: parent.width
                    text: "Токен пользователя"
                    font {
                        pixelSize: 0.67 * userTokenField.font.pixelSize
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
                    width: parent.width
                    spacing: 0.5 * userTokenFieldHelpButton.width

                    TextField {
                        id: userTokenField
                        width: parent.width - userTokenFieldHelpButton.width - parent.spacing
                        placeholderText: (text.length === 0) ? "user token" : text
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
                        id: userTokenFieldHelpButton
                        width: 1.25 * userTokenField.font.pixelSize
                    }

                    SettingsComponents.ToolTipPopup {
                        visible: userTokenFieldHelpButton.isHelpVisible
                        text: qsTr("User token <a href='https://newpayb2b.pro/'>Регистрация</a>")
                        x: userTokenField.x
                        y: userTokenField.y + userTokenField.height
                        onClosed: {
                            userTokenFieldHelpButton.isHelpVisible = false
                        }
                    }
                }
            }

            Label {
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Кассы филиала")
                font: titlePrintReports.font
                color: "black"
                clip: true
                elide: Label.ElideRight
            }

            ListView {
                id: cashboxes
                width: userTokenColumn.width
                height: (0.4 * 0.85 * userTokenColumn.width + 0.5 * dataColumn.spacing) * count
                visible: (cashboxes.count > 0)
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                model: ListModel {
                    id: cashboxesModel

                    ListElement {
                        cashboxName_: ""
                        cashboxKey_: ""
                        isActive_: false
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgA"
                        isActive_: false
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgB"
                        isActive_: true
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgC"
                        isActive_: false
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgD"
                        isActive_: false
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgE"
                        isActive_: false
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgF"
                        isActive_: false
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgG"
                        isActive_: false
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgH"
                        isActive_: false
                    }

                    ListElement {
                        cashboxName_: "Касса Касса Касса Касса Касса Касса Касса"
                        cashboxKey_: "newpay0A5pLH0PJMJTinSp92A23ZVR49LxP38YLgI"
                        isActive_: false
                    }
                }
                delegate: Column {
                    id: delegateFrame
                    width: 0.85 * userTokenColumn.width
                    height: 0.4 * width + 0.5 * dataColumn.spacing
                    anchors.horizontalCenter: parent.horizontalCenter

                    SettingsComponents.NewPayCashbox {
                        width: 0.85 * userTokenColumn.width
                        height: 0.4 * width
                        anchors.horizontalCenter: parent.horizontalCenter
                        cashboxName: cashboxName_
                        cashboxKey: cashboxKey_
                        isActive: isActive_
                        onCashboxChecked: {
                            choosenCashboxKey = cashboxKey
                        }
                    }
                }
                ScrollBar.vertical: ScrollBar {
                    id: scroll
                    policy: ScrollBar.AsNeeded
                    width: 8
                }
            }

            Row {
                id: rowPrintReports
                width: userTokenColumn.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.75 * titlePrintReports.font.pixelSize

                Column {
                    id: columnPrintReports
                    width: parent.width - switchPrintReports.width
                    spacing: 0.5 * descriptionPrintReports.font.pixelSize

                    Label {
                        id: titlePrintReports
                        text: qsTr("Печать отчётов")
                        font {
                            pixelSize: 0.0498 * rowPrintReports.width
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "black"
                        clip: true
                        elide: Label.ElideRight
                    }

                    Label {
                        id: descriptionPrintReports
                        width: parent.width
                        text: qsTr("Печать отчёта сверки итогов за период или детальный реестр по всем проведенным операциям при закрытии смены")
                        font {
                            pixelSize: 0.8 * titlePrintReports.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#979797"
                        elide: Label.ElideRight
                        maximumLineCount: 10
                        wrapMode: Text.WordWrap
                    }
                }

                Switch {
                    id: switchPrintReports
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged: {
                    }
                }
            }
        }
    }

    SaleComponents.Button_1 {
        id: saveData
        width: 0.92 * dataColumn.width
        height: 0.16 * width
        enabled: (userTokenField.text.length > 0)
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
