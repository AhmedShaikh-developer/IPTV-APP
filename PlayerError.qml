import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: playerError
    color: "#E6000000"
    
    property string errorType: "network" // network, geo-restricted, drm, playback
    property string errorMessage: "Connection lost. Please check your internet connection."
    property string errorTitle: "Playback Error"
    property bool showShake: false
    
    // Signals
    signal retry()
    signal back()
    signal changeSource()
    
    // Semi-transparent backdrop
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        
        MouseArea {
            anchors.fill: parent
            onClicked: {
                // Close on backdrop click
                back()
            }
        }
    }
    
    // Error content container
    Rectangle {
        id: errorContainer
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.8, 500)
        height: Math.min(parent.height * 0.7, 400)
        color: "#1a1a1a"
        radius: 15
        border.color: "#2f2f2f"
        border.width: 1
        
        // Shake animation
        SequentialAnimation {
            id: shakeAnimation
            running: showShake
            
            NumberAnimation {
                target: errorContainer
                property: "x"
                from: errorContainer.x
                to: errorContainer.x - 10
                duration: 50
                easing.type: Easing.InOutQuad
            }
            
            NumberAnimation {
                target: errorContainer
                property: "x"
                from: errorContainer.x - 10
                to: errorContainer.x + 10
                duration: 100
                easing.type: Easing.InOutQuad
            }
            
            NumberAnimation {
                target: errorContainer
                property: "x"
                from: errorContainer.x + 10
                to: errorContainer.x
                duration: 50
                easing.type: Easing.InOutQuad
            }
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20
            
            // Error icon and title
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                
                Rectangle {
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 80
                    radius: 40
                    color: getErrorColor()
                    Layout.alignment: Qt.AlignHCenter
                    
                    Text {
                        anchors.centerIn: parent
                        text: getErrorIcon()
                        font.pixelSize: 32
                        color: "#ffffff"
                    }
                }
                
                Text {
                    text: errorTitle
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
            }
            
            // Error message
            Text {
                text: errorMessage
                font.pixelSize: 16
                color: "#b3b3b3"
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }
            
            // Action buttons
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                
                Button {
                    text: "Retry"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 44
                    
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 6
                        border.color: parent.activeFocus ? "#ffffff" : "transparent"
                        border.width: 2
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "#ffffff"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        retry()
                        showShake = true
                        shakeTimer.start()
                    }
                    Keys.onReturnPressed: {
                        retry()
                        showShake = true
                        shakeTimer.start()
                    }
                }
                
                Button {
                    text: "Back"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 44
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: "#2f2f2f"
                        border.width: 1
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "#ffffff"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: back()
                    Keys.onReturnPressed: back()
                }
                
                Button {
                    text: "Change Source"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 44
                    
                    background: Rectangle {
                        color: parent.hovered ? "#2a2a2a" : "#1a1a1a"
                        radius: 6
                        border.color: "#2f2f2f"
                        border.width: 1
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "#ffffff"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: changeSource()
                    Keys.onReturnPressed: changeSource()
                }
            }
        }
    }
    
    // Shake animation reset timer
    Timer {
        id: shakeTimer
        interval: 200
        repeat: false
        onTriggered: {
            showShake = false
        }
    }
    
    // Get error color based on type
    function getErrorColor() {
        switch(errorType) {
            case "network":
                return "#E50914" // Red
            case "geo-restricted":
                return "#FFA500" // Orange
            case "drm":
                return "#FFD700" // Yellow
            case "playback":
                return "#E50914" // Red
            default:
                return "#E50914" // Red
        }
    }
    
    // Get error icon based on type
    function getErrorIcon() {
        switch(errorType) {
            case "network":
                return "📡"
            case "geo-restricted":
                return "🌍"
            case "drm":
                return "🔒"
            case "playback":
                return "⚠️"
            default:
                return "❌"
        }
    }
    
    // Show error with specific type and message
    function showError(type, title, message) {
        errorType = type
        errorTitle = title
        errorMessage = message
        visible = true
        opacity = 0.0
        
        showErrorAnimation.start()
    }
    
    // Hide error overlay
    function hideError() {
        hideErrorAnimation.start()
    }
    
    NumberAnimation {
        id: showErrorAnimation
        target: playerError
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 300
        easing.type: Easing.OutQuad
    }
    
    NumberAnimation {
        id: hideErrorAnimation
        target: playerError
        property: "opacity"
        from: 1.0
        to: 0.0
        duration: 300
        easing.type: Easing.InQuad
        onFinished: {
            visible = false
        }
    }
    
    // Keyboard shortcuts
    Keys.onPressed: function(event) {
        switch(event.key) {
            case Qt.Key_R:
                retry()
                showShake = true
                shakeTimer.start()
                event.accepted = true
                break
            case Qt.Key_Escape:
            case Qt.Key_B:
                back()
                event.accepted = true
                break
            case Qt.Key_C:
                changeSource()
                event.accepted = true
                break
            case Qt.Key_Return:
            case Qt.Key_Enter:
                retry()
                showShake = true
                shakeTimer.start()
                event.accepted = true
                break
        }
    }
    
    focus: visible
    
    // Initialize with fade-in animation
    Component.onCompleted: {
        if (visible) {
            opacity = 0.0
            initFadeInAnimation.start()
        }
    }
    
    NumberAnimation {
        id: initFadeInAnimation
        target: playerError
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 300
        easing.type: Easing.OutQuad
    }
}
