import QtQuick 2.12
import QtQuick.Controls 2.12

Column {
    width: parent.width
    spacing: 0

    property var boxModel
    property bool isEnabled
    property var choosenIndex
    signal choosen

    ComboBox {
        id: control
        width: parent.width
        enabled: isEnabled
        currentIndex: choosenIndex

        font: {
            pixelSize: 0.09 * width
            family: "Roboto"
            styleName: "medium"
            weight: Font.Medium
            bold: true
        }

        onCurrentIndexChanged: {
            choosenIndex = currentIndex
            choosen()
        }

        model: boxModel

        delegate: ItemDelegate {
            width: control.width
            contentItem: Text {
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                text: payType
                color: "black"
                font: control.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
        }

        indicator: Canvas {
            id: canvas
            x: control.width - width - control.rightPadding
            y: control.topPadding + (control.availableHeight - height) / 2
            width: 12
            height: 8
            contextType: "2d"
            visible: isEnabled

            Connections {
                target: control
                function onPressedChanged() { canvas.requestPaint(); }
            }

            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = "#0064B4";
                context.fill();
            }
        }

        contentItem: Text {
            leftPadding: 0
            rightPadding: control.indicator.width + control.spacing
            text: control.displayText
            font: control.font
            color: "#0064B4"
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 120
            implicitHeight: 40
            border.color: "#0064B4"
            border.width: 0
        }

        popup: Popup {
            y: control.height - 1
            width: control.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: control.popup.visible ? control.delegateModel : null
                currentIndex: control.currentIndex
                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }
    }

    Rectangle {
        width: parent.width
        height: 1
        color: "#0064B4"
    }
}

