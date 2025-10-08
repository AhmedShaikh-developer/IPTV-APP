import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: errorScreen
    color: "#f8f9fa"
    
    property string errorMessage: "An unexpected error occurred"
    
    signal retry()
    signal contactSupport()
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 700)
        
        // Error icon
        Rectangle {
            width: 120
            height: 120
            radius: 60
            color: "#e74c3c"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: "⚠️"
                font.pixelSize: 60
                color: "white"
            }
        }
        
        // Error title and message
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Text {
                text: "Something Went Wrong"
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
            
            Text {
                text: "IPTV Pro - Error Recovery"
                font.pixelSize: 14
                color: "#95a5a6"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
        
        // Error details card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15
                
                Text {
                    text: "Error Details"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }
                
                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    Text {
                        text: generateErrorDetails()
                        font.pixelSize: 12
                        color: "#6c757d"
                        wrapMode: Text.WordWrap
                        width: parent.width
                    }
                }
            }
        }
        
        // Troubleshooting suggestions
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 180
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15
                
                Text {
                    text: "💡 Troubleshooting Suggestions"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }
                
                ColumnLayout {
                    spacing: 10
                    
                    TroubleshootingStep {
                        step: "1. Check your internet connection"
                        description: "Ensure you have a stable internet connection"
                    }
                    
                    TroubleshootingStep {
                        step: "2. Restart the application"
                        description: "Close and reopen the app to clear any temporary issues"
                    }
                    
                    TroubleshootingStep {
                        step: "3. Clear app cache"
                        description: "Clear cached data from app settings"
                    }
                    
                    TroubleshootingStep {
                        step: "4. Update the application"
                        description: "Make sure you're running the latest version"
                    }
                }
            }
        }
        
        // Action buttons
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Button {
                text: "🔄 Try Again"
                Layout.preferredWidth: 150
                Layout.preferredHeight: 50
                background: Rectangle {
                    color: "#3498db"
                    radius: 8
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: retry()
            }
            
            Button {
                text: "📧 Contact Support"
                Layout.preferredWidth: 170
                Layout.preferredHeight: 50
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
                onClicked: contactSupport()
            }
        }
        
        // Additional help
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#f8f9fa"
            radius: 8
            border.color: "#dee2e6"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 8
                
                Text {
                    text: "Need more help?"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#495057"
                }
                
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20
                    
                    Text {
                        text: "📚 Help Center"
                        font.pixelSize: 12
                        color: "#3498db"
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Qt.openUrlExternally("https://help.example.com")
                        }
                    }
                    
                    Text {
                        text: "💬 Live Chat"
                        font.pixelSize: 12
                        color: "#3498db"
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Qt.openUrlExternally("https://chat.example.com")
                        }
                    }
                    
                    Text {
                        text: "📞 Phone Support"
                        font.pixelSize: 12
                        color: "#3498db"
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Qt.openUrlExternally("tel:+1234567890")
                        }
                    }
                }
            }
        }
        
        // Error ID for support
        Text {
            text: "Error ID: ERR-" + generateErrorId()
            font.pixelSize: 10
            color: "#adb5bd"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
    }
    
    function generateErrorDetails() {
        return "Error Type: Application Exception\n" +
               "Timestamp: " + new Date().toISOString() + "\n" +
               "Platform: " + Qt.platform.os + "\n" +
               "Version: 2.1.3\n" +
               "Memory Usage: 145 MB\n" +
               "Stack Trace: \n" +
               "  at MainWindow.initialize() (main.cpp:45)\n" +
               "  at Application.startup() (app.cpp:23)\n" +
               "  at QCoreApplication.exec() (qtcore.cpp:156)\n\n" +
               "Context: User was attempting to load the main dashboard when this error occurred. " +
               "The application was in a stable state prior to this incident."
    }
    
    function generateErrorId() {
        return Math.random().toString(36).substr(2, 8).toUpperCase()
    }
}
