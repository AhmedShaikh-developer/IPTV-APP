import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: recordBadge
    width: 120
    height: 40
    radius: 20
    color: "#E50914"
    visible: false
    opacity: 0.0
    
    property bool isRecording: false
    property int recordingDuration: 0
    property string recordingTime: "00:00:00"
    
    function updateRecordingTime() {
        var hours = Math.floor(recordingDuration / 3600)
        var minutes = Math.floor((recordingDuration % 3600) / 60)
        var seconds = recordingDuration % 60
        
        recordingTime = (hours < 10 ? "0" : "") + hours + ":" +
                       (minutes < 10 ? "0" : "") + minutes + ":" +
                       (seconds < 10 ? "0" : "") + seconds
    }
    
    function startRecording() {
        isRecording = true
        recordingDuration = 0
        visible = true
        recordingTimer.start()
        fadeInAnimation.start()
        console.log("Recording started")
    }
    
    function stopRecording() {
        isRecording = false
        recordingTimer.stop()
        fadeOutAnimation.start()
        console.log("Recording stopped. Duration:", recordingTime)
    }
    
    function toggleRecording() {
        if (isRecording) {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    NumberAnimation {
        id: fadeInAnimation
        target: recordBadge
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 300
        easing.type: Easing.OutQuad
    }
    
    NumberAnimation {
        id: fadeOutAnimation
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
    
    Timer {
        id: recordingTimer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            recordingDuration++
            updateRecordingTime()
        }
    }
    
    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: "transparent"
        border.color: "#FFFFFF"
        border.width: 2
        opacity: 0.3
        
        SequentialAnimation on opacity {
            running: isRecording
            loops: Animation.Infinite
            NumberAnimation { from: 0.3; to: 0.8; duration: 800 }
            NumberAnimation { from: 0.8; to: 0.3; duration: 800 }
        }
    }
    
    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 10
        
        Rectangle {
            width: 12
            height: 12
            radius: 6
            color: "#FFFFFF"
            
            SequentialAnimation on scale {
                running: isRecording
                loops: Animation.Infinite
                NumberAnimation { from: 1.0; to: 1.3; duration: 600; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 1.3; to: 1.0; duration: 600; easing.type: Easing.InOutQuad }
            }
            
            SequentialAnimation on opacity {
                running: isRecording
                loops: Animation.Infinite
                NumberAnimation { from: 1.0; to: 0.5; duration: 600 }
                NumberAnimation { from: 0.5; to: 1.0; duration: 600 }
            }
        }
        
        Text {
            text: isRecording ? ("REC " + recordingTime) : "REC"
            font.pixelSize: 14
            font.bold: true
            font.family: "Courier"
            color: "#FFFFFF"
            Layout.fillWidth: true
        }
    }
    
    layer.enabled: true
    layer.effect: ShaderEffect {
        property variant source: recordBadge
        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            void main() {
                gl_FragColor = texture2D(source, qt_TexCoord0) * qt_Opacity;
            }
        "
    }
    
    Rectangle {
        anchors.fill: parent
        anchors.margins: -4
        radius: parent.radius + 2
        color: "transparent"
        border.color: "#80E50914"
        border.width: 4
        z: -1
        
        SequentialAnimation on opacity {
            running: isRecording
            loops: Animation.Infinite
            NumberAnimation { from: 0.3; to: 0.8; duration: 1000 }
            NumberAnimation { from: 0.8; to: 0.3; duration: 1000 }
        }
    }
    
    Component.onCompleted: {
        updateRecordingTime()
    }
}
