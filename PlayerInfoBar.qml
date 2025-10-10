import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: playerInfoBar
    color: "transparent"
    
    property bool isVisible: false
    property real slideOffset: height
    
    // Slide-up panel
    Rectangle {
        id: infoPanel
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 200
        y: slideOffset
        
        // Translucent background with blur effect
        Rectangle {
            anchors.fill: parent
            color: "#CC000000"
            radius: 15
            
            // Blur effect simulation
            Rectangle {
                anchors.fill: parent
                color: "#4D141414"
                radius: 15
            }
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            
            // Channel info row
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                // Channel logo
                Rectangle {
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 60
                    radius: 8
                    color: "#2f2f2f"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "📺"
                        font.pixelSize: 32
                        color: "#ffffff"
                    }
                }
                
                // Channel details
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5
                    
                    Text {
                        text: "BBC News HD"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Channel 24 • HD • Live"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    Text {
                        text: "BBC News at 10"
                        font.pixelSize: 16
                        color: "#E50914"
                        font.bold: true
                    }
                }
                
                // Close button
                Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "transparent"
                        radius: 20
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: "✕"
                        font.pixelSize: 18
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: slideOut()
                    Keys.onReturnPressed: slideOut()
                    Keys.onEnterPressed: slideOut()
                }
            }
            
            // Timeline section
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10
                
                // Current program timeline
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "22:00"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 6
                        color: "#404040"
                        radius: 3
                        
                        Rectangle {
                            width: parent.width * 0.6 // Current progress
                            height: parent.height
                            color: "#E50914"
                            radius: 3
                        }
                    }
                    
                    Text {
                        text: "23:00"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                }
                
                // Program description
                Text {
                    text: "Live coverage of the day's news with analysis and interviews. Featuring breaking news updates and in-depth reporting from around the world."
                    font.pixelSize: 14
                    color: "#ffffff"
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.maximumHeight: 60
                    elide: Text.ElideRight
                }
                
                // Next program preview
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    color: "#0DFFFFFF"
                    radius: 8
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 10
                        
                        Text {
                            text: "Next:"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                        
                        Text {
                            text: "BBC News at 11"
                            font.pixelSize: 14
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "23:00 - 00:00"
                            font.pixelSize: 12
                            color: "#888888"
                        }
                        
                        Item { Layout.fillWidth: true }
                        
                        Text {
                            text: "⏭️"
                            font.pixelSize: 16
                            color: "#b3b3b3"
                        }
                    }
                }
            }
        }
        
        // Animation for slide in/out
        Behavior on y {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutBack
                easing.overshoot: 0.3
            }
        }
    }
    
    // Slide in animation
    function slideIn() {
        isVisible = true
        slideOffset = 0
    }
    
    // Slide out animation
    function slideOut() {
        slideOffset = height
        // Hide after animation completes
        slideOutTimer.start()
    }
    
    Timer {
        id: slideOutTimer
        interval: 300
        repeat: false
        onTriggered: {
            isVisible = false
            visible = false
        }
    }
    
    // Auto-hide timer
    Timer {
        id: autoHideTimer
        interval: 5000
        running: isVisible
        repeat: false
        onTriggered: {
            if (isVisible) {
                slideOut()
            }
        }
    }
    
    // Mouse area to close on click outside
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: {
            slideOut()
        }
        
        // Don't interfere with panel clicks
        onPressed: function(mouse) {
            if (infoPanel.contains(Qt.point(mouse.x, mouse.y))) {
                mouse.accepted = false
            }
        }
    }
    
    // Keyboard shortcuts
    Keys.onPressed: function(event) {
        switch(event.key) {
            case Qt.Key_Escape:
            case Qt.Key_Down:
                slideOut()
                event.accepted = true
                break
            case Qt.Key_Return:
            case Qt.Key_Enter:
                slideOut()
                event.accepted = true
                break
        }
    }
    
    focus: isVisible
    
    // Update visibility
    onIsVisibleChanged: {
        visible = isVisible
        if (isVisible) {
            autoHideTimer.restart()
        }
    }
}
