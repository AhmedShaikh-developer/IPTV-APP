import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import IPTVBackend 1.0

Rectangle {
    id: playerPage
    color: "#000000"

    // When true we don't render video inside this window. Instead, we launch
    // the full VLC player UI in a separate window using ExternalVlcLauncher.
    property bool useExternalVlc: false // DISABLED - play video inside app
    
    // Format time from milliseconds to MM:SS or HH:MM:SS
    function formatTime(milliseconds) {
        if (!milliseconds || milliseconds < 0) return "00:00"
        
        var totalSeconds = Math.floor(milliseconds / 1000)
        var hours = Math.floor(totalSeconds / 3600)
        var minutes = Math.floor((totalSeconds % 3600) / 60)
        var seconds = totalSeconds % 60
        
        if (hours > 0) {
            return (hours < 10 ? "0" : "") + hours + ":" + 
                   (minutes < 10 ? "0" : "") + minutes + ":" + 
                   (seconds < 10 ? "0" : "") + seconds
        } else {
            return (minutes < 10 ? "0" : "") + minutes + ":" + 
                   (seconds < 10 ? "0" : "") + seconds
        }
    }
    
    property url currentSource: "" // Changed from default video to empty
    property string streamUrl: ""
    property bool showControls: true // Controls visibility - always show initially
    property bool showMiniPlayer: false
    property real playbackPosition: 0.3
    property real bufferedPosition: 0.7
    property bool isSeeking: false
    property bool isPaused: vlcPlayer.state === VlcPlayer.Paused
    property bool isPlaying: vlcPlayer.state === VlcPlayer.Playing // Computed from VLC state
    
    // Force controls to always be visible when video is playing
    onIsPlayingChanged: {
        if (isPlaying) {
            showControls = true
            console.log("Video playing - forcing controls visible, showControls:", showControls)
        }
    }
    property bool hasValidSource: false // Track if we have a valid source
    
    // External VLC launcher removed - using embedded player
    
    // Force controls to be visible initially and when playing
    // Component.onCompleted will be at the end of the file
    
    onStreamUrlChanged: {
        console.log("═══════════════════════════════════════════════════")
        console.log("PlayerPage.onStreamUrlChanged")
        console.log("═══════════════════════════════════════════════════")
        console.log("New streamUrl:", streamUrl)
        console.log("streamUrl type:", typeof streamUrl)
        
        if (streamUrl !== "" && streamUrl !== undefined && streamUrl !== null) {
            console.log("✓ Valid streamUrl detected")
            
            // Convert to string and clean
            var urlString = String(streamUrl).trim()
            
            // Remove any quotes if present
            urlString = urlString.replace(/^["']|["']$/g, '')
            
            // Add protocol if missing
            if (!urlString.startsWith("http://") && !urlString.startsWith("https://") && 
                !urlString.startsWith("qrc:/") && !urlString.startsWith("file://")) {
                console.log("⚠ Adding http:// prefix")
                urlString = "http://" + urlString
            }
            
            console.log("✓ Final URL string:", urlString)
            
            // Validate URL format
            try {
                var testUrl = new URL(urlString)
                console.log("✓ URL validation passed")
                console.log("  Protocol:", testUrl.protocol)
                console.log("  Host:", testUrl.host)
            } catch (e) {
                console.warn("⚠ URL validation warning:", e)
            }
            
            // If we are using the external VLC UI, launch it here and skip internal playback
            if (useExternalVlc) {
                console.log("✓ Launching external VLC player with URL:", urlString)
                externalVlc.playUrl(urlString)

                // Still update state for history / other logic
                hasValidSource = true
                fallbackRect.visible = false
                currentSource = urlString

                // Do NOT configure internal vlcPlayer or start playTimer
            } else {
                // Stop any current playback
                if (vlcPlayer.state !== VlcPlayer.Stopped && vlcPlayer.state !== VlcPlayer.Idle) {
                    console.log("Stopping current playback...")
                    vlcPlayer.stop()
                }
                
                // Mark that we have a valid source
                hasValidSource = true
                
                // Hide fallback/error UI
                fallbackRect.visible = false
                
                // Set source to VLC player
                console.log("Setting currentSource property...")
                currentSource = urlString
                
                console.log("Setting VLC player source...")
                vlcPlayer.source = urlString
                
                // Verify it was set
                Qt.callLater(function() {
                    console.log("Verification after setting:")
                    console.log("  currentSource:", currentSource.toString())
                    console.log("  vlcPlayer.source:", vlcPlayer.source)
                    console.log("  Are they equal?", currentSource.toString() === vlcPlayer.source)
                })
                
                // Start playback timer
                console.log("Starting playTimer (1 second delay)...")
                playTimer.start()
            }
        } else {
            console.log("✗ streamUrl is empty or invalid")
            hasValidSource = false
            currentSource = ""
            vlcPlayer.source = ""
        }
        console.log("═══════════════════════════════════════════════════")
    }
    
    // Timer to start playback after source is set
    Timer {
        id: playTimer
        interval: 1000  // Increased to 1 second for better reliability
        repeat: false
        onTriggered: {
            console.log("=== playTimer: Attempting to start VLC playback ===")
            console.log("VLC source:", vlcPlayer.source)
            console.log("currentSource:", currentSource.toString())
            console.log("streamUrl:", streamUrl)
            console.log("hasValidSource:", hasValidSource)
            console.log("VLC state:", vlcPlayer.state)
            
            // Double-check source is set
            if (vlcPlayer.source === "" && currentSource.toString() !== "") {
                console.log("⚠ Source binding issue detected, forcing source update...")
                vlcPlayer.source = currentSource.toString()
            }
            
            if (hasValidSource) {
                var sourceStr = vlcPlayer.source
                if (sourceStr !== "" && sourceStr !== "undefined") {
                    console.log("✓ Source is valid, calling VLC play()...")
                    console.log("Source URL:", sourceStr)
                    
                    // Try playing with VLC - embedded in app
                    vlcPlayer.play()
                    
                    // Also check after a short delay if it didn't start
                    playCheckTimer.start()
                } else {
                    console.error("✗ Source is empty, cannot play")
                }
            } else {
                console.error("✗ hasValidSource is false, cannot play")
            }
        }
    }
    
    // Check if playback actually started
    Timer {
        id: playCheckTimer
        interval: 2000
        repeat: false
        onTriggered: {
            console.log("=== Play Check Timer ===")
            console.log("Playback state:", vlcPlayer.state === VlcPlayer.Playing ? "PLAYING ✓" : "NOT PLAYING ✗")
            console.log("VLC state:", vlcPlayer.state)
            console.log("Source:", vlcPlayer.source)
            
            if (!useExternalVlc && hasValidSource && vlcPlayer.state !== VlcPlayer.Playing) {
                console.log("⚠ Playback didn't start, retrying...")
                console.log("VLC state:", vlcPlayer.state === VlcPlayer.Error ? "Error ✗" : "Valid")
                
                // Retry once more
                if (vlcPlayer.source !== "") {
                    console.log("Retrying VLC play()...")
                    vlcPlayer.stop()
                    Qt.callLater(function() {
                        vlcPlayer.play()
                    })
                }
            }
        }
    }
    
    
    Timer {
        id: autoHideTimer
        interval: 5000 // 5 seconds before hiding
        running: false // DISABLED - NEVER HIDE CONTROLS
        onTriggered: {
            // DO NOTHING - keep controls always visible
            console.log("Auto-hide triggered (should not happen)")
        }
    }
    
    Timer {
        id: placeholderDelayTimer
        interval: 350
        onTriggered: {
                    if (vlcPlayer.state === VlcPlayer.Stopped || vlcPlayer.state === VlcPlayer.Idle) {
                fallbackRect.visible = true
            }
        }
    }
    
    function revealControls() {
        showControls = true
        // DO NOT restart timer - controls stay visible always
    }
    
    function retryPlayback() {
        if (useExternalVlc) {
            console.log("retryPlayback() called in external VLC mode - relaunching external VLC")
            var url = streamUrl !== "" ? streamUrl : currentSource
            if (url !== "") {
                externalVlc.playUrl(String(url))
            }
        } else {
            var source = streamUrl !== "" ? streamUrl : currentSource
            if (source !== "") {
                vlcPlayer.source = source
                vlcPlayer.play()
                fallbackRect.visible = false
            }
        }
    }
    
    Connections {
        target: PlaylistManager
        function onPlayStream(url) {
            console.log("═══════════════════════════════════════")
            console.log("PlayerPage: Received playStream signal")
            console.log("═══════════════════════════════════════")
            console.log("URL from signal:", url)
            console.log("URL type:", typeof url)
            
            // Convert QVariant/QString to string if needed
            var urlString = url
            if (typeof url === "object" && url.toString) {
                urlString = url.toString()
            }
            
            console.log("✓ Final URL string:", urlString)
            
            // Validate URL
            if (!urlString || urlString === "" || urlString === "undefined") {
                console.error("✗ ERROR: Invalid URL received!")
                return
            }
            
            if (!urlString.startsWith("http://") && !urlString.startsWith("https://")) {
                console.warn("⚠ WARNING: URL doesn't start with http:// or https://")
            }
            
            // Set streamUrl - this will trigger onStreamUrlChanged
            streamUrl = urlString
            console.log("✓ streamUrl property set, will trigger video load")
            console.log("═══════════════════════════════════════")
        }
        
        Component.onCompleted: {
            console.log("PlayerPage: Connections to PlaylistManager established")
        }
    }
    
    Rectangle {
        id: videoArea
        anchors.fill: parent
        color: "#000000"
        
        // libVLC Player Component
        VlcPlayer {
            id: vlcPlayer
            videoOutput: videoOutputItem
        }
        
        // Video output surface for libVLC
        Item {
            id: videoOutputItem
            anchors.fill: parent
            visible: vlcPlayer.state === VlcPlayer.Playing || vlcPlayer.state === VlcPlayer.Paused
            
            Component.onCompleted: {
                console.log("=== VLC Video Output initialized ===")
                // Wait for window to be available before attaching
                if (videoOutputItem.window) {
                    console.log("✓ Window available immediately")
                }
            }
            
            onWindowChanged: {
                if (window) {
                    console.log("✓ Video output window changed, attaching VLC player")
                    // VlcPlayer will automatically attach via videoOutput property
                }
            }
        }
        
        // VLC Player state handling
        Connections {
            target: vlcPlayer
            
            function onStateChanged() {
                var stateStr = ""
                switch(vlcPlayer.state) {
                    case VlcPlayer.Idle: stateStr = "Idle"; break
                    case VlcPlayer.Opening: stateStr = "Opening"; break
                    case VlcPlayer.Buffering: stateStr = "Buffering"; break
                    case VlcPlayer.Playing: stateStr = "Playing"; break
                    case VlcPlayer.Paused: stateStr = "Paused"; break
                    case VlcPlayer.Stopped: stateStr = "Stopped"; break
                    case VlcPlayer.Ended: stateStr = "Ended"; break
                    case VlcPlayer.Error: stateStr = "Error"; break
                }
                console.log("=== VLC Player state changed ===")
                console.log("State:", stateStr, "(" + vlcPlayer.state + ")")
                console.log("Source:", vlcPlayer.source)
            }
            
            function onPlaying() {
                console.log("✓✓✓ VLC VIDEO IS NOW PLAYING! ✓✓✓")
                fallbackRect.visible = false
                placeholderDelayTimer.stop()
                isPlaying = true
                showControls = true // Force controls to be visible
                console.log("✓ Controls FORCED to visible, showControls:", showControls)
                console.log("✓ PlayerControls opacity should be:", showControls ? 1.0 : 0.0)
                autoHideTimer.stop() // Stop auto-hide - keep controls always visible
                // DO NOT restart timer - controls stay visible permanently
            }
            
            function onPaused() {
                console.log("⏸ VLC Video paused")
                isPlaying = false
                showControls = true // Always show controls when paused
            }
            
            function onStopped() {
                console.log("⏹ VLC Video stopped")
                if (hasValidSource && vlcPlayer.source !== "") {
                    placeholderDelayTimer.start()
                    
                    // Add to history
                    try {
                        var history = playerPage.parent.parent.parent.readJson("historyJson", [])
                        var historyEntry = {
                            type: "video",
                            id: currentSource.toString(),
                            progress: playbackPosition,
                            ts: Date.now()
                        }
                        history.unshift(historyEntry)
                        if (history.length > 50) {
                            history = history.slice(0, 50)
                        }
                        playerPage.parent.parent.parent.writeJson("historyJson", history)
                    } catch (e) {
                        console.log("Could not save to history:", e)
                    }
                }
                isPlaying = false
            }
            
            function onEnded() {
                console.log("▶️ VLC Video ended")
                isPlaying = false
            }
            
            function onError() {
                console.error("=== VLC Player error ===")
                if (vlcPlayer.errorMessage) {
                    var userMessage = vlcPlayer.errorMessage
                    // Check if it's a 403 error (from logs)
                    if (userMessage.indexOf("403") !== -1 || userMessage.indexOf("Forbidden") !== -1 || 
                        userMessage.indexOf("can't be opened") !== -1) {
                        userMessage = "Access denied (403).\n\nThis stream may be:\n• Region-locked\n• Require authentication\n• Protected by the server\n\nTry a different stream or check if the URL is valid."
                    } else if (userMessage.indexOf("404") !== -1 || userMessage.indexOf("not found") !== -1) {
                        userMessage = "Stream not found (404).\n\nThe URL may be invalid or the stream may have been removed."
                    } else if (userMessage.indexOf("timeout") !== -1) {
                        userMessage = "Connection timeout.\n\nPlease check your internet connection and try again."
                    } else if (userMessage.indexOf("network") !== -1) {
                        userMessage = "Network error.\n\nPlease check your internet connection."
                    }
                    console.error("Error message:", userMessage)
                    playerError.showError("network", "Playback Error", userMessage)
                } else {
                    // Generic error if no specific message
                    playerError.showError("network", "Playback Error", "Unable to play this stream. It may be unavailable or require authentication.")
                }
            }
            
            function onErrorMessageChanged() {
                if (vlcPlayer.errorMessage) {
                    console.error("VLC Error:", vlcPlayer.errorMessage)
                }
            }
            
            function onPositionChanged() {
                playbackPosition = vlcPlayer.position
            }
            
            function onTimeChanged() {
                // Time updated
            }
            
            function onLengthChanged() {
                console.log("VLC Media length:", vlcPlayer.length, "ms")
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
                    vlcPlayer.state === VlcPlayer.Stopped || vlcPlayer.state === VlcPlayer.Idle
            
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
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 0  // No margins - go full width
        height: 160 // EXPLICIT HEIGHT - this is critical
        // Force controls to always be visible - disable auto-hide for now
        opacity: 1.0 // Always fully visible
        visible: true // Always visible
        enabled: true // Always enabled
        z: 10000 // Very high z-order to ensure it's on top of everything
        
        Component.onCompleted: {
            console.log("========== PLAYERCONTROLS COMPONENT ==========")
            console.log("PlayerControls width:", width, "height:", height)
            console.log("PlayerControls opacity:", opacity, "visible:", visible)
            console.log("PlayerControls enabled:", enabled, "z:", z)
            console.log("==============================================")
        }
        
        Behavior on opacity {
            NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
        }
        
        isPlaying: playerPage.isPlaying
        playbackPosition: playerPage.playbackPosition
        bufferedPosition: playerPage.bufferedPosition
        currentTime: formatTime(vlcPlayer.time)
        totalTime: formatTime(vlcPlayer.length)
        volume: vlcPlayer.volume * 100 // Convert 0-1 to 0-100
        muted: vlcPlayer.muted
        
        onAnyUserAction: {
            revealControls()
        }
        
        onTogglePlay: {
            playerPage.isPaused = !playerPage.isPaused
            playerPage.isPlaying = !playerPage.isPaused
            // VLC player doesn't need mockPlaying - state is controlled directly
            if (playerPage.isPaused) {
                vlcPlayer.pause()
            } else if (playerPage.isPlaying) {
                vlcPlayer.play()
            }
            revealControls()
        }
        
        onStopRequested: {
            vlcPlayer.stop()
            revealControls()
        }
        
        onBackPressed: {
            vlcPlayer.stop()
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
        
        onSeekTo: {
            if (vlcPlayer.length > 0) {
                var seekTime = position * vlcPlayer.length
                vlcPlayer.seek(seekTime)
                console.log("Seeking to:", seekTime, "ms (", position * 100, "%)")
            }
            revealControls()
        }
        
        onSetVolume: {
            vlcPlayer.setVolume(volume / 100) // Convert 0-100 to 0-1
            revealControls()
        }
        
        onToggleMute: {
            vlcPlayer.setMuted(!vlcPlayer.muted)
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
                // VLC player doesn't need mockPlaying - state is controlled directly
            if (playerPage.isPaused) {
                vlcPlayer.pause()
            } else if (playerPage.isPlaying) {
                vlcPlayer.play()
            }
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
        showControls = true
        console.log("PlayerPage completed, showControls:", showControls)
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