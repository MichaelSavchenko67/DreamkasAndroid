import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Item {
    property var itemLogo: ""
    property var itemTitle: ""
    property var itemSubscription: ""

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
                width: parent.width - manufacturerLogo.width - switchToggle.width - loader.implicitWidth - 3 * parent.leftPadding
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
                    verticalAlignment: Label.AlignBottom
                    maximumLineCount: 4
                    wrapMode: Label.WordWrap
                }
            }


            BusyIndicator {
                id: loader
                implicitWidth: parent.height
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
