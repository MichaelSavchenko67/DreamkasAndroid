import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents

Page
{
    implicitHeight: parent.height
    implicitWidth: parent.width
    anchors.fill: parent
    Rectangle
       {
            z:1
            id:bgFillForOnBoarding
            width: parent.width
            height: parent.height
            color: Qt.rgba(0.39,0.39,0.39,0.80)
            Label {
                id: infoLabel
                width: parent.width
                anchors
                {
                    top: parent.top
                    topMargin: 30
                }

                z:3
                text:  getOnboardingCurrentPageIndex()===3 ? qsTr("Добавьте товар камерой \n вашего \n смартфона") :
                       getOnboardingCurrentPageIndex()===4 ? qsTr("Поместите штрихкод \n в прямоугольник \n видоискателя") :
                                                             qsTr("введите названия \n товара \n")

                font {
                    pixelSize: 20
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                }
                color: "white"
                opacity: 1
                horizontalAlignment: Qt.AlignCenter
                verticalAlignment: Qt.AlignVCenter

            }

            SaleComponents.Button_1 {
                z:3
                width: 0.95 * parent.width
                height: 0.15 * width
                anchors {
                    top: infoLabel.bottom
                    bottomMargin: 5
                    horizontalCenter: parent.horizontalCenter
                }
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr("Далее")
                fontSize: 0.33 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked:
                {
                    incrementOnboardingProgressIndicator()
                    if(getOnboardingCurrentPageIndex()>5)
                    {
                         closePage()
                    }
                }
            }

       }
}
