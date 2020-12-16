import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1

Calendar {
    id: calendar
    width: (parent.width > parent.height ? parent.width * 0.6 - parent.spacing : parent.width)
    height: (parent.height > parent.width ? parent.height * 0.6 - parent.spacing : parent.height)
    frameVisible: true
    weekNumbersVisible: false
    selectedDate: new Date()
    focus: true

    style: CalendarStyle {
        dayDelegate: Item {
            readonly property color sameMonthDateTextColor: "#444"
            readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : systemPalette.highlight
            readonly property color selectedDateTextColor: "white"
            readonly property color differentMonthDateTextColor: "#bbb"
            readonly property color invalidDatecolor: "#dddddd"

            Rectangle {
                anchors.fill: parent
                border.color: "transparent"
                color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "transparent"
                anchors.margins: styleData.selected ? -1 : 0
            }

            Image {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: -1
                width: 12
                height: width
                source: "qrc:/images/eventindicator.png"
            }

            Label {
                id: dayDelegateText
                text: styleData.date.getDate()
                anchors.centerIn: parent
                color: {
                    var color = invalidDatecolor;
                    if (styleData.valid) {
                        // Date is within the valid range.
                        color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                        if (styleData.selected) {
                            color = selectedDateTextColor;
                        }
                    }
                    color;
                }
            }
        }
    }
}
