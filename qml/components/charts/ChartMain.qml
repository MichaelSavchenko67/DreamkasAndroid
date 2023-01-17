import QtQuick

import "qrc:/content/chart.js" as Chart
import "qrc:/qml/pages/subpages" as Subpages

Subpages.Chart {
    id: chart
    animationEasingType: Easing.Linear
    animationDuration: 200
    chartOptions: {return {
            maintainAspectRatio: false,
            responsive: true,
            hoverMode: 'nearest',
            intersect: true,
            title: {
                display: false,
                text: title
            }
        }
    }
}
