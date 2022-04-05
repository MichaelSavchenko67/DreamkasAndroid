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
    id:seventhPage
    anchors.fill: parent
    visible: true
    color:"transparent"
    Label
    {
      z:4
      id: userInfoText
      anchors.top : seventhPage.top
      anchors.topMargin: seventhPage.height * 0.29
      anchors.left: seventhPage.left
      anchors.right:seventhPage.right
      width: seventhPage.width
      text: qsTr("Добавляйте новые товары\nв плитках быстрого доступа")
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
    Image
       {
           z:5
           id: arrowImg
           height: 155
           width: 91
           anchors {
               top: userInfoText.bottom
               topMargin:5
               //left:sixPage.left
               //leftMargin: leftRect.width + (mainRectSix.width/6) - width/2
               horizontalCenter: parent.horizontalCenter
           }
           source: "qrc:/img/onboarding/page_7_arrow.png"
       }
    Rectangle {
        id:littleRectSeventh
        anchors.fill: parent
        visible: false
        color:Qt.rgba(0.15,0.15,0.15,0.8)
    }

    Item {
        id: hidingRectSeventh
        anchors.fill: littleRectSeventh
        visible: false

        Rectangle {
            id:mainRectSeventh
            //anchors.centerIn: parent
            width: rootStack.width / 3
            height: width
            x:botRect.x + secondPage.width - width
            y:botRect.y - height + 4
//            anchors
//               {
//                   right:botRect.right
//                   bottom: botRect.top
//                   rightMargin:5
//               }
            radius:15
        }
    }

    OpacityMask {
        anchors.fill: littleRectSeventh
        source: littleRectSeventh
        maskSource: hidingRectSeventh
        invert: true

    }

    /// далее идут прямоугольник с MouseArea они нужны чтобы не дать юзеру нажать на лишнее
    Rectangle
    {
        id:topRect
        width:seventhPage.width
        height:seventhPage.height - botRect.height - rootStack.width / 3
        color:"transparent"
        anchors.top: seventhPage.top
        MouseArea
        {
            id:mAreaTop
            anchors.fill:parent
        }
    }
    Rectangle
    {
        id:botRect
        width:seventhPage.width
        height:toolBar.height + 0.432 * root.width
        color:"transparent"
        anchors.bottom: seventhPage.bottom
        MouseArea
        {
            id:mAreaBot
            anchors.fill:parent
        }

    }
    Rectangle
    {
        id:leftRect
        width:seventhPage.width/3 * 2
        color:"transparent"
        anchors
        {
            left: seventhPage.left
            top:topRect.bottom
            bottom:botRect.top
        }
        MouseArea
        {
            id:mAreaRight
            anchors.fill:parent
        }
    }
}

