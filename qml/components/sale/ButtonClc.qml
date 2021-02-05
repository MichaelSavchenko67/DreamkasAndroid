import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.12

Button {
    id: buttonClc

    property string txt
    property bool txtVisible: true
    property int btnX
    property int btnY
    property int btnW: 1
    property int btnH: 1
    property color colorDown: "#0064B4"
    property color colorUp: "#FFFFFF"
    property string ico
    property double icoRotation
    property real icoSize: 0.25 * buttonClc.width

    property bool operator: false

    Layout.minimumWidth: parent.width / 4

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.column: btnX
    Layout.row: btnY
    Layout.columnSpan: btnW
    Layout.rowSpan: btnH

    Text {
        id: textField
        text: txt
        anchors.centerIn: parent
        visible: txtVisible
        font {
            family: "Roboto"
            pixelSize: 0.355 * parent.height
            styleName: "normal"
            weight: Font.Bold
            bold: true
        }
    }

    flat: true

    background: Rectangle {
        anchors.fill: parent
        border.color: "#ECECEC"
        border.width: 1
        color: parent.down ? colorDown : colorUp
        opacity: parent.down ? 0.3 : 1

        Image {
            width: icoSize
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: ico
            rotation: icoRotation
        }
    }

    onClicked: {
        if (operator)
            calculatorPage.operatorPressed(textField.text)
        else
            calculatorPage.digitPressed(textField.text)
    }

    signal hold()

    Timer {
        id: holdTimer
        interval: 500
        repeat: false
        running: false

        onTriggered: {
            hold()
        }
    }

    onPressedChanged: {
        holdTimer.interval = 500
        holdTimer.running = pressed
    }

    onHold: {
        if (pressed) {
            clicked()
            holdTimer.interval = 100
            holdTimer.running = true
        }
    }
}
