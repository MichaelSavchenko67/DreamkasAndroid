import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import "qrc:/qml/components/sale" as SaleComponents

Page {
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            root.setMenuEnabled(true)
        }
    }

    states: [
        State {
            name: "preview"
            PropertyChanges { target: welcomeColumn; visible: false }
            PropertyChanges { target: galleryElementFrameImage; visible: true }
            PropertyChanges { target: galleryElementImage; visible: true }
            PropertyChanges { target: changeImgTimer; running: true }
            PropertyChanges { target: previewButton; visible: true }
        },
        State {
            name: "view"
            PropertyChanges { target: welcomeColumn; visible: false }
            PropertyChanges { target: previewButton; visible: false }
            PropertyChanges { target: galleryElementFrameImage; visible: true }
            PropertyChanges { target: galleryElementImage; visible: true }
            PropertyChanges { target: changeImgTimer; running: true }
        },
        State {
            name: "welcome"
            PropertyChanges { target: previewButton; visible: false }
            PropertyChanges { target: galleryElementFrameImage; visible: false }
            PropertyChanges { target: galleryElementImage; visible: false }
            PropertyChanges { target: changeImgTimer; running: false }
            PropertyChanges { target: welcomeColumn; visible: true }
        }
    ]
    state: "welcome"
    property string imgSrc: "qrc:/img/gallery/gallery_" + (changeImgTimer.cnt++) + ".png"

    Timer {
        id: changeImgTimer
        property int cnt: 1

        interval: 2500
        repeat: true
        running: true
        onTriggered: {
            if (cnt > 4) {
                cnt = 1
            }

            imgSrc = "qrc:/img/gallery/gallery_" + (cnt++) + ".png"
            console.log("THIS: " + imgSrc)
        }
    }

    contentData: Rectangle {
        id: frame
        anchors.fill: parent
        radius: 16
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: frame.width
                height: frame.height

                Rectangle {
                    anchors.centerIn: parent
                    width: frame.adapt ? frame.width : Math.min(frame.width, frame.height)
                    height: frame.adapt ? frame.height : frame.height
                    radius: frame.radius
                }
            }
        }

        Image {
            id: galleryElementFrameImage
            anchors.fill: parent
            visible: false
            fillMode: Image.PreserveAspectCrop
            opacity: 0.3
            source: imgSrc
        }

        Image {
            id: galleryElementImage
            anchors.fill: parent
            visible: false
            fillMode: Image.PreserveAspectFit
            source: imgSrc
        }

        SaleComponents.ButtonIcoH {
            id: previewButton
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 0.039 * parent.width
            }
            visible: false
            width: 0.6 * 0.896 * parent.width
            height: 0.112 * 0.896 * parent.width
            buttonTxt: "ЗАКРЫТЬ ПРЕДПРОСМОТР"
            iconPath: "qrc:/ico/menu/close.png"
            iconHeight: fontSize
            borderWidth: 0
            backRadius: 8
            fontSize: 0.028 * parent.width
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            onClicked: {
                changeImgTimer.stop()
                root.closePage()
            }
        }

        Column {
            id: welcomeColumn
            anchors.fill: parent
            visible: false
            spacing: 1.5625 * welcomeLabel.font.pixelSize
            topPadding: 1.3 * spacing

            Label {
                id: welcomeLabel
                width: parent.width
                text: qsTr("Добро\nпожаловать!")
                font {
                    pixelSize: 0.083 * parent.width
                    family: "Roboto"
                    styleName: "bold"
                    weight: Font.Bold
                    bold: true
                }
                color: "#415A77"
                clip: true
                elide: Label.ElideRight
                maximumLineCount: 2
                wrapMode: Label.WordWrap
                lineHeight: 1.3
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Image {
                id: welcomeImage
                width: 0.441 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:/img/sale/cashier_woman.png"
            }
        }
    }
}
