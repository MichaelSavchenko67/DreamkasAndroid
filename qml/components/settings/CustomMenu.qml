import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/settings" as SettingsComponents

Menu {
    id: menu
    transformOrigin: Menu.TopRight
    topPadding: 2 * menuItem.font.pixelSize
    bottomPadding: topPadding
    leftPadding: topPadding
    rightPadding: topPadding
    x: parent.width - (width + 0.02 * toolBar.width)
    delegate: SettingsComponents.CustomMenuItem { id: menuItem }
}
