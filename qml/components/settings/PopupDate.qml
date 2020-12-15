import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents

Popup {
    id: popupDate

    property date curDate: new Date()
    property date choosenDate: curDate

    onOpened: {
        calendar.minimumDate = new Date(curDate.getFullYear(), curDate.getMonth() - 3, curDate.getDate())
        calendar.maximumDate = curDate
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
                width: 0.9 * parent.width
                height: width
                anchors.horizontalCenter: parent.horizontalCenter

                onSelectedDateChanged: {
                    choosenDate = selectedDate
                }
            }

            SaleComponents.Button_1 {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 0.7 * parent.width
                height: 0.2 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: choosenDate.toLocaleDateString(Qt.locale("ru_RU"))
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: "#0064B4"
                pushDownColor: "#004075"
                onClicked: {
                    popupDate.close()
                }
            }
        }
    }
}
