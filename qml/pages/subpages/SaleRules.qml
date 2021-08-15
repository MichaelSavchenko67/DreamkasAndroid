import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: rootFrameSaleRules
    anchors.fill: parent

    onFocusChanged: {
        clearContextMenu()
        if (focus) {
            setMainPageTitle("Правила торговли")
            resetAddRightMenuButton()
            setLeftMenuButtonAction(openMenu)
            setRightMenuButtonVisible(false)
            setToolbarVisible(true)
        }
    }

    ListView {
        id: listItemsSaleRules
        anchors.fill: parent
//        spacing: 2 * fiscalCloud.spacing
//        clip: true
        model: modelSaleRules

        delegate: Row {
            id: fiscalCloud
            width: parent.width
//            height: listItemsSaleRules.height / 6
            spacing: labelName.font.pixelSize
            leftPadding: 1.5 * spacing
            topPadding: 1.5 * spacing

            Column {
                width: parent.width - 3 * parent.spacing - switchState.width

                Label {
                    id: labelName                    
                    text: textName_
                    font {
                        pixelSize: 0.0498 * fiscalCloud.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "black"
                    clip: true
                    elide: "ElideRight"
                }

                Label {
                    id: labelInfo
                    width: parent.width
                    text: textInfo_
                    font {
                        pixelSize: 0.8 * labelName.font.pixelSize
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    elide: Label.ElideRight
                    maximumLineCount: 10
                    wrapMode: Text.WordWrap
                }
            }

            Switch {
                id: switchState
                anchors.verticalCenter: parent.verticalCenter
                checked: state_

                onCheckedChanged: {
                    console.log("!!!!!!!!!!!! INDEX = " + listItemsSaleRules.currentIndex.valueOf() + ". 2 index = " + index)
                    modelSaleRules.setState(index, checked)
                }
            }
        }
    }
}
