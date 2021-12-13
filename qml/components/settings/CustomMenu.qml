import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/qml/components/settings" as SettingsComponents

Menu {
    id: menu
    transformOrigin: Menu.TopRight
    topPadding: 2 * menuItem.font.pixelSize
    bottomPadding: topPadding
    leftPadding: topPadding
    rightPadding: topPadding
    delegate: SettingsComponents.CustomMenuItem { id: menuItem }
}
