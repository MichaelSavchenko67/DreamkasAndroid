import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: tidFieldHelpButton

    property bool isHelpVisible: false

    width: 1.25 * tidField.font.pixelSize
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