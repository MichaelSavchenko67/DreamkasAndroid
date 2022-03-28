import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/content/calculator.js" as CalcEngine
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: enterCostChoose
    implicitHeight: parent.height
    implicitWidth: parent.width
    anchors.fill: parent
    states: [
    State {
       name: "onboarding_mainSalesPage(page_2)"
       when: root.isOnboadingModeEnabled === true && getOnboardingCurrentPageIndex()===1
       PropertyChanges {target: calculator; z: 10}
       PropertyChanges {target: calcgreyBgColor; visible: false}
       PropertyChanges {target: userInfoText; visible: true}
       PropertyChanges {target: userInfoText; text: qsTr("Введите цену товара")}
       PropertyChanges {target: userInfoTextContent; visible: false}
       PropertyChanges {target: footerGreyBgColor; visible: true}
       PropertyChanges {target: arrowImage; visible: false}
       PropertyChanges {target: chooseSno; enabled: false}
       PropertyChanges {target: cashButton; enabled: false}
       PropertyChanges {target: nonCashButton; enabled: false}
       PropertyChanges {target: footerMain; visibilityOfShadow: false}


        },
    State {
       name: "normal"
       when: root.isOnboadingModeEnabled === false
       PropertyChanges {target: calculator; z: 0}
       PropertyChanges {target: calcgreyBgColor; visible: false}
       PropertyChanges {target: userInfoText; visible: false}
       PropertyChanges {target: userInfoTextContent; visible: false}
       PropertyChanges {target: footerGreyBgColor; visible: false}
       PropertyChanges {target: arrowImage; visible: false}
       PropertyChanges {target: chooseSno; enabled: !snoMenu.opened}
       PropertyChanges {target: cashButton; enabled: true}
       PropertyChanges {target: nonCashButton; enabled: true}
       PropertyChanges {target: footerMain; visibilityOfShadow: true}
        },
    State {
       name: "onboarding_ViewPaymentReciept(page_7)" ///индекс с 0, не забыть
       when: root.isOnboadingModeEnabled === true && getOnboardingCurrentPageIndex()===6
       PropertyChanges {target: calculator; z: 0}
       PropertyChanges {target: calculator; enabled: false}
       PropertyChanges {target: calcgreyBgColor; visible: true}
       PropertyChanges {target: userInfoText; visible: false}
       PropertyChanges {target: userInfoTextContent; visible: true}
       PropertyChanges {target: userInfoTextContent; text: qsTr("Добавленные товары можно \n посмотреть в чеке")}
       PropertyChanges {target: footerGreyBgColor; visible: true}
       PropertyChanges {target: arrowImage; visible: true}
       PropertyChanges {target: chooseSno; enabled: false}
       PropertyChanges {target: cashButton; enabled: false}
       PropertyChanges {target: nonCashButton; enabled: false}
       PropertyChanges {target: footerMain; visibilityOfShadow: false}
        },
     State {
       name: "onboarding_ChoosePaymentType(page_8)"
       when: root.isOnboadingModeEnabled === true && getOnboardingCurrentPageIndex()===7
       PropertyChanges {target: calculator; z: 0}
       PropertyChanges {target: calculator; enabled: false}
       PropertyChanges {target: calcgreyBgColor; visible: true}
       PropertyChanges {target: userInfoText; visible: false}
       PropertyChanges {target: userInfoTextContent; visible: true}
       PropertyChanges {target: userInfoTextContent; text: qsTr("Выберите способ оплаты")}
       PropertyChanges {target: footerGreyBgColor; visible: true}
       PropertyChanges {target: arrowImage; visible: true}
       PropertyChanges {target: chooseSno; enabled: false}
       PropertyChanges {target: cashButton; enabled: false}
       PropertyChanges {target: nonCashButton; enabled: false}
       PropertyChanges {target: footerMain; visibilityOfShadow: false}
            }
        ]
    contentData: Item {
        anchors.fill: parent
        Rectangle {
            z:3
            id:calcgreyBgColor
            anchors.fill: parent
            color: Qt.rgba(0.39,0.39,0.39,0.80)
        }
        Label // текстовая метка отвечает за то, чтобы показывать текст в contentData
        {
            z:4
            id: userInfoTextContent
            anchors.fill: parent
            text: qsTr("Добавленные товары можно \n посмотреть в чеке")
            color: "white"
            horizontalAlignment: Label.AlignHCenter
            anchors.topMargin: parent.height / 3
            font {
               pixelSize: 18
               family: "Roboto"
               styleName: "medium"
               weight: Font.Bold
               bold: true

                }

        }
        Image {
            z:5
            id: arrowImage
            anchors.bottom: userInfoTextContent.bottom
            anchors.bottomMargin:  5
            anchors.topMargin:  20
            width: 150
            height: parent.height * 0.55
            visible: false
            //fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: left
            source: "qrc:/img/onboarding/leftArrow.png"
        }

        SaleComponents.Calculator {
            id: calculator

            anchors.top: parent.top
            Component.onCompleted: {
                reset()
                setDisplay("saleDisplay")
                setKeyboard("keyboardFull")
            }

            onAdd2purchase: {
                openPurchase.total = calculator.formulaTotal
                calculator.reset()
                popupEnterPosName.open()
                if(root.isOnboadingModeEnabled === true)
                {
                     incrementOnboardingProgressIndicator()
                }
            }
        }

        SaleComponents.PopupCashlessPaymentChoose {
            id: popupCashlessPaymentChoose
            total: openPurchase.total
        }
        SaleComponents.PopupEnterPosName {
            z:0
            id: popupEnterPosName
            popupTitle: "Введите название"
            enteredTextTitle: "Наименование товара"
            enteredTextPlaceholder: "Введите название"
            isStayLastEntered: true
            onEntered:
            {
                openPage("qrc:/qml/onBoarding/cameraOnboardingSkipper.qml")
                incrementOnboardingProgressIndicator()
            }
        }
    }


    SettingsComponents.CustomMenu {
        id: snoMenu
        width: 0.35 * footerMain.width
        x: parent.width - width
        y: footerMain.y - height

        Action { text: qsTr("УСН"); checkable: true; checked: true; enabled: true }
        Action { text: qsTr("СНО"); checkable: true; checked: false; enabled: true }
        Action { text: qsTr("ПСН"); checkable: true; checked: false; enabled: true }
        Action { text: qsTr("ЕСХН"); checkable: true; checked: false; enabled: true }
    }

    footer: SaleComponents.FooterMain {
        id: footerMain
        height: btnRow.height + totalMsg.height + 3 * 0.125 * btnRow.height

        Component.onCompleted: {
            calculator.setFooterHeight(height)
        }

         Label // текстовая метка отвечает за то, чтобы показывать текст в footer
         {
           z:4
           id: userInfoText
           width: parent.width
           topPadding: 20
           text: qsTr("Введите цену товара")
           color: "white"
           horizontalAlignment: Label.AlignHCenter
           font {
           pixelSize: 15
           family: "Roboto"
           styleName: "medium"
           weight: Font.Medium
           bold: true
          }

            }


        Rectangle {
            z:3
            id:footerGreyBgColor
            anchors.fill: parent
             color: Qt.rgba(0.39,0.39,0.39,0.80)
        }
        Rectangle {
            anchors.fill: parent
            color: "#F6F6F6"

            Row {
                id: frame
                width: parent.width
                anchors {
                    bottom: btnRow.top
                    bottomMargin: 0.125 * btnRow.height
                }

                Label {
                    id: totalMsg
                    text: qsTr("К оплате <b>" + openPurchase.total + " \u20BD</b>")
                    width: parent.width -
                           chooseSno.width -
                           leftPadding
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: btnRow.spacing
                    font {
                        pixelSize: 1.5 * openPurchase.fontSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignBottom
                }

                Button {
                    id: chooseSno
                    width: 0.25 * frame.width
                    height: frame.height
                    anchors.verticalCenter: totalMsg.verticalCenter
                    enabled: !snoMenu.opened
                    background: Row {
                        spacing: snoMenuIco.width
                        anchors.verticalCenter: totalMsg.verticalCenter

                        Label {
                            id: snoTitle
                            width: parent.width - snoMenuIco.width - parent.spacing
                            height: frame.height
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("УСН")
                            font: totalMsg.font
                            color: "#979797"
                            elide: totalMsg.elide
                            horizontalAlignment: Qt.AlignRight
                            verticalAlignment: totalMsg.verticalAlignment
                        }

                        Image {
                            id: snoMenuIco
                            width: 0.5 * snoTitle.font.pixelSize
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            source: "qrc:/ico/menu/down.png"
                            fillMode: Image.PreserveAspectFit

                            ColorOverlay {
                                anchors.fill: snoMenuIco
                                source: snoMenuIco
                                color: snoTitle.color
                            }

                            states: State {
                                name: "toPressed"; when: snoMenu.opened
                                PropertyChanges {
                                    target: snoMenuIco
                                    rotation: 180
                                }
                            }

                            transitions: Transition {
                                to: "toPressed"
                                reversible: true

                                PropertyAnimation {
                                    properties: "rotation"
                                    easing.type: Easing.InOutQuad
                                    duration: 100
                                }
                            }
                        }
                    }
                    onClicked: {
                        snoMenu.open()
                    }
                }
            }

            Row {
                id: btnRow
                width: parent.width
                height: 0.16 * width
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 0.125 * height
                }
                spacing: 0.03 * width
                leftPadding: spacing
                rightPadding: spacing

                SaleComponents.ButtonIcoV {
                    id: openPurchase
                    property var total: "0,00"
                    iconPath: "qrc:/ico/menu/purchase.png"
                    buttonTxt: "ЧЕК"
                    width: 0.12 * parent.width
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    enabled: (total != "0,00")

                    onClicked: {
                        root.openPage("qrc:/qml/pages/subpages/Purchase.qml")
                    }
                    topPadding: buttons.spacing
                    leftPadding: buttons.spacing
                }

                SaleComponents.ButtonIcoH {
                    id:nonCashButton
                    width: (parent.width - 4 * parent.spacing - openPurchase.width) / 2
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    buttonTxt: "БЕЗНАЛ"
                    iconPath: "qrc:/ico/menu/credit_card.png"
                    enabled: openPurchase.enabled

                    onClicked: {
//                        popupCashlessPaymentChoose.open()
                        popupCashlessPay.open()
                    }
                }

                SaleComponents.ButtonIcoH {
                    id:cashButton
                    width:  (parent.width - 4 * parent.spacing - openPurchase.width) / 2
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    buttonTxt: "НАЛИЧНЫЕ"
                    iconPath: "qrc:/ico/menu/wallet.png"
                    enabled: openPurchase.enabled

                    onClicked: {
                        root.openPage("qrc:/qml/pages/subpages/Pay.qml")
                        rootStack.currentItem.purchaseTotal = openPurchase.total
                    }
                }
            }
        }
    }
}
