import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property string mode: "unlock" // unlock, setup, change
    property string enteredPin: ""
    property string correctPin: "1234"
    property int maxAttempts: 3
    property int attempts: 0
    property bool isLocked: false
    property string lockMessage: ""
    
    // Background blur effect simulation
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.95
    }
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 400)
        
        // Lock Icon
        Rectangle {
            width: 100
            height: 100
            radius: 50
            color: isLocked ? "#e74c3c" : "#e50914"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: isLocked ? "🔒" : (mode === "setup" ? "🔐" : "🔓")
                font.pixelSize: 50
            }
            
            // Shake animation on wrong PIN
            SequentialAnimation on x {
                id: shakeAnimation
                running: false
                NumberAnimation { to: 10; duration: 50 }
                NumberAnimation { to: -10; duration: 50 }
                NumberAnimation { to: 10; duration: 50 }
                NumberAnimation { to: -10; duration: 50 }
                NumberAnimation { to: 0; duration: 50 }
            }
        }
        
        // Title and Description
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            spacing: 15
            
            Text {
                text: {
                    if (isLocked) return "Too Many Attempts"
                    switch(mode) {
                        case "unlock": return "Enter PIN"
                        case "setup": return "Set Up PIN"
                        case "change": return "Enter Current PIN"
                        default: return "Enter PIN"
                    }
                }
                font.pixelSize: 32
                font.bold: true
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: {
                    if (isLocked) return "Please try again in 5 minutes"
                    if (lockMessage) return lockMessage
                    switch(mode) {
                        case "unlock": return "Enter your 4-digit PIN to continue"
                        case "setup": return "Create a 4-digit PIN for parental controls"
                        case "change": return "Enter your current PIN first"
                        default: return "Enter your PIN"
                    }
                }
                font.pixelSize: 16
                color: isLocked ? "#e74c3c" : "#b3b3b3"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }
            
            // Attempts remaining
            Text {
                text: "Attempts remaining: " + (maxAttempts - attempts)
                font.pixelSize: 14
                color: attempts >= 2 ? "#e74c3c" : "#f39c12"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                visible: mode === "unlock" && attempts > 0 && !isLocked
            }
        }
        
        // PIN Display
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Repeater {
                model: 4
                
                Rectangle {
                    width: 60
                    height: 60
                    radius: 30
                    color: "#2f2f2f"
                    border.color: index < enteredPin.length ? "#e50914" : "#564d4d"
                    border.width: 3
                    
                    Text {
                        anchors.centerIn: parent
                        text: index < enteredPin.length ? "●" : ""
                        font.pixelSize: 30
                        color: "#ffffff"
                    }
                    
                    // Pulse animation when entering
                    SequentialAnimation on scale {
                        running: index === enteredPin.length - 1
                        NumberAnimation { to: 1.2; duration: 100 }
                        NumberAnimation { to: 1.0; duration: 100 }
                    }
                }
            }
        }
        
        // Number Pad
        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            columns: 3
            rowSpacing: 15
            columnSpacing: 15
            
            Repeater {
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "◀", "0", "✓"]
                
                Rectangle {
                    width: 80
                    height: 80
                    radius: 40
                    color: {
                        if (modelData === "✓") return "#27ae60"
                        if (modelData === "◀") return "#2f2f2f"
                        return "#181818"
                    }
                    border.color: "#2f2f2f"
                    border.width: 2
                    
                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        font.pixelSize: modelData === "◀" || modelData === "✓" ? 24 : 28
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        enabled: !isLocked
                        cursorShape: Qt.PointingHandCursor
                        
                        onPressed: parent.scale = 0.95
                        onReleased: parent.scale = 1.0
                        
                        onClicked: {
                            if (modelData === "◀") {
                                // Backspace
                                if (enteredPin.length > 0) {
                                    enteredPin = enteredPin.slice(0, -1)
                                    lockMessage = ""
                                }
                            } else if (modelData === "✓") {
                                // Confirm/Submit
                                if (enteredPin.length === 4) {
                                    verifyPin()
                                }
                            } else {
                                // Number
                                if (enteredPin.length < 4) {
                                    enteredPin += modelData
                                    lockMessage = ""
                                    
                                    // Auto-submit when 4 digits entered
                                    if (enteredPin.length === 4) {
                                        autoSubmitTimer.start()
                                    }
                                }
                            }
                        }
                    }
                    
                    Behavior on scale {
                        NumberAnimation { duration: 100 }
                    }
                }
            }
        }
        
        // Cancel/Forgot PIN
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Button {
                text: "Cancel"
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Text {
                    text: parent.text
                    color: "#b3b3b3"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/profiles/pick")
            }
            
            Text {
                text: "•"
                color: "#564d4d"
                font.pixelSize: 20
            }
            
            Button {
                text: "Forgot PIN?"
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Text {
                    text: parent.text
                    color: "#e50914"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // Send recovery email or show security questions
                    lockMessage = "Recovery email sent to registered email address"
                }
            }
        }
        
        // Help text
        Text {
            text: "PIN is required to access parental controls and restricted content"
            font.pixelSize: 12
            color: "#564d4d"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            visible: mode !== "unlock"
        }
    }
    
    // Auto-submit timer
    Timer {
        id: autoSubmitTimer
        interval: 500
        onTriggered: verifyPin()
    }
    
    // Lock timer
    Timer {
        id: lockTimer
        interval: 300000 // 5 minutes
        onTriggered: {
            isLocked = false
            attempts = 0
            enteredPin = ""
            lockMessage = ""
        }
    }
    
    function verifyPin() {
        if (enteredPin === correctPin) {
            // Success
            lockMessage = "✓ PIN Correct"
            
            // Navigate based on mode
            if (mode === "unlock") {
                Qt.callLater(function() {
                    navigateTo("/main")
                })
            } else if (mode === "setup") {
                lockMessage = "✓ PIN Set Successfully"
                Qt.callLater(function() {
                    navigateTo("/settings/parental")
                })
            } else if (mode === "change") {
                mode = "setup"
                lockMessage = "Now enter your new PIN"
                enteredPin = ""
            }
        } else {
            // Failed attempt
            attempts++
            enteredPin = ""
            shakeAnimation.start()
            
            if (attempts >= maxAttempts) {
                isLocked = true
                lockMessage = "Too many attempts. Try again in 5 minutes."
                lockTimer.start()
            } else {
                lockMessage = "✗ Incorrect PIN. Try again."
            }
        }
    }
}

