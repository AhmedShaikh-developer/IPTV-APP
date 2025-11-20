import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import IPTVBackend 1.0

// Test page to verify VLC player works with public streams
Rectangle {
    id: testRoot
    color: "#1a1a1a"
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        
        // Title
        Text {
            text: "🧪 VLC Player Test Suite"
            font.pixelSize: 28
            font.bold: true
            color: "#ffffff"
            Layout.alignment: Qt.AlignHCenter
        }
        
        Text {
            text: "Test the player with known working streams"
            font.pixelSize: 14
            color: "#888888"
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10
        }
        
        // Test streams list
        ScrollView {
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            clip: true
            
            ColumnLayout {
                width: parent.width
                spacing: 10
                
                Repeater {
                    model: [
                        {
                            name: "Big Buck Bunny (MP4)",
                            url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                            desc: "Direct MP4 from Google - Should work"
                        },
                        {
                            name: "Apple HLS Test Stream",
                            url: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8",
                            desc: "Apple's official HLS test - Should work"
                        },
                        {
                            name: "Sintel (MP4)",
                            url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
                            desc: "Direct MP4 from Google - Should work"
                        },
                        {
                            name: "Buzzr Stream (Protected)",
                            url: "https://buzzrota-ono.amagi.tv/playlist1080.m3u8",
                            desc: "CloudFront protected - Will fail with 403"
                        }
                    ]
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 80
                        color: mouseArea.containsMouse ? "#2d2d2d" : "#242424"
                        radius: 8
                        border.color: "#444444"
                        border.width: 1
                        
                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 15
                            spacing: 15
                            
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 5
                                
                                Text {
                                    text: modelData.name
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                
                                Text {
                                    text: modelData.desc
                                    font.pixelSize: 12
                                    color: "#888888"
                                }
                                
                                Text {
                                    text: modelData.url
                                    font.pixelSize: 10
                                    color: "#666666"
                                    elide: Text.ElideMiddle
                                    Layout.fillWidth: true
                                }
                            }
                            
                            Button {
                                text: "▶ Test"
                                Layout.preferredWidth: 100
                                Layout.preferredHeight: 40
                                
                                background: Rectangle {
                                    color: parent.hovered ? "#e50914" : "#c20812"
                                    radius: 6
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    color: "#ffffff"
                                    font.pixelSize: 14
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    console.log("Testing stream:", modelData.url)
                                    testPlayer.source = modelData.url
                                    testPlayer.play()
                                    statusText.text = "Playing: " + modelData.name
                                    statusText.color = "#27ae60"
                                }
                            }
                        }
                        
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            propagateComposedEvents: true
                        }
                    }
                }
            }
        }
        
        // Status display
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: "#242424"
            radius: 8
            border.color: "#444444"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 5
                
                Text {
                    id: statusText
                    text: "Ready to test..."
                    font.pixelSize: 14
                    color: "#888888"
                }
                
                Text {
                    text: "State: " + getStateName(testPlayer.state) + " | Error: " + (testPlayer.errorMessage || "None")
                    font.pixelSize: 12
                    color: "#666666"
                }
            }
        }
        
        // Video output
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#000000"
            radius: 8
            border.color: "#444444"
            border.width: 2
            
            VlcPlayer {
                id: testPlayer
                
                videoOutput: videoOutput
                
                onStateChanged: {
                    console.log("=== Test Player State:", getStateName(state))
                }
                
                onError: {
                    console.error("=== Test Player Error:", errorMessage)
                    statusText.text = "ERROR: " + errorMessage
                    statusText.color = "#e74c3c"
                }
                
                onPlaying: {
                    console.log("=== Test Player: Playing successfully!")
                    statusText.text = "✓ Playing successfully!"
                    statusText.color = "#27ae60"
                }
            }
            
            Rectangle {
                id: videoOutput
                anchors.fill: parent
                anchors.margins: 5
                color: "#000000"
                
                Text {
                    anchors.centerIn: parent
                    text: testPlayer.state === 0 ? "Ready to play" : 
                          testPlayer.state === 4 ? "" :  // Playing, don't show text
                          "Loading..."
                    font.pixelSize: 18
                    color: "#666666"
                    visible: testPlayer.state !== 4
                }
            }
            
            // Controls overlay
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 60
                color: "#000000dd"
                visible: testPlayer.state === 4 // Show only when playing
                
                RowLayout {
                    anchors.centerIn: parent
                    spacing: 20
                    
                    Button {
                        text: testPlayer.state === 4 ? "⏸ Pause" : "▶ Play"
                        onClicked: {
                            if (testPlayer.state === 4) {
                                testPlayer.pause()
                            } else {
                                testPlayer.play()
                            }
                        }
                    }
                    
                    Button {
                        text: "⏹ Stop"
                        onClicked: testPlayer.stop()
                    }
                }
            }
        }
        
        // Back button
        Button {
            text: "← Back to App"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 45
            
            background: Rectangle {
                color: parent.hovered ? "#333333" : "#2a2a2a"
                radius: 6
                border.color: "#444444"
                border.width: 1
            }
            
            contentItem: Text {
                text: parent.text
                color: "#ffffff"
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            onClicked: {
                // Navigate back to main app
                testPlayer.stop()
                Qt.quit() // Or navigate to main screen
            }
        }
    }
    
    function getStateName(state) {
        switch(state) {
            case 0: return "Idle"
            case 1: return "Opening"
            case 2: return "Buffering"
            case 3: return "Playing"
            case 4: return "Playing"
            case 5: return "Stopped"
            case 6: return "Ended"
            case 7: return "Error"
            default: return "Unknown (" + state + ")"
        }
    }
}

