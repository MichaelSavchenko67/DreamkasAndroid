import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupDate

    property date curDate: new Date()
    property date minDate: new Date(curDate.getFullYear() - 1, curDate.getMonth(), curDate.getDate())
    property date choosenDate: curDate
    property date beginDate: new Date()
    property date endDate: new Date("")
    property bool isIntervalEnable: true

    onOpened: {
        calendar.choosenDate = isIntervalEnable ? beginDate : choosenDate

        if (isIntervalEnable) {
            calendar.choosenDateSecond = endDate
        }
    }

    function update() {
        if (isIntervalEnable) {
            beginDate = calendar.beginPeriodDate
            endDate = calendar.endPeriodDate
        } else {
            choosenDate = calendar.choosenDate
        }

        confirmButton.buttonTxt = calendar.getResultDateStr()
    }

    function reset() {
        curDate = new Date()
        minDate = new Date(curDate.getFullYear() - 1, curDate.getMonth(), curDate.getDate())
        choosenDate = curDate
        beginDate = new Date("")
        endDate = new Date("")
    }

    width: 0.963 * parent.width
    height: 1.386 * width
    x: 0.5 * (parent.width - width)
    y: 0.5 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle {
        id: popupFrame
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"

        Column {
            anchors.fill: parent
            spacing: (height -
                      calendar.height -
                      confirmButton.height) / 3
            topPadding: spacing
            bottomPadding: spacing

            SaleComponents.EnterDate {
                id: calendar
                width: 0.9 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                isPeriodAvailable: popupDate.isIntervalEnable
                isResultLableEnabled: false
                choosenDate: isIntervalEnable ? popupDate.beginDate : popupDate.choosenDate
                choosenDateSecond: popupDate.endDate

                onChoosenDateChanged: {
                    popupDate.update()
                }
                onChoosenDateSecondChanged: {
                    popupDate.update()
                }
            }

            SaleComponents.Button_1 {
                id: confirmButton
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.2 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: calendar.getResultDateStr()
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    popupDate.close()
                }
            }
        }
    }
}
