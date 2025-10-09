import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    // Responsive breakpoints and calculations
    readonly property real screenWidth: parent.width
    readonly property real screenHeight: parent.height
    readonly property bool isDesktop: screenWidth >= 1024
    readonly property bool isMobile: screenWidth <= 600
    
    // Responsive dimensions
    readonly property real formWidth: isDesktop ? 400 : (screenWidth * 0.9)
    readonly property real spacing: isMobile ? 16 : 24
    readonly property real titleSize: isMobile ? 28 : 35
    readonly property real subtitleSize: isMobile ? 16 : 20
    readonly property real fieldHeight: 44
    readonly property real fieldPadding: 12
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 20
        
        // Centered container
        Item {
            width: parent.width
            height: Math.max(parent.height, content.height + 40)
            
            ColumnLayout {
                id: content
                width: formWidth
                anchors.centerIn: parent
                spacing: spacing
                
                // Header
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 8
                    
                    Text {
                        text: "Sign In"
                        font.pixelSize: titleSize
                        font.bold: true
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    Text {
                        text: "Welcome back to IPTV Pro"
                        font.pixelSize: subtitleSize
                        color: "#b3b3b3"
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
                
                // Email field
                TextField {
                    id: emailField
                    placeholderText: "Enter your email"
                    placeholderTextColor: "#888888"
                    font.pixelSize: 16
                    color: "#E5E5E5"
                    Layout.fillWidth: true
                    Layout.preferredHeight: fieldHeight
                    
                    background: Rectangle {
                        color: "#1C1C1C"
                        radius: 6
                        border.color: "#2f2f2f"
                        border.width: 1
                    }
                    
                    // Internal padding
                    leftPadding: fieldPadding
                    rightPadding: fieldPadding
                    topPadding: fieldPadding
                    bottomPadding: fieldPadding
                    
                    // Focus states
                    onActiveFocusChanged: {
                        if (activeFocus) {
                            background.border.color = "#E50914"
                        } else {
                            background.border.color = "#2f2f2f"
                        }
                    }
                }
                
                // Password field
                TextField {
                    id: passwordField
                    placeholderText: "Enter your password"
                    placeholderTextColor: "#888888"
                    font.pixelSize: 16
                    color: "#E5E5E5"
                    echoMode: TextInput.Password
                    Layout.fillWidth: true
                    Layout.preferredHeight: fieldHeight
                    
                    background: Rectangle {
                        color: "#1C1C1C"
                        radius: 6
                        border.color: "#2f2f2f"
                        border.width: 1
                    }
                    
                    // Internal padding
                    leftPadding: fieldPadding
                    rightPadding: fieldPadding
                    topPadding: fieldPadding
                    bottomPadding: fieldPadding
                    
                    // Focus states
                    onActiveFocusChanged: {
                        if (activeFocus) {
                            background.border.color = "#E50914"
                        } else {
                            background.border.color = "#2f2f2f"
                        }
                    }
                }
                
                // Forgot password
                Text {
                    text: "Forgot Password?"
                    font.pixelSize: 14
                    color: "#E50914"
                    horizontalAlignment: Text.AlignRight
                    Layout.alignment: Qt.AlignRight
                    Layout.topMargin: -8
                    
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
                    Layout.preferredHeight: fieldHeight
                    Layout.topMargin: 8
                    
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 6
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
                    Layout.topMargin: 16
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
                    spacing: 10
                    
                    Button {
                        text: "🍎 Continue with Apple"
                        Layout.fillWidth: true
                        Layout.preferredHeight: fieldHeight
                        
                        background: Rectangle {
                            color: parent.hovered ? "#1a1a1a" : "#000000"
                            radius: 6
                            border.color: "#2f2f2f"
                            border.width: 1
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            isAuthenticated = true
                            userEmail = "user@icloud.com"
                            navigateTo("/main")
                        }
                    }
                    
                    Button {
                        text: "🔍 Continue with Google"
                        Layout.fillWidth: true
                        Layout.preferredHeight: fieldHeight
                        
                        background: Rectangle {
                            color: parent.hovered ? "#4a90e2" : "#4285f4"
                            radius: 6
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
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
                    color: "#1C1C1C"
                    radius: 6
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 16
                        spacing: 12
                        
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
                            Layout.preferredHeight: 32
                            
                            background: Rectangle {
                                color: "transparent"
                                radius: 6
                                border.color: "#E50914"
                                border.width: 1
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "#E50914"
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
                    Layout.topMargin: 16
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
                        color: "#E50914"
                        
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
}