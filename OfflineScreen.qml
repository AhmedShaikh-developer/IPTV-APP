import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: offlineScreen
    color: "#f8f9fa"
    
    signal retryConnection()
    signal goToDownloads()
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 600)
        
        // Offline icon
        Rectangle {
            width: 120
            height: 120
            radius: 60
            color: "#e74c3c"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: "📡"
                font.pixelSize: 60
                color: "white"
            }
        }
        
        // Title and description
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15
            
            Text {
                text: "You're Offline"
                font.pixelSize: 32
                font.bold: true
                color: "#2c3e50"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Check your internet connection and try again. Some features may be available in limited mode."
                font.pixelSize: 16
                color: "#7f8c8d"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }
        }
        
        // Connection status card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20
                
                Rectangle {
                    width: 60
                    height: 60
                    radius: 30
                    color: "#e74c3c"
                    Layout.alignment: Qt.AlignVCenter
                    
                    Text {
                        anchors.centerIn: parent
                        text: "❌"
                        font.pixelSize: 30
                        color: "white"
                    }
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5
                    
                    Text {
                        text: "No Internet Connection"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#2c3e50"
                    }
                    
                    Text {
                        text: "Last connected: 5 minutes ago"
                        font.pixelSize: 14
                        color: "#6c757d"
                    }
                    
                    Text {
                        text: "IPTV Pro - Offline Mode"
                        font.pixelSize: 12
                        color: "#95a5a6"
                    }
                }
            }
        }
        
        // Limited features available
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15
                
                Text {
                    text: "Available in Limited Mode"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }
                
                ColumnLayout {
                    spacing: 8
                    
                    LimitedFeature {
                        feature: "📱 Downloaded Content"
                        status: "Available"
                        available: true
                    }
                    
                    LimitedFeature {
                        feature: "📖 Cached Articles"
                        status: "Available"
                        available: true
                    }
                    
                    LimitedFeature {
                        feature: "🔄 Sync & Updates"
                        status: "Unavailable"
                        available: false
                    }
                    
                    LimitedFeature {
                        feature: "☁️ Cloud Storage"
                        status: "Unavailable"
                        available: false
                    }
                }
            }
        }
        
        // Action buttons
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Button {
                text: "🔄 Retry Connection"
                Layout.preferredWidth: 200
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
                onClicked: retryConnection()
            }
            
            Button {
                text: "📥 Go to Downloads"
                Layout.preferredWidth: 180
                Layout.preferredHeight: 50
                background: Rectangle {
                    color: "transparent"
                    radius: 8
                    border.color: "#3498db"
                    border.width: 2
                }
                contentItem: Text {
                    text: parent.text
                    color: "#3498db"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: goToDownloads()
            }
        }
        
        // Diagnostics section
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "#f8f9fa"
            radius: 8
            border.color: "#dee2e6"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10
                
                Text {
                    text: "🔧 Diagnostics"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#495057"
                }
                
                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    rowSpacing: 5
                    columnSpacing: 20
                    
                    Text {
                        text: "Network Interface:"
                        font.pixelSize: 12
                        color: "#6c757d"
                    }
                    
                    Text {
                        text: "WiFi (Disabled)"
                        font.pixelSize: 12
                        color: "#e74c3c"
                    }
                    
                    Text {
                        text: "DNS Status:"
                        font.pixelSize: 12
                        color: "#6c757d"
                    }
                    
                    Text {
                        text: "Unreachable"
                        font.pixelSize: 12
                        color: "#e74c3c"
                    }
                    
                    Text {
                        text: "Proxy Settings:"
                        font.pixelSize: 12
                        color: "#6c757d"
                    }
                    
                    Text {
                        text: "None"
                        font.pixelSize: 12
                        color: "#27ae60"
                    }
                }
            }
        }
        
        // Help text
        Text {
            text: "Need help? Check your network settings or contact support if the problem persists."
            font.pixelSize: 12
            color: "#6c757d"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
