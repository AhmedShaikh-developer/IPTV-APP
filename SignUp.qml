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
            spacing: 25
            
            // Header
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                
                Text {
                    text: "✨ Create Account"
                    font.pixelSize: 28
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "Join IPTV Pro and start streaming"
                    font.pixelSize: 16
                    color: "#b3b3b3"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
            }
            
            // Name field
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
                        text: "Full Name"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: nameField
                        placeholderText: "Enter your full name"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
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
                        placeholderText: "Create a password (min 8 characters)"
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
            
            // Confirm password field
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
                        text: "Confirm Password"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: confirmPasswordField
                        placeholderText: "Confirm your password"
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
            
            // Terms and Privacy
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 10
                    
                    CheckBox {
                        id: termsCheckbox
                        checked: false
                    }
                    
                    Text {
                        text: "I agree to the "
                        font.pixelSize: 12
                        color: "#b3b3b3"
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        
                        Text {
                            text: "Terms of Service"
                            font.pixelSize: 12
                            color: "#e50914"
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: Qt.openUrlExternally("https://example.com/terms")
                            }
                        }
                        
                        Text {
                            text: " and "
                            font.pixelSize: 12
                            color: "#b3b3b3"
                        }
                        
                        Text {
                            text: "Privacy Policy"
                            font.pixelSize: 12
                            color: "#e50914"
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: Qt.openUrlExternally("https://example.com/privacy")
                            }
                        }
                    }
                }
            }
            
            // Create account button
            Button {
                text: "Create Account"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                enabled: termsCheckbox.checked
                background: Rectangle {
                    color: parent.enabled ? "#e50914" : "#2f2f2f"
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
                    // Validate form
                    if (nameField.text.length > 0 && 
                        emailField.text.length > 0 && 
                        passwordField.text.length >= 8 &&
                        passwordField.text === confirmPasswordField.text &&
                        termsCheckbox.checked) {
                        
                        // Simulate account creation
                        isAuthenticated = true
                        userEmail = emailField.text
                        navigateTo("/auth/verify")
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
                    text: "🍎 Sign up with Apple"
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
                        // Simulate Apple Sign Up
                        isAuthenticated = true
                        userEmail = "user@icloud.com"
                        navigateTo("/main")
                    }
                }
                
                Button {
                    text: "🔍 Sign up with Google"
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
                        // Simulate Google Sign Up
                        isAuthenticated = true
                        userEmail = "user@gmail.com"
                        navigateTo("/main")
                    }
                }
            }
            
            // Sign in link
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 5
                
                Text {
                    text: "Already have an account?"
                    font.pixelSize: 14
                    color: "#b3b3b3"
                }
                
                Text {
                    text: "Sign In"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#e50914"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: navigateTo("/auth/sign-in")
                    }
                }
            }
        }
    }
}

