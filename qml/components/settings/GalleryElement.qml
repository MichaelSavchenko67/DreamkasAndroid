import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Column {
    id: galleryElement
    property string img: ""
    property bool isCheckMode: false
    property bool isChecked: false

    transformOrigin: Item.Center

    onIsCheckModeChanged: {
        checkColumn.visible = isCheckMode
    }

    visible: !((state === "add") && isCheckMode)

    states: [
        State {
            name: "add"
            PropertyChanges { target: galleryElementImage; visible: false }
            PropertyChanges { target: addGalleryElementColumn; visible: true }
        },
        State {
            name: "view"
            PropertyChanges { target: addGalleryElementColumn; visible: false }
            PropertyChanges { target: galleryElementImage; visible: true }
        }
    ]
    state: (img.length > 0) ? "view" : "add"

    Rectangle {
        id: rect
        anchors.fill: frame
        radius: frame.radius
    }

    DropShadow {
        anchors.fill: rect
        cached: true
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#d6d6d6"
        source: rect
    }

    Rectangle {
        id: frame
        width: 0.925 * parent.width
        height: 1.33 * width
        anchors.centerIn: parent
        radius: 16
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: frame.width
                height: frame.height

                Rectangle {
                    anchors.centerIn: parent
                    width: frame.adapt ? frame.width : Math.min(frame.width, frame.height)
                    height: frame.adapt ? frame.height : frame.height
                    radius: frame.radius
                }
            }
        }

        Column {
            id: addGalleryElementColumn
            anchors.fill: parent
            visible: false

            Column {
                anchors.centerIn: parent
                spacing: addTileMsg2user.font.pixelSize

                Image {
                    width: 0.32 * addGalleryElementColumn.width
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/ico/tiles/addTile.png"
                }

                Label {
                    id: addTileMsg2user
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Добавить\nслайд")
                    font {
                        pixelSize: 0.035 * root.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    lineHeight: 1.2
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }
            }
        }

        Image {
            anchors.fill: parent
            source: img
            fillMode: Image.PreserveAspectCrop
            opacity: 0.3
        }

        Image {
            id: galleryElementImage
            anchors.fill: parent
            visible: false
            source: img
            fillMode: Image.PreserveAspectFit
        }
    }

    Column {
        id: checkColumn
        anchors.fill: frame
        visible: false

        Rectangle {
            id: checkRect
            anchors.fill: parent
            color: "#C4C4C4"
            radius: 16
            opacity: 0
            states: State {
                name: "enable"; when: isCheckMode
                PropertyChanges {
                    target: checkRect
                    opacity: 0.4
                }
            }
            transitions: Transition {
                from: ""; to: "enable"
                reversible: true

                PropertyAnimation {
                    properties: "opacity"
                    easing.type: Easing.InOutQuad
                    duration: 500
                }
            }
        }

        Image {
            id: tileCheckIco
            width: 0.215 * parent.width
            height: width
            transformOrigin: Item.Center
            scale: 0
            anchors {
                right: parent.right
                rightMargin: width / 4
                top: parent.top
                topMargin: width / 4
            }
            source: isChecked ? "qrc:/ico/tiles/tileCheckOn" : "qrc:/ico/tiles/tileCheckOff"
            states: State {
                name: "enable"; when: isCheckMode
                PropertyChanges {
                    target: tileCheckIco
                    scale: 1.0
                }
            }
            transitions: Transition {
                from: ""; to: "enable"
                reversible: true

                PropertyAnimation {
                    properties: "scale"
                    easing.type: Easing.InOutQuad
                    duration: 500
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: ((galleryElement.state === "add") || isCheckMode)
        onPressedChanged: {
            galleryElement.scale = pressed ? 0.9 : 1
        }
        onClicked: {
            isChecked = !isChecked
        }
    }
}
