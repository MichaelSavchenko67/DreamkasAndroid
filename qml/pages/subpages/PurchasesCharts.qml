import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
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

    function getEmptyPurchasesChartData() {
        return {
            labels: [
                'Приход',
                'Расход',
                'Возврат прихода',
                'Возврат расхода'
            ],
            datasets: [{
                    label: 'Чеки',
                    data: [0, 0, 0, 0],
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
            spacing: 0.1 * parent.width

            Item {
                id: doughnutItem

                onFocusChanged: {
                    doughnut.chartData = focus ? getPurchasesChartData() : getEmptyPurchasesChartData()
                    doughnut.animateToNewData()
                }

                ChartsComponents.ChartMain {
                    id: doughnut
                    width: 0.9 * parent.width
                    height: 0.7 * parent.height
                    anchors.centerIn: parent
                    chartType: "doughnut"
                    chartData: getPurchasesChartData()
                }
            }

            Item {
                id: pieItem

                onFocusChanged: {
                    pie.chartData = focus ? getPurchasesChartData() : getEmptyPurchasesChartData()
                    pie.animateToNewData()
                }

                ChartsComponents.ChartMain {
                    id: pie
                    width: doughnut.width
                    height: doughnut.height
                    anchors.centerIn: parent
                    chartType: "pie"
                    chartData: getPurchasesChartData()
                }
            }

            Item {
                id: polarAreaItem

                onFocusChanged: {
                    polarArea.chartData = focus ? getPurchasesChartData() : getEmptyPurchasesChartData()
                    polarArea.animateToNewData()
                }

                ChartsComponents.ChartMain {
                    id: polarArea
                    width: doughnut.width
                    height: doughnut.height
                    anchors.centerIn: parent
                    chartType: "polarArea"
                    chartData: getPurchasesChartData()
                }
            }

            Item {
                id: barItem

                onFocusChanged: {
                    bar.chartData = focus ? getPurchasesChartData() : getEmptyPurchasesChartData()
                    bar.animateToNewData()
                }

                ChartsComponents.Bar {
                    id: bar
                    width: doughnut.width
                    height: doughnut.height
                    anchors.centerIn: parent
                    chartData: getPurchasesChartData()
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
