import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {
    Layout.fillHeight: true
    Layout.fillWidth: true

    onFocusChanged: {
        if (focus) {
            console.log("[Favorites.qml]\tfocus changed: " + focus)
        }
    }

    Label {
        text: "ИЗБРАННОЕ"
        anchors.centerIn: parent
        font {
            pixelSize: 48
            family: "Roboto"
            styleName: "normal"
            weight: Font.DemiBold
        }
    }
}
