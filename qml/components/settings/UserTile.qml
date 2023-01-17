import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Button {
    id: userTile
    property string username: "Савченко Михаил Андреевич"
    property string role: "Администратор"
    property string avatar: "qrc:/ico/tiles/tileGoods11.png"
    property bool isNewUser: false

    signal createUser()
    signal userChoosen()

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: 8

        Column {
            anchors.fill: parent
            leftPadding: 0.06 * parent.width
            rightPadding: leftPadding
            topPadding: 1.2 * leftPadding
            bottomPadding: topPadding
            spacing: leftPadding

            Row {
                id: contentRow
                width: parent.width - parent.leftPadding - parent.rightPadding
                height: parent.height -
                        parent.topPadding -
                        parent.bottomPadding -
                        parent.spacing -
                        chooseButton.height
                spacing: parent.leftPadding
                leftPadding: (isNewUser ? 0.5 * (width - avatarImage.width) : 0)

                SettingsComponents.AvatarFrame {
                    id: avatarImage
                    height: parent.height
                    width: height

                    Image {
                        anchors.fill: parent
                        source: isNewUser ? "qrc:/ico/users/default_avatar.png" : avatar
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                Column {
                    width: parent.width -
                           avatarImage.width -
                           parent.spacing
                    height: avatarImage.height
                    visible: !isNewUser
                    spacing: height - usernameLabel.contentHeight - roleLabel.contentHeight

                    Label {
                        id: usernameLabel
                        width: parent.width
                        text: qsTr(username)
                        font {
                            pixelSize: 0.2 * avatarImage.height
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "black"
                        elide: Label.ElideRight
                        maximumLineCount: 2
                        wrapMode: Text.WordWrap
                        lineHeight: 1.2
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }

                    Label {
                        id: roleLabel
                        width: usernameLabel.width
                        text: qsTr(role)
                        font {
                            pixelSize: 0.833 * usernameLabel.font.pixelSize
                            family: usernameLabel.font.family
                            styleName: usernameLabel.font.styleName
                            weight: usernameLabel.font.weight
                        }
                        color: "#979797"
                        elide: usernameLabel.elide
                        horizontalAlignment: usernameLabel.horizontalAlignment
                        verticalAlignment: usernameLabel.verticalAlignment
                    }
                }
            }

            SaleComponents.Button_1 {
                id: chooseButton
                width: 0.875 * parent.width
                height: 0.2 * width
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr(isNewUser ? "НАЧАТЬ" : "ВЫБРАТЬ")
                fontSize: roleLabel.font.pixelSize
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    if (isNewUser) {
                        createUser()
                    } else {
                        userChoosen()
                    }
                }
            }
        }
    }

    DropShadow {
        visible: true
        anchors.fill: rect
        cached: true
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#d6d6d6"
        source: rect
    }
}
