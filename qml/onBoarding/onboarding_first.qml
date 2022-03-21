import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents
Page
{
    Layout.fillHeight: true
    Layout.fillWidth: true
    onFocusChanged: {
        if (focus) {
            console.log("[Onboarding.qml]\tfocus changed: " + focus)
            setToolbarVisible(true)
            setToolbarShadow(false)
            setMainPageTitle("Обучение тест")
            setHeaderTitleButtonVisible(true)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
            setContextMenuVisible(false)
        }
    }
    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true
        anchors.fill: parent
        Rectangle
           {
                z:1
                id:bgFillForOnBoarding
                width: parent.width
                height: parent.height
                color: Qt.rgba(0.39,0.39,0.39,0.75)

           }
         Image
            {
                z:0
                id: cashierImg
                height: 0.4 * parent.height
                width: 0.465 * height
                anchors {
                    top: parent.top
                    topMargin: 0.33 * height
                    horizontalCenter: parent.horizontalCenter
                }
                source: "qrc:/img/sale/cashier.png"
            }
            Rectangle
            {
                z:2
                anchors
                {
                   top: cashierImg.bottom
                   topMargin: 10
                   horizontalCenter: cashierImg.horizontalCenter
                   bottomMargin: 5
                }
                id: infoWhiteSheet
                height: 0.43 * parent.height
                width: 0.95 * parent.width
                color: Qt.white
                visible: true
                radius: 5
                Text {
                    id: title
                    width:  0.71 * parent.width
                    height: 0.11 * width
                    anchors {
                        top: parent.top
                        topMargin: 0.78 * height
                        horizontalCenter: parent.horizontalCenter
                    }

                    text: qsTr("Открытие смены")
                    font {
                        pixelSize: 0.8 * height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Bold
                        bold: true
                    }
                    clip: true
                    color: "black"
                    elide: Text.ElideRight
                    horizontalAlignment: Qt.AlignCenter
                    verticalAlignment: Qt.AlignVCenter
                }

                Text {
                    id: msg2user
                    width:  title.width
                    anchors {
                        top: title.bottom
                        topMargin: 0.5 * title.anchors.topMargin
                        horizontalCenter: title.horizontalCenter
                    }

                    text: qsTr("Для продолжения работы вам\nнеобходимо открыть смену")
                    font {
                        pixelSize: 0.56 * title.font.pixelSize
                        family: title.font.family
                        styleName: title.font.styleName
                        weight: Font.Thin
                    }
                    clip: true
                    color: "black"
                    elide: title.elide
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                    horizontalAlignment: title.horizontalAlignment
                    verticalAlignment: title.verticalAlignment
                }
                Image
                   {
                       z:0
                       id: arrowImg
                       height: 0.4 * parent.height
                       width: 0.465 * height
                       anchors {
                           top: msg2user.bottom
                           topMargin: 5
                           horizontalCenter: parent.horizontalCenter
                       }
                       source: "qrc:/img/arrow/arrowOnboardingFirst.png"
                   }
                SaleComponents.Button_1 {
                    z:3
                    width: 0.95 * parent.width
                    height: 0.15 * width
                    anchors {
                        bottom: infoWhiteSheet.bottom
                        bottomMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }
                    borderWidth: 0
                    backRadius: 5
                    buttonTxt: qsTr("ОТКРЫТЬ СМЕНУ")
                    fontSize: 0.33 * height
                    buttonTxtColor: "white"
                    pushUpColor: "#415A77"
                    pushDownColor: "#004075"
                    action: openShift
                }
            }
            }


    }



