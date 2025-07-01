import QtQuick 2.9
import "qrc:/"

Item {
    id: root

    // Входные параметры
    property color backgroundColor: "transparent" // необязательный цвет фона

    // Размеры контейнера
    width: 330
    height: 800

    // Фон контейнера
    Rectangle {
        anchors.fill: parent
        color: backgroundColor
        radius: 8
    }

    Column {
        padding: 30
        width: parent.width

        Column {
            width: parent.width - 60
            spacing: 10

            // Ряд 1: Два вертикальных слайдера
            Item {
                width: parent.width
                height: 180

                TSliderVertical {
                    id: slider1
                    anchors.left: parent.left
                    value: 8
                    minValue: 0
                    maxValue: 16
                }

                TSliderVertical {
                    id: slider2
                    anchors.right: parent.right
                    value: 12
                    minValue: 0
                    maxValue: 20
                }
            }

            // Ряд 2: Горизонтальный слайдер по центру
            TSliderHorizontal {
                id: slider3
                anchors.horizontalCenter: parent.horizontalCenter
                value: 10
                minValue: 0
                maxValue: 20
                lineThickness: 5
            }

            // Ряд 3: Вертикальный слайдер по центру
            Item {
                width: parent.width
                height: 190


                TSliderVertical {
                    id: slider4
                    anchors.horizontalCenter: parent.horizontalCenter
                    value: 5
                    minValue: 0
                    maxValue: 10
                    lineThickness: 5
                }

            }

            // Ряд 4: Горизонтальный слайдер по центру
            TSliderHorizontal {
                id: slider5
                anchors.horizontalCenter: parent.horizontalCenter
                value: 7
                minValue: 0
                maxValue: 14
            }

            // Ряд 5: Три вертикальных слайдера равноудаленные
            Item {
                width: parent.width
                height: 120

                TSliderVertical {
                    id: slider6
                    anchors.left: parent.left
                    value: 4
                    minValue: 0
                    maxValue: 16
                }

                TSliderVertical {
                    id: slider7
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 85
                    value: 6
                    minValue: 0
                    maxValue: 12
                }

                TSliderVertical {
                    id: slider8
                    anchors.right: parent.right
                    value: 9
                    minValue: 0
                    maxValue: 18
                }
            }
        }
    }


}
