import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 6.0

Rectangle {
    id: playerPage
    color: "#000000"
    
    property url currentSource: "qrc:/src/IPTV Pro.mp4"
    property bool isPlaying: false
    property bool isPaused: false
    property bool showControls: true
    property bool showMiniPlayer: false
    property real playbackPosition: 0.3
    property real bufferedPosition: 0.7
    property real overlayOpacity: showControls ? 1.0 : 0.0
    
    Behavior on overlayOpacity {
        NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
    }
    
    Timer {
        id: autoHideTimer
        interval: 3000
        running: false // Disabled auto-hide for now
        onTriggered: showControls = false
    }
    
    Timer {
        id: placeholderDelayTimer
        interval: 350
        onTriggered: {
            if (videoPlayer.playbackState === MediaPlayer.StoppedState) {
                fallbackRect.visible = true
            }
        }
    }
    
    function resetAutoHide() {
        showControls = true
        autoHideTimer.restart()
    }
    
    function retryPlayback() {
        videoPlayer.source = currentSource
        videoPlayer.play()
        fallbackRect.visible = false
    }
    
    Rectangle {
        id: videoArea
        anchors.fill: parent
        color: "#000000"
        
        Video {
            id: videoPlayer
            anchors.fill: parent
            source: currentSource
            autoPlay: true
            loops: MediaPlayer.Once
            focus: false
            
            property bool mockPlaying: isPlaying && !isPaused
            
            onMockPlayingChanged: {
                if (mockPlaying) {
                    play()
                } else {
                    pause()
                }
            }
            
            onErrorOccurred: function(error, errorString) {
                console.log("Video error:", errorString)
                playerError.showError("network", "Playback Error", errorString)
            }
            
            onPlaybackStateChanged: {
                if (playbackState === MediaPlayer.StoppedState) {
                    placeholderDelayTimer.start()
                } else if (playbackState === MediaPlayer.PlayingState) {
                    fallbackRect.visible = false
                    placeholderDelayTimer.stop()
                    isPlaying = true
                } else if (playbackState === MediaPlayer.PausedState) {
                    isPlaying = false
                }
            }
            
            opacity: (playbackState === MediaPlayer.PlayingState || 
                     playbackState === MediaPlayer.PausedState) ? 1.0 : 0.0
            
            Behavior on opacity {
                NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
            }
        }
        
        Rectangle {
            id: fallbackRect
            anchors.centerIn: parent
            width: Math.min(parent.width * 0.8, parent.height * 1.78)
            height: width / 1.78
            color: "#181818"
            radius: 8
            visible: currentSource === "" || 
                    videoPlayer.playbackState === MediaPlayer.StoppedState
            
            opacity: visible ? 1.0 : 0.0
            
            Behavior on opacity {
                NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
            }
            
            Text {
                anchors.centerIn: parent
                text: "📺 Video Stream\n(IPTV Pro Test Video)"
                font.pixelSize: 20
                color: "#ffffff"
                opacity: 0.7
                horizontalAlignment: Text.AlignHCenter
            }
        }
        
        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: isPaused ? 0.4 : 0.0
            
            Behavior on opacity {
                NumberAnimation { duration: 250 }
            }
            
            Text {
                anchors.centerIn: parent
                text: "⏸"
                font.pixelSize: 120
                color: "#FFFFFF"
                opacity: isPaused ? 0.8 : 0.0
                scale: isPaused ? 1.0 : 0.8
                
                Behavior on opacity {
                    NumberAnimation { duration: 300 }
                }
                
                Behavior on scale {
                    NumberAnimation { duration: 300; easing.type: Easing.OutBack }
                }
            }
        }
    }
    
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 200
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.7; color: "#33000000" }
            GradientStop { position: 1.0; color: "#66000000" }
        }
        opacity: 1.0
        z: -1 // Put behind controls
        
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }
    }
    
    // Test rectangle to verify positioning
    Rectangle {
        id: testRect
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        color: "#E50914"
        opacity: 0.8
        z: 15
        
        Text {
            anchors.centerIn: parent
            text: "PLAYER CONTROLS SHOULD BE HERE"
            color: "white"
            font.pixelSize: 20
            font.bold: true
        }
    }
    
    PlayerControls {
        id: playerControls
        anchors.fill: parent
        opacity: 1.0
        visible: true
        z: 10
        
        isPlaying: playerPage.isPlaying
        playbackPosition: playerPage.playbackPosition
        bufferedPosition: playerPage.bufferedPosition
        
        onTogglePlay: {
            playerPage.isPaused = !playerPage.isPaused
            playerPage.isPlaying = !playerPage.isPaused
            videoPlayer.mockPlaying = playerPage.isPlaying && !playerPage.isPaused
            resetAutoHide()
        }
        
        onShowInfo: {
            playerInfoBar.slideIn()
            resetAutoHide()
        }
        
        onZapUp: {
            zapOverlay.show()
            resetAutoHide()
        }
        
        onZapDown: {
            zapOverlay.show()
            resetAutoHide()
        }
        
        onTogglePiP: {
            pipController.visible = !pipController.visible
            resetAutoHide()
        }
        
        onShowMultiView: {
            multiView.visible = true
            multiView.enterMultiView()
            resetAutoHide()
        }
        
        onBackPressed: {
            if (typeof navigateTo !== "undefined") {
                navigateTo("/home")
            } else {
                console.log("Back button pressed - navigate to home")
            }
        }
        
        onShowError: {
            playerError.showError("network", "Connection Error", "Unable to connect to video stream. Please check your internet connection and try again.")
            resetAutoHide()
        }
        
        onToggleRecording: {
            recordBadge.toggleRecording()
            resetAutoHide()
        }
    }
    
    PlayerInfoBar {
        id: playerInfoBar
        anchors.fill: parent
        visible: false
    }
    
    ZapOverlay {
        id: zapOverlay
        anchors.fill: parent
        visible: false
    }
    
    PipController {
        id: pipController
        anchors.fill: parent
        visible: false
    }
    
    MultiView {
        id: multiView
        anchors.fill: parent
        visible: false
    }
    
    RecordBadge {
        id: recordBadge
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        visible: false
    }
    
    PlayerError {
        id: playerError
        anchors.fill: parent
        visible: false
        
        onRetry: {
            retryPlayback()
        }
        
        onBack: {
            if (typeof navigateTo !== "undefined") {
                navigateTo("/home")
            }
        }
        
        onChangeSource: {
            console.log("Changing source...")
        }
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        
        onPositionChanged: {
            resetAutoHide()
        }
        
        onClicked: {
            resetAutoHide()
        }
    }
    
    Keys.onPressed: function(event) {
        resetAutoHide()
        
        switch(event.key) {
            case Qt.Key_Space:
                playerPage.isPaused = !playerPage.isPaused
                playerPage.isPlaying = !playerPage.isPaused
                videoPlayer.mockPlaying = playerPage.isPlaying && !playerPage.isPaused
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
            case Qt.Key_I:
                playerInfoBar.slideIn()
                event.accepted = true
                break
            case Qt.Key_S:
                playerError.showError("stats", "Stats", "Resolution: 1920x1080\nFPS: 30\nBitrate: 5 Mbps")
                event.accepted = true
                break
            case Qt.Key_M:
                multiView.visible = true
                multiView.enterMultiView()
                event.accepted = true
                break
            case Qt.Key_P:
                pipController.visible = !pipController.visible
                event.accepted = true
                break
            case Qt.Key_R:
                recordBadge.toggleRecording()
                event.accepted = true
                break
            case Qt.Key_Escape:
            case Qt.Key_Back:
                if (playerInfoBar.isVisible) {
                    playerInfoBar.slideOut()
                } else if (multiView.visible) {
                    multiView.exitMultiView()
                } else if (playerError.visible) {
                    playerError.hideError()
                } else {
                    console.log("Exit player")
                }
                event.accepted = true
                break
        }
    }
    
    Component.onCompleted: {
        opacity = 0.0
        fadeInAnimation.start()
        forceActiveFocus()
        
        // Ensure controls are visible
        showControls = true
        overlayOpacity = 1.0
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