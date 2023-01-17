import QtQuick

Text {
    id: animatedMsg

    property var nextMsg: ""

    ListModel { id: msgList }

    function add2Queue(msg) {
        msgList.append({"msg": msg})
        execQueue()
    }

    property bool locked: false

    function execQueue() {
        if (!locked && !changeMsgAnimation.running && (msgList.count > 0)) {
            locked = true
            nextMsg = msgList.get(0).msg
            msgList.remove(0)
            changeMsgAnimation.running = true
        }
    }

    function isQueueEmpty() {
        return (msgList.count === 0)
    }

    font {
        pixelSize: 0.15 * height
        family: "Roboto"
        styleName: "normal"
        weight: Font.Normal
    }
    clip: true
    color: "black"
    elide: Text.ElideRight
    wrapMode: Text.WordWrap
    maximumLineCount: 3
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    SequentialAnimation {
        id: changeMsgAnimation
        PropertyAnimation { target: animatedMsg; property: "color"; to: "#5C7490"; duration: ((animatedMsg.text.length > 0) ? 330 :  0) }
        NumberAnimation { target: animatedMsg; property: "opacity"; to: 0; duration: ((animatedMsg.text.length > 0) ? 330 :  0) }
        PropertyAnimation { target: animatedMsg; property: "text"; to: nextMsg }
        PropertyAnimation { target: animatedMsg; property: "color"; to: "black" }
        NumberAnimation { target: animatedMsg; property: "opacity"; to: 1; duration: 330 }

        onRunningChanged: {
            running = running && (animatedMsg.text !== nextMsg)
        }

        onFinished: {
            locked = false
            execQueue()
        }
    }
}
