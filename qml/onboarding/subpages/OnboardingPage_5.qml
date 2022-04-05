
import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/pages/" as Pages
import "qrc:/qml/pages/subpages" as Subpages
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Rectangle {
    id:fifthPage
    anchors.fill: parent
    visible: true
    color:"transparent"

    Rectangle {
        id:littleRectFifth
        anchors.fill: parent
        visible: false
        color:Qt.rgba(0.15,0.15,0.15,0.8)
    }

    Item {
        id: hidingRectFifth
        anchors.fill: littleRectFifth
        visible: false

        Rectangle {
            z:100
            id:mainRectFifth
            //anchors.centerIn: parent
            //anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - root.width/4
            height: 0.0898 * root.width
            anchors
               {
                   right:parent.right

                   top: parent.top
                   topMargin: toolBar.height
               }
            radius:8
        }
    }

    OpacityMask {
        anchors.fill: littleRectFifth
        source: littleRectFifth
        maskSource: hidingRectFifth
        invert: true

    }
    /// далее идут прямоугольник с MouseArea они нужны чтобы не дать юзеру нажать на лишнее
    Rectangle
    {
        id:topRect
        width:fifthPage.width
        height:toolBar.height
         color:"transparent"
        anchors.top: fifthPage.top
        MouseArea
        {
            id:mAreaTop
            anchors.fill:parent
        }
    }
    Rectangle
    {
        id:botRect
        width:fifthPage.width
        height:fifthPage.height - 0.0898 * root.width - topRect.height
        color:"transparent"
        anchors.bottom: fifthPage.bottom
        MouseArea
        {
            id:mAreaBot
            anchors.fill:parent
        }
    }
    Rectangle
    {
        id:leftRect
        width:root.width/4
        height:0.0898 * root.width
        color:"transparent"
        anchors{
            top:topRect.bottom
            left:fifthPage.left
            right: mainRectFifth.left
        }
        MouseArea
        {
            id:mAreaLeft
            anchors.fill:parent
        }
    }
    Image
       {
           z:4
           id: arrowImg
           height: 135
           width: 100
           anchors {
               top: fifthPage.top
               topMargin: toolBar.height + 0.0898 * root.width + 5
               left:fifthPage.left
               leftMargin: leftRect.width + (mainRectFifth.width/6) - width/2
               //horizontalCenter: parent.horizontalCenter
           }
           source: "qrc:/img/onboarding/page_5_arrow.png"
       }
    Label
    {
      z:4
      id: userInfoText
      width: parent.width
      anchors.top: arrowImg.bottom
      text: qsTr("Также можно добавить товары\nиз плиток быстрого доступа ")
      color: "white"
      horizontalAlignment: Label.AlignHCenter
      font
          {
          pixelSize: 18
          family: "Roboto"
          styleName: "medium"
          weight: Font.Bold
          bold: true
         }

       }
}
