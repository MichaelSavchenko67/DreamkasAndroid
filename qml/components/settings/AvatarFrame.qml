import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
    id: frame

    height: width
    radius: width
    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Item {
            width: frame.width
            height: frame.height
            Rectangle {
                anchors.centerIn: parent
                width: frame.adapt ? frame.width : Math.min(frame.width, frame.height)
                height: frame.adapt ? frame.height : width
                radius: frame.radius
            }
        }
    }
}
