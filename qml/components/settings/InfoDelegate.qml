import QtQuick
import QtQuick.Controls

Row {
    id: mainRow
    width: parent.width
    height: 1.1 * ico.height

    property string icoSrc: ""
    property string titleText: ""
    property string description: ""

    Image {
        id: ico
        anchors.verticalCenter: parent.verticalCenter
        width: 0.09 * parent.width
        height: width
        source: icoSrc
        fillMode: Image.PreserveAspectFit
    }

    Column {
        width: parent.width - ico.width - 2 * parent.leftPadding
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: title
            width: parent.width
            text: qsTr(titleText)
            font {
                pixelSize: 0.5 * ico.height
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            color: "black"
            clip: true
            elide: Label.ElideRight
            verticalAlignment: Label.AlignVCenter
            leftPadding: font.pixelSize
        }

        Label {
            width: parent.width
            text: qsTr(description)
            font {
                pixelSize: 0.83 * title.font.pixelSize
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            color: "#979797"
            clip: true
            elide: Label.ElideRight
            verticalAlignment: Label.AlignVCenter
            leftPadding: title.leftPadding
        }
    }
}
