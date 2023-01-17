import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: userPage
    anchors.fill: parent

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Список пользователей")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Column {
        anchors.fill: parent

        ListView {
            id: users
            width: parent.width
            height: parent.height - createUserButton.height
            clip: true
            model: ListModel {
                id: usersList

                ListElement {
                    name: "Савченко Михаил Андреевич"
                    rule: "Администратор"
                    avatarIco: "qrc:/ico/tiles/tileGoods10.png"
                    isLoggedIn: true
                }

                ListElement {
                    name: "Продавец месяца"
                    rule: "Кассир"
                    avatarIco: ""
                    isLoggedIn: false
                }

                ListElement {
                    name: "Продавец месяца"
                    rule: "Кассир"
                    avatarIco: ""
                    isLoggedIn: false
                }

                ListElement {
                    name: "Продавец месяца"
                    rule: "Кассир"
                    avatarIco: ""
                    isLoggedIn: false
                }

                ListElement {
                    name: "Продавец месяца"
                    rule: "Кассир"
                    avatarIco: ""
                    isLoggedIn: false
                }

                ListElement {
                    name: "Продавец месяца"
                    rule: "Кассир"
                    avatarIco: ""
                    isLoggedIn: false
                }

                ListElement {
                    name: "Продавец месяца"
                    rule: "Кассир"
                    avatarIco: ""
                    isLoggedIn: false
                }

                ListElement {
                    name: "Продавец месяца"
                    rule: "Кассир"
                    avatarIco: ""
                    isLoggedIn: false
                }

                ListElement {
                    name: "Продавец месяца"
                    rule: "Кассир"
                    avatarIco: ""
                    isLoggedIn: false
                }
            }
            delegate: ItemDelegate {
                width: parent.width
                height: users.height / 6

                Row {
                    anchors.fill: parent
                    leftPadding: 0.25 * activeFrame.width
                    spacing: leftPadding

                    Item {
                        id: avatarItem
                        width: 0.15 * parent.width
                        height: width
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            id: activeFrame
                            anchors.fill: parent
                            radius: width
                            visible: isLoggedIn
                            border.width: 3
                            border.color: "#4DA03F"
                            color: "transparent"
                        }

                        SettingsComponents.Avatar {
                            id: avatar
                            width: activeFrame.width - 2 * activeFrame.border.width
                            anchors.centerIn: activeFrame
                            avatarSrc: avatarIco
                            userNameFull: name
                        }
                    }

                    Column {
                        width: parent.width - avatarItem.width - chooseIco.width - 2 * parent.spacing - 2 * parent.leftPadding
                        anchors.verticalCenter: parent.verticalCenter

                        Label {
                            id: userName
                            width: parent.width
                            text: qsTr(name)
                            font {
                                pixelSize: 0.35 * avatarItem.height
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

                        Row {
                            width: parent.width
                            spacing: 0.25 * userRuleName.font.pixelSize

                            Image {
                                id: isLoggedInIco
                                anchors.verticalCenter: parent.verticalCenter
                                visible: isLoggedIn
                                width: userRuleName.font.pixelSize
                                height: width
                                source: "qrc:/ico/menu/success_ico_small.png"
                            }

                            Label {
                                id: userRuleName
                                text: qsTr(rule)
                                font {
                                    pixelSize: 0.83 * userName.font.pixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Normal
                                }
                                color: "#979797"
                                clip: true
                                elide: "ElideRight"
                                verticalAlignment: Label.AlignBottom
                            }

                            Image {
                                width: isLoggedInIco.width
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                source: (rule === "Администратор") ? "qrc:/ico/settings/tie_blue.png" :
                                                                     "qrc:/ico/settings/cash-multiple_blue.png"
                                fillMode: Image.PreserveAspectFit
                            }
                        }
                    }

                    Image {
                        id: chooseIco
                        anchors.verticalCenter: parent.verticalCenter
                        width: 0.5 * avatarItem.width
                        height: width
                        source: "qrc:/ico/menu/choose_right.png"
                    }
                }
                onClicked: {
                    root.openPage("qrc:/qml/pages/subpages/users/UserPage.qml")
                    rootStack.currentItem.state = "edit"
                }
            }
            ScrollBar.vertical: ScrollBar {
                id: scroll
                policy: ScrollBar.AsNeeded
                width: 8
            }
        }

        SaleComponents.Button_1 {
            id: createUserButton
            width: 0.92 * parent.width
            height: 0.2 * width
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 0.5 * dataColumn.spacing
            }
            enabled: nameField.acceptableInput &&
                     passwordField.acceptableInput &&
                     ((userPage.state == "firstUser") || innField.acceptableInput)
            opacity: enabled ? 1 : 0.6
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr("ДОБАВИТЬ ПОЛЬЗОВАТЕЛЯ")
            fontSize: 0.27 * height
            buttonTxtColor: "#415A77"
            pushUpColor: "#F6F6F6"
            pushDownColor: "#B9B9B9"
            onClicked: {
                root.openPage("qrc:/qml/pages/subpages/users/UserPage.qml")
                rootStack.currentItem.state = "default"
            }
        }
    }
}
