import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Row {
    id: toolBar

    property string title: ""

    function setButton(name, ico, action) {
        var buttonId

        console.log("setButton name: " + name + " ico: " + ico + " action: " + action)

        if (name === "secondButton") {
            buttonId = secondButton
        } else if (name === "thirdButton") {
            buttonId = thirdButton
        }

        buttonId.icon.source = ico
        buttonId.action = action
        buttonId.enabled = (ico.length > 0)
    }

    width: parent.width
    leftPadding: 0.25 * (width - 0.896 * width)
    topPadding: 1.5 * 0.04375 * parent.width
    bottomPadding: topPadding
    spacing: 0.25 * backButton.width

    SettingsComponents.ToolButtonCustom {
        id: backButton
        height: 1.5 * titleLabel.font.pixelSize
        icon.source: "qrc:/ico/menu/back_blue.png"
        onClicked: {
            root.closePage()
        }
    }

    Label {
        id: titleLabel
        width: parent.width -
               backButton.width -
               secondButton.width -
               thirdButton.width -
               3 * parent.spacing -
               2 * parent.leftPadding
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr(title)
        font {
            pixelSize: 0.04375 * toolBar.width
            family: "Roboto"
            styleName: "normal"
            weight: Font.DemiBold
            bold: true
        }
        color: "black"
        elide: Label.ElideRight
        horizontalAlignment: Label.AlignLeft
        verticalAlignment: Label.AlignVCenter
    }

    SettingsComponents.ToolButtonCustom {
        id: thirdButton
        height: 1.5 * titleLabel.font.pixelSize
        enabled: false
    }

    SettingsComponents.ToolButtonCustom {
        id: secondButton
        height: 1.5 * titleLabel.font.pixelSize
        enabled: false
    }
}
