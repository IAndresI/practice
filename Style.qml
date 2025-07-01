pragma Singleton
import QtQuick 2.0

QtObject{
    enum ButtonWidth{
        Normal = 80,
        Long = 120,
        ToLong = 160
    }

    enum ScrollBarSize{
        Normal = 40,
        Big = 60
    }

    function setStateColor(state) {
        switch (state) {
        case 0: return "#0cbf00"
        case 1: return "#f2ea00"
        case 2: return "#f20000"
        default: return foreground
        }
    }

    function setTextColor(state) {
        switch (state) {
        case 0: return textWhite
        case 1: return textEnabled
        case 2: return textWhite
        default: return textEnabled
        }
    }

    function setTextOnlyRed(state) {
        switch (state) {
        case 0: return textEnabled
        case 1: return textEnabled
        case 2: return "#f20000"
        default: return textEnabled
        }
    }

    function setGradientTopColor(state) {
        switch (state) {
        case 0: return "#0ed900"
        case 1: return "#fff700"
        case 2: return "#ff0000"
        default: return "#f2f2f2"
        }
    }

    function setGradientBottomColor(state) {
        switch (state) {
        case 0: return "#0aa600"
        case 1: return "#e5dd00"
        case 2: return "#cc0000"
        default: return "#cccccc"
        }
    }

    property bool coursePopupVisible : false
    property bool placePopupVisible : false

    property int buttonHeight: 80
    property int radius: 5

    property color textEnabled : "#333333"
    property color textDisabled : "#8c8c8c"
    property color textWhite: "#f2f2f2"

    property color borderEnabled : "#333333"
    property color borderDisabled : "#8c8c8c"
    property color borderActive : "#15999e"

    property color foreground : "#e5e5e5"
    property color foregroundDisabled : "#d9d9d9"

    property color shadowColor: "#8c8c8c"

    property color separatorColor: "#656565"
    property int shadowOffset:2
    property int frameOffset: 14

    property color background: "#f2f2f2" // Anna Для Операторов фон панелей

    property int iconSize : 20

    property int animationDuration : 200

    property int comboBoxWidth : 270

    property int checkBoxSize : 40

    property int checkBoxIconSize : 30

    property int comboBoxMenuWidth: 270

    property int separatorWidth: 2

    property int tabButonRealHeight : 70

    property int tabButtonWidth : 120

    property int tabButtonRadius : 10

    property int clickArea : 60

    property int dialogWindowCaptionHeight : 70

    property int schemeSingle : 40
    property int schemeMulti : 30
    property int schemeWidth : 120

    property color colorCPCI : "#ff9800"
    property color colorEthernet : "#00b0ff"
    property color colorCOM : "#9c27b0"
    property color colorIRPS : "black"
    property color colorManch : "#303f9f"

    enum InsidePadding{
        Small = 4,
        Middle = 8,
        Big = 20
    }

    enum OutsidePadding{
        Small = 16,
        Normal = 20,
        Group = 40
    }

    enum FrameLine {
        Internal = 2,
        External = 1
    }

    enum FontPixelSize{
        Normal = 18,
        Level1 = 22,
        Level2 = 20,
        Tips = 16
    }

    property int fontLeading : 10

    property string fontFamily : /*"Noto Mono"//*/"Arial"

    property int windowWidth: 1920
    property int windowHeight: 1080

    property int drawerWidth: 600
    property int windowStaticHeight: 120
    property int drawerHeight: windowHeight-windowStaticHeight
    property int drawerWidthSmall : windowStaticHeight*windowWidth/windowHeight
    property int windowImageWidth : windowWidth-drawerWidthSmall
    property int globalMargin : Style.OutsidePadding.Normal
    property int globalSpacing: Style.OutsidePadding.Normal - Style.frameOffset

    function setColorMonoTextOperators(number) {
        switch (number) {
        case 0: return "#ffffff"
        case 1: return "#f2f2f2"
        case 2: return "#e5e5e5"
        case 3: return "#d9d9d9"
        case 4: return "#cccccc"
        case 5: return "#bfbfbf"
        case 6: return "#b3b3b3"
        case 7: return "#a6a6a6"
        case 8: return "#999999"
        case 9: return "#8c8c8c"
        case 10: return "#808080"
        case 11: return "#737373"
        case 12: return "#666666"
        case 13: return "#595959"
        case 14: return "#4d4d4d"
        case 15: return "#404040"
        case 16: return "#333333"
        case 17: return "#262626"
        case 18: return "#1a1a1a"
        case 19: return "#0d0d0d"
        case 20: return "#000000"
        default: return "#f2f2f2"
        }
    }

    property int colorTextOperator:  1
    property int colorBackgroundOperator: 20
    property int colorBorderOperator: 1
    property int transparentBackground: 0
    property int transparentBorder: 255
    property int widthBorderOperator: separatorWidth
    property int fontSizeOperator: 14
    property int offsetXTable: 30
    property int offsetYTable: 30

}
