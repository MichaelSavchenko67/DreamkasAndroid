import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Button {
    property string title: ""
    property string icoPath: ""
    property real fontPixelSize: 0.06 * printerTypeRow.width
    property real icoHeight: 0.8 * printerTypeRow.height
    property bool isApplied: false
    property string appliedMsg: ""

    background: Rectangle {
        anchors.fill: parent
        color: parent.pressed ? "#c3c3c3" : "#F6F6F6"
        radius: 8

        Row {
            id: printerTypeRow
            anchors.fill: parent
            leftPadding: 0.042 * parent.width

            Image {
                id: levelIco
                anchors.verticalCenter: parent.verticalCenter
                height: icoHeight
                fillMode: Image.PreserveAspectFit
                source: (icoPath.length > 0) ? icoPath : "qrc:/ico/settings/signal_100_percent.png"
            }

            Column {
                width: parent.width - levelIco.width - ico.width - 2 * parent.leftPadding
                anchors.verticalCenter: levelIco.verticalCenter
                spacing: 0.5 * titleLabel.font.pixelSize

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
                    maximumLineCount: 2
                    wrapMode: Label.WordWrap
                    verticalAlignment: Label.AlignTop
                    leftPadding: font.pixelSize
                }

                Row {
                    width: parent.width - titleLabel.width - parent.spacing
                    leftPadding: titleLabel.leftPadding
                    spacing: 0.5 * appliedIco.width

                    Image {
                        id: appliedIco
                        visible: isApplied
                        width: titleLabel.font.pixelSize
                        height: width
                        anchors.verticalCenter: appliedMsgLabel.verticalCenter
                        source: "qrc:/ico/menu/success_ico_small.png"
                    }

                    Label {
                        id: appliedMsgLabel
                        visible: appliedIco.visible
                        width: parent.width -
                               appliedIco.width -
                               parent.leftPAdding -
                               parent.spacing
                        text: qsTr(appliedMsg)
                        font {
                            pixelSize: 0.85 * fontPixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#979797"
                        clip: true
                        elide: Label.ElideRight
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                    }
                }
            }

            Image {
                id: ico
                anchors.verticalCenter: parent.verticalCenter
                width: 0.09 * printerTypeRow.width
                height: width
                fillMode: Image.PreserveAspectFit
                source: "qrc:/ico/menu/choose_right.png"
            }
        }
    }
}
