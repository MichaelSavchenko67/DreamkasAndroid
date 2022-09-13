import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: supportHelpRequest

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Задать вопрос")
            resetAddRightMenuButton()
            resetAddRightMenuButton2()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    states: [
        State {
            name: "requestNewFeature"
            PropertyChanges { target: userEmailColumn; visible: true }
            PropertyChanges { target: newFeatureColumn; visible: true }
            PropertyChanges { target: subjectColumn; visible: false }

        },
        State {
            name: "deviceSupport"
            PropertyChanges { target: userEmailColumn; visible: true }
            PropertyChanges { target: newFeatureColumn; visible: false }
            PropertyChanges { target: subjectColumn; visible: true }
        },
        State {
            name: "cabinetError"
            PropertyChanges { target: userEmailColumn; visible: true }
            PropertyChanges { target: newFeatureColumn; visible: false }
            PropertyChanges { target: subjectColumn; visible: true }
        },
        State {
            name: "other"
            PropertyChanges { target: userEmailColumn; visible: true }
            PropertyChanges { target: newFeatureColumn; visible: false }
            PropertyChanges { target: subjectColumn; visible: true }
        }

    ]
    state: "requestNewFeature"

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
            spacing: userEmailField.font.pixelSize
            topPadding: 0.5 * spacing
            leftPadding: 0.08 * parent.width
            clip: true

            Column {
                id: requestTypeColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: requestTypeFieldTitle
                    width: parent.width
                    text: "Тип обращения"
                    font {
                        pixelSize: 0.67 * userEmailField.font.pixelSize
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

                SettingsComponents.CustomComboBox {
                    boxModel: ListModel {
                        id: model
                        ListElement { payType: "Запрос нового функционала"}
                        ListElement { payType: "Помощь по оборудованию"}
                        ListElement { payType: "Ошибки в работе Кабинета"}
                        ListElement { payType: "Прочее"}
                    }
                    isEnabled: true
                    choosenIndex: 0
                    onChoosen: {
                        switch(choosenIndex) {
                            case 0: supportHelpRequest.state = "requestNewFeature"; break
                            case 1: supportHelpRequest.state = "deviceSupport"; break
                            case 2: supportHelpRequest.state = "cabinetError"; break
                            case 3: supportHelpRequest.state = "other"; break
                            default: break;
                        }
                    }
                }
            }

            Column {
                id: userEmailColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: userEmailTitle
                    width: parent.width
                    text: "Адрес электронной почты"
                    font {
                        pixelSize: 0.67 * userEmailField.font.pixelSize
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
                    id: userEmailField
                    width: parent.width
                    placeholderText: (text.length === 0) ? "Введите email" : text
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

            }

            Column {
                id: newFeatureColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: newFeatureTitle
                    width: parent.width
                    text: "Какую функцию вы хотите добавить?"
                    font {
                        pixelSize: 0.67 * userEmailField.font.pixelSize
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
                    id: newFeatureField
                    width: parent.width
                    placeholderText: (text.length === 0) ? "Заполните это поле" : text
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


            }

            Column {
                id: subjectColumn
                width: 0.92 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0.15 * parent.spacing

                Label {
                    id: subjectTitle
                    width: parent.width
                    text: "Тема обращения"
                    font {
                        pixelSize: 0.67 * userEmailField.font.pixelSize
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
                    id: subjectField
                    width: parent.width
                    placeholderText: (text.length === 0) ? "Заполните это поле" : text
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


            }



        }
    }

    SaleComponents.Button_1 {
        id: saveData
        width: 0.92 * dataColumn.width
        height: 0.16 * width
        enabled: (userEmailField.text.length > 0)
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
