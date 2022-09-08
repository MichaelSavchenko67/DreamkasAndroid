import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import "qrc:/qml/pages" as Pages
import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/pages/subpages/loading_pages" as LoadingPages

Page {
    id: loadingPage
    anchors.fill: parent
    property bool isLoadingFinished: true

    Timer {
        interval: 7500
        repeat: false
        running: true
        onTriggered: {
            isLoadingFinished = true
        }
    }

    Image {
        id: dreamkasLogo
        width: 0.463 * parent.width
        anchors {
            top: parent.top
            topMargin: 0.2 * width
            horizontalCenter: parent.horizontalCenter
        }
        source: "qrc:/ico/menu/logo.png"
        fillMode: Image.PreserveAspectFit
    }

    LoadingPages.PhoneMarket {
        id: phoneMarket
        width: parent.width
        height: parent.height -
                dreamkasLogo.height -
                0.4 * dreamkasLogo.width
        anchors.verticalCenter: parent.verticalCenter
        onComplited: {
            phoneMarketGoOut.start()
        }

        NumberAnimation on x {
            alwaysRunToEnd: true
            from: -root.width
            to: 0
            duration: 1500
            easing {
                type: Easing.OutBounce
                amplitude: 2.50
            }
            onFinished: {
                phoneMarket.isRunning = true
            }
        }

        NumberAnimation on x {
            id: phoneMarketGoOut
            running: false
            alwaysRunToEnd: true
            from: 0
            to: parent.width
            duration: 750
            easing.type: Easing.Linear
            onStarted: {
                console.log("phoneMarketGoOut onStarted")
                if (!isLoadingFinished) {
                    courierGoIn.start()
                } else {
                    loaderColumnGoOut.start()
                    loginPageGoIn.start()
                }
            }
            onFinished: {
                phoneMarket.visible = false
            }
        }
    }

    LoadingPages.Courier {
        id: courier
        width: parent.width
        height: phoneMarket.height
        anchors.verticalCenter: parent.verticalCenter
        visible: false
        onComplited: {
            if (isLoadingFinished) {
                courierGoOut.start()
                courier.isRunning = false
                loaderColumnGoOut.start()
            }
        }

        NumberAnimation on x {
            id: courierGoIn
            running: false
            alwaysRunToEnd: true
            from: -parent.width
            to: 0
            duration: 1000
            easing.type: Easing.Linear
            onStarted: {
                console.log("courierGoIn onStarted")
                courier.visible = true
            }
            onFinished: {
                courier.isRunning = true
            }
        }

        NumberAnimation on x {
            id: courierGoOut
            running: false
            alwaysRunToEnd: true
            from: 0
            to: parent.width
            duration: 750
            easing.type: Easing.Linear
            onStarted: {
                console.log("courierGoOut onStarted")
                loaderColumnGoOut.start()
                loginPageGoIn.start()
            }
            onFinished: {
                courier.visible = false
            }
        }
    }

    Pages.Login {
        id: loginPage
        width: parent.width
        height: parent.height -
                dreamkasLogo.height -
                0.4 * dreamkasLogo.width
        visible: false
        isLogo: false
        x: -parent.width

        NumberAnimation on x {
            id: loginPageGoIn
            running: false
            alwaysRunToEnd: true
            from: -parent.width
            to: 0
            duration: 750
            easing.type: Easing.Linear
            onStarted: {
                console.log("loginPageGoIn onStarted")
                loginPage.visible = true
            }
            onFinished: {
                loginPage.forceActiveFocus()
            }
        }
    }

    Column {
        id: loaderColumn
        width: 0.5 * parent.width
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: spacing
        }
        spacing: 0.2 * loader.height

        Timer {
            id: addLoadMsg
            interval: 1000
            running: loader.running
            repeat: true
            property int i: 1
            onTriggered: {
                if (!isLoadingFinished) {
                    loaderMsg.add2Queue((i++) + "\nЗагрузка Загрузка Загрузка \nЗагрузка Загрузка Загрузка")
                }
            }
        }

        BusyIndicator {
            id: loader
            implicitWidth: 0.1 * loadingPage.width
            implicitHeight: implicitWidth
            anchors.horizontalCenter: parent.horizontalCenter
            running: true
            visible: running
            Material.accent: "#5C7490"
        }

        SaleComponents.AnimatedText {
            id: loaderMsg
            width: parent.width
            height: 1.2 * loader.height
            font.pixelSize: 0.3 * loader.height
            anchors.horizontalCenter: parent.horizontalCenter
        }

        OpacityAnimator {
            id: loaderColumnGoOut
            target: loaderColumn
            running: false
            duration: 350
            from: 1.0
            to: 0.0
            onFinished: {
                loaderColumn.visible = false
            }
        }
    }
}
