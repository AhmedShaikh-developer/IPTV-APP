import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: mainWindow
    
    // UI Components (defined early so they can be used throughout)
    component SectionGroup: ColumnLayout {
        property string title: ""
        Layout.fillWidth: true
        spacing: 8
        
        Text {
            text: title
            font.pixelSize: 14
            font.bold: true
            color: "#e50914"
            Layout.fillWidth: true
            Layout.bottomMargin: 5
        }
        
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: "#2f2f2f"
            Layout.bottomMargin: 8
        }
        
        children: parent.children
    }
    
    component SectionButton: Rectangle {
        property string text: ""
        property string icon: ""
        signal clicked()
        
        Layout.fillWidth: true
        Layout.preferredHeight: 45
        color: hoverArea.containsMouse ? "#2f2f2f" : "transparent"
        radius: 6
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12
            
            Text {
                text: icon
                font.pixelSize: 18
                color: "#e50914"
            }
            
            Text {
                text: parent.parent.text
                font.pixelSize: 14
                color: "#ffffff"
                Layout.fillWidth: true
            }
        }
        
        MouseArea {
            id: hoverArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.clicked()
        }
    }
    
    component NavItem: Button {
        property string itemText: ""
        property bool isSelected: false
        property bool isHighlighted: false
        
        Layout.fillWidth: true
        Layout.preferredHeight: 48
        
        background: Rectangle {
            color: "transparent"
            radius: 0
            
            // Red selection bar (2px) on the left
            Rectangle {
                width: 2
                height: parent.height
                color: "#e50914"
                visible: parent.parent.isSelected
            }
            
            // White focus outline (1px) when focused
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: "#ffffff"
                border.width: parent.parent.activeFocus ? 1 : 0
                radius: 4
            }
            
            // Hover/DPAD focus brightening effect
            Rectangle {
                anchors.fill: parent
                color: parent.parent.hovered ? "#ffffff" : "transparent"
                opacity: parent.parent.hovered ? 0.1 : 0
                radius: 4
                Behavior on opacity { NumberAnimation { duration: 150 } }
            }
        }
        
        contentItem: Text {
            text: itemText
            font.pixelSize: 15
            font.bold: isSelected
            color: "#ffffff"  // Always white for maximum visibility
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            leftPadding: 20  // Extra padding to account for selection bar
            
            // Add a subtle shadow for better contrast
            style: Text.Outline
            styleColor: "#000000"
        }
    }
    
    component PlaceholderScreen: Rectangle {
        property string title: ""
        property string description: ""
        property string icon: ""
        
        color: "#000000"
        
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 30
            
            Text {
                text: icon
                font.pixelSize: 80
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: title
                font.pixelSize: 36
                font.bold: true
                color: "#ffffff"
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: description
                font.pixelSize: 18
                color: "#b3b3b3"
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: 400
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }
            
            Button {
                text: "Back to Home"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 150
                Layout.preferredHeight: 40
                
                background: Rectangle {
                    color: "#e50914"
                    radius: 6
                }
                
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: navigateTo("/main")
            }
        }
    }
    
    visible: true
    width: 1200
    height: 800
    title: "IPTV Pro"
    color: backgroundColor
    
    property string currentRoute: "/main"
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
                case "/sources/add": return 18
                case "/sources/xtream": return 19
                case "/sources/m3u": return 20
                case "/sources/stalker": return 21
                case "/sources/single": return 22
                case "/sources/sync": return 23
                case "/sources/manage": return 24
                case "/sources/metadata": return 25
                case "/home": return 26
                case "/inbox": return 27
                case "/live": return 28
                case "/guide": return 29
                case "/movies": return 30
                case "/series": return 31
                case "/catchup": return 32
                case "/favorites": return 33
                case "/search": return 34
                case "/settings": return 35
                case "/account": return 36
                case "/main": return 37
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
        
        // Add Source Method
        AddSourceMethod {}
        
        // Xtream Form
        XtreamForm {}
        
        // M3U Form
        M3UForm {}
        
        // Stalker Form
        StalkerForm {}
        
        // Single Item Form
        SingleItemForm {}
        
        // Source Sync
        SourceSync {}
        
        // Source Manager
        SourceManager {}
        
        // Metadata Provider Settings
        MetaProviderSettings {}
        
        // Home / Dashboard
        Home {}
        
        // Notifications
        Notifications {}
        
        // Live TV
        PlaceholderScreen {
            title: "📡 Live TV"
            description: "Watch live television channels"
            icon: "📺"
        }
        
        // TV Guide
        PlaceholderScreen {
            title: "📅 TV Guide"
            description: "Browse upcoming programs and schedules"
            icon: "📅"
        }
        
        // Movies
        PlaceholderScreen {
            title: "🎬 Movies"
            description: "Browse and watch movies"
            icon: "🎥"
        }
        
        // Series
        PlaceholderScreen {
            title: "📺 Series"
            description: "Watch TV series and shows"
            icon: "📺"
        }
        
        // Catch-up
        PlaceholderScreen {
            title: "⏮️ Catch-up"
            description: "Watch previously aired programs"
            icon: "⏮️"
        }
        
        // Favorites
        PlaceholderScreen {
            title: "⭐ Favorites"
            description: "Your favorite channels and content"
            icon: "⭐"
        }
        
        // Search
        PlaceholderScreen {
            title: "🔍 Search"
            description: "Search for channels and content"
            icon: "🔍"
        }
        
        // Settings
        PlaceholderScreen {
            title: "⚙️ Settings"
            description: "Configure your IPTV experience"
            icon: "⚙️"
        }
        
        // Account
        PlaceholderScreen {
            title: "👤 Account"
            description: "Manage your account and profile"
            icon: "👤"
        }
        
        // Main Application (Netflix-style with sidebar)
        Rectangle {
            color: "#000000"
            
            RowLayout {
                anchors.fill: parent
                spacing: 0
                
                // Netflix-style Left Sidebar
            Rectangle {
                    Layout.preferredWidth: Math.min(280, parent.width * 0.22)
                    Layout.fillHeight: true
                    color: "#0f0f0f"  // Darker background for better contrast
                    border.color: "#2f2f2f"
                    border.width: 1
                
                ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 0
                        
                        // Netflix Logo Header
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 60
                            color: "transparent"
                            
                            RowLayout {
                    anchors.centerIn: parent
                                spacing: 10
                                
                                Rectangle {
                                    width: 40
                                    height: 40
                                    radius: 6
                                    color: "#e50914"
                
                    Text {
                                        anchors.centerIn: parent
                                        text: "N"
                                        font.pixelSize: 24
                        font.bold: true
                                        color: "white"
                                    }
                    }
                    
                    Text {
                                    text: "IPTV Pro"
                                    font.pixelSize: 20
                        font.bold: true
                                    color: "#e50914"
                                }
                            }
                        }
                        
                        // Navigation Items
                        ScrollView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.topMargin: 20
                            
                            ColumnLayout {
                                width: parent.width
                                spacing: 2
                                
                                // Primary Navigation
                                NavItem {
                                    itemText: "🏠 Home"
                                    isSelected: currentRoute === "/home"
                                    onClicked: navigateTo("/home")
                                }
                                
                                NavItem {
                                    itemText: "📡 Live TV"
                                    onClicked: navigateTo("/live")
                                }
                                
                                NavItem {
                                    itemText: "📅 TV Guide"
                                    onClicked: navigateTo("/guide")
                                }
                                
                                NavItem {
                                    itemText: "🎬 Movies"
                                    onClicked: navigateTo("/movies")
                                }
                                
                                NavItem {
                                    itemText: "📺 Series"
                                    onClicked: navigateTo("/series")
                                }
                                
                                NavItem {
                                    itemText: "⏮️ Catch-up"
                                    onClicked: navigateTo("/catchup")
                                }
                                
                                NavItem {
                                    itemText: "⭐ Favorites"
                                    onClicked: navigateTo("/favorites")
                                }
                                
                                NavItem {
                                    itemText: "🔍 Search"
                                    onClicked: navigateTo("/search")
                                }
                                
                                // Divider
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    Layout.topMargin: 15
                                    Layout.bottomMargin: 15
                                    Layout.leftMargin: 10
                                    Layout.rightMargin: 10
                                    color: "#404040"  // More visible divider
                                }
                                
                                // Settings & Account
                                NavItem {
                                    itemText: "⚙️ Settings"
                                    onClicked: navigateTo("/settings")
                                }
                                
                                NavItem {
                                    itemText: "👤 Account"
                                    onClicked: navigateTo("/account")
                                }
                                
                                NavItem {
                                    itemText: "👥 Profile Picker"
                                    onClicked: navigateTo("/profiles/pick")
                                }
                                
                                NavItem {
                                    itemText: "📬 Notifications"
                                    onClicked: navigateTo("/inbox")
                                }
                                
                                // Divider
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    Layout.topMargin: 15
                                    Layout.bottomMargin: 15
                                    Layout.leftMargin: 10
                                    Layout.rightMargin: 10
                                    color: "#404040"  // More visible divider
                                }
                                
                                // Quick Actions
                                NavItem {
                                    itemText: "➕ Add Source"
                                    isHighlighted: true
                                    onClicked: navigateTo("/sources/add")
                                }
                                
                                NavItem {
                                    itemText: "📋 Manage Sources"
                                    onClicked: navigateTo("/sources/manage")
                                }
                            }
                        }
                    }
                }
                
                // Main Content Area
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#000000"
                    
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 40
                        
                        // Hero Logo
                        Rectangle {
                            width: 200
                            height: 200
                            radius: 100
                            color: "#141414"
                            border.color: "#e50914"
                            border.width: 3
                            Layout.alignment: Qt.AlignHCenter
                            
                            Text {
                                anchors.centerIn: parent
                                text: "🎬"
                                font.pixelSize: 80
                                color: "#e50914"
                            }
                        }
                        
                        // Hero Title
                    Text {
                            text: "Welcome to IPTV Pro"
                            font.pixelSize: 48
                        font.bold: true
                        color: "#ffffff"
                        Layout.alignment: Qt.AlignHCenter
                        }
                        
                        // Hero Description
                        Text {
                            text: "Stream your favorite channels and content with a beautiful, intuitive interface"
                            font.pixelSize: 16
                            color: "#564d4d"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: 20
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                        }
                        
                        // Get Started Button
                        Button {
                            text: "Get Started"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 50
                            Layout.topMargin: 30
                            
                            background: Rectangle {
                                color: "#e50914"
                                radius: 8
                                border.color: "#e50914"
                                border.width: 2
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font.pixelSize: 18
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: navigateTo("/sources/add")
                        }
                        
                        // Quick Links
                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: 20
                            spacing: 30
                        
                        Button {
                                text: "Browse Channels"
                                Layout.preferredWidth: 150
                                Layout.preferredHeight: 40
                                
                                background: Rectangle {
                                    color: "transparent"
                                    radius: 6
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
                                
                                onClicked: navigateTo("/live")
                        }
                        
                        Button {
                                text: "View Plans"
                                Layout.preferredWidth: 150
                                Layout.preferredHeight: 40
                                
                                background: Rectangle {
                                    color: "transparent"
                                    radius: 6
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
                                
                                onClicked: navigateTo("/billing/plans")
                            }
                        }
                    }
                }
            }
        }
    }
    
    AppDrawer {
        id: appDrawer
    }
}

