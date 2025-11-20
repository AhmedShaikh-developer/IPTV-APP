import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: playerControls
    color: "transparent"
    
    // CRITICAL: Force size and visibility
    width: parent ? parent.width : 1366
    height: 160
    implicitHeight: 160
    implicitWidth: 1366
    
    // FORCE VISIBLE - ALWAYS ALWAYS ALWAYS
    visible: true
    opacity: 1.0
    enabled: true
    z: 1000
    
    // Override any bindings that might hide this
    Component.onCompleted: {
        playerControls.visible = true
        playerControls.opacity = 1.0
        console.log("PlayerControls FORCED visible in component")
    }
    
    property bool isPlaying: false
    property real playbackPosition: 0.3
    property real bufferedPosition: 0.7
    property bool isSeeking: false
    property string currentTime: "00:00"
    property string totalTime: "00:00"
    property real volume: 100
    property bool muted: false
    
    signal togglePlay()
    signal stopRequested()
    signal showInfo()
    signal zapUp()
    signal zapDown()
    signal togglePiP()
    signal showMultiView()
    signal backPressed()
    signal showError()
    signal toggleRecording()
    signal seekStart()
    signal seekEnd()
    signal seekTo(real position)
    signal setVolume(real volume)
    signal toggleMute()
    signal anyUserAction()
    
    Behavior on opacity {
        NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
    }
    
    Rectangle {
        id: controlsBar
        anchors.fill: parent
        anchors.margins: 10
        height: 140
        radius: 12
        color: "#F0000000" // Very opaque black background (94% opacity) - clearly visible
        opacity: 1.0 // Fully opaque
        visible: true // Always visible
        z: 10001 // Even higher z-order
        border.color: "#FF0000" // RED border so it's VERY visible for debugging
        border.width: 3
        
        Component.onCompleted: {
            console.log("========== CONTROLS BAR LOADED ==========")
            console.log("ControlsBar width:", width, "height:", height)
            console.log("ControlsBar x:", x, "y:", y)
            console.log("ControlsBar color:", color, "opacity:", opacity)
            console.log("==========================================")
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16
            Layout.alignment: Qt.AlignHCenter
            
            // Progress bar
            Rectangle {
                id: progressContainer
                Layout.fillWidth: true
                Layout.preferredHeight: 6
                color: "#333333"
                radius: 3
                
                Rectangle {
                    id: buffered
                    width: parent.width * playerControls.bufferedPosition
                    height: parent.height
                    color: "#777777"
                    radius: parent.radius
                }
                
                Rectangle {
                    id: progress
                    width: parent.width * playerControls.playbackPosition
                    height: parent.height
                    color: "#E50914"
                    radius: parent.radius
                }
                
                Rectangle {
                    id: thumb
                    x: progress.width - width/2
                    y: parent.height/2 - height/2
                    width: 10
                    height: 10
                    radius: 5
                    color: "#FFFFFF"
                    visible: false
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: thumb.scale = 1.2
                        onExited: thumb.scale = 1.0
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        thumb.visible = true
                        thumb.scale = 1.0
                    }
                    onExited: {
                        if (!isSeeking) {
                            thumb.visible = false
                        }
                    }
                    onPressed: {
                        isSeeking = true
                        seekStart()
                        anyUserAction()
                        thumb.visible = true
                    }
                    onReleased: {
                        isSeeking = false
                        seekEnd()
                        anyUserAction()
                        if (!containsMouse) {
                            thumb.visible = false
                        }
                    }
                    onPositionChanged: {
                        if (pressed) {
                            var newPos = mouseX / width
                            // Mock seek functionality
                            console.log("Seek to:", newPos)
                        }
                    }
                    onClicked: {
                        var newPos = mouseX / width
                        // Mock seek functionality
                        console.log("Seek to:", newPos)
                    }
                }
            }
            
            // Control buttons row - properly centered with top margin
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 56
                Layout.topMargin: 20
                
                Row {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 10
                    spacing: 32
                
                // Back button
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: "#0D0D0DB3"
                    border.color: "#333333"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "←"
                        color: "#FFFFFF"
                        font.pixelSize: 24
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.scale = 1.1
                        onExited: parent.scale = 1.0
                        onClicked: {
                            playerControls.backPressed()
                            anyUserAction()
                        }
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                
                // Play/Pause button
                Rectangle {
                    width: 56
                    height: 56
                    radius: 28
                    color: playerControls.isPlaying ? "#E50914" : "#0D0D0DB3"
                    border.color: "#333333"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: playerControls.isPlaying ? "⏸" : "▶"
                        color: "#FFFFFF"
                        font.pixelSize: 28
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.scale = 1.1
                        onExited: parent.scale = 1.0
                        onClicked: {
                            playerControls.togglePlay()
                            anyUserAction()
                        }
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                
                // Time display
                Text {
                    text: "00:30"
                    color: "#FFFFFF"
                    font.pixelSize: 16
                    font.family: "Arial"
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                // Volume button
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: "#0D0D0DB3"
                    border.color: "#333333"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "🔊"
                        color: "#FFFFFF"
                        font.pixelSize: 24
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.scale = 1.1
                        onExited: parent.scale = 1.0
                        onClicked: {
                            anyUserAction()
                        }
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                
                // Record button
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: "#0D0D0DB3"
                    border.color: "#333333"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "●"
                        color: "#E50914"
                        font.pixelSize: 24
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.scale = 1.1
                        onExited: parent.scale = 1.0
                        onClicked: {
                            playerControls.toggleRecording()
                            anyUserAction()
                        }
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                
                // PiP button
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: "#0D0D0DB3"
                    border.color: "#333333"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "⊞"
                        color: "#FFFFFF"
                        font.pixelSize: 24
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.scale = 1.1
                        onExited: parent.scale = 1.0
                        onClicked: {
                            playerControls.togglePiP()
                            anyUserAction()
                        }
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                
                // MultiView button
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: "#0D0D0DB3"
                    border.color: "#333333"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "⊡"
                        color: "#FFFFFF"
                        font.pixelSize: 24
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.scale = 1.1
                        onExited: parent.scale = 1.0
                        onClicked: {
                            playerControls.showMultiView()
                            anyUserAction()
                        }
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                
                // Info button
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: "#0D0D0DB3"
                    border.color: "#333333"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "ⓘ"
                        color: "#FFFFFF"
                        font.pixelSize: 24
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.scale = 1.1
                        onExited: parent.scale = 1.0
                        onClicked: {
                            playerControls.showInfo()
                            anyUserAction()
                        }
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                
                // Settings button
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: "#0D0D0DB3"
                    border.color: "#333333"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "⚙"
                        color: "#FFFFFF"
                        font.pixelSize: 24
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.scale = 1.1
                        onExited: parent.scale = 1.0
                        onClicked: {
                            anyUserAction()
                        }
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                }
            }
        }
    }
}