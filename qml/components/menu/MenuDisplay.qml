import QtQuick
import QtQuick.Controls

Drawer {
    id: menuDisplay
    width: parent.width
    height: menuItemColumn.topPadding +
            menuHeaderColumn.height +
            menuItemColumn.spacing +
            1.1 * Math.ceil(gridView.count / 3) * gridView.cellHeight
    edge: Qt.BottomEdge
    dragMargin: 0.018 * width
    contentData: Column {
        id: menuItemColumn
        anchors.fill: parent
        spacing: 0.5 * 0.0311 * menuDisplay.width
        topPadding: 0.5 * spacing

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
                anchors.horizontalCenter: parent.horizontalCenter
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
            height: parent.height - menuHeaderColumn.height
            cellWidth: width / 3
            cellHeight: 0.5 * cellWidth
            model: ListModel {
                id: menuItemsList

                property var actions : {
                    "Настройки": function() { root.openPage("qrc:/qml/pages/startCustomerDisplay/MainSettings.qml") },
                    "Галерея": function() { root.openPage("qrc:/qml/pages/startCustomerDisplay/Gallery.qml") },
                    "2can NFC": function() { root.openPage("qrc:/qml/pages/startCustomerDisplay/Pinpad2canSettings.qml") },
                    "Ещё": function() {  }
                }

                ListElement {
                    name: "Настройки"
                    icoSrc: "qrc:/ico/menu/settings_blue.png"
                    isCanApply: false
                    isApplied: false
                }

                ListElement {
                    name: "Галерея"
                    icoSrc: "qrc:/ico/menu/gallery.png"
                    isCanApply: false
                    isApplied: false
                }

                ListElement {
                    name: "2can NFC"
                    icoSrc: "qrc:/ico/settings/2can.png"
                    isCanApply: true
                    isApplied: true
                }

                ListElement {
                    name: "Ещё"
                    icoSrc: "qrc:/ico/menu/other.png"
                    isCanApply: false
                    isApplied: false
                }
            }
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
                        topPadding: 0.5 * (height -
                                           itemIco.height -
                                           spacing -
                                           itemName.contentHeight)
                        bottomPadding: topPadding

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
                            elide: Label.ElideRight
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                    }

                    onClicked: {
                        menuDisplay.close()
                        menuItemsList.actions[name]();
                    }
                }
            }
        }
    }
}
