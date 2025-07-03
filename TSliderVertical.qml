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
    

    width: 50
    height: implicitHeight
    implicitHeight: (width * 0.6) + (9.5 * lineThickness + 96) + (width * 0.6) + 16  // кнопки + прогресс + spacing между элементами
    
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

    // Фон контейнера
    // Rectangle {
    //     anchors.fill: parent
    //     color: "#33333333"
    // }
    
    Column {
        anchors.fill: parent
        spacing: 8
        
        // Кнопка инкремента (вверх - увеличение)
        Rectangle {
            id: incrementButton
            width: parent.width * 0.6
            height: parent.width * 0.6
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            
            // Треугольник вверх
            Canvas {
                anchors.centerIn: parent
                width: progressContainer.width * 0.5 - 2
                height: progressContainer.width * 0.5 - 2
                
                property color triangleColor: {
                    if (disabled) return Style.borderDisabled
                    if (normalizedDeviation > 0) return isUnreliable ? unreliableLineColor : normalLineColor
                    return "transparent"
                }
                property real lineThickness: root.lineThickness
                
                onTriangleColorChanged: requestPaint()
                Component.onCompleted: requestPaint()
                onLineThicknessChanged: requestPaint()
                
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    
                    // Учитываем толщину линии для корректного размещения внутри границ
                    var offset = lineThickness / 2
                    
                    ctx.fillStyle = triangleColor
                    ctx.beginPath()
                    ctx.moveTo(width / 2, offset)
                    ctx.lineTo(offset, height - offset)
                    ctx.lineTo(width - offset, height - offset)
                    ctx.closePath()
                    ctx.fill()
                    
                    // Черный бордер
                    ctx.strokeStyle = "white"
                    ctx.lineWidth = lineThickness
                    ctx.stroke()
                }
            }
            
            MouseArea {
                anchors.fill: parent
                enabled: !disabled
                onClicked: changeValue(1)
            }
        }
        
        // Прогресс-бар с линиями (вертикальный)
        Item {
            id: progressContainer
            width: parent.width
            height: lineThickness + 103
                
                // 4 линии сверху (для положительных отклонений - выше среднего)
                Repeater {
                    model: 4
                    Rectangle {
                        width: progressContainer.width * 0.5
                        height: lineThickness
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: progressContainer.height / 1.8 - lineThickness * 1.5 / 2 - 12 - (4 - index) * 12  // позиция от центра вверх
                        color: {
                            if (disabled) return Style.borderDisabled
                            // Подсвечиваем если отклонение положительное (выше среднего)
                            if (normalizedDeviation <= 0) return "white"
                            // Линии идут от центра наружу: 4-я, 3-я, 2-я, 1-я
                            var lineThreshold = (4 - index) / 4.0  // 1.0, 0.75, 0.5, 0.25
                            return normalizedDeviation >= lineThreshold ? (isUnreliable ? unreliableLineColor : normalLineColor) : "white"
                        }
                    }
                }
                
                // Центральная большая линия (загорается при отклонении)
                Rectangle {
                    width: progressContainer.width * 0.8
                    height: lineThickness * 1.5
                    anchors.centerIn: progressContainer
                    
                    color: {
                        if (disabled) return Style.borderDisabled
                        if (Math.abs(normalizedDeviation) < 0.01) return "white" // почти центр
                        return isUnreliable ? unreliableLineColor : normalLineColor
                    }
                }
                
                // 4 линии снизу (для отрицательных отклонений - ниже среднего)
                Repeater {
                    model: 4
                    Rectangle {
                        width: progressContainer.width * 0.5
                        height: lineThickness
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: progressContainer.height / 2 + lineThickness * 1.5 / 2 + 12 + index * 12  // позиция от центра вниз
                        color: {
                            if (disabled) return Style.borderDisabled
                            // Подсвечиваем если отклонение отрицательное (ниже среднего)
                            if (normalizedDeviation >= 0) return "white"
                            // Линии идут от центра наружу: 1-я, 2-я, 3-я, 4-я
                            var lineThreshold = (index + 1) / 4.0  // 0.25, 0.5, 0.75, 1.0
                            var absDeviation = Math.abs(normalizedDeviation)
                            return absDeviation >= lineThreshold ? (isUnreliable ? unreliableLineColor : normalLineColor) : "white"
                        }
                    }
                }
            
            // Верхняя половина для инкремента
            MouseArea {
                width: parent.width
                height: parent.height / 2
                enabled: !disabled
                onClicked: changeValue(1)
            }
            
            // Нижняя половина для декремента
            MouseArea {
                y: parent.height / 2
                width: parent.width
                height: parent.height / 2
                enabled: !disabled
                onClicked: changeValue(-1)
            }
        }
        
        // Кнопка декремента (вниз - уменьшение)
        Rectangle {
            id: decrementButton
            width: parent.width * 0.6
            height: parent.width * 0.6
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            
            // Треугольник вниз
            Canvas {
                anchors.centerIn: parent
                width: progressContainer.width * 0.5 - 2
                height: progressContainer.width * 0.5 - 2
                
                property color triangleColor: {
                    if (disabled) return Style.borderDisabled
                    if (normalizedDeviation < 0) return isUnreliable ? unreliableLineColor : normalLineColor
                    return "transparent"
                }
                property real lineThickness: root.lineThickness
                
                onTriangleColorChanged: requestPaint()
                Component.onCompleted: requestPaint()
                onLineThicknessChanged: requestPaint()
                
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    
                    // Учитываем толщину линии для корректного размещения внутри границ
                    var offset = lineThickness / 2
                    
                    ctx.fillStyle = triangleColor
                    ctx.beginPath()
                    ctx.moveTo(offset, offset)
                    ctx.lineTo(width - offset, offset)
                    ctx.lineTo(width / 2, height - offset)
                    ctx.closePath()
                    ctx.fill()
                    
                    // Черный бордер
                    ctx.strokeStyle = "white"
                    ctx.lineWidth = lineThickness
                    ctx.stroke()
                }
            }
            
            MouseArea {
                anchors.fill: parent
                enabled: !disabled
                onClicked: changeValue(-1)
            }
        }
    }
    
    // Текст со значением (опционально)
    // Text {
    //     anchors.left: parent.right
    //     anchors.leftMargin: 4
    //     anchors.verticalCenter: parent.verticalCenter
    //     text: value.toFixed(0)
    //     font.pixelSize: fontSize
    //     color: !disabled ? fontColor : Style.textDisabled
    //     font.family: Style.fontFamily
    // }
} 
