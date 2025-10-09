import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "styles"
import "screens"
import "components"

ApplicationWindow {
    id: appWindow
    visible: true
    width: 1280
    height: 720
    color: Theme.bg
    title: "IPTV Pro"
    
    property bool isOnline: true
    property bool updateRequired: false
    property bool hasError: false
    property bool bootComplete: false
    property string currentRoute: "splash"
    property bool isLargeScreen: width >= 1200
    
    function navigateTo(route) {
        currentRoute = route
    }
    
    StackLayout {
        anchors.fill: parent
        currentIndex: {
            if (!bootComplete) return 0
            if (updateRequired) return 1
            if (!isOnline) return 2
            if (hasError) return 3
            return 4
        }
        
        SplashScreen {
            onBootCompleted: {
                bootComplete = true
            }
        }
        
        UpdateRequired {}
        
        OfflineScreen {
            onRetryClicked: {
                isOnline = true
            }
        }
        
        ErrorFallback {
            onRetryClicked: {
                hasError = false
            }
        }
        
        Item {
            RowLayout {
                anchors.fill: parent
                spacing: 0
                
                Rectangle {
                    visible: isLargeScreen
                    Layout.preferredWidth: 240
                    Layout.fillHeight: true
                    color: Theme.surface
                    
                    Column {
                        anchors.fill: parent
                        anchors.margins: Theme.spacing4
                        spacing: Theme.spacing2
                        
                        Text {
                            text: "IPTV Pro"
                            font.pixelSize: Theme.font2Xl
                            font.bold: true
                            color: Theme.accent
                            width: parent.width
                        }
                        
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: Theme.border
                        }
                        
                        Repeater {
                            model: ["Home", "Browse", "Search", "Library", "Settings"]
                            
                            Rectangle {
                                width: parent.width
                                height: 48
                                radius: Theme.radiusSmall
                                color: "transparent"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: modelData
                                    font.pixelSize: Theme.fontBase
                                    color: Theme.text
                                }
                            }
                        }
                    }
                }
                
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    EmptyState {
                        icon: "🎬"
                        title: "Welcome to IPTV Pro"
                        subtitle: "Your content will appear here"
                        ctaText: "Browse Content"
                    }
                }
            }
            
            Rectangle {
                visible: !isLargeScreen
                anchors.bottom: parent.bottom
                width: parent.width
                height: 60
                color: Theme.surface
                
                Row {
                    anchors.centerIn: parent
                    spacing: Theme.spacing8
                    
                    Repeater {
                        model: ["Home", "Browse", "Search", "Library"]
                        
                        Text {
                            text: modelData
                            font.pixelSize: Theme.fontSm
                            color: Theme.textSecondary
                        }
                    }
                }
            }
        }
    }
    
    Toast {
        id: toast
        width: parent.width - Theme.spacing8 * 2
        x: Theme.spacing8
    }
}

