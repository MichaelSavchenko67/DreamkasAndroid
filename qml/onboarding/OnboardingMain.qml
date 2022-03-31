import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents
import "qrc:/qml/onboarding/components" as OnboardingComponents
import "qrc:/qml/onboarding/subpages" as OnboardingPages

Button
{
    z:2
    property int onboardingPageIndex: 0 /// это реальный номер страницы прохождения обучения
    property int onboardingIndicatorValue: 0 /// а эта цифра используется для подстветки индикатора прогресса обучения
                                             /// фактически она меньше чем onboardingPageIndex
    id:onboardingMainButton
    enabled: true
    visible: root.isOnboardingModeEnabled
    anchors.fill:parent
    Connections {
        target: firstPage
        function onNextPage() { onboardingPageIndex++; onboardingIndicatorValue++}
    }

    background:
    Rectangle
    {
        anchors.fill:parent
        color: "transparent"
        OnboardingComponents.OnboardingProgressIndicator{id: progressIndicator; z:30;}
        OnboardingComponents.OnboardingButtonSkip{id:skipButton;z:30;}
        StackLayout
        {
           id:onboardinfHovers
           anchors.fill:parent
           currentIndex: onboardingPageIndex
           OnboardingPages.OnboardingPage_1{id:firstPage;}
        }

    }
}
