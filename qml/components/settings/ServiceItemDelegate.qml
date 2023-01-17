import QtQuick
import QtQuick.Controls

Column {
    id: rootColumn
    property var title: ""
    property var ico: ""

    width: parent.width
    height: operationIco.height
    spacing: 0.06 * parent.width

    ItemDelegate {
        id: itemDelegate
        anchors.fill: parent
        leftPadding: 0.7 * parent.spacing

        contentItem: Row {
            width: parent.width

            Image {
                id: operationIco
                anchors.verticalCenter: parent.verticalCenter
                width: 0.09 * rootColumn.width
                height: width
                source: ico
            }

            Label {
                id: operationTitle
                width: parent.width - operationIco.width - 2 * itemDelegate.leftPadding
                text: qsTr(title)
                anchors.verticalCenter: parent.verticalCenter
                font {
                    pixelSize: 0.5 * operationIco.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                clip: true
                elide: "ElideRight"
                verticalAlignment: Label.AlignVCenter
                leftPadding: font.pixelSize
            }
        }
    }
}
