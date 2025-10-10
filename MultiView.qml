import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: multiView
    color: "#E6000000"
    
    property int activePaneIndex: 0
    property int viewMode: 2 // 2 for 2-up, 4 for 4-up
    property bool isVisible: false
    
    // Grid layout
    GridLayout {
        id: viewGrid
        anchors.fill: parent
        anchors.margins: 20
        columns: viewMode === 4 ? 2 : 1
        rows: viewMode === 4 ? 2 : 2
        columnSpacing: 10
        rowSpacing: 10
        
        // Video panes
        Repeater {
            model: viewMode
            
            Rectangle {
                id: videoPane
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#181818"
                radius: 8
                border.color: index === activePaneIndex ? "#E50914" : "transparent"
                border.width: 3
                
                // Scale animation for active pane
                scale: index === activePaneIndex ? 1.02 : 1.0
                
                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }
                
                Behavior on border.color {
                    ColorAnimation { duration: 200 }
                }
                
                // Video placeholder
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    color: "#2f2f2f"
                    radius: 6
                    
                    Text {
                        anchors.centerIn: parent
                        text: "📺 Channel " + (index + 1)
                        font.pixelSize: 16
                        color: "#ffffff"
                        opacity: 0.7
                    }
                }
                
                // Channel overlay
                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 10
                    width: 120
                    height: 30
                    color: "#B3000000"
                    radius: 15
                    
                    Text {
                        anchors.centerIn: parent
                        text: "BBC News HD"
                        font.pixelSize: 12
                        color: "#ffffff"
                    }
                }
                
                // Audio indicator
                Rectangle {
                    id: audioIndicator
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 10
                    width: 30
                    height: 30
                    color: index === activePaneIndex ? "#E50914" : "transparent"
                    radius: 15
                    border.color: "#E50914"
                    border.width: 2
                    visible: index === activePaneIndex
                    
                    Text {
                        anchors.centerIn: parent
                        text: "🔊"
                        font.pixelSize: 14
                        color: "#ffffff"
                    }
                    
                    Behavior on opacity {
                        NumberAnimation { duration: 200 }
                    }
                }
                
                // Click area for pane selection
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        activePaneIndex = index
                    }
                }
            }
        }
    }
    
    // Control bar at bottom
    Rectangle {
        id: controlBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        color: "#CC000000"
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20
            
            // View mode toggle
            Button {
                text: viewMode === 2 ? "2-Up" : "4-Up"
                Layout.preferredWidth: 80
                Layout.preferredHeight: 40
                
                background: Rectangle {
                    color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                    radius: 6
                    border.color: parent.activeFocus ? "#E50914" : "transparent"
                    border.width: 2
                }
                
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 14
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    viewMode = viewMode === 2 ? 4 : 2
                    activePaneIndex = 0
                }
            }
            
            // Audio focus indicator
            Text {
                text: "Audio: Channel " + (activePaneIndex + 1)
                font.pixelSize: 14
                color: "#E50914"
                Layout.fillWidth: true
            }
            
            // Exit multi-view
            Button {
                text: "Exit Multi-View"
                Layout.preferredWidth: 120
                Layout.preferredHeight: 40
                
                background: Rectangle {
                    color: parent.hovered ? "#F5191F" : "#E50914"
                    radius: 6
                    border.color: parent.activeFocus ? "#ffffff" : "transparent"
                    border.width: 2
                }
                
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 14
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    exitMultiView()
                }
            }
        }
    }
    
    // Enter multi-view with zoom-out animation
    function enterMultiView() {
        isVisible = true
        visible = true
        activePaneIndex = 0
        
        // Zoom-out animation
        scale = 0.8
        opacity = 0.0
        
        scaleAnimation.start()
        opacityAnimation.start()
        
        console.log("Entered multi-view mode:", viewMode + "-up")
    }
    
    NumberAnimation {
        id: scaleAnimation
        target: multiView
        property: "scale"
        to: 1.0
        duration: 300
        easing.type: Easing.OutBack
        easing.overshoot: 0.3
    }
    
    NumberAnimation {
        id: opacityAnimation
        target: multiView
        property: "opacity"
        to: 1.0
        duration: 300
        easing.type: Easing.OutQuad
    }
    
    // Exit multi-view with zoom-in animation
    function exitMultiView() {
        // Zoom-in animation
        exitScaleAnimation.start()
        exitOpacityAnimation.start()
        
        console.log("Exited multi-view mode")
    }
    
    NumberAnimation {
        id: exitScaleAnimation
        target: multiView
        property: "scale"
        to: 1.1
        duration: 200
        easing.type: Easing.InQuad
    }
    
    NumberAnimation {
        id: exitOpacityAnimation
        target: multiView
        property: "opacity"
        to: 0.0
        duration: 200
        easing.type: Easing.InQuad
        onFinished: {
            isVisible = false
            visible = false
            scale = 1.0
        }
    }
    
    // Switch active pane
    function switchToPane(index) {
        if (index >= 0 && index < viewMode) {
            activePaneIndex = index
            console.log("Switched to pane:", index + 1)
        }
    }
    
    // Keyboard shortcuts
    Keys.onPressed: function(event) {
        switch(event.key) {
            case Qt.Key_1:
            case Qt.Key_2:
            case Qt.Key_3:
            case Qt.Key_4:
                var paneIndex = event.key - Qt.Key_1
                if (paneIndex < viewMode) {
                    switchToPane(paneIndex)
                }
                event.accepted = true
                break
            case Qt.Key_Tab:
                var nextPane = (activePaneIndex + 1) % viewMode
                switchToPane(nextPane)
                event.accepted = true
                break
            case Qt.Key_Escape:
                exitMultiView()
                event.accepted = true
                break
            case Qt.Key_V:
                viewMode = viewMode === 2 ? 4 : 2
                activePaneIndex = 0
                event.accepted = true
                break
        }
    }
    
    focus: isVisible
    
    // Mouse area to close on click outside panes
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: {
            // Only close if clicking on background, not on panes
            if (!viewGrid.contains(Qt.point(mouse.x, mouse.y))) {
                exitMultiView()
            }
        }
        
        // Don't interfere with pane clicks
        onPressed: function(mouse) {
            if (viewGrid.contains(Qt.point(mouse.x, mouse.y))) {
                mouse.accepted = false
            }
        }
    }
    
    // Update visibility
    onIsVisibleChanged: {
        visible = isVisible
        if (isVisible) {
            enterMultiView()
        }
    }
}
