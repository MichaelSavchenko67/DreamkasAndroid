import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Button {
    property var name: ""
    property var cost: ""
    property var measure: ""
    property var img: ""
    property bool checkMode: false
    property bool isChecked: false

    width: parent.width / 3
    height: width
    transformOrigin: Item.Center
    visible: !((state === "addTile") && checkMode)

    function setState() {
        if (name === "") {
            state = "addTile"
        } else if (img === "") {
            state = "tileWithoutImage"
        } else {
            state = "tileWithImage"
        }
    }

    states: [
        State {
            name: "addTile"
            PropertyChanges { target: tileSubstrate; visible: true }
            PropertyChanges { target: tileImg; visible: false }
            PropertyChanges { target: addTileColumn; visible: true }
            PropertyChanges { target: tileColumn; visible: false }
        },
        State {
            name: "tileWithoutImage"
            PropertyChanges { target: tileSubstrate; visible: true }
            PropertyChanges { target: tileImg; visible: false }
            PropertyChanges { target: addTileColumn; visible: false }
            PropertyChanges { target: tileColumn; visible: true }
            PropertyChanges { target: tileImgName; visible: true }
            PropertyChanges { target: goodsName; visible: false }
        },
        State {
            name: "tileWithImage"
            PropertyChanges { target: tileSubstrate; visible: false }
            PropertyChanges { target: tileImg; visible: true }
            PropertyChanges { target: addTileColumn; visible: false }
            PropertyChanges { target: tileColumn; visible: true }
            PropertyChanges { target: tileImgName; visible: false }
            PropertyChanges { target: goodsName; visible: true }
        }
    ]

    onNameChanged: {
        setState()
    }

    onImgChanged: {
        setState()
    }

    onCheckModeChanged: {
        checkColumn.visible = checkMode
    }

    onClicked: {
        isChecked = !isChecked
    }

    background: Rectangle {
        color: "#00FFFFFF"

        Rectangle {
            id: rect
            anchors.fill: parent
            radius: 16
            color: parent.color

            Rectangle {
                id: tile
                anchors.centerIn: parent
                width: 0.9 * parent.width
                height: width
                states: State {
                    name: "pushDown"; when: pressed
                    PropertyChanges {
                        target: tile;
                        width: 0.95 * rect.width
                    }
                }
                transitions: Transition {
                    to: "pushDown"
                    reversible: true

                    PropertyAnimation {
                        properties: "width"
                        easing.type: Easing.InOutQuad
                        duration: 100
                    }
                }
                color: parent.color
                radius: parent.radius
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: tile.width
                        height: tile.height
                        Rectangle {
                            anchors.centerIn: parent
                            width: tile.adapt ? tile.width : Math.min(tile.width, tile.height)
                            height: tile.adapt ? tile.height : width
                            radius: tile.radius
                        }
                    }
                }

                Image {
                    id: tileSubstrate
                    visible: false
                    anchors.fill: parent
                    source: "qrc:/ico/tiles/tileSubstrate.png"
                    fillMode: Image.PreserveAspectFit
                }

                Column {
                    id: addTileColumn
                    anchors.fill: parent

                    Column {
                        anchors.centerIn: parent
                        spacing: addTileMsg2user.font.pixelSize

                        Image {
                            width: 0.32 * tile.width
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "qrc:/ico/tiles/addTile.png"
                        }

                        Label {
                            id: addTileMsg2user
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("Добавить\nтовар")
                            font {
                                pixelSize: 1.2 * goodsName.font.pixelSize
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "#979797"
                            lineHeight: 1.2
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                        }
                    }
                }

                Column {
                    id: tileColumn
                    anchors.fill: parent

                    Image {
                        id: tileImg
                        anchors.fill: parent
                        source: img
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: tileImgName
                        visible: false
                        text: name
                        width: parent.width
                        font {
                            pixelSize: 1.35 * goodsName.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "black"
                        elide: goodsName.elide
                        maximumLineCount: 4
                        wrapMode: Label.WordWrap
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignTop
                        leftPadding: goodsName.font.pixelSize
                        topPadding: leftPadding
                    }

                    Rectangle {
                        id: infoFrame
                        width: parent.width
                        height: 0.37 * parent.width
                        anchors.bottom: parent.bottom
                        color: "#D8EEFF"
                        opacity: 0.9
                    }

                    Column {
                        height: 0.71 * infoFrame.height
                        anchors.verticalCenter: infoFrame.verticalCenter
                        spacing: 0.5 * (height - 2 * goodsName.height)
                        leftPadding: goodsName.font.pixelSize

                        Label {
                            id: goodsName
                            text: name
                            font {
                                pixelSize: 0.33 * parent.height
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "black"
                            elide: Label.ElideRight
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignTop
                        }

                        Label {
                            text: cost + " \u20BD/" + measure
                            font: goodsName.font
                            color: "black"
                            elide: goodsName.elide
                            horizontalAlignment: Qt.AlignLeft
                            verticalAlignment: Qt.AlignBottom
                            opacity: 0.5
                        }
                    }
                }
            }

            Column {
                id: checkColumn
                anchors.fill: tile
                visible: false

                Rectangle {
                    id: checkRect
                    anchors.fill: parent
                    color: "#C4C4C4"
                    radius: tile.radius
                    opacity: 0
                    states: State {
                        name: "enable"; when: checkMode
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
                        name: "enable"; when: checkMode
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
        }

        DropShadow {
            anchors.fill: rect
            horizontalOffset: 0
            verticalOffset: 2
            radius: 8
            color: "#D6D6D6"
            cached: true
            source: rect
        }
    }
}
