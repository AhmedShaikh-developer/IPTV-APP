import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1200
    height: 800
    title: "IPTV Pro"
    color: backgroundColor
    
    property string currentRoute: "/boot"
    property bool isOnline: true
    property bool hasValidAuth: false
    property bool requiresUpdate: false
    property string errorMessage: ""
    
    // Authentication state
    property bool isAuthenticated: false
    property string userEmail: ""
    property string subscriptionStatus: "free" // free, trial, active, expired, cancelled
    property bool hasActiveSubscription: false
    
    // Netflix theme colors
    readonly property color primaryColor: "#141414"      // Netflix dark background
    readonly property color secondaryColor: "#e50914"    // Netflix red
    readonly property color accentColor: "#f5f5f1"       // Netflix white
    readonly property color backgroundColor: "#000000"   // Pure black
    readonly property color cardColor: "#181818"         // Dark gray cards
    readonly property color textColor: "#ffffff"         // White text
    readonly property color lightTextColor: "#b3b3b3"    // Light gray text
    readonly property color netflixRed: "#e50914"        // Netflix signature red
    readonly property color netflixDarkGray: "#2f2f2f"   // Netflix dark gray
    readonly property color netflixLightGray: "#564d4d"  // Netflix light gray
    
    // Navigation system
    function navigateTo(route) {
        console.log("Navigating to:", route)
        currentRoute = route
    }
    
    function showError(message) {
        errorMessage = message
        navigateTo("/error")
    }
    
    // Bootstrap checks simulation
    Timer {
        id: bootstrapTimer
        interval: 3000
        running: currentRoute === "/boot"
        onTriggered: {
            // Simulate bootstrap checks - always go to main for testing
            navigateTo("/main")
        }
    }
    
    // Main content area with routing
    StackLayout {
        id: mainStack
        anchors.fill: parent
        currentIndex: getCurrentIndex()
        
        function getCurrentIndex() {
            switch(currentRoute) {
                case "/boot": return 0
                case "/update-required": return 1
                case "/offline": return 2
                case "/error": return 3
                case "/welcome": return 4
                case "/auth/sign-in": return 5
                case "/auth/sign-up": return 6
                case "/auth/verify": return 7
                case "/auth/reset": return 8
                case "/auth/pair": return 9
                case "/billing/plans": return 10
                case "/billing/checkout": return 11
                case "/billing/status": return 12
                case "/account/devices": return 13
                case "/profiles/pick": return 14
                case "/profiles/manage": return 15
                case "/pin": return 16
                case "/settings/parental": return 17
                case "/main": return 18
                default: return 0
            }
        }
        
        // Splash Screen
        Rectangle {
            color: "#2c3e50"
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 40
                width: Math.min(parent.width * 0.8, 600)
                
                // App Logo
                Rectangle {
                    width: 120
                    height: 120
                    radius: 60
                    color: "#3498db"
                    Layout.alignment: Qt.AlignHCenter
                    
                    Text {
                        anchors.centerIn: parent
                        text: "🚀"
                        font.pixelSize: 60
                        color: "white"
                    }
                    
                    RotationAnimation on rotation {
                        running: true
                        loops: Animation.Infinite
                        duration: 2000
                        from: 0
                        to: 360
                    }
                }
                
                Text {
                    text: "App Shell & System"
                    font.pixelSize: 36
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                
                Button {
                    text: "Continue"
                    Layout.alignment: Qt.AlignHCenter
                    background: Rectangle {
                        color: "#3498db"
                        radius: 8
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/main")
                }
            }
        }
        
        // Update Required Screen
        Rectangle {
            color: "#f8f9fa"
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 30
                width: Math.min(parent.width * 0.8, 600)
                
                Text {
                    text: "🔄 Update Required"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#2c3e50"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "A new version is available and required to continue."
                    font.pixelSize: 16
                    color: "#7f8c8d"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
                
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20
                    
                    Button {
                        text: "Update Now"
                        background: Rectangle {
                            color: "#27ae60"
                            radius: 8
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: navigateTo("/main")
                    }
                    
                    Button {
                        text: "Skip Update"
                        background: Rectangle {
                            color: "transparent"
                            radius: 8
                            border.color: "#6c757d"
                            border.width: 2
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#6c757d"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: navigateTo("/main")
                    }
                }
            }
        }
        
        // Offline Screen
        Rectangle {
            color: "#f8f9fa"
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 30
                width: Math.min(parent.width * 0.8, 600)
                
                Text {
                    text: "📡 You're Offline"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#2c3e50"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "Check your internet connection and try again."
                    font.pixelSize: 16
                    color: "#7f8c8d"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Button {
                    text: "🔄 Retry Connection"
                    Layout.alignment: Qt.AlignHCenter
                    background: Rectangle {
                        color: "#3498db"
                        radius: 8
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        isOnline = true
                        navigateTo("/boot")
                    }
                }
            }
        }
        
        // Error Fallback Screen
        Rectangle {
            color: "#f8f9fa"
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 30
                width: Math.min(parent.width * 0.8, 600)
                
                Text {
                    text: "⚠️ Something Went Wrong"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#2c3e50"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: errorMessage
                    font.pixelSize: 16
                    color: "#7f8c8d"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
                
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20
                    
                    Button {
                        text: "🔄 Try Again"
                        background: Rectangle {
                            color: "#3498db"
                            radius: 8
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: navigateTo("/boot")
                    }
                    
                    Button {
                        text: "📧 Contact Support"
                        background: Rectangle {
                            color: "transparent"
                            radius: 8
                            border.color: "#e74c3c"
                            border.width: 2
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#e74c3c"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: Qt.openUrlExternally("mailto:support@example.com")
                    }
                }
            }
        }
        
        // Welcome Screen
        Welcome {}
        
        // Sign In Screen
        SignIn {}
        
        // Sign Up Screen
        SignUp {}
        
        // Verify Email Screen
        VerifyEmail {}
        
        // Password Reset Screen
        PasswordReset {}
        
        // Device Pairing Screen
        PairByCode {}
        
        // Plans & Pricing Screen
        Plans {}
        
        // Checkout Screen
        Checkout {}
        
        // Billing Status Screen
        SubStatus {}
        
        // Account Devices Screen
        DeviceManager {}
        
        // Profile Picker
        ProfilePicker {}
        
        // Profile Manager
        ProfileManager {}
        
        // PIN Pad
        PinPad {}
        
        // Parental Settings
        ParentalSettings {}
        
        // Main Application (placeholder)
        Rectangle {
            color: "#000000"
            
            Rectangle {
                anchors.centerIn: parent
                width: 800
                height: 600
                color: "#181818"
                radius: 8
                border.color: "#e50914"
                border.width: 2
                
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 30
                
                    Text {
                        text: "🎬 IPTV Pro - Netflix Style"
                        font.pixelSize: 32
                        font.bold: true
                        color: "#e50914"
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    Text {
                        text: "🔐 Netflix Style Authentication Screens"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#ffffff"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    GridLayout {
                        Layout.alignment: Qt.AlignHCenter
                        columns: 4
                        rowSpacing: 15
                        columnSpacing: 15
                        
                        Button {
                            text: "Welcome"
                            onClicked: navigateTo("/welcome")
                        }
                        
                        Button {
                            text: "Sign In"
                            onClicked: navigateTo("/auth/sign-in")
                        }
                        
                        Button {
                            text: "Sign Up"
                            onClicked: navigateTo("/auth/sign-up")
                        }
                        
                        Button {
                            text: "Plans"
                            onClicked: navigateTo("/billing/plans")
                        }
                        
                        Button {
                            text: "Checkout"
                            onClicked: navigateTo("/billing/checkout")
                        }
                        
                        Button {
                            text: "Subscription Status"
                            onClicked: navigateTo("/billing/status")
                        }
                        
                        Button {
                            text: "My Devices"
                            onClicked: navigateTo("/account/devices")
                        }
                        
                        Button {
                            text: "Verify Email"
                            onClicked: navigateTo("/auth/verify")
                        }
                        
                        Button {
                            text: "Reset Password"
                            onClicked: navigateTo("/auth/reset")
                        }
                        
                        Button {
                            text: "TV Pairing"
                            onClicked: navigateTo("/auth/pair")
                        }
                        
                        Button {
                            text: "Test Offline"
                            onClicked: {
                                isOnline = false
                                navigateTo("/offline")
                            }
                        }
                    }
                    
                    Text {
                        text: "👤 Profile & Parental Controls"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#ffffff"
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 20
                    }
                    
                    GridLayout {
                        Layout.alignment: Qt.AlignHCenter
                        columns: 4
                        rowSpacing: 15
                        columnSpacing: 15
                        
                        Button {
                            text: "Profile Picker"
                            onClicked: navigateTo("/profiles/pick")
                        }
                        
                        Button {
                            text: "Manage Profiles"
                            onClicked: navigateTo("/profiles/manage")
                        }
                        
                        Button {
                            text: "PIN Lock"
                            onClicked: navigateTo("/pin")
                        }
                        
                        Button {
                            text: "Parental Settings"
                            onClicked: navigateTo("/settings/parental")
                        }
                    }
                }
            }
        }
    }
}
