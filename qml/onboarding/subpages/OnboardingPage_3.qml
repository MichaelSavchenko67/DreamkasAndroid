import QtQuick 2.0

import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "qrc:/qml/pages/" as Pages
import "qrc:/qml/pages/subpages" as Subpages
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/settings" as SettingsComponents

Rectangle
{
    id:pageThree
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



