import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models 2.12


import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: sectionGoods

    property int tilesInRow: 3
    property bool sectionCheckMode: false

    anchors.fill: parent

    onTilesInRowChanged: {
        tileGridView.cellWidth = parent.width / tilesInRow
        tile.width = sectionGoods.width / tilesInRow
    }

    onSectionCheckModeChanged: {
        tile.checkMode = sectionCheckMode
    }

    ListModel {
        id: tilesModel

        ListElement {
            tileSectionId: 1
            tileName: "Василеостровское нефильтрованное светлое"
            tileCost: 10
            tileMeasure: "кг"
            isTap: true
            litersLeft: 4
            litersLeftPercent: 30
            litersSold: 8
            tapName: "Кран №1"
            salesStep: 0.5
        }
        ListElement {
            tileSectionId: 1
            tileName: "Мистр Сидр"
            tileCost: 20
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods2.png"
            isTap: true
            litersLeft: 15
            litersLeftPercent: 75
            litersSold: 5
            tapName: "Кран №2"
            salesStep: 1
        }
        ListElement {
            tileSectionId: 1
            tileName: "Мистр Сидр"
            tileCost: 20
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods3.png"
            isTap: true
            litersLeft: 0
            litersLeftPercent: 0
            litersSold: 10
            tapName: "Кран №3"
            salesStep: 1
        }
        ListElement {
            tileSectionId: 1
            tileName: "Тыква"
            tileCost: 40
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods4.png"
        }
        ListElement {
            tileSectionId: 1
            tileName: "Салат айсберг"
            tileCost: 50
            tileMeasure: "г"
            tileImg: "qrc:/ico/tiles/tileGoods5.png"
        }
        ListElement {
            tileSectionId: 0
            tileName: "Морковь"
            tileCost: 60
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods6.png"
        }
        ListElement {
            tileSectionId: 1
            tileName: "Картофель"
            tileCost: 70
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods7.png"
        }
        ListElement {
            tileSectionId: 1
            tileName: "Лук красный"
            tileCost: 80
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods8.png"
        }
        ListElement {
            tileSectionId: 1
            tileName: "Чеснок"
            tileCost: 90
            tileMeasure: "г"
            tileImg: "qrc:/ico/tiles/tileGoods9.png"
        }
        ListElement {
            tileSectionId: 1
            tileName: "Роллы"
            tileCost: 100
            tileMeasure: "шт"
            tileImg: "qrc:/ico/tiles/tileGoods10.png"
        }
        ListElement {
            tileSectionId: 1
            tileName: "Конфеты"
            tileCost: 110
            tileMeasure: "шт"
            tileImg: "qrc:/ico/tiles/tileGoods11.png"
        }
        ListElement {
            tileSectionId: 1
            tileName: "Баклажан"
            tileCost: 10
            tileMeasure: "кг"
            tileImg: "qrc:/ico/tiles/tileGoods1.png"
        }
        ListElement {
            tileSectionId: 1
            tileName: "Товар без картинки на плитке"
            tileCost: 10
            tileMeasure: "кг"
            tileImg: ""
        }
        ListElement {
            tileSectionId: 1
            tileName: ""
            tileCost: 0
            tileMeasure: ""
            tileImg: ""
        }
    }

    SettingsComponents.FilterProxyModel {
        id: filterProxyModel
        model: tilesModel
        delegate: SaleComponents.TileGoods {
            id: tile
            width: sectionGoods.width / tilesInRow
            height: width
            name: model.tileName
            tapName: model.tapName
            cost: model.tileCost
            measure: isTap ? "л" : model.tileMeasure
            img: model.tileImg
            isTap: model.isTap
            litersLeft: model.litersLeft
            litersLeftPercent: model.litersLeftPercent
            litersSold: model.litersSold
            salesStep: model.salesStep
            checkMode: sectionCheckMode
        }

        filterAccepts: function(item) {
              return item.tileSectionId === 1
        }
    }

    contentData: GridView
    {
        anchors.fill: parent
        model: filterProxyModel
        cellWidth: parent.width / tilesInRow
        cellHeight: cellWidth
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
//                        popupCashlessPaymentChoose.open()
                        popupCashlessPay.open()
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
