import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: voiceSearchScreen
    color: "#000000CC" // Semi-transparent background

    property bool isListening: false
    property bool voiceAvailable: true // Mock platform detection
    property string detectedText: ""

    // Mock voice states
    property var voiceStates: [
        "Listening...",
        "Try saying a movie, series, or channel name",
        "No voice detected"
    ]
    property int currentState: 1

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function startListening() {
        isListening = true
        currentState = 0
        
        // Mock voice detection after 3 seconds
        voiceDetectionTimer.start()
    }

    function stopListening() {
        isListening = false
        currentState = 1
        voiceDetectionTimer.stop()
    }

    Timer {
        id: voiceDetectionTimer
        interval: 3000
        repeat: false
        onTriggered: {
            // Mock successful voice detection
            detectedText = "The Dark Knight"
            currentState = 0
            isListening = false
            
            // Auto-navigate to results after brief delay
            resultsTimer.start()
        }
    }

    Timer {
        id: resultsTimer
        interval: 1500
        repeat: false
        onTriggered: {
            navigateTo("/search/results?q=" + encodeURIComponent(detectedText))
        }
    }

    // Background blur effect
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.8
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00000040" }
            GradientStop { position: 0.5; color: "#00000080" }
            GradientStop { position: 1.0; color: "#00000040" }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40

        // Voice unavailable message (for non-TV platforms)
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            color: "#111111"
            radius: 12
            border.color: "#333333"
            border.width: 1
            visible: !voiceAvailable

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "🎤"
                    font.pixelSize: 48
                    color: "#666666"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "Voice Search Unavailable"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "Voice search is not available on this platform. Please use the keyboard search instead."
                    font.pixelSize: 16
                    color: "#B3B3B3"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        // Voice Search Interface (TV platforms)
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 40
            visible: voiceAvailable

            // Microphone Icon with Animation
            Rectangle {
                width: 200
                height: 200
                radius: 100
                color: "#111111"
                border.color: isListening ? "#E50914" : "#333333"
                border.width: 4
                Layout.alignment: Qt.AlignHCenter

                // Ripple animation
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width + 40
                    height: parent.height + 40
                    radius: (parent.width + 40) / 2
                    color: "transparent"
                    border.color: "#E50914"
                    border.width: 2
                    opacity: isListening ? 0.3 : 0
                    visible: isListening

                    SequentialAnimation on opacity {
                        running: isListening
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.3; duration: 500 }
                        NumberAnimation { to: 0; duration: 500 }
                    }

                    SequentialAnimation on scale {
                        running: isListening
                        loops: Animation.Infinite
                        NumberAnimation { to: 1.2; duration: 500 }
                        NumberAnimation { to: 1.0; duration: 500 }
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: "🎤"
                    font.pixelSize: 80
                    color: isListening ? "#E50914" : "#FFFFFF"
                }

                // Pulse animation for listening state
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width - 20
                    height: parent.height - 20
                    radius: (parent.width - 20) / 2
                    color: "transparent"
                    border.color: "#E50914"
                    border.width: 1
                    opacity: isListening ? 0.6 : 0

                    SequentialAnimation on opacity {
                        running: isListening
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.8; duration: 300 }
                        NumberAnimation { to: 0.2; duration: 300 }
                    }
                }
            }

            // Status Text
            Text {
                text: {
                    if (isListening && detectedText !== "") {
                        return '"' + detectedText + '"'
                    }
                    return voiceStates[currentState]
                }
                font.pixelSize: 24
                font.bold: true
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }

            // Action Buttons
            RowLayout {
                spacing: 20
                Layout.alignment: Qt.AlignHCenter

                Button {
                    text: isListening ? "Stop" : "Start Listening"
                    Layout.preferredWidth: 140
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 6
                        border.color: parent.activeFocus ? "#FFFFFF" : "transparent"
                        border.width: parent.activeFocus ? 2 : 0
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        if (isListening) {
                            stopListening()
                        } else {
                            startListening()
                        }
                    }
                }

                Button {
                    text: "Cancel"
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: parent.hovered ? "#2A2A2A" : "transparent"
                        radius: 6
                        border.color: "#666666"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        stopListening()
                        navigateTo("/search")
                    }
                }
            }

            // Instructions
            Text {
                text: "Speak clearly into your microphone or remote control"
                font.pixelSize: 14
                color: "#B3B3B3"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Close on background click
    MouseArea {
        anchors.fill: parent
        onClicked: {
            stopListening()
            navigateTo("/search")
        }
    }

    // Keyboard shortcuts
    Keys.onEscapePressed: {
        stopListening()
        navigateTo("/search")
    }

    Keys.onReturnPressed: {
        if (!isListening) {
            startListening()
        }
    }

    Component.onCompleted: {
        // Auto-focus for keyboard navigation
        forceActiveFocus()
        
        // Mock platform detection
        voiceAvailable = true // Set to false for non-TV platforms
    }
}
