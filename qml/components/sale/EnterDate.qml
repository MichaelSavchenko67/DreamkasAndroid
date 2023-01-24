import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "qrc:/qml/components/settings" as SettingsComponents

Page {
    property bool isPeriodAvailable: true
    property bool isResultLableEnabled: true
    property date gridDate: new Date()
    property date currentDate: new Date()
    property date maxDate: currentDate
    property date choosenDate: currentDate
    property date choosenDateSecond: new Date("")
    property date beginPeriodDate: new Date("")
    property date endPeriodDate: new Date("")


    function getResultDateStr() {
        if (isPeriodAvailable) {
            let isChoosenDateBegin = choosenDate.getTime() < choosenDateSecond.getTime()
            beginPeriodDate = isChoosenDateBegin ? choosenDate : choosenDateSecond
            endPeriodDate = isChoosenDateBegin ? choosenDateSecond : choosenDate

            if (isNaN(beginPeriodDate)) {
                beginPeriodDate = endPeriodDate
            } else if (isNaN(endPeriodDate)) {
                endPeriodDate = beginPeriodDate
            }

            if (beginPeriodDate.toLocaleDateString() === endPeriodDate.toLocaleDateString()) {
                return beginPeriodDate.toLocaleDateString(grid.locale)
            } else {
                return beginPeriodDate.toLocaleDateString('ru_RU') + " - " + endPeriodDate.toLocaleDateString('ru_RU')
            }
        } else {
            return choosenDate.toLocaleDateString(Qt.locale("ru_RU"))
        }
    }

    onChoosenDateChanged: {
        resultDateLabel.text = getResultDateStr()
    }

    onChoosenDateSecondChanged: {
        resultDateLabel.text = getResultDateStr()
    }

    header: ToolBar {
        id: calendarToolbar

        RowLayout {
            anchors.fill: parent

            Rectangle {
                anchors.fill: parent
                color: "#415A77"
            }

            ToolButton {
                contentItem: Label {
                    id: prevMonthButtonLable
                    Layout.fillWidth: true
                    text: qsTr("<")
                    font {
                        pixelSize: 0.05 * calendarToolbar.width
                        weight: Font.DemiBold
                        bold: true
                    }
                    color: "white"
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }
                onClicked: {
                    gridDate = new Date(gridDate.setMonth(gridDate.getMonth() - 1));
                }
            }

            Label {
                id: monthLabel
                Layout.fillWidth: true
                text: qsTr(grid.locale.standaloneMonthName(gridDate.getMonth()) + " " + gridDate.toLocaleString(grid.locale, "yyyy"))
                font {
                    pixelSize: 0.05 * parent.width
                    weight: Font.DemiBold
                    bold: true
                }
                color: "white"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            ToolButton {
                contentItem: Label {
                    Layout.fillWidth: true
                    text: qsTr(">")
                    font: prevMonthButtonLable.font
                    color: prevMonthButtonLable.color
                    horizontalAlignment: prevMonthButtonLable.horizontalAlignment
                    verticalAlignment: prevMonthButtonLable.verticalAlignment
                }
                onClicked: {
                    gridDate = new Date(gridDate.setMonth(gridDate.getMonth() + 1));
                }
            }
        }
    }

    GridLayout {
        anchors.fill: parent
        columns: 1

        DayOfWeekRow {
            id: dayOfWeekRow
            locale: grid.locale
            font.bold: true
            delegate: Label {
                text: model.shortName
                font: monthLabel.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Layout.column: 1
            Layout.fillWidth: true
        }

        MonthGrid {
            id: grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            month: gridDate.getMonth()
            year: gridDate.getFullYear()
            locale: Qt.locale("ru_RU")
            spacing: 0

            readonly property int gridLineThickness: 1

            delegate: SettingsComponents.MonthGridDelegate {
                visibleMonth: grid.month
                gridDateDelegate: gridDate
                choosenDateDelegate: choosenDate
                choosenDateSecondDelegate: choosenDateSecond
                beginPeriodDateDelegate: beginPeriodDate
                endPeriodDateDelegate: endPeriodDate
            }

            background: Item {
                x: grid.leftPadding
                y: grid.topPadding
                width: grid.availableWidth
                height: grid.availableHeight

                // Vertical lines
                Row {
                    spacing: (parent.width - (grid.gridLineThickness * rowRepeater.model)) / rowRepeater.model

                    Repeater {
                        id: rowRepeater
                        model: 7
                        delegate: Rectangle {
                            width: 1
                            height: grid.height
                            color: "#ccc"
                        }
                    }
                }

                // Horizontal lines
                Column {
                    spacing: (parent.height - (grid.gridLineThickness * columnRepeater.model)) / columnRepeater.model

                    Repeater {
                        id: columnRepeater
                        model: 6
                        delegate: Rectangle {
                            width: grid.width
                            height: 1
                            color: "#ccc"
                        }
                    }
                }
            }

            onClicked: function (date) {
                console.log("onClicked date: " + date.toLocaleDateString())

                if (date.getTime() > maxDate.getTime()) {
                    return
                }

                if (isPeriodAvailable) {
                    let clickedDateStr = date.toLocaleDateString()
                    let choosenDateStr = choosenDate.toLocaleDateString()
                    let choosenDateSecondStr = choosenDateSecond.toLocaleDateString()

                    if (clickedDateStr === choosenDateStr) {
                        choosenDateSecond = new Date("");
                    } else if (clickedDateStr === choosenDateSecondStr) {
                        choosenDate = new Date("")
                    } else if (isNaN(choosenDate)) {
                        choosenDate = date
                    } else if (isNaN(choosenDateSecond)) {
                        choosenDateSecond = date
                    } else {
                        // period already choosen
                        let isChoosenDateBegin = (choosenDate.getTime() < choosenDateSecond.getTime())
                        let beginDate = isChoosenDateBegin ? choosenDate : choosenDateSecond
                        let endDate = isChoosenDateBegin ? choosenDateSecond : choosenDate


                        if (date.getTime() < beginDate) {
                            if (isChoosenDateBegin) {
                                choosenDate = date
                            } else {
                                choosenDateSecond = date
                            }
                        } else if (date.getTime() > endDate) {
                            if (isChoosenDateBegin) {
                                choosenDateSecond = date
                            } else {
                                choosenDate = date
                            }
                        } else {
                            choosenDateSecond = date
                        }
                    }
                } else {
                    choosenDate = date
                    console.log("choosenDate: " + choosenDate)
                }
            }
        }
    }

    footer: ToolBar {
        visible: isResultLableEnabled

        RowLayout {
            anchors.fill: parent

            Rectangle {
                anchors.fill: parent
                color: "#5C7490"
            }

            Label {
                id: resultDateLabel
                Layout.fillWidth: true
                text: getResultDateStr()
                font.pixelSize: Qt.application.font.pixelSize * 1.25
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            color: "#ccc"
            width: 1
        }
    }
}
