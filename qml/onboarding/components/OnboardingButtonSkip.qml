import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Rectangle
{
    anchors.top: parent.top
    anchors.leftMargin: 0.15 * leftButton.width
    id: headerImitator
    width: toolBar.width
    height: toolBar.height
    color: "transparent"

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
