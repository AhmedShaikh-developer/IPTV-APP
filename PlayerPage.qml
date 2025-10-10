import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 6.0

Rectangle {
    id: playerPage
    color: "#000000"
    
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
        running: showControls && isPlaying
        onTriggered: showControls = false
    }
    
    function resetAutoHide() {
        showControls = true
        autoHideTimer.restart()
    }
    
    Rectangle {
        id: videoArea
        anchors.fill: parent
        color: "#000000"
        
        Video {
            id: videoPlayer
            anchors.fill: parent
            source: "qrc:/src/IPTV Pro.mp4"
            autoPlay: false
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
                fallbackRect.visible = true
            }
            
            Rectangle {
                id: fallbackRect
                anchors.centerIn: parent
                width: Math.min(parent.width * 0.8, parent.height * 1.78)
                height: width / 1.78
                color: "#181818"
                radius: 8
                visible: true
                
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
        opacity: showControls ? 1.0 : 0.0
        
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }
    }
    
    PlayerControls {
        id: playerControls
        anchors.fill: parent
        opacity: overlayOpacity
        visible: opacity > 0
        
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
            // Navigate back to home screen
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
            console.log("Retrying playback...")
            videoPlayer.play()
        }
        
        onBack: {
            console.log("Going back...")
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
        
        // Start playing the video after a short delay
        Qt.callLater(function() {
            isPlaying = true
            isPaused = false
            videoPlayer.mockPlaying = true
        })
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
