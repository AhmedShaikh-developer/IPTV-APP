import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: playerControls
    color: "transparent"
    
    // Signals for parent communication
    signal togglePlay()
    signal showInfo()
    signal zapUp()
    signal zapDown()
    signal togglePiP()
    signal showMultiView()
    signal backPressed()
    signal showError()
    signal toggleRecording()
    
    // Control bar at bottom
    Rectangle {
        id: controlsBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        color: "transparent"
        
        // Semi-transparent gradient background
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#00000000" }
                GradientStop { position: 0.3; color: "#4D000000" }
                GradientStop { position: 1.0; color: "#CC000000" }
            }
            radius: 10
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10
            
            // Seek bar
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
                color: "#404040"
                radius: 2
                
                Rectangle {
                    width: parent.width * 0.3 // Playback position
                    height: parent.height
                    color: "#E50914"
                    radius: 2
                }
                
                Rectangle {
                    width: parent.width * 0.7 // Buffered position
                    height: parent.height
                    color: "#666666"
                    radius: 2
                    opacity: 0.6
                }
            }
            
            // Main controls row
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 20
                
                // Zap Down button
                Button {
                    id: zapDownBtn
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: RowLayout {
                        spacing: 8
                        anchors.centerIn: parent
                        
                        Text {
                            text: "⬇️"
                            font.pixelSize: 16
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Zap Down"
                            font.pixelSize: 14
                            color: "#ffffff"
                        }
                    }
                    
                    onClicked: zapDown()
                    Keys.onReturnPressed: zapDown()
                    Keys.onEnterPressed: zapDown()
                }
                
                // Audio track selector
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "🔊 Audio"
                        font.pixelSize: 14
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: console.log("Audio tracks")
                }
                
                // Aspect ratio toggle
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "📐 16:9"
                        font.pixelSize: 14
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: console.log("Aspect ratio")
                }
                
                // Play/Pause button (center)
                Button {
                    id: playPauseBtn
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 60
                    
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 30
                        border.color: parent.activeFocus ? "#ffffff" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "⏸️" // Will toggle between ⏸️ and ▶️
                        font.pixelSize: 24
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: togglePlay()
                    Keys.onReturnPressed: togglePlay()
                    Keys.onEnterPressed: togglePlay()
                }
                
                // Info button
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "ℹ️ Info"
                        font.pixelSize: 14
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: showInfo()
                    Keys.onReturnPressed: showInfo()
                    Keys.onEnterPressed: showInfo()
                }
                
                // Deinterlace toggle
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "📺 Deint"
                        font.pixelSize: 14
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: console.log("Deinterlace")
                }
                
                // Stats button
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "📊 Stats"
                        font.pixelSize: 14
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: showError()
                }
                
                // Multi-view button
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "📱 Multi"
                        font.pixelSize: 14
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: showMultiView()
                    Keys.onReturnPressed: showMultiView()
                    Keys.onEnterPressed: showMultiView()
                }
                
                // PiP button
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "📺 PiP"
                        font.pixelSize: 14
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: togglePiP()
                    Keys.onReturnPressed: togglePiP()
                    Keys.onEnterPressed: togglePiP()
                }
                
                // Record button
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "⏺️ Record"
                        font.pixelSize: 14
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: toggleRecording()
                    Keys.onReturnPressed: toggleRecording()
                    Keys.onEnterPressed: toggleRecording()
                }
                
                // Zap Up button
                Button {
                    id: zapUpBtn
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: RowLayout {
                        spacing: 8
                        anchors.centerIn: parent
                        
                        Text {
                            text: "⬆️"
                            font.pixelSize: 16
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Zap Up"
                            font.pixelSize: 14
                            color: "#ffffff"
                        }
                    }
                    
                    onClicked: zapUp()
                    Keys.onReturnPressed: zapUp()
                    Keys.onEnterPressed: zapUp()
                }
            }
        }
    }
    
    // Back button (top-left)
    Button {
        id: backBtn
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        width: 50
        height: 50
        
        background: Rectangle {
            color: parent.hovered ? "#2a2a2a" : "#80000000"
            radius: 25
            border.color: parent.activeFocus ? "#E50914" : "transparent"
            border.width: 2
        }
        
        contentItem: Text {
            text: "←"
            font.pixelSize: 20
            color: "#ffffff"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: backPressed()
        Keys.onReturnPressed: backPressed()
        Keys.onEnterPressed: backPressed()
    }
    
    // Focus management for DPAD navigation
    focus: true
    
    Keys.onPressed: function(event) {
        switch(event.key) {
            case Qt.Key_Left:
                // Move focus left through controls
                event.accepted = true
                break
            case Qt.Key_Right:
                // Move focus right through controls
                event.accepted = true
                break
            case Qt.Key_Up:
                zapUp()
                event.accepted = true
                break
            case Qt.Key_Down:
                zapDown()
                event.accepted = true
                break
            case Qt.Key_Space:
                togglePlay()
                event.accepted = true
                break
            case Qt.Key_Return:
            case Qt.Key_Enter:
                if (activeFocus) {
                    // Trigger focused button
                }
                event.accepted = true
                break
        }
    }
}
