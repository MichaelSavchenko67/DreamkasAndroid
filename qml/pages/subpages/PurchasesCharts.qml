import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12

import "qrc:/qml/components/sale" as SaleComponents
import "qrc:/qml/components/charts" as ChartsComponents

Page {
    id: popupPurchasesCharts

    function getPurchasesChartData() {
        return {
            labels: [
                'Приход',
                'Расход',
                'Возврат прихода',
                'Возврат расхода'
            ],
            datasets: [{
                    label: 'Чеки',
                    data: [300, 50, 100, 125],
                    backgroundColor: [
                        'rgb(255, 99, 132)',
                        'rgb(54, 162, 235)',
                        'rgb(255, 205, 86)',
                        'rgb(74, 220, 0)',
                        'rgb(4, 3, 255)'
                    ],
                    hoverOffset: 4
                }]
        }
    }

    anchors.fill: parent
    contentData: Column {
        width: 0.9 * parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        SwipeView {
            id: view
            currentIndex: 0
            width: parent.width
            height: parent.height - indicator.height - confirmButton.height

            Item {
                id: doughnutItem

                Timer {
                    interval: 350
                    repeat: false
                    running: !doughnutItem.focus
                    onTriggered: {
                        doughnutLoader.sourceComponent = null
                    }
                }

                onFocusChanged: {
                    if (focus) {
                        doughnutLoader.sourceComponent = doughnutComponent
                    }
                }

                Component {
                    id: doughnutComponent

                    ChartsComponents.ChartMain {
                        id: doughnut
                        chartType: "doughnut"
                        chartData: getPurchasesChartData()
                        anchors.centerIn: parent
                    }
                }

                Loader {
                    id: doughnutLoader
                    width: 0.9 * parent.width
                    height: 0.7 * parent.height
                    anchors.centerIn: parent
                }
            }

            Item {
                id: pieItem

                Timer {
                    interval: 350
                    repeat: false
                    running: !pieItem.focus
                    onTriggered: {
                        pieLoader.sourceComponent = null
                    }
                }

                onFocusChanged: {
                    if (focus) {
                        pieLoader.sourceComponent = pieComponent
                    }
                }

                Component {
                    id: pieComponent

                    ChartsComponents.ChartMain {
                        id: pie
                        chartType: "pie"
                        chartData: getPurchasesChartData()
                        anchors.centerIn: parent
                    }
                }

                Loader {
                    id: pieLoader
                    width: 0.9 * parent.width
                    height: 0.7 * parent.height
                    anchors.centerIn: parent
                }
            }

            Item {
                id: polarAreaItem

                Timer {
                    interval: 350
                    repeat: false
                    running: !polarAreaItem.focus
                    onTriggered: {
                        polarAreaLoader.sourceComponent = null
                    }
                }

                onFocusChanged: {
                    if (focus) {
                        polarAreaLoader.sourceComponent = polarAreaComponent
                    }
                }

                Component {
                    id: polarAreaComponent

                    ChartsComponents.ChartMain {
                        id: pie
                        chartType: "polarArea"
                        chartData: getPurchasesChartData()
                        anchors.centerIn: parent
                    }
                }

                Loader {
                    id: polarAreaLoader
                    width: 0.9 * parent.width
                    height: 0.7 * parent.height
                    anchors.centerIn: parent
                }
            }

            Item {
                id: barItem

                Timer {
                    interval: 350
                    repeat: false
                    running: !barItem.focus
                    onTriggered: {
                        barLoader.sourceComponent = null
                    }
                }

                onFocusChanged: {
                    if (focus) {
                        barLoader.sourceComponent = barComponent
                    }
                }

                Component {
                    id: barComponent

                    ChartsComponents.Bar {
                        chartData: getPurchasesChartData()
                        width: 0.9 * parent.width
                        height: 0.7 * parent.height
                        anchors.centerIn: parent
                    }
                }

                Loader {
                    id: barLoader
                    width: 0.9 * parent.width
                    height: 0.7 * parent.height
                    anchors.centerIn: parent
                }
            }
        }

        Column {
            width: parent.width
            anchors {
                bottom: parent.bottom
                bottomMargin: parent.spacing
            }

            PageIndicator {
                id: indicator
                count: view.count
                currentIndex: view.currentIndex
                anchors.horizontalCenter: parent.horizontalCenter
            }

            SaleComponents.Button_1 {
                id: confirmButton
                width: parent.width
                height: 0.18 * width
                Layout.alignment: Qt.AlignCenter
                borderWidth: 0
                backRadius: 5
                buttonTxt: qsTr("ОТПРАВИТЬ")
                fontSize: 0.27 * height
                buttonTxtColor: "white"
                pushUpColor: "#415A77"
                pushDownColor: "#004075"
                onClicked: {
                    root.closePage()
                }
            }
        }
    }

}
