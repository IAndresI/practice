import QtQuick 2.9
import "qrc:/"

Item {
    id: root

    // Входные параметры
    property color backgroundColor: "transparent" // цвет бекграунда
    property color textColor: "#ffffff" // цвет текста
    property int fontSize: Style.FontPixelSize.Normal // размер текста
    property int lineThickness: 2 // ширина линий
    property int depthValue: 0 // параметр величины глубины (1,2,0)
    property double speed: 0 // скорость
    property double bowDistance: 0 // расстояние нос
    property double sternDistance: 0 // расстояние корма
    property double meanDistance: 0 // расстояние сред
    property double degree: 0 // угол
    property var sliderValues: [8, 12, 10, 5, 7, 4, 6, 9]  // массив значений для 8 слайдеров
    property var sliderUnreliable: [false, false, false, false, false, false, false, false]  // массив булиновских значений

    // Размеры контейнера
    width: 330
    height: 820

    // Фон
    Rectangle {
        anchors.fill: parent
        color: backgroundColor
        radius: 8
    }

    Column {
        padding: 20
        width: parent.width

        Column {
            width: parent.width - 40
            spacing: 5

            // Ряд 1: Два вертикальных слайдера
            Item {
                width: parent.width
                height: 160

                TSliderVertical {
                    id: slider1
                    anchors.left: parent.left
                    value: root.sliderValues[0] || 0
                    minValue: 0
                    maxValue: 16
                    lineThickness: root.lineThickness
                    isUnreliable: root.sliderUnreliable[0] || false
                }

                // Центральные значения между слайдерами
                Column {
                    anchors.centerIn: parent
                    spacing: 8

                    TLabel {
                        id: speedLabel
                        //  "Скорость: " +
                        text:root.speed.toFixed(1)  + " м/с"
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: textColor
                        font.pointSize: fontSize
                    }

                    TLabel {
                        id: bowDistanceLabel
                        // "Расст. нос: " +
                        text: root.bowDistance.toFixed(1) + " м" + (root.depthValue === 0 ? " ◄" : "")
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: textColor
                        font.pointSize: fontSize
                    }

                    TLabel {
                        id: degreeLabel
                        // "Угол: " +
                        text: root.degree.toFixed(1) + "°"
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: root.degree >= 0
                        color: textColor
                        font.pointSize: fontSize
                    }


                }

                TSliderVertical {
                    id: slider2
                    anchors.right: parent.right
                    value: root.sliderValues[1] || 0
                    minValue: 0
                    maxValue: 20
                    lineThickness: root.lineThickness
                    isUnreliable: root.sliderUnreliable[1] || false
                    unreliableLineColor: "#234535"
                }
            }

            TLabel {
                id: meanLabel
                // "Угол: " +
                text: root.meanDistance.toFixed(1) + " м" + (root.depthValue === 1 ? " ◄" : "")
                anchors.horizontalCenter: parent.horizontalCenter
                color: textColor
                font.pointSize: fontSize
            }

            // Ряд 2: Горизонтальный слайдер по центру
            TSliderHorizontal {
                id: slider3
                anchors.horizontalCenter: parent.horizontalCenter
                value: root.sliderValues[2] || 0
                minValue: 0
                maxValue: 20
                lineThickness: root.lineThickness
                isUnreliable: root.sliderUnreliable[2] || false
            }

            // Ряд 3: Вертикальный слайдер по центру
            Item {
                width: parent.width
                height: 190


                TSliderVertical {
                    id: slider4
                    anchors.horizontalCenter: parent.horizontalCenter
                    value: root.sliderValues[3] || 0
                    minValue: 0
                    maxValue: 10
                    lineThickness: root.lineThickness
                    isUnreliable: root.sliderUnreliable[3] || false
                }

            }

            // Ряд 4: Горизонтальный слайдер по центру
            TSliderHorizontal {
                id: slider5
                anchors.horizontalCenter: parent.horizontalCenter
                value: root.sliderValues[4] || 0
                minValue: 0
                maxValue: 14
                lineThickness: root.lineThickness
                isUnreliable: root.sliderUnreliable[4] || false
            }

            // Ряд 5: Три вертикальных слайдера равноудаленные
            Item {
                width: parent.width
                height: 120

                TSliderVertical {
                    id: slider6
                    anchors.left: parent.left
                    value: root.sliderValues[5] || 0
                    minValue: 0
                    maxValue: 16
                    lineThickness: root.lineThickness
                    isUnreliable: root.sliderUnreliable[5] || false
                }

                // Центральные значения между слайдерами
                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 8

                    TLabel {
                        id: sternDistanceLabel
                        // "Расст. корма: " +
                        text:  root.sternDistance.toFixed(1) + " м" + (root.depthValue === 2 ? " ◄" : "")
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: root.textColor
                        font.pointSize: fontSize
                    }

                    TLabel {
                        id: negativeDegreeLabel
                        // "Угол: " +
                        text:  root.degree.toFixed(1) + "°"
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: root.textColor
                        font.pointSize: fontSize
                        visible: root.degree < 0
                    }
                }

                TSliderVertical {
                    id: slider7
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 130
                    value: root.sliderValues[6] || 0
                    minValue: 0
                    maxValue: 12
                    lineThickness: root.lineThickness
                    isUnreliable: root.sliderUnreliable[6] || false
                }

                TSliderVertical {
                    id: slider8
                    anchors.right: parent.right
                    value: root.sliderValues[7] || 0
                    minValue: 0
                    maxValue: 18
                    lineThickness: root.lineThickness
                    isUnreliable: root.sliderUnreliable[7] || false
                }
            }
        }
    }
}
