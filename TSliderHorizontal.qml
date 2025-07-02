import QtQuick 2.9
import "qrc:/"

Item {
    id: root
    
    // Входные параметры
    property real value: 0
    property real minValue: 0
    property real maxValue: 100
    property bool disabled: false 
    property int fontSize: Style.FontPixelSize.Normal
    property color fontColor: Style.textEnabled
    property color lineColor: Style.borderEnabled
    property color normalLineColor: "#4caf50"     // зеленый для достоверных данных
    property color unreliableLineColor: "#f44336" // красный для недостоверных данных
    property bool isUnreliable: false
    property real lineThickness: 2
    
    // Сигналы
    signal valueModified(real newValue)
    

    height: 50
    width: implicitWidth
    implicitWidth: decrementButton.width + progressContainer.implicitWidth + incrementButton.width + 16
    
    // Вычисляемые значения
    readonly property real centerValue: (minValue + maxValue) / 2
    readonly property real deviation: value - centerValue
    readonly property real maxDeviation: (maxValue - minValue) / 2
    readonly property real normalizedDeviation: deviation / maxDeviation // от -1 до +1
    
    // Функция для ограничения значения
    function clampValue(val) {
        return Math.max(minValue, Math.min(maxValue, val))
    }
    
    // Функция для изменения значения
    function changeValue(delta) {
        var newValue = clampValue(value + delta)
        if (newValue !== value) {
            value = newValue
            valueModified(newValue)
        }
    }
    
    Row {
        anchors.fill: parent
        spacing: 8
        
        // Кнопка декремента
        Rectangle {
            id: decrementButton
            width: parent.height * 0.6
            height: parent.height * 0.6
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
            
            // Треугольник влево
            Canvas {
                anchors.centerIn: parent
                width: progressContainer.height * 0.5 - 2
                height: progressContainer.height * 0.5 - 2
                
                property color triangleColor: {
                    if (disabled) return Style.borderDisabled
                    if (normalizedDeviation < 0) return isUnreliable ? unreliableLineColor : normalLineColor
                    return "transparent"
                }
                onTriangleColorChanged: requestPaint()
                Component.onCompleted: requestPaint()
                
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    
                    ctx.fillStyle = triangleColor
                    ctx.beginPath()
                    ctx.moveTo(width, 0)
                    ctx.lineTo(0, (height) / 2)
                    ctx.lineTo(width, height)
                    ctx.closePath()
                    ctx.fill()
                    
                    // Черный бордер
                    ctx.strokeStyle = "white"
                    ctx.lineWidth = 1
                    ctx.stroke()
                }
            }
            
            MouseArea {
                anchors.fill: parent
                enabled: !disabled
                onClicked: changeValue(-1)
            }
        }
        
        // Прогресс-бар с линиями
        Item {
            id: progressContainer
            width: implicitWidth
            height: parent.height
            implicitWidth: lineThickness + 103  // автоматическая ширина на основе содержимого
            
            Item {
                anchors.centerIn: parent
                width: 9.5 * lineThickness + 96  // 8 обычных линий + 1 центральная + отступы
                height: progressContainer.height
                
                // 4 линии слева (для отрицательных отклонений)
                Repeater {
                    model: 4
                    Rectangle {
                        width: lineThickness
                        height: progressContainer.height * 0.5
                        anchors.verticalCenter: parent.verticalCenter
                        x: parent.width / 1.8 - lineThickness * 1.5 / 2 - 12 - (4 - index) * 12  // позиция от центра влево
                        color: {
                            if (disabled) return Style.borderDisabled
                            // Подсвечиваем если отклонение отрицательное
                            if (normalizedDeviation >= 0) return "white"
                            // Линии идут от центра наружу: 4-я, 3-я, 2-я, 1-я
                            var lineThreshold = (4 - index) / 4.0  // 1.0, 0.75, 0.5, 0.25
                            var absDeviation = Math.abs(normalizedDeviation)
                            return absDeviation >= lineThreshold ? (isUnreliable ? unreliableLineColor : normalLineColor) : "white"
                        }
                    }
                }
                
                // Центральная большая линия (загорается при отклонении)
                Rectangle {
                    width: lineThickness * 1.5
                    height: progressContainer.height * 0.8
                    anchors.centerIn: parent

                    color: {
                        if (disabled) return Style.borderDisabled
                        if (Math.abs(normalizedDeviation) < 0.01) return "white" // почти центр
                        return isUnreliable ? unreliableLineColor : normalLineColor
                    }
                }
                
                // 4 линии справа (для положительных отклонений)
                Repeater {
                    model: 4
                    Rectangle {
                        width: lineThickness
                        height: progressContainer.height * 0.5
                        anchors.verticalCenter: parent.verticalCenter
                        x: parent.width / 2 + lineThickness * 1.5 / 2 + 12 + index * 12  // позиция от центра вправо
                        color: {
                            if (disabled) return Style.borderDisabled
                            // Подсвечиваем если отклонение положительное
                            if (normalizedDeviation <= 0) return "white"
                            // Линии идут от центра наружу: 1-я, 2-я, 3-я, 4-я
                            var lineThreshold = (index + 1) / 4.0  // 0.25, 0.5, 0.75, 1.0
                            return normalizedDeviation >= lineThreshold ? (isUnreliable ? unreliableLineColor : normalLineColor) : "white"
                        }
                    }
                }
            }
            
            // Левая половина для декремента
            MouseArea {
                width: parent.width / 2
                height: parent.height
                enabled: !disabled
                onClicked: changeValue(-1)
            }
            
            // Правая половина для инкремента
            MouseArea {
                x: parent.width / 2
                width: parent.width / 2
                height: parent.height
                enabled: !disabled
                onClicked: changeValue(1)
            }
        }
        
        // Кнопка инкремента
        Rectangle {
            id: incrementButton
            width: parent.height * 0.6
            height: parent.height * 0.6
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
            
            // Треугольник вправо
            Canvas {
                anchors.centerIn: parent
                width: progressContainer.height * 0.5 - 2
                height: progressContainer.height * 0.5 - 2
                
                property color triangleColor: {
                    if (disabled) return Style.borderDisabled
                    if (normalizedDeviation > 0) return isUnreliable ? unreliableLineColor : normalLineColor
                    return "transparent"
                }
                onTriangleColorChanged: requestPaint()
                Component.onCompleted: requestPaint()
                
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    
                    ctx.fillStyle = triangleColor
                    ctx.beginPath()
                    ctx.moveTo(0, 0)
                    ctx.lineTo(width, height / 2)
                    ctx.lineTo(0, height)
                    ctx.closePath()
                    ctx.fill()
                    
                    // Черный бордер
                    ctx.strokeStyle = "white"
                    ctx.lineWidth = 1
                    ctx.stroke()
                }
            }
            
            MouseArea {
                anchors.fill: parent
                enabled: !disabled
                onClicked: changeValue(1)
            }
        }
    }
    
    // Текст со значением (опционально)
    // Text {
    //     anchors.bottom: parent.top
    //     anchors.bottomMargin: 4
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     text: value.toFixed(0)
    //     font.pixelSize: fontSize
    //     color: !disabled ? fontColor : Style.textDisabled
    //     font.family: Style.fontFamily
    // }
} 
