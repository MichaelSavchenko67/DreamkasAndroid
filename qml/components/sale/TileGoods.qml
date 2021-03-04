import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13

Rectangle {
    property var name: ""
    property var cost: ""
    property var measure: ""
    property var img: ""

    width: parent.width / 3
    height: width
    color: "#00FFFFFF"

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: 16
        color: parent.color

        Rectangle {
            id: tile
            anchors.centerIn: parent
            width: 0.9 * parent.width
            height: width
            color: parent.color
            radius: parent.radius
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: tile.width
                    height: tile.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: tile.adapt ? tile.width : Math.min(tile.width, tile.height)
                        height: tile.adapt ? tile.height : width
                        radius: tile.radius
                    }
                }
            }

            Image {
                anchors.fill: parent
                source: img
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                width: parent.width
                height: 0.37 * parent.width
                anchors.bottom: parent.bottom
                color: "#D8EEFF"
                opacity: 0.9

                Column {
                    height: 0.71 * parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 0.5 * (height - 2 * goodsName.height)
                    leftPadding: goodsName.font.pixelSize

                    Label {
                        id: goodsName
                        text: name
                        font {
                            pixelSize: 0.33 * parent.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "black"
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignTop
                    }

                    Label {
                        text: cost + " \u20BD/" + measure
                        font: goodsName.font
                        color: "black"
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignBottom
                        opacity: 0.5
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: rect
        horizontalOffset: 0
        verticalOffset: 2
        radius: 8
        color: "#D6D6D6"
        cached: true
        source: rect
    }
}
