import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Page {
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            setMainPageTitle("Дримкас Дисплей")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(back)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    contentData: Column {
        anchors.fill: parent
        topPadding: 1.925 * connectionButton.fontSize
        bottomPadding: topPadding
        spacing: 0.5 * topPadding

        Column {
            id: welcomeImgColumn
            width: parent.width
            height: parent.height -
                    parent.topPadding -
                    connectionButton.height -
                    parent.spacing -
                    parent.bottomPadding
            spacing: 0.5 * parent.spacing

            Image {
                id: dreamkasDisplayLogoImage
                width: 0.222 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/img/dreamkas_display/dreamkas_display_logo.png"
                fillMode: Image.PreserveAspectFit
            }

            Column {
                id: titleColumn
                width: parent.width
                spacing: 0.75 * parent.spacing

                Label {
                    id: title
                    width: parent.width
                    text: qsTr("Дримкас Дисплей")
                    font {
                        pixelSize: 0.05 * parent.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Bold
                        bold: true
                    }
                    clip: true
                    elide: Label.ElideRight
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }

                Label {
                    width: parent.width
                    text: qsTr("Скачайте новое приложение\nдля вашего магазина")
                    font {
                        pixelSize: 0.8 * title.font.pixelSize
                        family: title.font.family
                        styleName: title.font.styleName
                        weight: Font.Normal
                    }
                    lineHeight: 1.1
                    clip: title.clip
                    elide: title.elide
                    maximumLineCount: 2
                    wrapMode: Label.WordWrap
                    horizontalAlignment: title.horizontalAlignment
                    verticalAlignment: title.verticalAlignment
                }
            }

            Column {
                id: slidesColumn
                width: parent.width
                height: parent.height -
                        dreamkasDisplayLogoImage.height -
                        titleColumn.height -
                        storeColumn.height -
                        2 * parent.spacing

                Flickable {
                    id: slidesFlickable
                    anchors.fill: parent
                    contentWidth: image.width
                    contentHeight: image.height
                    onDragStarted: {
                        swipeSildesForwardTimer.stop()
                        swipeSildesBackTimer.stop()
                    }

                    Timer {
                        id: swipeSildesForwardTimer
                        interval: 50
                        repeat: true
                        running: true
                        onTriggered: {

                            if (slidesFlickable.contentX < 0.75 * image.width) {
                                slidesFlickable.contentX += 2
                            } else {
                                stop()
                                swipeSildesBackTimer.start()
                            }
                        }
                    }

                    Timer {
                        id: swipeSildesBackTimer
                        interval: 50
                        repeat: true
                        running: false
                        onTriggered: {

                            if (slidesFlickable.contentX >= 0) {
                                slidesFlickable.contentX -= 2
                            } else {
                                stop()
                                swipeSildesForwardTimer.start()
                            }
                        }
                    }

                    Image {
                        id: image
                        height: slidesColumn.height
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/img/dreamkas_display/welcome_slides.png"
                    }
                }
            }

            Column {
                id: storeColumn
                spacing: 0.25 * parent.spacing
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    spacing: parent.spacing

                    Image {
                        id: googlePlayMarketBadge
                        width: 0.324 * welcomeImgColumn.width
                        source: "qrc:/img/store/google_play_badge.png"
                        fillMode: Image.PreserveAspectFit
                    }

                    Image {
                        width: googlePlayMarketBadge.width
                        source: "qrc:/img/store/app_store_badge.png"
                        fillMode: googlePlayMarketBadge.fillMode
                    }
                }

                Row {
                    spacing: parent.spacing

                    Image {
                        width: googlePlayMarketBadge.width
                        source: "qrc:/img/store/app_gallery_badge.png"
                        fillMode: googlePlayMarketBadge.fillMode
                    }

                    Image {
                        width: googlePlayMarketBadge.width
                        source: "qrc:/img/store/rustore_app_badge.png"
                        fillMode: googlePlayMarketBadge.fillMode
                    }
                }
            }
        }

        SaleComponents.Button_1 {
            id: connectionButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: 0.9 * parent.width
            height: 0.16 * width
            borderWidth: 0
            backRadius: 8
            buttonTxt: qsTr("ПОДКЛЮЧИТЬ УСТРОЙСТВО")
            fontSize: 0.27 * height
            buttonTxtColor: "#415A77"
            pushUpColor: "#F6F6F6"
            pushDownColor: "#B9B9B9"
            onClicked: {
                root.openPage("qrc:/qml/pages/subpages/dreamkas_display/Connection.qml")
            }
        }
    }
}
