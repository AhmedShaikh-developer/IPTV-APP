import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 500)
        
        // Netflix Logo
        Rectangle {
            width: 120
            height: 120
            radius: 8
            color: "#e50914"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: "N"
                font.pixelSize: 80
                font.bold: true
                color: "white"
            }
        }
        
        // Welcome text
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15
            
            Text {
                text: "Welcome to IPTV Pro"
                font.pixelSize: 40
                font.bold: true
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Netflix Style Streaming Experience"
                font.pixelSize: 18
                color: "#b3b3b3"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Stream thousands of channels worldwide"
                font.pixelSize: 16
                color: "#564d4d"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
        }
        
        // Feature highlights
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "#181818"
            radius: 8
            border.color: "#2f2f2f"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10
                
                Text {
                    text: "🎯 Premium Features"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#ffffff"
                }
                
                RowLayout {
                    spacing: 30
                    
                    ColumnLayout {
                        spacing: 5
                        
                        Text {
                            text: "📡 10,000+ Channels"
                            font.pixelSize: 12
                            color: "#e50914"
                        }
                        
                        Text {
                            text: "🎬 HD Quality"
                            font.pixelSize: 12
                            color: "#e50914"
                        }
                    }
                    
                    ColumnLayout {
                        spacing: 5
                        
                        Text {
                            text: "📱 Multi-Device"
                            font.pixelSize: 12
                            color: "#e50914"
                        }
                        
                        Text {
                            text: "⚡ No Ads"
                            font.pixelSize: 12
                            color: "#e50914"
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
                text: "🔑 Sign In"
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
                onClicked: navigateTo("/auth/sign-in")
            }
            
            Button {
                text: "✨ Create Account"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                background: Rectangle {
                    color: "#2f2f2f"
                    radius: 4
                    border.color: "#564d4d"
                    border.width: 1
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/auth/sign-up")
            }
            
            Button {
                text: "🔄 Restore Purchase"
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                background: Rectangle {
                    color: "transparent"
                    radius: 4
                    border.color: "#564d4d"
                    border.width: 1
                }
                contentItem: Text {
                    text: parent.text
                    color: "#b3b3b3"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // Simulate restore purchase
                    hasActiveSubscription = true
                    subscriptionStatus = "active"
                    navigateTo("/main")
                }
            }
        }
        
        // Guest access
        Text {
            text: "or continue as guest"
            font.pixelSize: 12
            color: "#564d4d"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    isAuthenticated = true
                    subscriptionStatus = "free"
                    navigateTo("/main")
                }
            }
        }
    }
}
