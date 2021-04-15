import QtQuick 2.12
import QtQuick.Controls 2.12

ItemDelegate {

    property var startTime
    property var finishTime

    contentItem: Row {
        spacing: 2 * delimiter.width

        Column {
            id: firstDateTime
            anchors.verticalCenter: parent.verticalCenter

            Label {
                text: startTime
                font {
                    pixelSize: 1.2 * titleLabelInfo.font.pixelSize
                }
                color: "#0064B4"
            }

            Rectangle {
                width: parent.width
                height: delimiter.height
                color: "#0064B4"
            }
        }

        Rectangle {
            id: delimiter
            width: 0.06 * parent.width
            height: 2
            color: "#0064B4"
            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            Label {
                text: finishTime
                font {
                    pixelSize: 1.2 * titleLabelInfo.font.pixelSize
                }
                color: "#0064B4"
            }

            Rectangle {
                width: parent.width
                height: delimiter.height
                color: "#0064B4"
            }
        }
    }
}

