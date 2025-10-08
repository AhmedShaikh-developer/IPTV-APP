import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 400)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30
            
            // Header
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                
                Text {
                    text: "Sign In"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "Welcome back to IPTV Pro"
                    font.pixelSize: 16
                    color: "#b3b3b3"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
            }
            
            // Email field
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Email"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: emailField
                        placeholderText: "Enter your email"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Password field
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
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
                        placeholderText: "Enter your password"
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
            
            // Forgot password
            Text {
                text: "Forgot Password?"
                font.pixelSize: 14
                color: "#e50914"
                horizontalAlignment: Text.AlignRight
                Layout.alignment: Qt.AlignRight
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: navigateTo("/auth/reset")
                }
            }
            
            // Sign in button
            Button {
                text: "Sign In"
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
                onClicked: {
                    // Simulate sign in
                    if (emailField.text.length > 0 && passwordField.text.length > 0) {
                        isAuthenticated = true
                        userEmail = emailField.text
                        navigateTo("/main")
                    }
                }
            }
            
            // Divider
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#2f2f2f"
                }
                
                Text {
                    text: "or"
                    font.pixelSize: 14
                    color: "#b3b3b3"
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#2f2f2f"
                }
            }
            
            // SSO buttons
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 12
                
                Button {
                    text: "🍎 Continue with Apple"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    background: Rectangle {
                        color: "#000000"
                        radius: 4
                        border.color: "#2f2f2f"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        // Simulate Apple Sign In
                        isAuthenticated = true
                        userEmail = "user@icloud.com"
                        navigateTo("/main")
                    }
                }
                
                Button {
                    text: "🔍 Continue with Google"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    background: Rectangle {
                        color: "#4285f4"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        // Simulate Google Sign In
                        isAuthenticated = true
                        userEmail = "user@gmail.com"
                        navigateTo("/main")
                    }
                }
            }
            
            // TV Pairing
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 10
                    
                    Text {
                        text: "📺 Login with TV Code"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Get a 6-digit code from your TV app to sign in quickly"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }
                    
                    Button {
                        text: "Enter TV Code"
                        Layout.alignment: Qt.AlignHCenter
                        background: Rectangle {
                            color: "transparent"
                            radius: 4
                            border.color: "#e50914"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#e50914"
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: navigateTo("/auth/pair")
                    }
                }
            }
            
            // Sign up link
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 5
                
                Text {
                    text: "Don't have an account?"
                    font.pixelSize: 14
                    color: "#b3b3b3"
                }
                
                Text {
                    text: "Sign Up"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#e50914"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: navigateTo("/auth/sign-up")
                    }
                }
            }
        }
    }
}
