import QtQuick 2.15
import QtQuick.Controls 2.15

Label {
    id: weightLabel

    property real weight: 0.000

    onWeightChanged: {
        setWeightRoutine.stop()
        setWeightRoutine.setStep(weight)
        setWeightRoutine.start()
    }

    Timer {
        id: setWeightRoutine

        property real curWeight: 0.000
        property real step: 0.001

        function setStep(newWeight) {
           let newStep = (Math.abs(weight - setWeightRoutine.curWeight) / 30).toFixed(3)
           step = (newStep > 0) ? newStep : 0.001
        }

        interval: 33
        repeat: true
        running: false
        onTriggered: {
            if (curWeight.toFixed(3) == weight.toFixed(3)) {
                stop()
            } else {
                let rest = Math.abs(weight - curWeight)

                if (step > rest) {
                    step = rest
                }

                curWeight += ((curWeight > weight) ? -1 : 1) * step
            }
        }
    }

    text: setWeightRoutine.curWeight.toFixed(3)
    font.pixelSize: 0.1 * parent.width
    horizontalAlignment: Label.AlignHCenter
    verticalAlignment: Label.AlignVCenter
}
