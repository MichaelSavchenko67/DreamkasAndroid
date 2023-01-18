import QtQuick
import QtQuick.Controls

ItemDelegate {

    property int startTime
    property int finishTime

    contentItem: Row {
        spacing: 1.5 *delimiter.width

        Column {
            id: firstDateTime
            anchors.verticalCenter: parent.verticalCenter

            Label {
                text: ((startTime < 10 ? "0%1" : "%1") + ":00").arg(startTime)
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
                text: ((finishTime < 10 ? "0%1" : "%1") + ":00").arg(finishTime)
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

