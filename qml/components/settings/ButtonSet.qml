import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Button {
    id: buttonSet
    property string buttonTxt
    property string iconPath: "qrc:/ico/settings/check_blue.png"
    property bool isSetUp: false

    width: 0.5 * parent.width
    height: 0.5 * width
    contentItem: Row {
        id: contentRow
        anchors.fill: parent
        leftPadding: 0.75 * txt.font.pixelSize
        spacing: leftPadding

        Text {
            id: txt
            width: parent.width - ico.width - 3 * parent.spacing
            anchors.verticalCenter: parent.verticalCenter
            text: buttonTxt
            elide: Label.ElideRight
            horizontalAlignment: Label.AlignLeft
            verticalAlignment: Label.AlignVCenter
            opacity: isSetUp ? 1.0 : 0.54
            font {
                pixelSize: 0.338 * parent.height
                weight: Font.Normal
            }
            color: "black"
        }

        Image {
            id: ico
            visible: buttonSet.isSetUp
            source: iconPath
            height: 0.26 * parent.height
            width: height
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    background: Rectangle {
        id: rect
        color: "transparent"
        border.color: buttonSet.isSetUp ? "#0064B4" : "#979797"
        border.width: 1
        radius: 8
    }

    DropShadow {
        visible: true
        anchors.fill: rect
        cached: true
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#d6d6d6"
        source: rect
    }

    onClicked: {
        isSetUp = true
    }
}
