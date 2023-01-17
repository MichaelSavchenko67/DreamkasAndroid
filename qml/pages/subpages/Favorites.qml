import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    property var pageTitle: "ПЛИТКИ"

    onFocusChanged: {
        if (focus) {
            console.log("[Favorites.qml]\tfocus changed: " + focus)
        }
    }

    Label {
        text: pageTitle
        anchors.centerIn: parent
        font {
            pixelSize: 48
            family: "Roboto"
            styleName: "normal"
            weight: Font.DemiBold
        }
    }
}
