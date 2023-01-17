import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ItemDelegate {
    property var itemLogo: ""
    property var itemTitle: ""
    property var itemSubscription: ""

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 16

        Row {
            id: printerType
            width: parent.width
            height: 0.85 * parent.height
            anchors.verticalCenter: manufacturerLogo.verticalCenter
            leftPadding: 0.042 * parent.width

            Image {
                id: manufacturerLogo
                anchors.verticalCenter: parent.verticalCenter
                width: 0.09 * parent.width
                height: width
                source: itemLogo
            }

            Column {
                width: parent.width - manufacturerLogo.width - chooseIco.width - 2 * parent.leftPadding
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0.25 * printerTypeName.font.pixelSize

                Label {
                    id: printerTypeName
                    width: parent.width
                    text: qsTr(itemTitle)
                    font {
                        pixelSize: 0.5 * manufacturerLogo.height
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    clip: true
                    elide: "ElideRight"
                    verticalAlignment: Label.AlignTop
                    leftPadding: font.pixelSize
                }

                Label {
                    width: parent.width

                    leftPadding: printerTypeName.leftPadding
                    text: qsTr(itemSubscription)
                    font {
                        pixelSize: 0.67 * printerTypeName.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    clip: true
                    elide: "ElideRight"
                    lineHeight: 1.3
                    verticalAlignment: Label.AlignBottom
                    maximumLineCount: 4
                    wrapMode: Label.WordWrap
                }
            }

            Image {
                id: chooseIco
                anchors.verticalCenter: parent.verticalCenter
                width: manufacturerLogo.width
                height: width
                source: "qrc:/ico/menu/choose_right.png"
            }
        }
    }
}
