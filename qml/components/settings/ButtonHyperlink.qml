import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/sale" as SaleComponents

Column {
    width: parent.width
    spacing: (titleLabel.text.length > 0) ? (height - titleLabel.contentHeight - icoImage.height) : 0

    property var title: ""
    property var icoTitle: ""
    property var icoPath: ""

    signal go()

    Label {
        id: titleLabel
        width: parent.width
        text: qsTr(title)
        visible: (text.length > 0)
        font {
            pixelSize: 0.35 * parent.height
            family: "Roboto"
            styleName: "normal"
        }
        color: "black"
        clip: true
        elide: "ElideRight"
        horizontalAlignment: Label.AlignLeft
        verticalAlignment: Label.AlignVCenter
    }

    ItemDelegate {
        width: parent.width
        height: icoImage.height

        Row {
            anchors.fill: parent
            spacing: 0.5 * titleLabel.font.pixelSize

            Image {
                id: icoImage
                width: 1.2 * titleLabel.font.pixelSize
                height: width
                anchors.verticalCenter: parent.verticalCenter
                source: icoPath
                fillMode: Image.PreserveAspectFit
            }

            Label {
                id: icoTitleLabel
                width: parent.width - icoImage.width - 3 * parent.spacing
                text: qsTr(icoTitle)
                anchors.verticalCenter: parent.verticalCenter
                font: titleLabel.font
                color: "#0064B4"
                clip: titleLabel.clip
                elide: titleLabel.elide
                horizontalAlignment: titleLabel.horizontalAlignment
                verticalAlignment: titleLabel.verticalAlignment
            }
        }
        onClicked: {
            go()
        }
    }
}
