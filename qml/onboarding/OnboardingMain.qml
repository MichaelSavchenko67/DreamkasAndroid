import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents
import "qrc:/qml/onboarding/components" as OnboardingComponents
import "qrc:/qml/onboarding/subpages" as OnboardingPages

Rectangle ///основной прямоугольник режима обучения, содержит кнопку выхода
          ///а также прогресс бар по прохождению обучения
{
    z:2
    property int onboardingPageIndex: 0 /// это номер страницы прохождения обучения
    id:onboardingMainRect
    enabled: true
    visible: root.isOnboardingModeEnabled
    color:"transparent"
    anchors.fill:parent
    Connections {
        target: firstPage
        function onNextPage() { root.incrimentOnboardingProgressBar()}
    }
    OnboardingComponents.OnboardingProgressIndicator{id: progressIndicator; z:30;}
    OnboardingComponents.OnboardingButtonSkip{id:skipButton;z:30;}
    Rectangle ///  тут содержится stackLayout который меняет подложку и настраивает mouse Area чтобы нельзя было нажимать на определенные элементы
    {
        anchors.fill:parent
        color: "transparent"
        StackLayout
        {
           id:onboardingHovers
           visible: true
           anchors.fill:parent
           currentIndex: onboardingPageIndex
           OnboardingPages.OnboardingPage_1{id:firstPage;} // открытие смены
           ///между первой и второй страницей будет операция открытия смены
           OnboardingPages.OnboardingPage_2{id:secondPage;} // ввод по свободной цене
           OnboardingPages.OnboardingPage_3{id:thirdPage;} //popup введите название товара(просто черный залоченный фон)
           OnboardingPages.OnboardingPage_4{id:fourthPage;} //popup введите количество товара (просто черный залоченный фон)
           OnboardingPages.OnboardingPage_5{id:fifthPage;} // вы можете добавить товары с плиток
        }

    }
}
