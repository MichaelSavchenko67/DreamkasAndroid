import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Rectangle /// индикатор прогресса(плитки)
{
    id: onboardingProgressIndicatorRect
    width:parent.width
    color: "transparent"
    x: parent.x
    y: parent.y
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
            model:15
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
