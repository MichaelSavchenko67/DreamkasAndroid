import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts

import "qrc:/qml/components/sale" as SaleComponents

Page {
    anchors.fill: parent

    property var code: ""

    function enterDigit(digit) {
        if (code.length < 5) {
            console.log("[CabinetConnection.qml]\tenter digit: " + digit)
            code = code + digit
        }
    }

    function deleteDigit() {
        if (code.length > 0) {
            code = code.substring(0, code.length - 1)
        }
    }

    onCodeChanged: {
        if (code.length >= 5) {
            console.log("[CabinetConnection.qml]\tCode from user: " + code)
            root.openPage("qrc:/qml/pages/subpages/Connect2Cabinet.qml")
            isCabinetEnable = true
        }
    }

    contentData: Rectangle {
        id: frame
        anchors.fill: parent
        color: "white"

        Column {
            id: enterCodeField
            anchors.fill: parent
            spacing: 1.5 * enterCodeTitle.font.pixelSize
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 0.5 * spacing
            }

            Image {
                width: 0.6 * parent.width
                height: 0.3 * width
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/img/logo/cabinet_logo.png"
            }

            Text {
                id: enterCodeTitle
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Введите код")
                font {
                    pixelSize: 0.05 * parent.height
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Normal
                }
                color: "black"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Row {
                id: codeIndicators
                width: 5 * first.width + 4 * spacing
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 2 * first.width

                SaleComponents.LoginIndicator {
                    id: first
                    width: 0.03 * frame.width
                    enabled: (code.length >= 1)
                    digit: enabled ? code.charAt(0) : ""
                }
                SaleComponents.LoginIndicator {
                    id: second
                    width: first.width
                    enabled: (code.length >= 2)
                    digit: enabled ? code.charAt(1) : ""
                }
                SaleComponents.LoginIndicator {
                    id: third
                    width: first.width
                    enabled: (code.length >= 3)
                    digit: enabled ? code.charAt(2) : ""
                }
                SaleComponents.LoginIndicator {
                    id: fourth
                    width: first.width
                    enabled: (code.length >= 4)
                    digit: enabled ? code.charAt(3) : ""
                }
                SaleComponents.LoginIndicator {
                    id: fifth
                    width: first.width
                    enabled: (code.length === 5)
                    digit: enabled ? code.charAt(4) : ""
                }
            }

            Grid {
                id: grid
                width: 0.69 * frame.width
                height: 0.77 * width
                anchors.horizontalCenter: codeIndicators.horizontalCenter
                columns: 3
                spacing: 0

                SaleComponents.LoginButton { text: "1"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { text: "2"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { text: "3"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { text: "4"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { text: "5"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { text: "6"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { text: "7"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { text: "8"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { text: "9"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton { enabled: false }
                SaleComponents.LoginButton { text: "0"; onPressed: enterDigit(text)}
                SaleComponents.LoginButton {
                    enabled: (code.length > 0)
                    icon {
                        width: parent.width
                        height: parent.height
                        source: enabled ? "qrc:/ico/calculator/del_en.png" : "qrc:/ico/calculator/del_dis.png"
                        color: enabled ? "#5C7490" : "grey"
                    }
                    onClicked: {
                        deleteDigit()
                    }
                }
            }
        }
    }
}
