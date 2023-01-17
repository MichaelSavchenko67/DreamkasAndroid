import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1

Calendar {
    id: calendar
    width: parent.width
    height: parent.height
    frameVisible: true
    weekNumbersVisible: true
    selectedDate: new Date
    focus: true
    property var startDate: undefined
    property var stopDate: undefined
    property bool isIntervalEnable: false

    style: CalendarStyle {
        dayDelegate: Item {
            readonly property color sameMonthDateTextColor: "#444"
            readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : systemPalette.highlight
            readonly property color selectedDateTextColor: "white"
            readonly property color differentMonthDateTextColor: "#bbb"
            readonly property color invalidDatecolor: "#dddddd"
            property var dateOnFocus: styleData.date

            Rectangle {
                anchors.fill: parent
                border.color: "transparent"
                color: ((styleData.date !== undefined) && styleData.selected) ? selectedDateColor : "transparent"
            }

            Rectangle {
                id:fl
                anchors.fill: parent
                property bool flag: false
                color: ((dateOnFocus>calendar.startDate) && (dateOnFocus< calendar.stopDate)) ? "#55555555":
                                                                                                ((calendar.startDate !== undefined) && (dateOnFocus.getTime() === calendar.startDate.getTime())) ? "#3778d0" :
                                                                                                                                                                                                   "transparent"
            }

            MouseArea{
                anchors.fill: parent
                propagateComposedEvents: true
                onPressed: {
                    if (!isIntervalEnable) {
                        calendar.startDate = undefined
                        calendar.stopDate = undefined
                    }

                    if (calendar.startDate === undefined) {
                        calendar.startDate  =styleData.date
                    }
                    else if (calendar.stopDate === undefined) {
                        calendar.stopDate = styleData.date
                    }
                    else {
                        calendar.startDate = styleData.date
                        calendar.stopDate = undefined
                    }

                    if (calendar.stopDate <= calendar.startDate) {
                        calendar.startDate = styleData.date
                        calendar.stopDate = undefined
                    }

                    mouse.accepted = false
                }
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
                        else if (dateOnFocus.getTime() === calendar.startDate.getTime()) {
                            color = selectedDateTextColor;
                        }
                    }
                    color;
                }
            }
        }
    }
}
