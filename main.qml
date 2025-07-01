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
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
        
        // Контейнер с 8 слайдерами
        SliderContainer {
            backgroundColor: "#33000000"  // пример с белым фоном
        }
    }
}
