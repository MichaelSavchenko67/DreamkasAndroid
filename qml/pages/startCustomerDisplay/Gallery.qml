import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/menu" as MenuComponents
import "qrc:/qml/components/settings" as SettingsComponents

Page {
    id: galleryPage
    width: parent.width
    height: parent.height

    property bool galleryCheckMode: false

    onFocusChanged: {
        if (focus) {
            root.setMenuEnabled(false)
            toolBar.setButton("secondButton", "qrc:/ico/settings/trash_can.png", deleteGalleryElements)
            toolBar.setButton("thirdButton", "qrc:/ico/settings/camera.png", getPhoto)
        }
    }

    onGalleryCheckModeChanged: {
        toolBar.setButton("thirdButton",
                          "qrc:/ico/settings/" + (galleryCheckMode ? "close_blue" : "camera") + ".png",
                          galleryCheckMode ? cancelCheckMode : getPhoto)
    }

    function resetCheckedGalleryElements() {
        for (var i = 0; i <= gridView.count; i++) {
            gridView.contentItem.children[i].isChecked = false;
        }
        gridView.checkedGalleryElementsCnt = 0
    }

    function execForCheckedGalleryElements(isDelete) {
        while (gridView.checkedGalleryElementsCnt > 0) {
            for (var i = 0; i <= galleryElementsListModel.rowCount(); i++) {
                console.log("galleryElementsListModel isChecked " + galleryElementsListModel.get(i)["isChecked"])

                if (galleryElementsListModel.get(i)["isChecked"]) {

                    if (isDelete) {
                        galleryElementsListModel.remove(i)
                    }
                    gridView.checkedGalleryElementsCnt--
                    break
                }
            }
        }
        galleryCheckMode = false
    }

    Action {
        id: deleteGalleryElements
        onTriggered: {
            if (!galleryCheckMode) {
                galleryCheckMode = true
            } else {
                execForCheckedGalleryElements(galleryCheckMode)
            }
        }
    }

    Action {
        id: getPhoto
        onTriggered: {
        }
    }

    Action {
        id: cancelCheckMode
        onTriggered: {
            resetCheckedGalleryElements()
            galleryCheckMode = false
        }
    }

    header: MenuComponents.ToolBarSimple {
        id: toolBar
        title: "Галерея"
    }
    contentData: Column {
        width: 0.896 * parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        bottomPadding: 0.039 * galleryPage.width
        spacing: height -
                 galleryFrequencyColumn.height -
                 previewButton.height -
                 bottomPadding

        Column {
            id: galleryFrequencyColumn
            width: parent.width
            height: parent.height -
                    previewButton.height -
                    parent.bottomPadding
            spacing: 0.014 * galleryPage.width

            Column {
                id: gallerySetFrequencyColumn
                width: parent.width
                spacing: parent.spacing

                Label {
                    id: galleryFrequencyTitleLabel
                    width: parent.width
                    text: qsTr("Частота смены кадров")
                    font {
                        pixelSize: 0.7 * 0.04375 * galleryPage.width
                        family: "Roboto"
                        styleName: "normal"
                        weight: Font.Normal
                    }
                    color: "#979797"
                    clip: true
                    elide: Label.ElideRight
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter

                    SpinBox {
                        id: spinBox
                        anchors.verticalCenter: parent.verticalCenter
                        from: 5
                        to: 120
                        stepSize: 5
                        Material.accent: "#0064B4"
                        font: secondsLabel.font
                        contentItem: TextInput {
                            z: 2
                            text: spinBox.textFromValue(spinBox.value, spinBox.locale)
                            font: spinBox.font
                            color: "#0064B4"
                            selectionColor: "#0064B4"
                            selectedTextColor: "#0064B4"
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            readOnly: !spinBox.editable
                            validator: spinBox.validator
                            inputMethodHints: Qt.ImhFormattedNumbersOnly
                        }
                    }

                    TextField {
                        id: secondsLabel
                        anchors.verticalCenter: parent.verticalCenter
                        enabled: false
                        text: "секунд"
                        font {
                            pixelSize: 0.9 * 0.04375 * galleryPage.width
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#0064B4"
                        horizontalAlignment: TextField.AlignHCenter
                        verticalAlignment: TextField.AlignVCenter
                    }
                }
            }

            Column {
                id: galleryElementsColumn
                width: parent.width
                height: parent.height -
                        gallerySetFrequencyColumn.height -
                        parent.spacing
                spacing: parent.spacing

                Label {
                    id: galleryElementsTitleLable
                    width: parent.width
                    text: qsTr("Загруженная реклама")
                    font: galleryFrequencyTitleLabel.font
                    color: galleryFrequencyTitleLabel.color
                    clip: galleryFrequencyTitleLabel.clip
                    elide: galleryFrequencyTitleLabel.elide
                    horizontalAlignment: galleryFrequencyTitleLabel.horizontalAlignment
                    verticalAlignment: galleryFrequencyTitleLabel.verticalAlignment
                }

                Column {
                    id: column
                    width: parent.width
                    height: parent.height -
                            galleryElementsTitleLable.contentHeight -
                            parent.spacing
                    clip: true

                    ListModel {
                        id: galleryElementsListModel

                        ListElement {
                            imgSrc: ""
                        }

                        ListElement {
                            imgSrc: "qrc:/img/gallery/gallery_1.png"
                            isChecked: false
                        }

                        ListElement {
                            imgSrc: "qrc:/img/gallery/gallery_2.png"
                            isChecked: false
                        }

                        ListElement {
                            imgSrc: "qrc:/img/gallery/gallery_3.png"
                            isChecked: false
                        }

                        ListElement {
                            imgSrc: "qrc:/img/gallery/gallery_4.png"
                            isChecked: false
                        }

                        ListElement {
                            imgSrc: "qrc:/img/gallery/gallery_1.png"
                            isChecked: false
                        }

                        ListElement {
                            imgSrc: "qrc:/img/gallery/gallery_2.png"
                            isChecked: false
                        }

                        ListElement {
                            imgSrc: "qrc:/img/gallery/gallery_3.png"
                            isChecked: false
                        }
                    }

                    GridView {
                        id: gridView

                        property int checkedGalleryElementsCnt: 0

                        anchors.fill: parent
                        cellWidth: width / 3
                        cellHeight: 1.33 * cellWidth
                        model: galleryElementsListModel
                        add: Transition { NumberAnimation { properties: "scale"; from: 0; to: 1; easing.type: Easing.InOutQuad } }
                        remove: Transition { NumberAnimation { properties: "scale"; from: 1; to: 0; easing.type: Easing.InOutQuad } }
                        delegate: SettingsComponents.GalleryElement {
                            id: galleryElement
                            width: gridView.cellWidth
                            height: gridView.cellHeight
                            img: imgSrc
                            isCheckMode: galleryCheckMode
                            onIsCheckedChanged: {
                                model.isChecked = isChecked

                                if (isChecked) {
                                    gridView.checkedGalleryElementsCnt++
                                } else {
                                    gridView.checkedGalleryElementsCnt--
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: borderRect
                        width: parent.width
                        height: previewButton.height
                        anchors.bottom: column.bottom
                        color: "white"
                        opacity: 0.55
                    }

                    FastBlur {
                        anchors.fill: borderRect
                        source: borderRect
                        visible: borderRect.visible
                        radius: 32
                        opacity: 0.55
                    }
                }
            }
        }

        SaleComponents.Button_1 {
            id: previewButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: 0.5 * parent.width
            height: 0.112 * parent.width
            buttonTxt: "ПРЕДПРОСМОТР"
            borderWidth: 0
            backRadius: 8
            fontSize: 0.028 * parent.width
            buttonTxtColor: "white"
            pushUpColor: "#415A77"
            pushDownColor: "#004075"
            onClicked: {
                root.openPage("qrc:/qml/pages/startCustomerDisplay/Advertising.qml")
                rootStack.currentItem.state = "preview"
            }
        }
    }
}
