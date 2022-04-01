import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/pages/" as Pages
import "qrc:/qml/pages/subpages" as Subpages
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents
import QtQuick 2.12
import QtQuick.Window 2.12
Rectangle {
 id:secondPage
 anchors.fill: parent
 color: "transparent"

 Rectangle
 {
     id:topRect
     width:secondPage.width
     height:toolBar.height + 0.135 * root.width
     color:Qt.rgba(0.15,0.15,0.15,0.8)
     anchors.top: secondPage.top
     MouseArea
     {
         id:mAreaTop
         anchors.fill:topRect
     }
 }
 Rectangle
 {
     id:botRect
     width:secondPage.width
     height:toolBar.height + 0.21 * root.width
     color:Qt.rgba(0.15,0.15,0.15,0.8)
     anchors.bottom: secondPage.bottom
     MouseArea
     {
         id:mAreaBot
         anchors.fill:botRect
     }
 }
 Rectangle
 {
     id:rightRect
     width:mainRect.anchors.rightMargin
     color:Qt.rgba(0.15,0.15,0.15,0.8)
     anchors
     {
         right: secondPage.right
         top:topRect.bottom
         bottom:botRect.top
     }
     MouseArea
     {
         id:mAreaRight
         anchors.fill:botRect
     }
 }
 Rectangle
 {
     id:leftRect
     width:mainRect.anchors.leftMargin
     color:Qt.rgba(0.15,0.15,0.15,0.8)
     anchors
     {
         left: secondPage.left
         top:topRect.bottom
         bottom:botRect.top
     }
     MouseArea
     {
         id:mAreaLeft
         anchors.fill:botRect
     }
 }
 Rectangle
 {
     id:mainRect
     width: rootStack.width
     height: rootStack.height - 0.425 * width
     anchors
        {
            top: secondPage.top
            topMargin: toolBar.height + 0.0898 * root.width
            right:secondPage.right
            rightMargin:20
            left:secondPage.left
            leftMargin:20
        }
      color:"transparent"
      radius:10

 }
}
