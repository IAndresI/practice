import QtQuick 2.15

/* CompassScale – горизонтальная компас‑линейка.*/

Item {
    id: root
    z: 10

    // Входные параметры
    property real value: 0  // текущее значение прибора
    property int fontSize: 28 // базовый размер
    property color backgroundColor: "#000000" // фон
    property color tickColor: "#ffffff" // штрихи и подписи
    property color indicatorColor: "#ff0000" // центральная палочка
    property color valueTextColor: tickColor // цвет значения под палочкой

    property color labelColor: tickColor // цвет числовых подписей по шкале
    property real  tickLineWidth: 2 // толщина штрихов шкалы
    property real  indicatorLineWidth: 3 // толщина центральной палочки

    property real  degreesInView: 120 // охват по горизонтали

    implicitWidth: 960
    height: fontSize * 3 + fontSize * 1.8

    readonly property real pxPerDeg: width / degreesInView

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            const fs = root.fontSize
            const ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            /* ── фон ── */
            ctx.fillStyle = backgroundColor;
            ctx.fillRect(0, 0, width, height);

            /* ── деления и цифры ── */
            ctx.strokeStyle = tickColor;
            ctx.lineWidth   = tickLineWidth;
            ctx.fillStyle   = labelColor;
            ctx.font = (fs * 0.9) + "px sans-serif";
            ctx.textAlign = "center";
            ctx.textBaseline = "top";

            const startDeg = value - degreesInView / 2;
            const endDeg = value + degreesInView / 2;
            let deg = Math.floor(startDeg / 5) * 5;

            for (; deg <= endDeg; deg += 5) {
                const x = (deg - startDeg) * pxPerDeg;
                const n = ((deg % 360) + 360) % 360;
                const major = (n % 20 === 0);
                const tickH = major ? height * 0.35 : height * 0.2;

                ctx.beginPath();
                ctx.moveTo(x, 0);
                ctx.lineTo(x, tickH);
                ctx.stroke();
                if (major) ctx.fillText(String(n), x, tickH + 4);
            }

            //центральная палочка
            const cx = width / 2;
            ctx.strokeStyle = indicatorColor;
            ctx.lineWidth = indicatorLineWidth;
            ctx.beginPath();
            ctx.moveTo(cx, 0);
            ctx.lineTo(cx, height - fontSize * 1.4 - 4);
            ctx.stroke();

            // подпись текущего значения
            ctx.fillStyle = valueTextColor;
            ctx.textBaseline = "bottom";
            ctx.font = "bold " + (fs * 1.2) + "px sans-serif";
            const current = ((Math.round(value) % 360) + 360) % 360;
            ctx.fillText(String(current), cx, height);
        }
        Component.onCompleted: requestPaint();
    }

    function repaint() { canvas.requestPaint(); }

    onValueChanged:            repaint();
    onWidthChanged:            repaint();
    onFontSizeChanged:         repaint();
    onBackgroundColorChanged:  repaint();
    onTickColorChanged:        repaint();
    onDegreesInViewChanged:    repaint();
    onIndicatorColorChanged:   repaint();
    onValueTextColorChanged:   repaint();
}
