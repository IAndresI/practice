import QtQuick 2.9

import "qrc:/"

Text {
    property bool down: false
    property bool accent : false
    height:implicitHeight
    clip: true
    font.family: Style.fontFamily
    font.pointSize: Style.FontPixelSize.Normal
    color: enabled ? down || accent ? Style.borderActive : Style.textEnabled: Style.textDisabled
    padding: 0
    verticalAlignment: Text.AlignVCenter
    fontSizeMode: Text.VerticalFit
    lineHeightMode: Text.FixedHeight
    lineHeight: font.pointSize + Style.fontLeading
    minimumPointSize: font.pointSize
}

