import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupDate

    property date curDate: new Date()
    property date minDate: new Date(curDate.getFullYear() - 1, curDate.getMonth(), curDate.getDate())
    property date choosenDate: curDate
    property date beginDate: undefined
    property date endDate: undefined
    property bool isIntervalEnable: false

    onOpened: {
        calendar.minimumDate = minDate
        calendar.maximumDate = curDate
    }

    function getConfirmButtonTxt() {
        if (isIntervalEnable) {
            console.log("beginDate: " + beginDate.toJSON())
            console.log("endDate: " + endDate.toJSON())
            return beginDate.toLocaleDateString('ru_RU') + " - " + endDate.toLocaleDateString('ru_RU')
        }
        return choosenDate.toLocaleDateString(Qt.locale("ru_RU"))
    }

    function reset() {
        curDate = new Date()
        minDate = new Date(curDate.getFullYear() - 1, curDate.getMonth(), curDate.getDate())
        choosenDate = curDate
        beginDate = undefined
        endDate = undefined
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

        Column {
            anchors.fill: parent
            topPadding: 2 * 0.038 * parent.height
            spacing: topPadding

            SaleComponents.EnterDate {
                id: calendar
                isIntervalEnable: popupDate.isIntervalEnable
                width: 0.9 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                onSelectedDateChanged: {
                    if (isIntervalEnable) {
                        beginDate = startDate
                        endDate = stopDate
                    } else {
                        choosenDate = selectedDate
                    }
                    confirmButton.buttonTxt = getConfirmButtonTxt()
                }
            }

            SaleComponents.Button_1 {
                id: confirmButton
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.2 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: getConfirmButtonTxt()
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
