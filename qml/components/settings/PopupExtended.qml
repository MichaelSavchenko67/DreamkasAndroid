import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/settings" as SettingsComponents

Rectangle {
    visible: parent.visible
    onVisibleChanged: {
        root.setKeypadToolBarMainBlocked(visible)
    }

    function reset() {
        keypadToolBar.reset()
    }

    function setFirstAction(action) {
        keypadToolBar.firstAction = action
    }

    function setSecondAction(action) {
        keypadToolBar.secondAction = action
    }

    SettingsComponents.KeypadToolBar {
        id: keypadToolBar
    }
}
