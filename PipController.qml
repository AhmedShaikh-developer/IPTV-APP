import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: pipController
    color: "transparent"
    
    property bool isPiPMode: false
    property bool isDragging: false
    property point dragStartPosition
    property point pipPosition: Qt.point(50, 50)
    property size pipSize: Qt.size(320, 180) // 16:9 aspect ratio
    
    // PiP window
    Rectangle {
        id: pipWindow
        x: pipPosition.x
        y: pipPosition.y
        width: pipSize.width
        height: pipSize.height
        visible: isPiPMode
        color: "#000000"
        radius: 8
        border.color: "#E50914"
        border.width: 2
        
        // Shadow effect
        Rectangle {
            anchors.fill: parent
            anchors.margins: -5
            color: "#4D000000"
            radius: parent.radius + 2
            z: -1
        }
        
        // Video area
        Rectangle {
            anchors.fill: parent
            anchors.margins: 2
            color: "#181818"
            radius: 6
            
            Text {
                anchors.centerIn: parent
                text: "📺 PiP Stream"
                font.pixelSize: 16
                color: "#ffffff"
                opacity: 0.7
            }
            
            // Minimal playback controls
            Rectangle {
                id: pipControls
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 40
                color: "#B3000000"
                radius: 6
                visible: false
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 8
                    
                    Button {
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        
                        background: Rectangle {
                            color: parent.hovered ? "#2a2a2a" : "transparent"
                            radius: 12
                        }
                        
                        contentItem: Text {
                            text: "⏸️"
                            font.pixelSize: 12
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: console.log("PiP Play/Pause")
                    }
                    
                    Item { Layout.fillWidth: true }
                    
                    Button {
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        
                        background: Rectangle {
                            color: parent.hovered ? "#2a2a2a" : "transparent"
                            radius: 12
                        }
                        
                        contentItem: Text {
                            text: "✕"
                            font.pixelSize: 12
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: togglePiP()
                    }
                }
                
                // Show/hide controls timer
                Timer {
                    id: pipControlsTimer
                    interval: 3000
                    repeat: false
                    onTriggered: pipControls.visible = false
                }
            }
        }
        
        // Drag area for desktop
        MouseArea {
            anchors.fill: parent
            drag.target: pipWindow
            drag.axis: Drag.XAndYAxis
            drag.minimumX: 0
            drag.maximumX: parent.parent.width - pipWindow.width
            drag.minimumY: 0
            drag.maximumY: parent.parent.height - pipWindow.height
            
            onPressed: function(mouse) {
                isDragging = true
                dragStartPosition = Qt.point(mouse.x, mouse.y)
                pipControls.visible = true
                pipControlsTimer.restart()
            }
            
            onReleased: {
                isDragging = false
                snapToCorner()
            }
            
            onPositionChanged: function(mouse) {
                if (isDragging) {
                    pipPosition = Qt.point(pipWindow.x, pipWindow.y)
                }
            }
            
            // Double click to exit PiP
            onDoubleClicked: {
                togglePiP()
            }
        }
        
        // Animation for PiP transitions
        Behavior on x {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
        
        Behavior on y {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
        
        Behavior on width {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
        
        Behavior on height {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
    }
    
    // Snapping function for mobile/tablet
    function snapToCorner() {
        var newX = pipWindow.x
        var newY = pipWindow.y
        var margin = 20
        
        // Snap to corners with margin
        if (pipWindow.x < parent.width / 2) {
            newX = margin
        } else {
            newX = parent.width - pipWindow.width - margin
        }
        
        if (pipWindow.y < parent.height / 2) {
            newY = margin
        } else {
            newY = parent.height - pipWindow.height - margin
        }
        
        pipWindow.x = newX
        pipWindow.y = newY
        pipPosition = Qt.point(newX, newY)
    }
    
    // Toggle PiP mode
    function togglePiP() {
        if (isPiPMode) {
            // Exit PiP - restore fullscreen
            exitPiP()
        } else {
            // Enter PiP - minimize to window
            enterPiP()
        }
    }
    
    // Enter PiP mode
    function enterPiP() {
        isPiPMode = true
        
        // Animate from fullscreen to PiP size
        pipWindow.width = pipSize.width
        pipWindow.height = pipSize.height
        
        // Position in bottom-right corner
        pipPosition = Qt.point(
            parent.width - pipSize.width - 20,
            parent.height - pipSize.height - 20
        )
        
        pipWindow.x = pipPosition.x
        pipWindow.y = pipPosition.y
        
        console.log("Entered PiP mode")
    }
    
    // Exit PiP mode
    function exitPiP() {
        isPiPMode = false
        pipControls.visible = false
        
        console.log("Exited PiP mode - restored fullscreen")
    }
    
    // Handle window resize
    onWidthChanged: {
        if (isPiPMode) {
            // Keep PiP window within bounds
            if (pipWindow.x + pipWindow.width > width) {
                pipWindow.x = width - pipWindow.width - 20
                pipPosition.x = pipWindow.x
            }
        }
    }
    
    onHeightChanged: {
        if (isPiPMode) {
            // Keep PiP window within bounds
            if (pipWindow.y + pipWindow.height > height) {
                pipWindow.y = height - pipWindow.height - 20
                pipPosition.y = pipWindow.y
            }
        }
    }
    
    // Keyboard shortcuts
    Keys.onPressed: function(event) {
        switch(event.key) {
            case Qt.Key_P:
                togglePiP()
                event.accepted = true
                break
            case Qt.Key_Escape:
                if (isPiPMode) {
                    exitPiP()
                    event.accepted = true
                }
                break
        }
    }
    
    focus: isPiPMode
}
