import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: recordBadge
    width: 80
    height: 30
    color: "#E50914"
    radius: 15
    visible: false
    
    property bool isRecording: false
    property int recordingDuration: 0 // in seconds
    property string recordingTime: "00:00:00"
    
    // Pulse animation for recording
    SequentialAnimation {
        id: pulseAnimation
        running: isRecording
        loops: Animation.Infinite
        
        NumberAnimation {
            target: recordBadge
            property: "scale"
            from: 1.0
            to: 1.1
            duration: 1000
            easing.type: Easing.InOutQuad
        }
        
        NumberAnimation {
            target: recordBadge
            property: "scale"
            from: 1.1
            to: 1.0
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }
    
    // Recording duration timer
    Timer {
        id: recordingTimer
        interval: 1000
        running: isRecording
        repeat: true
        onTriggered: {
            recordingDuration++
            updateRecordingTime()
        }
    }
    
    // Update recording time display
    function updateRecordingTime() {
        var hours = Math.floor(recordingDuration / 3600)
        var minutes = Math.floor((recordingDuration % 3600) / 60)
        var seconds = recordingDuration % 60
        
        recordingTime = String(hours).padStart(2, '0') + ":" +
                       String(minutes).padStart(2, '0') + ":" +
                       String(seconds).padStart(2, '0')
    }
    
    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 6
        
        // REC icon
        Text {
            text: "⏺️"
            font.pixelSize: 12
            color: "#ffffff"
        }
        
        // Recording time
        Text {
            text: recordingTime
            font.pixelSize: 10
            font.bold: true
            color: "#ffffff"
        }
    }
    
    // Fade-in animation when recording starts
    function startRecording() {
        isRecording = true
        recordingDuration = 0
        visible = true
        opacity = 0.0
        
        startRecordingAnimation.start()
        
        console.log("Recording started")
    }
    
    // Fade-out animation when recording stops
    function stopRecording() {
        isRecording = false
        
        stopRecordingAnimation.start()
        
        console.log("Recording stopped. Duration:", recordingTime)
    }
    
    // Toggle recording
    function toggleRecording() {
        if (isRecording) {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    NumberAnimation {
        id: startRecordingAnimation
        target: recordBadge
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 300
        easing.type: Easing.OutQuad
    }
    
    NumberAnimation {
        id: stopRecordingAnimation
        target: recordBadge
        property: "opacity"
        from: 1.0
        to: 0.0
        duration: 300
        easing.type: Easing.InQuad
        onFinished: {
            visible = false
            recordingDuration = 0
            updateRecordingTime()
        }
    }
    
    // Show badge (for testing or manual control)
    function show() {
        visible = true
        opacity = 1.0
    }
    
    // Hide badge
    function hide() {
        visible = false
        isRecording = false
        recordingDuration = 0
        updateRecordingTime()
    }
    
    // Initialize
    Component.onCompleted: {
        updateRecordingTime()
    }
}
