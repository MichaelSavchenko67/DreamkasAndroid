import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/content/calculator.js" as CalcEngine

Label {
    id: dynamicNumberLabel

    property real number: 0.000
    property int accuracy: 3
    property string ending: ""

    onNumberChanged: {
        setWeightRoutine.stop()
        setWeightRoutine.setStep(number)
        setWeightRoutine.start()
    }

    Timer {
        id: setWeightRoutine

        property real curNumber: 0.000
        property real defaultStep: 1 / Math.pow(10, accuracy)
        property real step: defaultStep

        function setStep(newWeight) {
           let newStep = (Math.abs(number - setWeightRoutine.curNumber) / 30).toFixed(accuracy)
           step = (newStep > 0) ? newStep : defaultStep
        }

        interval: 33
        repeat: true
        running: false
        onTriggered: {
            if (curNumber.toFixed(accuracy) == number.toFixed(accuracy)) {
                stop()
            } else {
                let rest = Math.abs(number - curNumber)

                if (step > rest) {
                    step = rest
                }

                curNumber += ((curNumber > number) ? -1 : 1) * step
            }
        }
    }

    text: CalcEngine.formatCommaResult(setWeightRoutine.curNumber.toFixed(accuracy).replace('.', ',')) + " " + ending
    font.pixelSize: 0.1 * parent.width
    horizontalAlignment: Label.AlignHCenter
    verticalAlignment: Label.AlignVCenter
}
