import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/pages/subpages" as Subpages
import "qrc:/qml/onBoarding" as Onboarding

Page {
    id: enterCostPage
    Layout.fillHeight: true
    Layout.fillWidth: true

    property bool isOpenShiftBannerEnable: !isShiftOpened

    Subpages.Connect2printerBanner {id: connect2printerBanner; visible: !root.isPrinterConnected}
    Subpages.OpenShiftBanner {id: openShiftBanner; visible: (!isOnBoardingMode() && root.isPrinterConnected && isOpenShiftBannerEnable)}
    Onboarding.OpenShiftBannerOnboarding{id: openShiftBannerOnboarding; visible: (isOnBoardingMode() && isOpenShiftBannerEnable)}
    Subpages.EnterCostChoose {visible: (root.isPrinterConnected && !isOpenShiftBannerEnable)}
}
