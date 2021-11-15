import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ProgressBar {
    width: parent.width
    height: 12
    indeterminate: true
    Material.accent: "white"
    background: Rectangle {
        color: "#5C7490"
        implicitWidth: parent.width
        implicitHeight: parent.height
    }
}
