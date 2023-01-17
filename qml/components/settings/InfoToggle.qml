import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 2.12

Item {
    width: parent.width
    height: txtColumn.height

    property string itemLogo: ""
    property string itemTitle: ""
    property string itemSubscription: ""
    property real icoHeight: 0
    property real icoWidth: 0

    onIcoHeightChanged: {
        ico.height = icoHeight
    }

    onIcoWidthChanged: {
        ico.width = icoWidth
    }

    function setChecked(isChecked) {
        switchToggle.checked = isChecked
    }

    function getChecked() {
        return switchToggle.checked
    }

    function setLoader(isLoad) {
        loader.running = isLoad
    }

    function getLoader() {
        return loader.running
    }

    signal switched()

    Rectangle {
        id: mainFrame
        anchors.fill: parent
        color: "transparent"
        radius: 8

        Row {
            id: mainRow
            anchors.fill: parent
            spacing: 0.042 * parent.width
            leftPadding: spacing

            Image {
                id: ico
                anchors.verticalCenter: parent.verticalCenter
                height: mainFrame.height
                width: height
                source: itemLogo
            }

            Column {
                id: txtColumn
                width: parent.width -
                       ico.width -
                       switchToggle.width -
                       loader.implicitWidth -
                       2 * parent.leftPadding -
                       3 * parent.spacing
                height: printerTypeName.contentHeight +
                        subscriptionLabel.contentHeight +
                        spacing
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0.25 * printerTypeName.font.pixelSize

                Label {
                    id: printerTypeName
                    width: parent.width
                    text: qsTr(itemTitle)
                    font {
                        pixelSize: 0.045 * mainRow.width
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
                }

                Label {
                    id: subscriptionLabel
                    width: parent.width
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
                    maximumLineCount: 4
                    wrapMode: Label.WordWrap
                    verticalAlignment: Label.AlignBottom
                }
            }

            BusyIndicator {
                id: loader
                implicitWidth: 0.09 * parent.width
                implicitHeight: implicitWidth
                anchors.verticalCenter: parent.verticalCenter
                running: false
                Material.accent: "#5C7490"
            }

            Switch {
                id: switchToggle
                anchors.verticalCenter: parent.verticalCenter
                onCheckedChanged: {
                    switched()
                }
            }
        }
    }
}
