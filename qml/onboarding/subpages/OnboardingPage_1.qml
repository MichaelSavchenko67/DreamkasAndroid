import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/pages/" as Pages
import "qrc:/qml/pages/subpages" as Subpages
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Rectangle
{
    MouseArea
    {
        z:2
        id:mArea
        anchors.fill: parent
    }

    z:2
    id: firstPage
    color:Qt.rgba(0.15,0.15,0.15,0.8)
    anchors.fill: parent
    signal nextPage()
    Rectangle
    {
         z:3
         anchors
         {
           bottom: firstPage.bottom
           bottomMargin: 15
           right: firstPage.right
           rightMargin:15
           leftMargin:15
           left: firstPage.left
          }
            id: infoWhiteSheet
            height: 0.365 * parent.height
            width: parent.width
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
                          source: "qrc:/img/onboarding/first_arrow.png"
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
                       onClicked:
                       {
                            nextPage()
                       }
                   }
               }
}



