import QtQuick 2.15
import QtQuick.Window 2.15
import "qrc:/"

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("TSlider Test")
    color: "#f0f0f0"
    
    Column {
        anchors.centerIn: parent
        spacing: 40
        
        // Заголовок
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Slider Container"
            font.pixelSize: 24
            font.family: Style.fontFamily
            color: Style.textEnabled
        }
        
        // Контейнер с 8 слайдерами
        SliderContainer {
            anchors.horizontalCenter: parent.horizontalCenter
            backgroundColor: "#33000000"  // пример с белым фоном
        }
    }
}
