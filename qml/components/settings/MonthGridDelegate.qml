import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material


ColumnLayout {
    id: columnLayout

    required property var model
    required property bool today
    required property int year
    required property int month
    required property int day

    required property int visibleMonth

    property date gridDateDelegate: new Date()
    property date choosenDateDelegate: new Date("")
    property date choosenDateSecondDelegate: new Date("")
    property date beginPeriodDateDelegate: new Date("")
    property date endPeriodDateDelegate: new Date("")
    property bool isChoosen: getIsChoosen()

    function getIsChoosen() {
        return  ((!isNaN(choosenDateDelegate) && (model.date.toLocaleDateString() === choosenDateDelegate.toLocaleDateString())) ||
                 (!isNaN(choosenDateSecondDelegate) && (model.date.toLocaleDateString() === choosenDateSecondDelegate.toLocaleDateString())) ||
                 ((model.date.getTime() > beginPeriodDateDelegate.getTime()) && (model.date.getTime() < endPeriodDateDelegate.getTime())))
    }

    function isChoosenDate() {
        return (!isNaN(choosenDateDelegate) && (model.date.toLocaleDateString() === choosenDateDelegate.toLocaleDateString()))
    }

    function isChoosenDateSecond() {
        return (!isNaN(choosenDateSecondDelegate) && (model.date.toLocaleDateString() === choosenDateSecondDelegate.toLocaleDateString()))
    }

    onGridDateDelegateChanged: {
        isChoosen = getIsChoosen()
    }

    onChoosenDateDelegateChanged: {
        console.log("onChoosenDateDelegateChanged: " + choosenDateDelegate.toLocaleDateString())
        isChoosen = getIsChoosen()
    }

    onChoosenDateSecondDelegateChanged: {
        console.log("onChoosenDateSecondDelegateChanged: " + choosenDateSecondDelegate.toLocaleDateString())
        isChoosen = getIsChoosen()
    }

    Rectangle {
        anchors.fill: parent
        color: isChoosen ? "#415A77" : "transparent"
        anchors.centerIn: dayText
        anchors.verticalCenterOffset: dayText.height - dayText.baselineOffset
        z: -1
        opacity: (isChoosen && !isChoosenDate() && !isChoosenDateSecond()) ? 0.7 : 1.0
        border.width: (isChoosenDate() || isChoosenDateSecond()) ? 1 : 0
        border.color: "grey"
    }

    Label {
        id: dayText
        anchors.fill: parent
        opacity: ((month === columnLayout.visibleMonth) || isChoosen) ? 1 : 0.3
        text: model.day
        font {
            pixelSize: 0.05 * root.width
            weight: (isChoosen && (isChoosenDate() || isChoosenDateSecond())) ? Font.DemiBold : Font.Normal
        }
        color: (isChoosenDate() || isChoosenDateSecond()) ? "white" : "black"
        elide: Label.ElideRight
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }
}
