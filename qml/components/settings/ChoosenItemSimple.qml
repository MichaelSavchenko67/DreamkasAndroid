import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Button {
    property var title: ""
    property var icoPath: ""
    property var fontPixelSize: 0.06 * printerTypeRow.width

    background: Rectangle {
        anchors.fill: parent
        color: "#F6F6F6"
        radius: 16

        Row {
            id: printerTypeRow
            anchors.fill: parent
            leftPadding: 0.042 * parent.width

            Image {
                id: levelIco
                anchors.verticalCenter: parent.verticalCenter
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                source: (icoPath.length > 0) ? icoPath : "qrc:/ico/settings/signal_100_percent.png"
            }

            Column {
                width: parent.width - levelIco.width - ico.width - 2 * parent.leftPadding
                anchors.verticalCenter: levelIco.verticalCenter
                spacing: 0.25 * titleLabel.font.pixelSize

                Label {
                    id: titleLabel
                    width: parent.width
                    text: qsTr(title)
                    font {
                        pixelSize: fontPixelSize
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
            }

            Image {
                id: ico
                anchors.verticalCenter: parent.verticalCenter
                width: 0.09 * printerTypeRow.width
                height: width
                source: "qrc:/ico/menu/choose_right.png"
            }
        }
    }
}
