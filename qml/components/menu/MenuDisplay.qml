import QtQuick
import QtQuick.Controls

import MenuRolesEnum 1.0

Drawer {
    id: menuDisplay

    property var actions : {
        "Настройки": function() { root.openPage("qrc:/qml/pages/startCustomerDisplay/MainSettings.qml") },
        "Галерея": function() { root.openPage("qrc:/qml/pages/startCustomerDisplay/Gallery.qml") },
        "Терминал 2can NFC": function() {
            menuDisplayModel.setItemApplied(MenuRoles.MENU_ID_2CAN, true)
            root.openPage("qrc:/qml/pages/startCustomerDisplay/Pinpad2canSettings.qml") },
        "Ещё": function() {  }
    }

    width: parent.width
    height: menuItemColumn.height
    edge: Qt.BottomEdge
    dragMargin: 0.018 * width
    contentData: Column {
        id: menuItemColumn
        width: parent.width
        topPadding: 0.5 * menuHeaderColumn.height
        spacing: topPadding

        Column {
            id: menuHeaderColumn
            width: 0.151 * root.width
            height: topPadding +
                    closeMenuButton.height
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: menuDisplay.dragMargin

            Button {
                id: closeMenuButton
                width: 0.5 * root.width
                height: menuSwipeIco.height
                anchors.centerIn: parent
                background: Row {
                    anchors.fill: parent
                    spacing: menuSwipeIco.width
                    leftPadding: 0.5 * (width - menuSwipeIco.width - spacing - menuTitleLabel.contentWidth)

                    Image {
                        id: menuSwipeIco
                        width: 0.02 * root.width
                        height: 1.12 * width
                        source: "qrc:/ico/menu/menu_swipe.png"
                        fillMode: Image.PreserveaspectFit
                        rotation: 180
                        scale: closeMenuButton.pressed ? 0.8 : 1.0
                    }

                    Label {
                        id: menuTitleLabel
                        text: qsTr("Нажмите, чтобы скрыть меню")
                        anchors.verticalCenter: parent.verticalCenter
                        font {
                            pixelSize: 0.028 * root.width
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#0064B4"
                        elide: Label.ElideRight
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                }
                onPressed: {
                    menuDisplay.close()
                }
            }
        }

        GridView {
            id: gridView
            width: parent.width
            height: Math.ceil(count / 3) * cellHeight
            cellWidth: width / 3
            cellHeight: 0.5 * cellWidth
            model: menuDisplayModel
            delegate: Column {
                width: gridView.cellWidth
                height: gridView.cellHeight

                Button {
                    id: itemMenuActionButton
                    width: 0.7 * gridView.cellWidth
                    height: gridView.cellHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    background: Column {
                        id: itemMenuActionButtonBackground
                        width: parent.width
                        height: parent.height
                        spacing: 0.5 * itemName.font.pixelSize

                        Rectangle {
                            id: itemIco
                            height: imageIco.height
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "transparent"

                            Image {
                                id: imageIco
                                width: 0.052 * menuDisplay.width
                                height: width
                                source: icoSrc
                                fillMode: Image.PreserveAspectFit
                                scale: itemMenuActionButton.pressed ? 0.8 : 1
                            }

                            Rectangle {
                                id: appliedIco
                                width: 0.5 * imageIco.width
                                height: width
                                visible: isCanApply
                                radius: width / 2
                                anchors {
                                    right: imageIco.right
                                    rightMargin: -width
                                    bottom: imageIco.bottom
                                    bottomMargin: -0.5 * height
                                }
                                color: isApplied ? "#4DA03F" : "#F7AA13"
                            }
                        }

                        Label {
                            id: itemName
                            text: qsTr(name)
                            width: parent.width
                            font {
                                pixelSize: 0.0311 * menuDisplay.width
                                family: "Roboto"
                                styleName: "normal"
                                weight: Font.Normal
                            }
                            color: "black"
                            lineHeight: 1.1
                            elide: Label.ElideRight
                            maximumLineCount: 2
                            wrapMode: Label.WordWrap
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                    }

                    onClicked: {
                        menuDisplay.close()
                        menuDisplay.actions[name]();
                    }
                }
            }
        }
    }
}
