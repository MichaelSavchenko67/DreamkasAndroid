import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/sale" as SaleComponents

Page {
    anchors.fill: parent

    onFocusChanged: {
        if (focus) {
            console.log("[Orders.qml]\tfocus changed: " + focus)
            setMainPageTitle("Заказы")
            setLeftMenuButtonAction(openMenu)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    function getStatusMsg(status) {
        if (status === "success") {
            return "Фискализирован"
        } else if (status === "pending") {
            return "Не фискализирован"
        } else if (status === "failed") {
            return "Не фискализирован"
        }
    }

    function getStatusIco(status) {
        if (status === "success") {
            return "qrc:/ico/menu/operation_success.png"
        } else if (status === "pending") {
            return "qrc:/ico/menu/operation_pending.png"
        } else if (status === "failed") {
            return "qrc:/ico/menu/operation_failed.png"
        }
    }

    contentData: Column {
        anchors.fill: parent
        topPadding: 0.025 * parent.width

        ListView {
            id: ordersView
            width: parent.width
            height: parent.height
            visible: (orderModel.count > 0)
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            cacheBuffer: 100 * 0.15 * ordersView.height
            model: ListModel {
                id: orderModel

                //                ListElement {
                //                    orderStatus: "success"
                //                    number: "3838-20"
                //                    date: "25.07.2021"
                //                    total: "15 230,00"
                //                    buyersContacts: "+7 921 383-29-39"
                //                }

                //                ListElement {
                //                    orderStatus: "pending"
                //                    number: "3838-19"
                //                    date: "24.07.2021"
                //                    total: "14 230,00"
                //                    buyersContacts: "victor_fedorov@gmail.com"
                //                }

                //                ListElement {
                //                    orderStatus: "failed"
                //                    number: "3838-18"
                //                    date: "23.07.2021"
                //                    total: "18 230 000 000 000,00"
                //                    buyersContacts: "+7 921 383-29-39"
                //                }
            }
            delegate: ItemDelegate {
                id: position
                width: parent.width
                height: orderColumn.height

                Column {
                    id: orderColumn
                    width: parent.width - 0.1 * parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 0.5 * statusLabel.font.pixelSize
                    topPadding: 2 * spacing

                    Row {
                        width: parent.width

                        Row {
                            id: statusRow
                            width: 0.6 * parent.width
                            spacing: 0.5 * statusLabel.font.pixelSize

                            Image {
                                id: statusImage
                                width: statusLabel.font.pixelSize
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                source: getStatusIco(orderStatus)
                                fillMode: Image.PreserveAspectFit
                            }

                            Label {
                                id: statusLabel
                                text: qsTr(getStatusMsg(orderStatus))
                                width: parent.width - statusImage.width - parent.spacing
                                anchors.verticalCenter: parent.verticalCenter
                                font {
                                    pixelSize: 0.07 * parent.width
                                    family: "Roboto"
                                    styleName: "normal"
                                }
                                color: "#979797"
                                elide: Label.ElideRight
                                horizontalAlignment: Qt.AlignLeft
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }

                        Row {
                            id: retryRow
                            width: parent.width - statusRow.width
                            spacing: statusRow.spacing
                            anchors.verticalCenter: statusRow.verticalCenter
                            visible: (orderStatus === "failed")
                            leftPadding: width - (retryImage.width + retryLabel.contentWidth + spacing)

                            Button {
                                background: Row {
                                    spacing: statusRow.spacing
                                    anchors.verticalCenter: statusRow.verticalCenter

                                    Image {
                                        id: retryImage
                                        width: statusImage.width
                                        height: statusImage.height
                                        anchors.verticalCenter: parent.verticalCenter
                                        source: "qrc:/ico/settings/update_blue.png"
                                        fillMode: Image.PreserveAspectFit
                                    }

                                    Label {
                                        id: retryLabel
                                        text: qsTr("ПОВТОРИТЬ")
                                        anchors.verticalCenter: parent.verticalCenter
                                        font {
                                            pixelSize: 0.8 * statusLabel.font.pixelSize
                                            family: "Roboto"
                                            styleName: "normal"
                                        }
                                        color: "#0064B4"
                                        elide: Label.ElideRight
                                        horizontalAlignment: Qt.AlignRight
                                        verticalAlignment: Qt.AlignVCenter
                                    }
                                }
                                onClicked: {
                                    console.info("[Orders.qml]\t\tretry order")
                                }
                            }
                        }
                    }

                    Row {
                        width: parent.width

                        Column {
                            width: 0.5 * parent.width
                            spacing: 0.5 * orderColumn.spacing
                            anchors.verticalCenter: totalLabel

                            Row {
                                width: parent.width

                                Label {
                                    id: numberLabel
                                    text: qsTr("№ " + number + " ")
                                    font {
                                        pixelSize: 1.1 * statusLabel.font.pixelSize
                                        family: "Roboto"
                                        styleName: Font.DemiBold
                                    }
                                    color: "black"
                                    elide: Label.ElideRight
                                    horizontalAlignment: Qt.AlignLeft
                                    verticalAlignment: Qt.AlignBottom
                                }

                                Label {
                                    height: numberLabel.contentHeight
                                    text: qsTr("от " + date)
                                    font {
                                        pixelSize: 0.7 * numberLabel.font.pixelSize
                                        family: "Roboto"
                                        styleName: "normal"
                                    }
                                    color: "black"
                                    elide: Label.ElideRight
                                    horizontalAlignment: Qt.AlignLeft
                                    verticalAlignment: Qt.AlignBottom
                                }
                            }

                            Label {
                                text: qsTr(buyersContacts)
                                width: parent.width
                                font {
                                    pixelSize: 0.8 * statusLabel.font.pixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                }
                                color: statusLabel.color
                                horizontalAlignment: statusLabel.horizontalAlignment
                                verticalAlignment: statusLabel.verticalAlignment
                            }
                        }

                        Label {
                            id: totalLabel
                            width: 0.5 * parent.width
                            text: total + "&nbsp;\u20BD"
                            textFormat: Label.RichText
                            font: numberLabel.font
                            color: "black"
                            elide: Label.ElideRight
                            maximumLineCount: 2
                            wrapMode: Label.WordWrap
                            horizontalAlignment: Qt.AlignRight
                            verticalAlignment: Qt.AlignBottom
                        }
                    }

                    Column {
                        width: parent.width
                        topPadding: parent.topPadding

                        SaleComponents.Line {
                            id: positionSeparator
                            width: parent.width
                            visible: model.index < (ordersView.count - 1)
                            color: "#E0E0E0"
                        }
                    }
                }
                onClicked: {
                    printedPurchase.open()
                }
            }
            ScrollBar.vertical: ScrollBar {
                id: scroll
                policy: ScrollBar.AsNeeded
                width: 4
            }
        }

        Column {
            anchors.fill: parent
            visible: !ordersView.visible
            topPadding: 0.21 * parent.height
            spacing: 2 * infoMsg.font.pixelSize

            Label {
                id: infoMsg
                width: 0.72 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Здесь будет список заказов отправленных на облачную кассу")
                font {
                    pixelSize: 0.04 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                }
                color: "#979797"
                elide: Label.ElideRight
                maximumLineCount: 3
                wrapMode: Label.WordWrap
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Button {
                id: go2saleButton
                height: 2 * go2saleMsg.contentHeight
                width: infoMsg.width
                anchors.horizontalCenter: infoMsg.horizontalCenter
                background: Label {
                    id: go2saleMsg
                    width: parent.width
                    text: qsTr("ПЕРЕЙТИ К ФОРМИРОВАНИЮ ЗАКАЗА")
                    font {
                        pixelSize: 0.8 * infoMsg.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                    }
                    color: "#0064B4"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }
                onClicked: { rootStack.pop(null) }
            }
        }

        Image {
            id: girl
            width: 0.38 * parent.width
            height: 1.45 * width
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            source: "qrc:/ico/settings/girl.png"
            fillMode: Image.PreserveAspectCrop
        }
    }

    SaleComponents.PrintedPurchase { id: printedPurchase }
}
