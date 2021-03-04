import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    id: sectionGoods

    property int tilesInRow: 3

    anchors.fill: parent

    ListModel {
        id: tilesModel

        ListElement {
            tileName: "Баклажан"
            tileCost: 10
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods1.png"
        }
        ListElement {
            tileName: "Свекла"
            tileCost: 20
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods2.png"
        }
        ListElement {
            tileName: "Кабачок"
            tileCost: 30
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods3.png"
        }
        ListElement {
            tileName: "Тыква"
            tileCost: 40
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods4.png"
        }
        ListElement {
            tileName: "Салат айсберг"
            tileCost: 50
            tileMeasure: "г"
            tileImg: "qrc:/ico/tiles/tileGoods5.png"
        }
        ListElement {
            tileName: "Морковь"
            tileCost: 60
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods6.png"
        }
        ListElement {
            tileName: "Картофель"
            tileCost: 70
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods7.png"
        }
        ListElement {
            tileName: "Лук красный"
            tileCost: 80
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods8.png"
        }
        ListElement {
            tileName: "Чеснок"
            tileCost: 90
            tileMeasure: "г"
            tileImg: "qrc:/ico/tiles/tileGoods9.png"
        }
        ListElement {
            tileName: "Роллы"
            tileCost: 100
            tileMeasure: "шт"
            tileImg: "qrc:/ico/tiles/tileGoods10.png"
        }
        ListElement {
            tileName: "Конфеты"
            tileCost: 110
            tileMeasure: "шт"
            tileImg: "qrc:/ico/tiles/tileGoods11.png"
        }
        ListElement {
            tileName: "Баклажан"
            tileCost: 10
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods1.png"
        }
        ListElement {
            tileName: "Свекла"
            tileCost: 20
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods2.png"
        }
        ListElement {
            tileName: "Кабачок"
            tileCost: 30
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods3.png"
        }
        ListElement {
            tileName: "Тыква"
            tileCost: 40
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods4.png"
        }
        ListElement {
            tileName: "Салат айсберг"
            tileCost: 50
            tileMeasure: "г"
            tileImg: "qrc:/ico/tiles/tileGoods5.png"
        }
        ListElement {
            tileName: "Морковь"
            tileCost: 60
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods6.png"
        }
        ListElement {
            tileName: "Картофель"
            tileCost: 70
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods7.png"
        }
        ListElement {
            tileName: "Лук красный"
            tileCost: 80
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods8.png"
        }
        ListElement {
            tileName: "Чеснок"
            tileCost: 90
            tileMeasure: "г"
            tileImg: "qrc:/ico/tiles/tileGoods9.png"
        }
        ListElement {
            tileName: "Роллы"
            tileCost: 100
            tileMeasure: "шт"
            tileImg: "qrc:/ico/tiles/tileGoods10.png"
        }
        ListElement {
            tileName: "Конфеты"
            tileCost: 110
            tileMeasure: "шт"
            tileImg: "qrc:/ico/tiles/tileGoods11.png"
        }
        ListElement {
            tileName: "Баклажан"
            tileCost: 10
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods1.png"
        }
        ListElement {
            tileName: "Свекла"
            tileCost: 20
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods2.png"
        }
        ListElement {
            tileName: "Кабачок"
            tileCost: 30
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods3.png"
        }
        ListElement {
            tileName: "Тыква"
            tileCost: 40
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods4.png"
        }
        ListElement {
            tileName: "Салат айсберг"
            tileCost: 50
            tileMeasure: "г"
            tileImg: "qrc:/ico/tiles/tileGoods5.png"
        }
        ListElement {
            tileName: "Морковь"
            tileCost: 60
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods6.png"
        }
        ListElement {
            tileName: "Картофель"
            tileCost: 70
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods7.png"
        }
        ListElement {
            tileName: "Лук красный"
            tileCost: 80
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods8.png"
        }
        ListElement {
            tileName: "Чеснок"
            tileCost: 90
            tileMeasure: "г"
            tileImg: "qrc:/ico/tiles/tileGoods9.png"
        }
        ListElement {
            tileName: "Роллы"
            tileCost: 100
            tileMeasure: "шт"
            tileImg: "qrc:/ico/tiles/tileGoods10.png"
        }
        ListElement {
            tileName: "Конфеты"
            tileCost: 110
            tileMeasure: "шт"
            tileImg: "qrc:/ico/tiles/tileGoods11.png"
        }
    }

    contentData: GridView {
        anchors.fill: parent
        cellWidth: parent.width / tilesInRow
        cellHeight: cellWidth
        model: tilesModel

        delegate: SaleComponents.TileGoods {
            id: tile

            width: sectionGoods.width / tilesInRow
            height: width

            name: tileName
            cost: tileCost
            measure: tileMeasure
            img: tileImg
        }
    }

    footer: SaleComponents.FooterMain {
        height: btnRow.height + totalMsg.height + 3 * 0.125 * btnRow.height

        Rectangle {
            anchors.fill: parent
            color: "#F6F6F6"

            Label {
                id: totalMsg
                text: qsTr("К оплате <b>" + openPurchase.total + " \u20BD</b>")
                width: parent.width
                anchors {
                    bottom: btnRow.top
                    bottomMargin: 0.125 * btnRow.height
                }
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
                    width: (parent.width - 4 * parent.spacing - openPurchase.width) / 2
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    buttonTxt: "БЕЗНАЛ"
                    iconPath: "qrc:/ico/menu/credit_card.png"
                    enabled: openPurchase.enabled

                    onClicked: {
                        popupCashlessPaymentChoose.open()
                    }
                }

                SaleComponents.ButtonIcoH {
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
