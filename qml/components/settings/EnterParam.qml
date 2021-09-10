import QtQuick 2.12
import QtQuick.Controls 2.12

Column {
    id: enterParamData
    width: parent.width
    spacing: 0.25 * parent.spacing

    property var title: ""
    property var paramPlaceholder: ""
    property var paramValue: ""
    property var regExpValidator: ""
    property bool isAcceptable: enterParamValueField.acceptableInput

    signal entered(string value)

    Label {
        id: enterParamTitle
        width: parent.width
        text: qsTr(title)
        font {
            pixelSize: 0.67 * 4 * enterParamData.spacing
            family: "Roboto"
            styleName: "normal"
            weight: Font.Normal
        }
        color: "#979797"
        clip: true
        elide: "ElideRight"
        horizontalAlignment: Label.AlignLeft
        verticalAlignment: Label.AlignVCenter
    }

    Row {
        width: parent.width

        TextField {
            id: enterParamValueField
            width: parent.width
            text: paramValue
            focus: true
            placeholderText: (text.length === 0) ? qsTr(paramPlaceholder) : text
            placeholderTextColor: "#979797"
            validator: regExpValidator
            font {
                pixelSize: 4 * enterParamData.spacing
                family: "Roboto"
                styleName: "normal"
                weight: Font.Normal
            }
            color: "#0064B4"
            onTextChanged: {
                isAcceptable = enterParamValueField.acceptableInput
            }
            onAcceptableInputChanged: {
                if (acceptableInput) {
                    console.log("[UserPage.qml]\t\t " + title + " accepted: " + text)
                }
            }
            onEditingFinished: {
                console.log("[UserPage.qml]\t\t " + title + " onEditingFinished: " + text)
                paramValue = text
                entered(paramValue)
            }
        }
    }
}
