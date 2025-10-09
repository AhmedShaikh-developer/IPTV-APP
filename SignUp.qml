import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    // Validation state
    property bool showTermsError: false
    
    // Responsive breakpoints and calculations
    readonly property real screenWidth: parent.width
    readonly property real screenHeight: parent.height
    readonly property bool isDesktop: screenWidth >= 1024
    readonly property bool isMobile: screenWidth <= 600
    
    // Responsive dimensions
    readonly property real formWidth: isDesktop ? 400 : (screenWidth * 0.9)
    readonly property real spacing: isMobile ? 12 : 20
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
                        text: "Create Account"
                        font.pixelSize: titleSize
                        font.bold: true
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    Text {
                        text: "Join IPTV Pro and start streaming"
                        font.pixelSize: subtitleSize
                        color: "#b3b3b3"
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
                
                // Name field
                TextField {
                    id: nameField
                    placeholderText: "Enter your full name"
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
                    placeholderText: "Create a password (min 8 characters)"
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
                
                // Confirm password field
                TextField {
                    id: confirmPasswordField
                    placeholderText: "Confirm your password"
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
                
                // Terms and Privacy
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        
                        CheckBox {
                            id: termsCheckbox
                            checked: false
                            Layout.alignment: Qt.AlignTop
                            
                            onCheckedChanged: {
                                if (checked && showTermsError) {
                                    showTermsError = false
                                }
                            }
                        }
                        
                        Text {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignTop
                            text: "I agree to the <a href='https://example.com/terms' style='color: #E50914; text-decoration: none;'>Terms of Service</a> and <a href='https://example.com/privacy' style='color: #E50914; text-decoration: none;'>Privacy Policy</a>"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                            wrapMode: Text.WordWrap
                            textFormat: Text.RichText
                            linkColor: "#E50914"
                            
                            onLinkActivated: function(link) {
                                Qt.openUrlExternally(link)
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                                acceptedButtons: Qt.NoButton
                            }
                        }
                    }
                    
                    // Error message for terms validation
                    Text {
                        id: termsError
                        Layout.fillWidth: true
                        visible: showTermsError
                        text: "You must agree to the Terms of Service and Privacy Policy to continue"
                        font.pixelSize: 12
                        color: "#E50914"
                        wrapMode: Text.WordWrap
                    }
                }
                
                // Create account button
                Button {
                    text: "Create Account"
                    Layout.fillWidth: true
                    Layout.preferredHeight: fieldHeight
                    enabled: termsCheckbox.checked
                    
                    background: Rectangle {
                        color: parent.enabled ? (parent.hovered ? "#F5191F" : "#E50914") : "#2f2f2f"
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
                        // Clear previous error
                        showTermsError = false
                        
                        // Validate terms first
                        if (!termsCheckbox.checked) {
                            showTermsError = true
                            return
                        }
                        
                        // Validate other fields
                        if (nameField.text.length > 0 && 
                            emailField.text.length > 0 && 
                            passwordField.text.length >= 8 &&
                            passwordField.text === confirmPasswordField.text) {
                            
                            isAuthenticated = true
                            userEmail = emailField.text
                            navigateTo("/auth/verify")
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
                        text: "🍎 Sign up with Apple"
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
                        text: "🔍 Sign up with Google"
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
                
                // Sign in link
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 16
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
                        color: "#E50914"
                        
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
}