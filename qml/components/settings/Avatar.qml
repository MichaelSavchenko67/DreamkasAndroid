import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12

import "qrc:/qml/components/settings" as SettingsComponents

SettingsComponents.AvatarFrame {
    id: avatar

    property var avatarSrc
    property var userNameFull

    width: logo.width

    function getUserNameShort(userNameFull) {
        let acronym = userNameFull.split(/\s/).reduce((response,word)=> response += (word.slice(0,1) + ' '),'')
        console.log(acronym);
        return acronym.toUpperCase()
    }

    Image {
        anchors.fill: parent
        visible: (avatarSrc.length > 0)
        fillMode: Image.PreserveAspectCrop
        source: avatarSrc
    }

    Rectangle {
        anchors.fill: parent
        visible: (avatarSrc.length === 0)
        color: "#979797"

        Label {
            width: parent.width
            anchors.centerIn: parent
            text: getUserNameShort(userNameFull)
            font {
                pixelSize: 0.3 * width
                family: "Roboto"
                styleName: "normal"
                weight: Font.DemiBold
                bold: true
            }
            color: "white"
            clip: true
            elide: "ElideRight"
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
        }
    }
}
