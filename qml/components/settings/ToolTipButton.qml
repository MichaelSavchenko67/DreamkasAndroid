import QtQuick
import QtQuick.Controls

Button {
    id: tidFieldHelpButton

    property bool isHelpVisible: false

    height: width
    anchors.verticalCenter: parent.verticalCenter
    background: Image {
        anchors.fill: parent
        source: parent.isHelpVisible ? "qrc:/ico/settings/help_active.png" : "qrc:/ico/settings/help.png"
        fillMode: Image.PreserveAspectFit
    }
    onClicked: {
        isHelpVisible = !isHelpVisible
    }
}
