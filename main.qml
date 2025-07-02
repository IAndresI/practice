import QtQuick 2.15
import QtQuick.Window 2.15
import "qrc:/"

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Practice")
    color: "#f0f0f0"

    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }
    
    Column {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
        
        SliderContainer {
            backgroundColor: "#33ffffff" // цвет подложки
            lineThickness: 2 // ширина линий у слайдеров
            fontSize: Style.FontPixelSize.Normal // Размер текста
            sliderValues: [8, 15, 8, 3, 12, 2, 9, 14]  // значения для каждого слайдера
            bowDistance: 6.6 // расстояние нос
            sternDistance: 4.7 // расстояние корма
            environmentDistance: 2.4 // расстояние сред
            degree: 5.5 // угол
            sliderUnreliable: [false, true, false, true, false, true, false, true]  // правильность данных
        }
    }
}
