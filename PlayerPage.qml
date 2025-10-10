import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 6.0

Rectangle {
    id: playerPage
    color: "#000000"
    
    // Player state properties
    property bool isPlaying: true
    property bool isPaused: false
    property bool showControls: true
    property bool showMiniPlayer: false
    property real playbackPosition: 0.3
    property real bufferedPosition: 0.7
    
    // Animation properties
    property real overlayOpacity: 1.0
    
    // Video area with safe margins for overlays
    Rectangle {
        id: videoArea
        anchors.fill: parent
        color: "#000000"
        
        // Blurred background gradient
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#1a0000" }
                GradientStop { position: 0.5; color: "#000000" }
                GradientStop { position: 1.0; color: "#000000" }
            }
            opacity: 0.8
        }
        
        // Pause overlay
        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: isPaused ? 0.3 : 0.0
            
            Behavior on opacity {
                NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
            }
        }
        
        // Video player with local test video
        Video {
            id: videoPlayer
            anchors.fill: parent
            source: "qrc:/src/IPTV Pro.mp4"
            autoPlay: false
            loops: MediaPlayer.Once
            
            // Video controls (hidden, controlled by overlays)
            focus: false
            
            // Mock playback state
            property bool mockPlaying: isPlaying && !isPaused
            property real mockPosition: playbackPosition
            property real mockBuffered: bufferedPosition
            
            // Update mock state based on player state
            onMockPlayingChanged: {
                if (mockPlaying) {
                    play()
                } else {
                    pause()
                }
            }
            
            // Mock seek functionality
            function mockSeek(position) {
                playbackPosition = position
                seek(position * duration)
            }
            
            // Fallback if video fails to load
            onErrorOccurred: function(error, errorString) {
                console.log("Video error:", errorString)
                // Show placeholder if video fails
                fallbackRect.visible = true
            }
            
            // Fallback rectangle
            Rectangle {
                id: fallbackRect
                anchors.centerIn: parent
                width: Math.min(parent.width * 0.8, parent.height * 1.78) // 16:9 aspect
                height: width / 1.78
                color: "#181818"
                radius: 8
                visible: false
                
                Text {
                    anchors.centerIn: parent
                    text: "📺 Video Stream\n(IPTV Pro Test Video)"
                    font.pixelSize: 20
                    color: "#ffffff"
                    opacity: 0.7
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
    
    // Bottom fade mask for controls legibility
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 120
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: "#000000" }
        }
        opacity: showControls ? 0.8 : 0.0
        
        Behavior on opacity {
            NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
        }
    }
    
    // Player Controls Overlay
    PlayerControls {
        id: playerControls
        anchors.fill: parent
        visible: showControls
        opacity: overlayOpacity
        
        onTogglePlay: {
            isPaused = !isPaused
            isPlaying = !isPaused
            // Update video player
            videoPlayer.mockPlaying = isPlaying && !isPaused
        }
        
        onShowInfo: {
            playerInfoBar.visible = true
            playerInfoBar.slideIn()
        }
        
        onZapUp: {
            zapOverlay.show()
            zapOverlay.zapUp()
        }
        
        onZapDown: {
            zapOverlay.show()
            zapOverlay.zapDown()
        }
        
        onTogglePiP: {
            pipController.togglePiP()
        }
        
        onShowMultiView: {
            multiView.visible = true
            multiView.enterMultiView()
        }
        
        onBackPressed: {
            if (showMiniPlayer) {
                showMiniPlayer = false
            } else {
                showMiniPlayer = true
            }
        }
        
        onShowError: {
            playerError.showError("network", "Connection Error", "Unable to connect to video stream. Please check your internet connection and try again.")
        }
        
        onToggleRecording: {
            if (recordBadge.isRecording) {
                recordBadge.stopRecording()
            } else {
                recordBadge.startRecording()
            }
        }
    }
    
    // Player Info Bar
    PlayerInfoBar {
        id: playerInfoBar
        anchors.fill: parent
        visible: false
    }
    
    // Zap Overlay
    ZapOverlay {
        id: zapOverlay
        anchors.fill: parent
        visible: false
    }
    
    // PiP Controller
    PipController {
        id: pipController
        anchors.fill: parent
        visible: false
    }
    
    // Multi View
    MultiView {
        id: multiView
        anchors.fill: parent
        visible: false
    }
    
    // Record Badge
    RecordBadge {
        id: recordBadge
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        visible: false
    }
    
    // Player Error Overlay
    PlayerError {
        id: playerError
        anchors.fill: parent
        visible: false
        
        onRetry: {
            // Retry playback logic
            console.log("Retrying playback...")
        }
        
        onBack: {
            playerError.visible = false
        }
        
        onChangeSource: {
            playerError.visible = false
            // Navigate to source selection
        }
    }
    
    // Mini Player Preview (when BACK is pressed)
    Rectangle {
        id: miniPlayerPreview
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        color: "#141414"
        visible: showMiniPlayer
        opacity: showMiniPlayer ? 1.0 : 0.0
        
        Behavior on opacity {
            NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
        }
        
        Behavior on height {
            NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
        }
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 15
            
            Rectangle {
                width: 100
                height: 56
                radius: 4
                color: "#2f2f2f"
                
                Text {
                    anchors.centerIn: parent
                    text: "📺"
                    font.pixelSize: 24
                    color: "#ffffff"
                }
            }
            
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                
                Text {
                    text: "BBC News HD"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#ffffff"
                }
                
                Text {
                    text: "BBC News at 10"
                    font.pixelSize: 14
                    color: "#b3b3b3"
                }
            }
            
            Button {
                text: "▶️"
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                background: Rectangle {
                    color: "#2f2f2f"
                    radius: 20
                }
                onClicked: showMiniPlayer = false
            }
        }
    }
    
    // Auto-hide controls timer
    Timer {
        id: controlsTimer
        interval: 4000
        running: showControls && isPlaying
        repeat: false
        onTriggered: {
            if (showControls) {
                overlayOpacity = 0.0
                showControls = false
            }
        }
    }
    
    // Mouse area for showing controls
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            showControls = true
            overlayOpacity = 1.0
            controlsTimer.restart()
        }
        
        onPositionChanged: {
            if (showControls) {
                controlsTimer.restart()
            }
        }
    }
    
    // Keyboard shortcuts
    Keys.onPressed: function(event) {
        switch(event.key) {
            case Qt.Key_Space:
                isPaused = !isPaused
                isPlaying = !isPaused
                event.accepted = true
                break
            case Qt.Key_Escape:
                if (showMiniPlayer) {
                    showMiniPlayer = false
                } else {
                    showMiniPlayer = true
                }
                event.accepted = true
                break
            case Qt.Key_Up:
                zapOverlay.show()
                zapOverlay.zapUp()
                event.accepted = true
                break
            case Qt.Key_Down:
                zapOverlay.show()
                zapOverlay.zapDown()
                event.accepted = true
                break
            case Qt.Key_Return:
            case Qt.Key_Enter:
                playerInfoBar.visible = true
                playerInfoBar.slideIn()
                event.accepted = true
                break
            case Qt.Key_I:
                playerInfoBar.visible = true
                playerInfoBar.slideIn()
                event.accepted = true
                break
            case Qt.Key_E:
                playerError.showError("network", "Connection Error", "Unable to connect to video stream. Please check your internet connection and try again.")
                event.accepted = true
                break
            case Qt.Key_R:
                if (recordBadge.isRecording) {
                    recordBadge.stopRecording()
                } else {
                    recordBadge.startRecording()
                }
                event.accepted = true
                break
            case Qt.Key_M:
                multiView.visible = true
                multiView.enterMultiView()
                event.accepted = true
                break
            case Qt.Key_P:
                pipController.togglePiP()
                event.accepted = true
                break
        }
    }
    
    focus: true
    
    // Fade-in animation when entering
    Component.onCompleted: {
        opacity = 0.0
        fadeInAnimation.start()
    }
    
    NumberAnimation {
        id: fadeInAnimation
        target: playerPage
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 300
        easing.type: Easing.InOutQuad
    }
}
