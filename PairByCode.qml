import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#f8f9fa"
    
    property string pairingCode: "123456"
    property int countdown: 300 // 5 minutes in seconds
    property bool isPaired: false
    property string pairedProfile: ""
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 500)
        
        // TV icon
        Rectangle {
            width: 120
            height: 120
            radius: 60
            color: isPaired ? "#27ae60" : "#3498db"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: isPaired ? "✅" : "📺"
                font.pixelSize: 60
                color: "white"
            }
            
            // Success animation
            SequentialAnimation on scale {
                running: isPaired
                NumberAnimation { to: 1.2; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { to: 1.0; duration: 200; easing.type: Easing.OutQuad }
            }
        }
        
        // Status text
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Text {
                text: isPaired ? "Successfully Paired!" : "Enter TV Code"
                font.pixelSize: 32
                font.bold: true
                color: "#2c3e50"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: isPaired ? 
                      "Your device has been paired as: " + pairedProfile :
                      "Enter the 6-digit code shown on your TV to sign in quickly."
                font.pixelSize: 16
                color: "#7f8c8d"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }
            
            // Paired profile display
            Text {
                text: pairedProfile
                font.pixelSize: 18
                font.bold: true
                color: "#27ae60"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                visible: isPaired
            }
        }
        
        // Code display (when not paired)
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            visible: !isPaired
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15
                
                Text {
                    text: "TV Code"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: pairingCode
                    font.pixelSize: 36
                    font.bold: true
                    color: "#3498db"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                    
                    // Blink animation
                    SequentialAnimation on opacity {
                        running: !isPaired
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.5; duration: 1000 }
                        NumberAnimation { to: 1.0; duration: 1000 }
                    }
                }
                
                Text {
                    text: "This code expires in " + formatTime(countdown)
                    font.pixelSize: 14
                    color: "#e74c3c"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
        
        // Instructions card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            visible: !isPaired
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10
                
                Text {
                    text: "📺 How to pair:"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }
                
                ColumnLayout {
                    spacing: 8
                    
                    RowLayout {
                        spacing: 10
                        
                        Text {
                            text: "1."
                            font.pixelSize: 14
                            color: "#3498db"
                        }
                        
                        Text {
                            text: "Open IPTV Pro on your TV"
                            font.pixelSize: 14
                            color: "#495057"
                            Layout.fillWidth: true
                        }
                    }
                    
                    RowLayout {
                        spacing: 10
                        
                        Text {
                            text: "2."
                            font.pixelSize: 14
                            color: "#3498db"
                        }
                        
                        Text {
                            text: "Go to Settings > Device Pairing"
                            font.pixelSize: 14
                            color: "#495057"
                            Layout.fillWidth: true
                        }
                    }
                    
                    RowLayout {
                        spacing: 10
                        
                        Text {
                            text: "3."
                            font.pixelSize: 14
                            color: "#3498db"
                        }
                        
                        Text {
                            text: "Enter the code shown above"
                            font.pixelSize: 14
                            color: "#495057"
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }
        
        // Action buttons
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 15
            
            Button {
                text: isPaired ? "🎉 Continue to App" : "⏳ Waiting for Pairing..."
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                enabled: isPaired
                background: Rectangle {
                    color: parent.enabled ? "#27ae60" : "#bdc3c7"
                    radius: 8
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    if (isPaired) {
                        isAuthenticated = true
                        navigateTo("/main")
                    }
                }
            }
            
            Button {
                text: "🔄 Generate New Code"
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                background: Rectangle {
                    color: "transparent"
                    radius: 8
                    border.color: "#3498db"
                    border.width: 2
                }
                contentItem: Text {
                    text: parent.text
                    color: "#3498db"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // Generate new code
                    pairingCode = Math.floor(Math.random() * 900000 + 100000).toString()
                    countdown = 300
                }
                visible: !isPaired
            }
            
            Button {
                text: "🔙 Back to Sign In"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Text {
                    text: parent.text
                    color: "#6c757d"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/auth/sign-in")
            }
        }
        
        // Help text
        Text {
            text: "Having trouble pairing? Make sure both devices are connected to the same network."
            font.pixelSize: 12
            color: "#95a5a6"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
        }
    }
    
    // Countdown timer
    Timer {
        id: countdownTimer
        interval: 1000
        repeat: true
        running: !isPaired && countdown > 0
        onTriggered: {
            countdown--
            if (countdown === 0) {
                // Generate new code when expired
                pairingCode = Math.floor(Math.random() * 900000 + 100000).toString()
                countdown = 300
            }
        }
    }
    
    // Simulate pairing after 10 seconds
    Timer {
        id: pairingTimer
        interval: 10000
        running: !isPaired
        onTriggered: {
            isPaired = true
            pairedProfile = "Living Room TV"
        }
    }
    
    function formatTime(seconds) {
        var minutes = Math.floor(seconds / 60)
        var secs = seconds % 60
        return minutes + ":" + (secs < 10 ? "0" : "") + secs
    }
}

