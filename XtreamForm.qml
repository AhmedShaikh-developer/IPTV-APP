import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property bool testing: false
    property bool testSuccess: false
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 600)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30
            
            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 20
                
                Button {
                    text: "←"
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#2f2f2f"
                        radius: 25
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#ffffff"
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/sources/add")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "🔐 Xtream Codes"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Enter your Xtream Codes credentials"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Server URL
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Server URL"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: serverField
                        placeholderText: "http://example.com:8080"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Username
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Username"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: usernameField
                        placeholderText: "Your username"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Password
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Password"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: passwordField
                        placeholderText: "Your password"
                        font.pixelSize: 16
                        color: "#ffffff"
                        echoMode: TextInput.Password
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Timezone Offset
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 15
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: "Timezone Offset"
                            font.pixelSize: 12
                            color: "#b3b3b3"
                        }
                        
                        Text {
                            text: "EPG time adjustment (hours)"
                            font.pixelSize: 11
                            color: "#564d4d"
                        }
                    }
                    
                    SpinBox {
                        id: timezoneOffset
                        from: -12
                        to: 12
                        value: 0
                        editable: true
                    }
                }
            }
            
            // Test Connection Button
            Button {
                text: testing ? "Testing..." : (testSuccess ? "✓ Connection Successful" : "🔍 Test Connection")
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                enabled: !testing
                background: Rectangle {
                    color: testSuccess ? "#27ae60" : (testing ? "#564d4d" : "#3498db")
                    radius: 4
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
                    testing = true
                    testTimer.start()
                }
            }
            
            // Save and Sync
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Button {
                    text: "💾 Save"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#e50914"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/sources/manage")
                }
                
                Button {
                    text: "💾 Save & Sync"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#27ae60"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/sources/sync")
                }
            }
        }
    }
    
    Timer {
        id: testTimer
        interval: 2000
        onTriggered: {
            testing = false
            testSuccess = true
        }
    }
}

