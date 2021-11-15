import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Button {
    id: button
    property var buttonTxt
    scale: pressed ? 1.05 : 1.0
    background: Rectangle {
        id: rect
        radius: 8
        border.width: 0
        gradient: Gradient {
            orientation: Gradient.Horizontal
            stops: [
                GradientStop {
                    position: 0.0
                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "#1AC825"; to: "#1AC8B3"; duration: 2000 }
                        ColorAnimation { from: "#1AC8B3"; to: "#1A6AC8"; duration: 2000 }
                        ColorAnimation { from: "#1A6AC8"; to: "#321AC8"; duration: 2000 }
                        ColorAnimation { from: "#321AC8"; to: "#901AC8"; duration: 2000 }
                        ColorAnimation { from: "#901AC8"; to: "#C81AAC"; duration: 2000 }
                        ColorAnimation { from: "#C81AAC"; to: "#C81A58"; duration: 2000 }
                        ColorAnimation { from: "#C81A58"; to: "#C8631A"; duration: 2000 }
                        ColorAnimation { from: "#C8631A"; to: "#C8B61A"; duration: 2000 }
                        ColorAnimation { from: "#C8B61A"; to: "#90C81A"; duration: 2000 }
                        ColorAnimation { from: "#90C81A"; to: "#1AC825"; duration: 2000 }
                    }
                },
                GradientStop {
                    position: 0.0977
                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "#34B596"; to: "#34B5AD"; duration: 2000 }
                        ColorAnimation { from: "#34B5AD"; to: "#34A5B5"; duration: 2000 }
                        ColorAnimation { from: "#34A5B5"; to: "#3467B5"; duration: 2000 }
                        ColorAnimation { from: "#3467B5"; to: "#5D34B5"; duration: 2000 }
                        ColorAnimation { from: "#5D34B5"; to: "#B234B5"; duration: 2000 }
                        ColorAnimation { from: "#B234B5"; to: "#B5345B"; duration: 2000 }
                        ColorAnimation { from: "#B5345B"; to: "#B57234"; duration: 2000 }
                        ColorAnimation { from: "#B57234"; to: "#AAB534"; duration: 2000 }
                        ColorAnimation { from: "#AAB534"; to: "#65B534"; duration: 2000 }
                        ColorAnimation { from: "#65B534"; to: "#34B596"; duration: 2000 }
                    }
                },
                GradientStop {
                    position: 1.0
                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "#08E3D6"; to: "#08C9E3"; duration: 2000 }
                        ColorAnimation { from: "#08C9E3"; to: "#0853E3"; duration: 2000 }
                        ColorAnimation { from: "#0853E3"; to: "#0D08E3"; duration: 2000 }
                        ColorAnimation { from: "#0D08E3"; to: "#B808E3"; duration: 2000 }
                        ColorAnimation { from: "#B808E3"; to: "#E3084A"; duration: 2000 }
                        ColorAnimation { from: "#E3084A"; to: "#E34A08"; duration: 2000 }
                        ColorAnimation { from: "#E34A08"; to: "#E3CE08"; duration: 2000 }
                        ColorAnimation { from: "#E3CE08"; to: "#08AFE3"; duration: 2000 }
                        ColorAnimation { from: "#08AFE3"; to: "#0860E3"; duration: 2000 }
                        ColorAnimation { from: "#0860E3"; to: "#08E3D6"; duration: 2000 }
                    }
                }
            ]
        }

        Text {
            id: txt
            text: buttonTxt
            anchors.fill: parent
            elide: Text.ElideRight
            maximumLineCount: 3
            wrapMode: Text.WordWrap
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            color: "white"
            font {
                pixelSize: 0.25 * height
                weight: Font.bold
                bold: true
            }
        }
    }
}
