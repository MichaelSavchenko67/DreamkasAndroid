import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0

import "qrc:/qml/components/sale/" as SaleComponents

Page {
    id: searchGoodsPage

    onFocusChanged: {
        if (focus) {
            console.log("[SearchGoods.qml]\tfocus changed: " + focus)
            setMainPageTitle("Поиск товара")
            setLeftMenuButtonAction(back)
            setToolbarVisible(true)
            setToolBarShadow(false)
            setRightMenuButtonVisible(false)
            resetAddRightMenuButton()
        }
    }

    header: SaleComponents.MyTextInput {
        id: findGoodsInput
        onChangeText: {
            console.log("[SearchGoods.qml]\tText from user: " + txt)
        }
    }
    contentData: ListView {
        id: findGoodsListView
        anchors {
            fill: parent
            top: findGoodsInput.bottom
            topMargin: 0.03 * searchGoodsPage.height
            left: searchGoodsPage.left
            leftMargin: findGoodsInput.fontSize
        }
        clip: true

        model: ListModel {
            id: findGoodsList

            ListElement {
                goodsParam1: "Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1"
                goodsParam2: "Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1 Товар 1"
            }
            ListElement {
                goodsParam1: "Товар 2"
                goodsParam2: "Товар 2"
            }
            ListElement {
                goodsParam1: "Товар 3"
                goodsParam2: "Товар 3"
            }
            ListElement {
                goodsParam1: "Товар 4"
                goodsParam2: "Товар 4"
            }
            ListElement {
                goodsParam1: "Товар 5"
                goodsParam2: "Товар 5"
            }
            ListElement {
                goodsParam1: "Товар 6"
                goodsParam2: "Товар 6"
            }
            ListElement {
                goodsParam1: "Товар 7"
                goodsParam2: "Товар 7"
            }
            ListElement {
                goodsParam1: "Товар 8"
                goodsParam2: "Товар 8"
            }
            ListElement {
                goodsParam1: "Товар 9"
                goodsParam2: "Товар 9"
            }
            ListElement {
                goodsParam1: "Товар 10"
                goodsParam2: "Товар 10"
            }
            ListElement {
                goodsParam1: "Товар 10"
                goodsParam2: "Товар 10"
            }
            ListElement {
                goodsParam1: "Товар 10"
                goodsParam2: "Товар 10"
            }
            ListElement {
                goodsParam1: "Товар 10"
                goodsParam2: "Товар 10"
            }
            ListElement {
                goodsParam1: "Товар 10"
                goodsParam2: "Товар 10"
            }
        }
        delegate: ItemDelegate {
            height: 1.7 * findGoodsInput.height
            width: findGoodsInput.width

            Column {
                anchors.fill: parent

                Text {
                    height: parent.height
                    width: parent.width - font.pixelSize
                    text: '<b>' + goodsParam1 + '</b>' + "\n" + goodsParam2
                    font {
                        pixelSize: 0.25 * height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    maximumLineCount: 4
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                }
            }

            onPressYChanged: {
                findGoodsInput.editOn = false
            }

            onClicked: {
                findGoodsInput.editOn = false
                ListView.currentIndex = index
                console.log("[SearchGoods.qml]\tGoods with index: " + index + " is choosen")
                rootStack.pop()
            }
        }
        ScrollBar.vertical: ScrollBar {
            id: scroll
            policy: ScrollBar.AsNeeded
            width: 8

            onVisualPositionChanged: {
                findGoodsInput.editOn = false
            }
        }
    }
}
