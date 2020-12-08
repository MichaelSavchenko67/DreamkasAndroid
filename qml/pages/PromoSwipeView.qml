import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("[PromoSwipeView.qml]\tfocus changed: " + focus)
            setToolbarVisible(true)
            setToolBarShadow(false)
            setMainPageTitle("")
            setLeftMenuButtonAction(close)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            clearContextMenu()
        }
    }

    contentData: Rectangle {
        id: frame
        anchors.fill: parent
        color: "#4DA13F"

        SwipeView {
            id: promoSwipeView
            width: 0.85 * parent.width
            height: 0.9 * parent.height
            anchors {
                top: parent
                horizontalCenter: parent.horizontalCenter
            }

            currentIndex: 0

            Repeater {
                model: 3

                Rectangle {
                    border.width: 0.02 * width
                    border.color: "#4DA13F"
                    color: "white"
                    radius: 0.03 * parent.width

                    Column {
                        width: 0.9 * parent.width
                        height: 0.9 * parent.height
                        anchors.centerIn: parent
                        spacing: 0.1 * titlePromo.font.pixelSize

                        Image {
                            id: imagePromo
                            source: "qrc:/ico/menu/viki.jpg"
                            transformOrigin: Item.Center
                            width: 0.495 * parent.width
                            height: 0.375 * parent.height
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            id: titlePromo
                            width: parent.width
                            height: 0.2 * parent.height
                            anchors.horizontalCenter: imagePromo.horizontalCenter
                            text: qsTr("Купите или обновите\n\"Дримкас Ключ\"")
                            font {
                                pixelSize: 0.1 * width
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Bold
                                bold: true
                            }
                            color: "black"
                            elide: Label.ElideRight
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                        }

                        Text {
                            id: addPromoMsg
                            width: parent.width
                            height: 0.2 * parent.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("Чтобы продолжить получать новый\nфункционал за 159 \u20BD в месяц")
                            font {
                                pixelSize: 0.15 * height
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "black"
                            elide: Label.ElideRight
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter

                            Text {
                                width: addPromoMsg.width
                                font: addPromoMsg.font
                                text: qsTr("<a href='https://dreamkas.ru/kluch/'>подробнее</a>")
                                color: "green"
                                linkColor: color
                                elide: Label.ElideRight
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignBottom
                                onLinkActivated: {
                                    Qt.openUrlExternally(link)
                                }
                            }
                        }

                        SaleComponents.Button_1 {
                            anchors.horizontalCenter:  parent.horizontalCenter
                            width: 0.5 * parent.width
                            height: 0.35 * width
                            borderWidth: 0
                            backRadius: 5
                            buttonTxt: qsTr("ПРОДОЛЖИТЬ")
                            fontSize: 0.33 * height
                            buttonTxtColor: "white"
                            pushUpColor: "#AC58E1"
                            pushDownColor: "#651D92"
                            onClicked: {
                                console.log("[PromoSwipeView.qml]\tSkip promo messages")
                                closePage()
                            }
                        }
                    }
                }
            }
        }

        PageIndicator {
            id: indicator
            anchors {
                bottom: parent.bottom
                bottomMargin: 0.035 * parent.height
                horizontalCenter: parent.horizontalCenter
            }
            count: promoSwipeView.count
            currentIndex: promoSwipeView.currentIndex

            delegate: Rectangle {
                implicitWidth: (index === promoSwipeView.currentIndex) ? 12 : 8
                implicitHeight: implicitWidth

                anchors.verticalCenter: parent.verticalCenter

                radius: width / 2
                color: "white"

                opacity: (index === promoSwipeView.currentIndex) ? 0.95 : pressed ? 0.7 : 0.45

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 100
                    }
                }
            }
        }
    }
}
