import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("DEMOSWIPEVIEW FOCUS")
            setToolbarVisible(false)
        }
    }

    contentData: Rectangle {
        id: frame
        anchors.fill: parent
        color: "#878787"

        Column {
            anchors.fill: parent
            spacing: exitButton.icon.height * 0.5

            Row {
                width: parent.width
                spacing: parent.width * 0.5 - exitButton.width - (textDemoMode.width * 0.5)

                ToolButton {
                    id: exitButton
                    icon {
                        color: "transparent"
                        height: 0.025 * frame.height
                        width: height
                        source: "qrc:/ico/menu/close.png"
                    }
                    onClicked: {
                        closePage()
                    }
                }

                Column {
                    topPadding: exitButton.icon.height

                    Rectangle {
                        id: textDemoMode
                        width: frame.width * 0.3
                        height: exitButton.height * 0.5
                        border.color: "white"
                        color: "transparent"
                        radius: 20

                        Text {
                            width: parent.width
                            text: qsTr("ДЕМО-РЕЖИМ")
                            anchors.horizontalCenter: textDemoMode.horizontalCenter
                            anchors.verticalCenter: textDemoMode.verticalCenter
                            font {
                                pixelSize: 0.1 * width
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "white"
                            elide: Label.ElideRight
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                        }
                    }
                }
            }

            SwipeView {
                id: promoSwipeView
                width: 0.9 * parent.width
                height: 0.8 * parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                currentIndex: 0

                Repeater {
                    model: modelDemoSwipe

                    Rectangle {
                        border.width: 0.02 * width
                        border.color: "#878787"
                        color: "white"
                        radius: 16

                        Column {
                            width: 0.9 * parent.width
                            height: 0.9 * parent.height
                            anchors.centerIn: parent
                            spacing: 0.8 * textNotePromo.font.pixelSize

                            Image {
                                id: imagePromo
                                source: pathImage_
                                transformOrigin: Item.Center
                                height: 0.4 * parent.height
                                width: parent.width
                                fillMode: Image.PreserveAspectFit
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Label {
                                id: textNotePromo
                                width: 0.95 * parent.width
                                anchors.horizontalCenter: imagePromo.horizontalCenter
                                text: textNote_
                                font {
                                    pixelSize: 0.07 * width
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Bold
                                }
                                color: "black"
                                elide: Label.ElideRight
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                            }

                            Column {
                                width: parent.width
                                height: parent.height - imagePromo.height - textNotePromo.height - 2 * parent.spacing
                                spacing: height - textInfoPromo.height - buttonNext.height

                                Label {
                                    id: textInfoPromo

                                    onTextChanged: {
                                        console.log("TEXT: " + text.toString().search("\n\n"))
                                        if (text.toString().search("\n\n"))
                                        {
                                            console.log("SEARCH!!!")
                                        }
                                    }

                                    onContentHeightChanged: {
                                        console.log("textInfoPromo height: " + textInfoPromo.contentHeight + ", font: " + textInfoPromo.font.pixelSize + ", count: " + textInfoPromo.contentHeight / textInfoPromo.font.pixelSize)
                                        if (textInfoPromo.contentHeight / textInfoPromo.font.pixelSize >= 5)
                                        {
                                            font.pixelSize = 0.8 * textNotePromo.font.pixelSize
                                        }
                                        else
                                        {
                                            font.pixelSize = 1.2 * textNotePromo.font.pixelSize
                                        }
                                    }

                                    width: parent.width
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: textInfo_
                                    font {
//                                        pixelSize: 0.8 * textNotePromo.font.pixelSize
                                        family: "Roboto"
                                        styleName: "normal"
                                        weight: Font.Normal
                                    }
                                    color: "#444444"
                                    elide: Label.ElideRight
                                    maximumLineCount: 8
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Qt.AlignLeft
                                    verticalAlignment: Qt.AlignVCenter

                                    onLineLaidOut: {
                                        if (horizontalAlignment === Qt.AlignLeft)
                                        {
                                            line.width = line.width - 50
                                            line.x = line.x + 20
                                        }
                                    }
                                }

                                SaleComponents.Button_1 {
                                    id: buttonNext
                                    anchors.horizontalCenter:  parent.horizontalCenter
                                    width: parent.width * 0.95
                                    height: 0.2 * width
                                    borderWidth: 0
                                    backRadius: 5
                                    buttonTxt: textButton_.toUpperCase()
                                    fontSize: 0.27 * height
                                    fontBold: false
                                    buttonTxtColor: "white"
                                    pushUpColor: "#415A77"
                                    pushDownColor: "#004075"
                                    onClicked: {
                                        if (promoSwipeView.currentIndex === (modelDemoSwipe.rowCount() - 1) )
                                        {
                                            closePage()
                                            modelDemoSwipe.closeDemoSwipeFromFront()
                                        }

                                        promoSwipeView.incrementCurrentIndex()
                                    }
                                }
                            }
                        }
                    }
                }
            }

            PageIndicator {
                id: indicator
                anchors.horizontalCenter: parent.horizontalCenter

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
}

