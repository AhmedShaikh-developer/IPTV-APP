pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property color accent: "#E50914"
    readonly property color overlayBg: "#0D0D0DB3"
    readonly property color controlBg: "#0B0B0BE0"
    readonly property color glass: "#1A1A1A99"
    readonly property color controlPill: "#1E1E1E"
    readonly property color controlPillHover: "#262626"
    readonly property color controlPillActive: "#2E2E2E"
    readonly property color textPrimary: "#FFFFFF"
    readonly property color textMuted: "#B3B3B3"
    readonly property color success: "#12B886"
    readonly property color warning: "#F59F00"
    readonly property color error: "#FF4D4F"
    readonly property color trackColor: "#404040"
    readonly property color bufferedColor: "#666666"
    
    // Home screen colors
    readonly property color backgroundPrimary: "#0D0D0D"
    readonly property color backgroundSecondary: "#1A1A1A"
    readonly property color cardBg: "#111111"
    readonly property real cardRadius: 12
    readonly property real cardShadow: 20
    
    readonly property int radiusSm: 6
    readonly property int radiusMd: 10
    readonly property int radiusLg: 12
    
    readonly property real blurStrength: 20
    readonly property real shadowOpacity: 0.3
    
    readonly property int transitionFast: 150
    readonly property int transitionMedium: 250
    readonly property int transitionSlow: 300
    readonly property int delayedFade: 350
    
    readonly property int controlHeight: 48
    readonly property int controlBarHeight: 120
    readonly property int progressBarHeight: 4
}

