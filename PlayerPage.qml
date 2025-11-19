import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 6.0
import IPTVBackend 1.0

Rectangle {
    id: playerPage
    color: "#000000"
    
    property url currentSource: "qrc:/src/IPTV Pro.mp4"
    property string streamUrl: ""
    property bool isPlaying: false
    property bool showControls: true
    property bool showMiniPlayer: false
    property real playbackPosition: 0.3
    property real bufferedPosition: 0.7
    property bool isSeeking: false
    property bool isPaused: videoPlayer.playbackState === MediaPlayer.PausedState
    
    onStreamUrlChanged: {
        console.log("=== PlayerPage: streamUrl changed ===")
        console.log("New streamUrl:", streamUrl)
        console.log("streamUrl type:", typeof streamUrl)
        if (streamUrl !== "" && streamUrl !== undefined && streamUrl !== null) {
            console.log("Setting video source to:", streamUrl)
            
            // Ensure URL has proper format
            var urlString = streamUrl
            if (!urlString.startsWith("http://") && !urlString.startsWith("https://") && !urlString.startsWith("qrc:/") && !urlString.startsWith("file://")) {
                urlString = "http://" + urlString
            }
            console.log("Formatted URL string:", urlString)
            
            // Stop current playback first
            videoPlayer.stop()
            
            // Convert string to QUrl - this ensures proper URL handling
            // For M3U8/HLS streams, Qt needs a proper QUrl object
            var urlObj = Qt.resolvedUrl(urlString)
            // If Qt.resolvedUrl doesn't work for HTTP URLs, create URL directly
            if (urlString.startsWith("http://") || urlString.startsWith("https://")) {
                // For HTTP URLs, we must use the string directly as QUrl
                // But ensure it's treated as a proper URL
                console.log("Using HTTP URL string directly:", urlString)
                currentSource = urlString  // Keep as string for HTTP URLs
            } else {
                currentSource = urlObj
            }
            
            console.log("currentSource set to:", currentSource)
            console.log("currentSource type:", typeof currentSource)
            
            // The source binding will automatically update since currentSource changed
            // But also explicitly set it to ensure it updates
            Qt.callLater(function() {
                console.log("Video player source before update:", videoPlayer.source)
                // Force source update - use the string directly for HTTP URLs
                if (urlString.startsWith("http://") || urlString.startsWith("https://")) {
                    videoPlayer.source = urlString
                } else {
                    videoPlayer.source = urlObj
                }
                console.log("Video player source after update:", videoPlayer.source)
                console.log("Video player source toString:", videoPlayer.source.toString())
                
                // Wait a bit more for the source to be fully loaded before playing
                Qt.callLater(function() {
                    console.log("Calling videoPlayer.play() with source:", videoPlayer.source.toString())
                    videoPlayer.play()
                })
            })
        } else {
            console.log("streamUrl is empty, not changing source")
        }
    }
    
    
    Timer {
        id: autoHideTimer
        interval: 3000
        running: showControls && !isPaused && !isSeeking
        onTriggered: {
            showControls = false
        }
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
    
    function revealControls() {
        showControls = true
        autoHideTimer.restart()
    }
    
    function retryPlayback() {
        var source = streamUrl !== "" ? streamUrl : currentSource
        videoPlayer.source = source
        videoPlayer.play()
        fallbackRect.visible = false
    }
    
    Connections {
        target: PlaylistManager
        function onPlayStream(url) {
            console.log("=== PlayerPage: Received playStream signal ===")
            console.log("URL from signal:", url)
            console.log("URL type:", typeof url)
            console.log("URL string:", url.toString ? url.toString() : url)
            
            // Convert QVariant/QString to string if needed
            var urlString = url
            if (typeof url === "object" && url.toString) {
                urlString = url.toString()
            }
            console.log("URL string value:", urlString)
            
            // Set streamUrl - this will trigger onStreamUrlChanged
            streamUrl = urlString
            console.log("streamUrl property set to:", streamUrl)
        }
        
        Component.onCompleted: {
            console.log("=== PlayerPage: Connections to PlaylistManager completed ===")
            console.log("PlaylistManager object:", PlaylistManager)
            console.log("PlaylistManager type:", typeof PlaylistManager)
        }
    }
    
    Rectangle {
        id: videoArea
        anchors.fill: parent
        color: "#000000"
        
        Video {
            id: videoPlayer
            anchors.fill: parent
            // For HTTP/HTTPS URLs, prefer currentSource (which is set from streamUrl)
            // This ensures we use the properly formatted URL
            source: (streamUrl !== "" && streamUrl !== undefined) ? streamUrl : currentSource
            autoPlay: false  // We'll call play() explicitly in onSourceChanged
            loops: MediaPlayer.Once
            focus: true  // Allow focus for keyboard controls
            
            property bool mockPlaying: isPlaying && !isPaused
            
            onSourceChanged: {
                console.log("=== Video source changed ===")
                console.log("New source:", source)
                console.log("Source URL string:", source.toString())
                console.log("Source type:", typeof source)
                var sourceStr = source.toString()
                // Only auto-play if it's a valid URL (not empty and not the default resource)
                if (sourceStr !== "" && sourceStr !== "qrc:/src/IPTV Pro.mp4" && sourceStr !== "undefined") {
                    console.log("New source detected:", sourceStr)
                    // Check if it's an HTTP/HTTPS URL
                    if (sourceStr.startsWith("http://") || sourceStr.startsWith("https://")) {
                        console.log("HTTP URL detected, calling play()...")
                        // Use a small delay to ensure source is fully set and loaded
                        Qt.callLater(function() {
                            console.log("Calling videoPlayer.play() with source:", videoPlayer.source.toString())
                            videoPlayer.play()
                        })
                    } else {
                        console.log("Not an HTTP URL, skipping auto-play")
                    }
                } else {
                    console.log("Source is default or empty, not playing")
                }
            }
            
            onMockPlayingChanged: {
                if (mockPlaying) {
                    play()
                } else {
                    pause()
                }
            }
            
            onErrorOccurred: function(error, errorString) {
                console.error("=== Video error ===")
                console.error("Error code:", error)
                console.error("Error string:", errorString)
                console.error("Source URL:", source)
                playerError.showError("network", "Playback Error", errorString || "Failed to play stream")
            }
            
            onPlaybackStateChanged: {
                console.log("=== Video playback state changed ===")
                console.log("State:", playbackState)
                console.log("Source:", source)
                
                if (playbackState === MediaPlayer.PlayingState) {
                    console.log("✓ Video is now playing!")
                    fallbackRect.visible = false
                    placeholderDelayTimer.stop()
                    isPlaying = true
                } else if (playbackState === MediaPlayer.StoppedState) {
                    console.log("Video stopped")
                    placeholderDelayTimer.start()
                    
                    // Add to history when playback stops
                    var history = parent.parent.parent.parent.readJson("historyJson", [])
                    var historyEntry = {
                        type: "video",
                        id: currentSource.toString(),
                        progress: playbackPosition,
                        ts: Date.now()
                    }
                    
                    // Add to beginning of history
                    history.unshift(historyEntry)
                    
                    // Truncate to max 50 items
                    if (history.length > 50) {
                        history = history.slice(0, 50)
                    }
                    
                    parent.parent.parent.parent.writeJson("historyJson", history)
                } else if (playbackState === MediaPlayer.PausedState) {
                    console.log("Video paused")
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
    
    
    
    PlayerControls {
        id: playerControls
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 24
        opacity: showControls ? 1.0 : 0.0
        visible: showControls
        enabled: showControls
        z: 900
        
        Behavior on opacity {
            NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
        }
        
        isPlaying: playerPage.isPlaying
        playbackPosition: playerPage.playbackPosition
        bufferedPosition: playerPage.bufferedPosition
        
        onAnyUserAction: {
            revealControls()
        }
        
        onTogglePlay: {
            playerPage.isPaused = !playerPage.isPaused
            playerPage.isPlaying = !playerPage.isPaused
            videoPlayer.mockPlaying = playerPage.isPlaying && !playerPage.isPaused
            revealControls()
        }
        
        onBackPressed: {
            if (typeof navigateTo !== "undefined") {
                navigateTo("/home")
            } else {
                console.log("Back button pressed - navigate to home")
            }
        }
        
        onSeekStart: {
            playerPage.isSeeking = true
            revealControls()
        }
        
        onSeekEnd: {
            playerPage.isSeeking = false
            revealControls()
        }
    }
    
    PlayerInfoBar {
        id: playerInfoBar
        anchors.fill: parent
        visible: false
        z: 950
    }
    
    ZapOverlay {
        id: zapOverlay
        anchors.fill: parent
        visible: false
        z: 850
    }
    
    PipController {
        id: pipController
        anchors.fill: parent
        visible: false
        z: 850
    }
    
    MultiView {
        id: multiView
        anchors.fill: parent
        visible: false
        z: 850
    }
    
    RecordBadge {
        id: recordBadge
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        visible: false
        z: 850
    }
    
    PlayerError {
        id: playerError
        anchors.fill: parent
        visible: false
        z: 1000
        
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
        id: interactionLayer
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.AllButtons
        propagateComposedEvents: !showControls
        
        onPositionChanged: {
            revealControls()
        }
        
        onPressed: {
            revealControls()
        }
    }
    
    Keys.onPressed: function(event) {
        revealControls()
        
        switch(event.key) {
            case Qt.Key_C:
                showControls = !showControls
                event.accepted = true
                break
            case Qt.Key_Space:
                playerPage.isPaused = !playerPage.isPaused
                playerPage.isPlaying = !playerPage.isPaused
                videoPlayer.mockPlaying = playerPage.isPlaying && !playerPage.isPaused
                revealControls()
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
        
        // Show controls initially
        revealControls()
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