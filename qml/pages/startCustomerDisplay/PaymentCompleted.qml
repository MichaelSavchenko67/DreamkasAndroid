import QtQuick
import QtQuick.Controls

Page {
    width: parent.width
    height: parent.height

    onFocusChanged: {
        if (focus) {
            root.setMenuEnabled(false)
        }
    }

    states: [
        State {
            name: "success"
            PropertyChanges { target: feedbackRow; visible: false }
            PropertyChanges { target: paymentCompletedTitleLabel; text: qsTr("Покупка оплачена") }
            PropertyChanges { target: paymentCompletedDescriptionLabel; text: " \n " }
            PropertyChanges { target: paymentCompletedImage; source: "qrc:/ico/sale/check_in_success.png" }
            PropertyChanges { target: paymentCompletedImage; visible: true }
        },
        State {
            name: "failed"
            PropertyChanges { target: feedbackRow; visible: false }
            PropertyChanges { target: paymentCompletedTitleLabel; text: qsTr("Ошибка при оплате") }
            PropertyChanges { target: paymentCompletedDescriptionLabel; text: qsTr("Недостаточно средств\n ") }
            PropertyChanges { target: paymentCompletedDescriptionLabel; visible: true }
            PropertyChanges { target: paymentCompletedImage; source: "qrc:/ico/sale/failed.png" }
            PropertyChanges { target: paymentCompletedImage; visible: true }
        },
        State {
            name: "feedback"
            PropertyChanges { target: paymentCompletedTitleLabel; text: qsTr("Спасибо\nза покупку") }
            PropertyChanges { target: paymentCompletedDescriptionLabel; text: qsTr("Пожалуйста, оцените обслуживание") }
            PropertyChanges { target: paymentCompletedDescriptionLabel; visible: true }
            PropertyChanges { target: paymentCompletedImage; visible: false }
            PropertyChanges { target: feedbackRow; visible: true }
        }
    ]
    state: "success"
    contentData: Column {
        width: parent.width
        anchors.horizontalCenter: parent
        spacing: paymentCompletedTitleLabel.font.pixelSize
        topPadding: 2.5 * spacing

        Column {
            width: parent.width
            spacing: paymentCompletedDescriptionLabel.font.pixelSize

            Label {
                id: paymentCompletedTitleLabel
                width: 0.8 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    pixelSize: 0.083 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.DemiBold
                    bold: true
                }
                color: "#415A77"
                elide: Label.ElideRight
                lineHeight: 1.3
                maximumLineCount: 3
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Label {
                id: paymentCompletedDescriptionLabel
                width: 0.8 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    pixelSize: 0.05 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                opacity: 0.6
                lineHeight: 1.4
                elide: Label.ElideRight
                maximumLineCount: 5
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }
        }

        Image {
            id: paymentCompletedImage
            width: 0.3125 * parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            fillMode: Image.PreserveAspectFit
        }

        Row {
            id: feedbackRow
            visible: false
            width: parent.width
            leftPadding: (width - 2 * feedbackGoodColumn.width) / 3
            spacing: leftPadding

            Column {
                id: feedbackGoodColumn
                width: paymentCompletedImage.width
                spacing: feedbackGoodLabel.font.pixelSize

                Button {
                    width: parent.width
                    height: width
                    background: Image {
                        id: feedbackGoodImage
                        width: parent.width
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/ico/sale/feedback_good.png"
                        scale: parent.pressed ? 0.9 : 1
                    }
                }

                Label {
                    id: feedbackGoodLabel
                    width:  parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Всё хорошо")
                    font {
                        pixelSize: 0.5 * paymentCompletedTitleLabel.font.pixelSize
                        family: paymentCompletedTitleLabel.font.family
                        styleName: paymentCompletedTitleLabel.font.styleName
                        weight: Font.Normal
                    }
                    color: "black"
                    opacity: 0.6
                    elide: Label.ElideRight
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }
            }

            Column {
                width: paymentCompletedImage.width
                spacing: feedbackGoodLabel.font.pixelSize

                Button {
                    width: parent.width
                    height: width
                    background: Image {
                        width: parent.width
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/ico/sale/feedback_not_good.png"
                        scale: parent.pressed ? 0.9 : 1
                    }
                }

                Label {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Плохо")
                    font: feedbackGoodLabel.font
                    color: feedbackGoodLabel.color
                    opacity: feedbackGoodLabel.opacity
                    elide: feedbackGoodLabel.elide
                    horizontalAlignment: feedbackGoodLabel.horizontalAlignment
                    verticalAlignment: feedbackGoodLabel.verticalAlignment
                }
            }
        }
    }
}
