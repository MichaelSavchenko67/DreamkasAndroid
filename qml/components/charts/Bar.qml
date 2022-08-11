import QtQuick 2.15

import "qrc:/content/chart.js" as Chart
import "qrc:/qml/pages/subpages" as Subpages

Subpages.Chart {
    id: chart
    chartType: 'bar'
    animationEasingType: Easing.Linear
    animationDuration: 200
    chartOptions: {return {
            maintainAspectRatio: false,
            responsive: true,
            hoverMode: 'nearest',
            intersect: true,
            title: {
                display: false,
                text: ""
            },
            tooltips: {
                mode: 'index',
                intersect: false
            },
            responsive: true,
            scales: {
                xAxes: [{
                        stacked: true,
                    }],
                yAxes: [{
                        stacked: true
                    }]
            },
            legend: {
                display: false
            }
        }
    }
    anchors {
        fill: parent
        bottomMargin: 50
    }
}
