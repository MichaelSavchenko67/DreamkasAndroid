import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/pages/" as Pages
import "qrc:/qml/pages/subpages" as Subpages
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Button
{
    z:2
    property int onboardingPageIndex: 0
    id:onboardingMainButton
    enabled: true
    visible: root.isOnboardingModeEnabled
    anchors.fill:parent
    background: Rectangle
    {

        anchors.fill:parent
        color: "#272727"
        opacity:0.8
        Rectangle
        {
            anchors.top: parent.top
            anchors.leftMargin: 0.15 * leftButton.width
            id: headerImitator
            width: toolBar.width
            height: toolBar.height
            color: "transparent"
            z: 3

        SettingsComponents.ToolButtonCustom { /// кнопка пропустить обучение

          id: skipOnboardingBtn
          width: leftButton.width
          height: leftButton.height
          x: leftButton.x
          y: leftButton.y
          visible: onboardingPageIndex===0
          action: skipOnboarding
          icon.source: "qrc:/ico/menu/close.png"
          }
        }
        Rectangle /// индикатор прогресса(плитки)
        {
            id: onboardingProgressIndicatorRect
            width:parent.width
            x: parent.x
            y: parent.y
            z:3
            Row
            {
                id: onboardingRow
                width: parent.width
                height: 2
                spacing: 2
                visible: true
                leftPadding: 20
                rightPadding: 20
                topPadding: 5

                Repeater
                {
                    id: onboardingProgressIndicator
                    z:3
                    model:7
                    visible: true
                    anchors.fill: parent

                    delegate:Rectangle
                    {
                        height: 2
                        width: (onboardingRow.width - onboardingRow.leftPadding - onboardingRow.rightPadding -
                                (onboardingRow.spacing * (onboardingProgressIndicator.count - 1)))
                               / onboardingProgressIndicator.count
                        color: "#FFFFFF"
                        visible: true
                        opacity: onboardingPageIndex >= index ? 1  : 0.5
                    }

                }
            }
        }
    }
}
