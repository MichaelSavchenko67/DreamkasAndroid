import QtQuick
import QtMultimedia
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "qrc:/qml/components/settings" as SettingsComponents

Popup {
    id: createAvatarPopup

    property var avatarImage
    signal avatarCaptured

    width: 0.9 * parent.width
    height: 0.75 * parent.height
    x: 0.5 * (parent.width - width)
    y: 0.25 * (parent.height - height)
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    background: Rectangle {
        anchors.fill: parent
        radius: 8
        color: "#FFFFFF"
    }
    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"

        ToolButton {
            id: exitButton
            anchors {
                top: parent.top
                topMargin: 0.5 *  0.038 * parent.height
                right: parent.right
                rightMargin: 0.5 *  0.038 * parent.height
            }
            icon {
                color: "#979797"
                height: 0.049 * parent.width
                source: "qrc:/ico/menu/close.png"
            }
            onClicked: {
                createAvatarPopup.close()
            }
        }

        Column {
            id: contentColumn
            width: parent.width
            anchors.centerIn: parent
            topPadding: exitButton.height
            spacing: 0.2 * avatar.height

            Label {
                id: nameFieldTitle
                width: parent.width
                text: "Создайте аватар"
                font {
                    pixelSize: 0.073 * parent.width
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                clip: true
                elide: "ElideRight"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            SettingsComponents.AvatarFrame {
                id: avatar
                width: 0.6 * parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                MediaDevices {
                    id: mediaDevices
                }

                CaptureSession {
                    id: captureSession
                    camera: Camera {
                        id: camera
                        cameraDevice: mediaDevices.defaultVideoInput
//                        position: Camera.FrontFace
                        focusMode: Camera.FocusModeAutoNear
                    }
                    imageCapture: ImageCapture {
                        id: imageCapture
                        onImageCaptured: {
                            // Show the preview in an Image
                            console.log("onImageCaptured")
                            photoPreview.source = preview
                        }
                    }
                    videoOutput: VideoOutput {
                        anchors.fill: parent
//                        autoOrientation: false
                        fillMode: VideoOutput.PreserveAspectCrop
//                        source: camera
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                leftPadding: capture.width + 0.5 * spacing
                spacing: 0.25 * capture.width

                Button {
                    id: capture
                    width: 0.2 * contentColumn.width
                    height: width
                    background: Rectangle {
                        anchors.fill: parent
                        radius: width
                        border.width: 3
                        border.color: capture.pressed ? "#717171" : "#979797"
                        color: "transparent"

                        Rectangle {
                            width: parent.width - 4 * parent.border.width
                            height: width
                            radius: width
                            anchors.centerIn: parent
                            color: capture.pressed ? "#717171" : "#979797"
                        }
                    }
                    onClicked: {
                        captureSession.imageCapture.capture()
                    }
                }

                Button {
                    id: changeCameraPosition
                    width: 0.12 * contentColumn.width
                    height: width
                    anchors.verticalCenter: capture.verticalCenter
                    background: Rectangle {
                        anchors.fill: parent
                        radius: width
                        border.width: 3
                        border.color: changeCameraPosition.pressed ? "#717171" : "#979797"
                        color: "transparent"

                        Image {
                            width: parent.width - 4 * parent.border.width
                            height: width
                            anchors.centerIn: parent
                            source: "qrc:/ico/settings/autorenew.png"
                            fillMode: Image.PreserveAspectFit

                            Colorize {
                                anchors.fill: parent
                                source: parent
                                hue: 0.0
                                saturation: 0.0
                                lightness: changeCameraPosition.pressed ? -0.25 : 0.0
                            }
                        }
                    }
                    onClicked: {
                        camera.position = ((camera.position == Camera.BackFace) ? Camera.FrontFace : Camera.BackFace)
                    }
                }
            }
        }

        Image {
            id: photoPreview
            visible: false
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            onSourceChanged: {
                console.log("Capture: " + source)
                avatarImage = photoPreview
                avatarCaptured()
                createAvatarPopup.close()
            }
        }
    }
}
