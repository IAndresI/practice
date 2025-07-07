import QtQuick 2.15
import QtQuick.Window 2.15
import "qrc:/"

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Practice")
    color: "#f0f0f0"

    CompassScale {
        id: compass
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: parent.width * 0.5
        height: 120
        value: 0 // Текущее значение шкалы
        fontSize: Style.FontPixelSize.Normal // Размер шрифта
        backgroundColor: "#000000" // Цвет подложки
        tickColor: "#ffffff" // Цвет шкалы
        indicatorColor: "#ff0000" // Цвет линии, отображающей текущее значение (по умолчанию красный)
        tickLineWidth: 2 // толщина линий линейки
        indicatorLineWidth: 3 // толщина линии текущего значения
        labelColor: "#ffffff" // цвет текста (чисел) (по умолчанию = tickColor)
        valueTextColor: "#ffffff" // цвет текущего значения (по умолчанию = tickColor)
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }

    Column {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30

        SliderContainer {
            id: sliderContainer
            backgroundColor: "#33ffffff" // цвет подложки
            lineThickness: 5 // ширина линий у слайдеров
            fontSize: Style.FontPixelSize.Normal // Размер текста
            sliderValues: [8, 15, 8, 3, 12, 2, 9, 14]  // значения для каждого слайдера
            bowDistance: 6.6 // расстояние нос
            sternDistance: 4.7 // расстояние корма
            meanDistance: 2.4 // расстояние сред
            depthValue: 1 // параметр величины глубины (1,2,0)
            speed: 10 //. Скорость
            degree: -5.5 // угол
            sliderUnreliable: [false, true, false, true, false, true, false, true]  // правильность данных
        }

         //Timer для проверки динамического изменения lineThickness
//         Timer {
//             interval: 2000
//             running: true
//             repeat: true
//             onTriggered: {
//                 sliderContainer.lineThickness = sliderContainer.lineThickness === 5 ? 1 : 5
//                 console.log("LineThickness changed to:", sliderContainer.lineThickness)
//             }
//         }

         //Timer для проверки динамического изменения CompassScale
         Timer {
             interval: 1000
             running: true
             repeat: true
             onTriggered: {
                 var delta
                 do {
                     delta = Math.floor(Math.random() * 25) - 12;
                  } while (delta === 0);      // чтобы не остаться на месте
                 compass.value = (compass.value + delta + 360) % 360;
             }
         }
    }
}
