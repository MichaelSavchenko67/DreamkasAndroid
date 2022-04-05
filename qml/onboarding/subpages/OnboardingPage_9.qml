import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/components/sale" as SaleComponents
Rectangle
{
    id:pageNine

    Label
    {
      z:4
      id: userInfoText
      anchors.top: parent.top
      anchors.topMargin: parent.height * 0.4
      width:parent.width
      text: qsTr("Поместите штрихкод в прямоугольник\nвидоискателя")
      color: "white"
      horizontalAlignment: Label.AlignHCenter
      font
          {
          pixelSize: 15
          family: "Roboto"
          styleName: "medium"
          weight: Font.Bold
          bold: true
         }

    }
    SaleComponents.Button_1 {
        z:3
        width: 0.95 * parent.width
        height: 0.15 * width
        anchors {
            top: userInfoText.bottom
            topMargin: 5
            horizontalCenter: parent.horizontalCenter
        }
        borderWidth: 0
        backRadius: 5
        buttonTxt: qsTr("ДАЛЕЕ")
        fontSize: 0.33 * height
        buttonTxtColor: "white"
        pushUpColor: "#415A77"
        pushDownColor: "#004075"
        onClicked:
        {
             root.incrimentOnboardingProgressBar()
        }
    }
    MouseArea
    {
        z:2
        id:mArea
        anchors.fill: parent
    }

    z:2
    color:Qt.rgba(0.15,0.15,0.15,0.8)
    anchors.fill: parent
}
