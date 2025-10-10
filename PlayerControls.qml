import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: playerControls
    color: "transparent"
    
    property bool isPlaying: false
    property real playbackPosition: 0.3
    property real bufferedPosition: 0.7
    property bool isSeeking: false
    
    signal togglePlay()
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
    signal anyUserAction()
    
    Behavior on opacity {
        NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
    }
    
    Rectangle {
        id: controlsBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        height: 120
        radius: 14
        color: "#FF0000"
        border.color: "#333333"
        border.width: 1
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16
            
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
            
            // Control buttons row
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
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
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }
                    }
                }
            }
        }
    }
}