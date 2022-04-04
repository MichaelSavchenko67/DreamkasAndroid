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
import QtQuick 2.0
import QtQuick.Window 2.0

Rectangle {
    id:secondPage
    anchors.fill: parent
    visible: true
    color:"transparent"

    Rectangle {
        id:littleRect
        anchors.fill: parent
        visible: false
        color:Qt.rgba(0.15,0.15,0.15,0.8)
    }

    Item {
        id: hidingRect
        anchors.fill: littleRect
        visible: false

        Rectangle {
            z:100
            id:mainRect
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            width: rootStack.width
            height: rootStack.height - 0.500 * width
            anchors
               {
                   right:parent.right
                   left:parent.left
                   leftMargin:18
                   rightMargin:18
                   top: parent.top
                   topMargin: toolBar.height + 0.1125 * root.width
               }
            radius:15
        }
    }

    OpacityMask {
        anchors.fill: littleRect
        source: littleRect
        maskSource: hidingRect
        invert: true

    }
    /// далее идут прямоугольник с MouseArea они нужны чтобы не дать юзеру нажать на лишнее
    Rectangle
    {
        id:topRect
        width:secondPage.width
        height:toolBar.height + 0.135 * root.width
         color:"transparent"
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
        color:"transparent"
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
         color:"transparent"
        anchors
        {
            right: secondPage.right
            top:topRect.bottom
            bottom:botRect.top
        }
        MouseArea
        {
            id:mAreaRight
            anchors.fill:rightRect
        }
    }
    Rectangle
    {
        id:leftRect
        width:mainRect.anchors.leftMargin
         color:"transparent"
        anchors
        {
            left: secondPage.left
            top:topRect.bottom
            bottom:botRect.top
        }
        MouseArea
        {
            id:mAreaLeft
            anchors.fill:leftRect
        }
    }
    Rectangle
    {
        id:textRect
        width:secondPage.width
        height:toolBar.height + 0.21 * root.width
        color:"transparent"
        anchors.bottom: secondPage.bottom
        anchors.centerIn: parent
        Label
        {

        }
    }
}

