import QtQuick
import QtQuick.Controls

import "qrc:/qml/components/sale" as SaleComponents

Rectangle {
    property var delegateHeight: 0.17 * 0.99 * parent.height
    property string organizationName: "ООО \"Рога и Копыта\""
    property string choosenMerchantId: ""

    border.width: 1
    border.color: "#979797"
    radius: 8
    color: "transparent"

    onChoosenMerchantIdChanged: {
        updateCheckedMerchants()
    }

    function updateCheckedMerchants() {
        for (var i = 0; i <= merchantsModel.rowCount(); i++) {
            merchantsModel.get(i)["isChoosen"] = (merchantsModel.get(i)["merchantId"] === choosenMerchantId);
        }
    }

    Page {
        id: contentPage
        width: 0.99 * parent.width
        height: 0.99 * parent.height
        anchors.centerIn: parent
        header: Column {
            id: organization
            width: parent.width
            topPadding: 0.1 * delegateHeight
            spacing: topPadding
            leftPadding: topPadding

            Label {
                id: organizationLabel
                width: parent.width - parent.leftPadding
                text: qsTr(organizationName)
                font {
                    pixelSize: 0.15 * delegateHeight
                    family: "Roboto"
                    styleName: "normal"
                    weight: Font.Bold
                    bold: true
                }
                clip: true
                elide: Label.ElideRight
                maximumLineCount: 2
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }

            SaleComponents.Line {
                id: organizationSeparator
                width: parent.width - parent.leftPadding - scroll.width
                color: "#979797"
            }
        }
        contentData: ListView {
            id: merchantsList
            width: contentPage.width
            height: contentPage.height - organization.height
            clip: true
            model: ListModel {
                id: merchantsModel

                ListElement {
                    type: "member"
                    memberId: "100000000028"
                    memberName: "Тинькофф Банк"
                }

                ListElement {
                    type: "merchant"
                    parentMemberId: "100000000028"
                    merchantId: "MB0000725127"
                    brandName: "ИП Варвара ИП Варвара ИП Варвара ИП Варвара"
                    mcc: "3235"
                    address: "площадь Свердлова, 867 площадь Свердлова, 867 площадь Свердлова, 867"
                    registrationDate: "2022-03-26"
                    isChoosen: false
                }

                ListElement {
                    type: "merchant"
                    parentMemberId: "100000000028"
                    merchantId: "MB0000434038"
                    brandName: "ОАО ПромСбыт"
                    mcc: "5735"
                    address: "Трактовая проспект, 154"
                    registrationDate: "2022-01-10"
                    isChoosen: false
                }

                ListElement {
                    type: "merchant"
                    parentMemberId: "100000000028"
                    merchantId: "MB0000166087"
                    brandName: "ОП Макар"
                    mcc: "3719"
                    address: "Коммунальная проспект, 701"
                    registrationDate: "2022-06-14"
                    isChoosen: true
                }

                ListElement {
                    type: "member"
                    memberId: "100000000012"
                    memberName: "Райффайзен Банк"
                }

                ListElement {
                    type: "merchant"
                    parentMemberId: "100000000012"
                    merchantId: "MA0000111192"
                    brandName: "ОАО ИркутскПромТорг"
                    mcc: "5611"
                    address: "Береговая улица, 322"
                    registrationDate: "2021-12-27"
                    isChoosen: false
                }

                ListElement {
                    type: "merchant"
                    parentMemberId: "100000000012"
                    merchantId: "MA0000535114"
                    brandName: "НКО ХабаровскТоргПромТрейд"
                    mcc: "3163"
                    address: "Луговая пр., 559"
                    registrationDate: "2022-04-21"
                    isChoosen: false
                }

                ListElement {
                    type: "merchant"
                    parentMemberId: "100000000012"
                    merchantId: "MB0000502280"
                    brandName: "ЗАО ПромТрейд"
                    mcc: "3564"
                    address: "проспект Коммунистическая, 209"
                    registrationDate: "2022-05-09"
                    isChoosen: false
                }
            }
            delegate: Column {
                width: contentPage.width
                height: delegateHeight
                states: [
                    State {
                        name: "member"
                        PropertyChanges { target: merchant; visible: false }
                        PropertyChanges { target: member; visible: true }
                    },
                    State {
                        name: "merchant"
                        PropertyChanges { target: member; visible: false }
                        PropertyChanges { target: merchant; visible: true }
                    }
                ]
                state: type

                Column {
                    id: member
                    width: parent.width
                    visible: false
                    spacing: 0.5 * memberNameLabel.font.pixelSize
                    anchors.verticalCenter: parent.verticalCenter

                    Label {
                        id: memberNameLabel
                        width: contentPage.width
                        text: qsTr(memberName)
                        font {
                            pixelSize: 0.15 * delegateHeight
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Bold
                            bold: true
                        }
                        clip: true
                        elide: Label.ElideRight
                        maximumLineCount: 2
                        wrapMode: Label.WordWrap
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                        leftPadding: 0.2 * delegateHeight
                    }

                    Label {
                        id: memberIdLabel
                        width: memberNameLabel.width
                        leftPadding: memberNameLabel.leftPadding
                        text: qsTr("Идентификатор банка получателя: \n" + memberId)
                        font {
                            pixelSize: 0.67 * memberNameLabel.font.pixelSize
                            family: "Roboto"
                            styleName: "normal"
                            weight: Font.Normal
                        }
                        color: "#979797"
                        clip: true
                        elide: Label.ElideRight
                        maximumLineCount: 2
                        wrapMode: Label.WordWrap
                        lineHeight: 1.2
                        verticalAlignment: Label.AlignBottom
                    }

                    Row {
                        width: parent.width
                        leftPadding: memberNameLabel.leftPadding

                        SaleComponents.Line {
                            width: parent.width - parent.leftPadding - scroll.width
                            color: "#979797"
                        }
                    }
                }

                ItemDelegate {
                    id: merchant
                    width: contentPage.width
                    height: delegateHeight
                    visible: false
                    onClicked: {
                        choosenMerchantId = merchantId
                    }

                    Row {
                        anchors.fill: parent
                        leftPadding: memberNameLabel.leftPadding
                        spacing: 0.25 * leftPadding

                        SaleComponents.RadioButtonCursor {
                            id: radioButton
                            height: 0.5 * delegateHeight
                            anchors.verticalCenter: parent.verticalCenter
                            checked: isChoosen
                            onCheckedChanged: {
                                if (checked) {
                                    choosenMerchantId = merchantId
                                }
                            }
                        }

                        Column {
                            id: dataColumn
                            width: parent.width -
                                   radioButton.implicitWidth -
                                   parent.spacing -
                                   parent.leftPadding
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 0.2 * brandNameLabel.font.pixelSize

                            Label {
                                id: brandNameLabel
                                width: parent.width
                                text: qsTr(brandName)
                                font {
                                    pixelSize: 0.8 * memberNameLabel.font.pixelSize
                                    family: "Roboto"
                                    styleName: "normal"
                                    weight: Font.Thin
                                }
                                clip: true
                                elide: Label.ElideRight
                                maximumLineCount: 2
                                wrapMode: Label.WordWrap
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }

                            Column {
                                width: parent.width
                                spacing: 0.5 * parent.spacing

                                Label {
                                    width: brandNameLabel.width
                                    text: qsTr("Идентификатор ТСП: " + merchantId)
                                    font: memberIdLabel.font
                                    color: memberIdLabel.color
                                    clip: memberIdLabel.clip
                                    elide: memberIdLabel.elide
                                    horizontalAlignment: memberIdLabel.horizontalAlignment
                                    verticalAlignment: memberIdLabel.verticalAlignment
                                }

                                Label {
                                    width: brandNameLabel.width
                                    text: qsTr("MCC код: " + mcc)
                                    font: memberIdLabel.font
                                    color: memberIdLabel.color
                                    clip: memberIdLabel.clip
                                    elide: memberIdLabel.elide
                                    horizontalAlignment: memberIdLabel.horizontalAlignment
                                    verticalAlignment: memberIdLabel.verticalAlignment
                                }

                                Label {
                                    width: brandNameLabel.width
                                    text: qsTr("Зарегистрирован: " + registrationDate)
                                    font: memberIdLabel.font
                                    color: memberIdLabel.color
                                    clip: memberIdLabel.clip
                                    elide: memberIdLabel.elide
                                    horizontalAlignment: memberIdLabel.horizontalAlignment
                                    verticalAlignment: memberIdLabel.verticalAlignment
                                }

                                Label {
                                    width: brandNameLabel.width
                                    text: qsTr("Адрес: " + address)
                                    font: memberIdLabel.font
                                    color: memberIdLabel.color
                                    clip: memberIdLabel.clip
                                    elide: memberIdLabel.elide
                                    maximumLineCount: 2
                                    wrapMode: Label.WordWrap
                                    horizontalAlignment: memberIdLabel.horizontalAlignment
                                    verticalAlignment: memberIdLabel.verticalAlignment
                                }
                            }
                        }
                    }
                }
            }
            ScrollBar.vertical: ScrollBar {
                id: scroll
                policy: ScrollBar.AlwaysOn
                width: 8
            }
        }
    }
}
