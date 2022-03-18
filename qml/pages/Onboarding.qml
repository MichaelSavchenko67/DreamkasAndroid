import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
Page
{
    Layout.fillHeight: true
    Layout.fillWidth: true
    onFocusChanged: {
        if (focus) {
            console.log("[Onboarding.qml]\tfocus changed: " + focus)
            setToolbarVisible(false)
            setToolbarShadow(false)
            setMainPageTitle("")
            setLeftMenuButtonAction(close)
            resetAddRightMenuButton()
            setRightMenuButtonVisible(false)
        }
    }
    Rectangle
    {
        id:bgFillForOnBoarding
        width: parent.width
        height: parent.height
        color: Qt.rgba(0.39,0.39,0.39,0.05)

    }
}
