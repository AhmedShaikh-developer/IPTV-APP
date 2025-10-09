pragma Singleton
import QtQuick 2.15

QtObject {
    // Netflix-like color tokens
    readonly property color bg: "#000000"
    readonly property color surface: "#141414"
    readonly property color surfaceVariant: "#181818"
    readonly property color text: "#ffffff"
    readonly property color textSecondary: "#b3b3b3"
    readonly property color textTertiary: "#564d4d"
    readonly property color accent: "#e50914"
    readonly property color accentHover: "#f40612"
    readonly property color border: "#2f2f2f"
    readonly property color borderLight: "#564d4d"
    
    // Spacing tokens
    readonly property int spacing1: 4
    readonly property int spacing2: 8
    readonly property int spacing3: 12
    readonly property int spacing4: 16
    readonly property int spacing5: 20
    readonly property int spacing6: 24
    readonly property int spacing8: 32
    readonly property int spacing10: 40
    readonly property int spacing12: 48
    
    // Radius tokens
    readonly property int radiusSmall: 4
    readonly property int radiusMedium: 8
    readonly property int radiusLarge: 12
    readonly property int radiusFull: 9999
    
    // Shadow tokens (as color with opacity)
    readonly property color shadowLight: "#33000000"
    readonly property color shadowMedium: "#66000000"
    readonly property color shadowHeavy: "#99000000"
    
    // Typography scale
    readonly property int fontXs: 12
    readonly property int fontSm: 14
    readonly property int fontBase: 16
    readonly property int fontLg: 18
    readonly property int fontXl: 20
    readonly property int font2Xl: 24
    readonly property int font3Xl: 30
    readonly property int font4Xl: 36
    readonly property int font5Xl: 48
}

