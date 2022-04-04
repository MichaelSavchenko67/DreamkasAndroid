
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
        anchors.fill: littleRect
        source: littleRect
        maskSource: hidingRect
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
            right: mainRect.left
        }
        MouseArea
        {
            id:mAreaLeft
            anchors.fill:parent
        }
    }
}
