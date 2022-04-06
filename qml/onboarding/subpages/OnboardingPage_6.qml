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
    function calculateOnboardingHoleHeight()
    {
         var splitTileKoef = pageType + 1 // так совпало что у нас количество плиток в ряду на текущий момент зависят от индекса меню
                                          // 0 индекс(Ввод цены нам никогда не придет)
                                          // на 1 индексе(Услуги) у нас 2 плитки в ряду
                                          // на 2 индексе(Овощи) у нас 3 плитки в ряду
                                          // на 3 индексе(Продукты) у нас 4 плитки в ряду
        mainRectSix.height =  rootStack.width / splitTileKoef  * 2

    }

    id:sixPage
    anchors.fill: parent
    visible: true
    property int pageType:0
    onPageTypeChanged:
    {
        calculateOnboardingHoleHeight()
    }


    color:"transparent"

    Rectangle {
        id:littleRectSix
        anchors.fill: parent
        visible: false
        color:Qt.rgba(0.15,0.15,0.15,0.8)
    }

    Item {
        id: hidingRectSix
        anchors.fill: littleRectSix
        visible: false

        Rectangle {
            z:100
            id:mainRectSix
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            width: rootStack.width
            //height: calculateOnboardingHoleHeight()//rootStack.height - 0.700 * width - rootStack.width / 3 - 5
            anchors
               {
                   right:parent.right
                   left:parent.left
                   leftMargin:5
                   rightMargin:5
                   top: parent.top
                   topMargin: toolBar.height + 0.1125 * root.width
               }
            radius:15
        }
    }


    OpacityMask {
        anchors.fill: littleRectSix
        source: littleRectSix
        maskSource: hidingRectSix
        invert: true

    }

    /// далее идут прямоугольник с MouseArea они нужны чтобы не дать юзеру нажать на лишнее
    Rectangle
    {
        id:topRect
        width:sixPage.width
        height:toolBar.height + 0.135 * root.width
         color:"transparent"
        anchors.top: sixPage.top
        MouseArea
        {
            id:mAreaTop
            anchors.fill:parent
        }
    }
    Rectangle
    {
        id:botRect
        width:sixPage.width
        height:toolBar.height + 0.437 * root.height
        color:"transparent"
        anchors.bottom: sixPage.bottom
        MouseArea
        {
            id:mAreaBot
            anchors.fill:parent
        }
        Image
           {
               z:4
               id: arrowImg
               height: 80
               width: 69
               anchors {
                   top: parent.top
                   topMargin:5
                   //left:sixPage.left
                   //leftMargin: leftRect.width + (mainRectSix.width/6) - width/2
                   horizontalCenter: parent.horizontalCenter
               }
               source: "qrc:/img/onboarding/page_6_arrow.png"
           }
        Label
        {
          z:4
          id: userInfoText
          width: parent.width
          anchors.top: arrowImg.bottom
          text: qsTr("Нажмите на плитку с товаром\nдля добавления в заказ")
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
    Rectangle
    {
        id:rightRect
        width:mainRectSix.anchors.rightMargin
         color:"transparent"
        anchors
        {
            right: sixPage.right
            top:topRect.bottom
            bottom:botRect.top
        }
        MouseArea
        {
            id:mAreaRight
            anchors.fill:parent
        }
    }
    Rectangle
    {
        id:leftRect
        width:mainRectSix.anchors.leftMargin
         color:"transparent"
        anchors
        {
            left: sixPage.left
            top:topRect.bottom
            bottom:botRect.top
        }
        MouseArea
        {
            id:mAreaLeft
            anchors.fill:parent
        }
    }

}

