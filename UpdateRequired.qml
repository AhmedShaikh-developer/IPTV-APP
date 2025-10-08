import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: updateScreen
    color: "#f8f9fa"
    
    signal updateCompleted()
    signal skipUpdate()
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 800)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30
            
            // Header
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20
                
                // Update icon
                Rectangle {
                    width: 100
                    height: 100
                    radius: 50
                    color: "#e74c3c"
                    Layout.alignment: Qt.AlignHCenter
                    
                    Text {
                        anchors.centerIn: parent
                        text: "🔄"
                        font.pixelSize: 50
                        color: "white"
                    }
                }
                
                Text {
                    text: "Update Required"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#2c3e50"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "A new version is available and required to continue using the application."
                    font.pixelSize: 16
                    color: "#7f8c8d"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
            }
            
            // Version info card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: "white"
                radius: 12
                border.color: "#e9ecef"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Text {
                            text: "Current Version:"
                            font.pixelSize: 14
                            color: "#6c757d"
                        }
                        
                        Text {
                            text: "2.1.3"
                            font.pixelSize: 14
                            font.bold: true
                            color: "#2c3e50"
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Text {
                            text: "Available Version:"
                            font.pixelSize: 14
                            color: "#6c757d"
                        }
                        
                        Text {
                            text: "2.2.0"
                            font.pixelSize: 14
                            font.bold: true
                            color: "#27ae60"
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: "#e9ecef"
                    }
                    
                    Text {
                        text: "📦 Size: 45.2 MB"
                        font.pixelSize: 12
                        color: "#6c757d"
                    }
                }
            }
            
            // Changelog card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 300
                color: "white"
                radius: 12
                border.color: "#e9ecef"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15
                    
                    Text {
                        text: "What's New in v2.2.0"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#2c3e50"
                    }
                    
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 12
                            
                            ChangelogItem {
                                type: "feature"
                                title: "New Dashboard Design"
                                description: "Completely redesigned dashboard with improved navigation and better user experience."
                            }
                            
                            ChangelogItem {
                                type: "feature"
                                title: "Enhanced Security"
                                description: "Added two-factor authentication and improved data encryption."
                            }
                            
                            ChangelogItem {
                                type: "improvement"
                                title: "Performance Optimizations"
                                description: "Reduced app startup time by 40% and improved memory usage."
                            }
                            
                            ChangelogItem {
                                type: "bugfix"
                                title: "Bug Fixes"
                                description: "Fixed crashes when switching between accounts and resolved sync issues."
                            }
                            
                            ChangelogItem {
                                type: "security"
                                title: "Security Updates"
                                description: "Updated security protocols and fixed potential vulnerabilities."
                            }
                        }
                    }
                }
            }
            
            // Action buttons
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20
                
                Button {
                    text: "Update Now"
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#27ae60"
                        radius: 8
                        border.color: "#27ae60"
                        border.width: 2
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
                        // Simulate update process
                        updateInProgress = true
                        updateTimer.start()
                    }
                }
                
                Button {
                    text: "Update Later"
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 50
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
                    onClicked: skipUpdate()
                }
            }
            
            // Store buttons
            Text {
                text: "Or update from your app store:"
                font.pixelSize: 14
                color: "#6c757d"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                
                Button {
                    text: "📱 App Store"
                    Layout.preferredHeight: 45
                    background: Rectangle {
                        color: "#007AFF"
                        radius: 8
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: Qt.openUrlExternally("https://apps.apple.com")
                }
                
                Button {
                    text: "🤖 Google Play"
                    Layout.preferredHeight: 45
                    background: Rectangle {
                        color: "#01875F"
                        radius: 8
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: Qt.openUrlExternally("https://play.google.com")
                }
            }
        }
    }
    
    property bool updateInProgress: false
    
    // Update progress overlay
    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: updateInProgress ? 0.8 : 0
        visible: updateInProgress
        z: 1000
        
        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }
        
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 30
            
            Rectangle {
                width: 80
                height: 80
                radius: 40
                color: "#3498db"
                Layout.alignment: Qt.AlignHCenter
                
                Text {
                    anchors.centerIn: parent
                    text: "🔄"
                    font.pixelSize: 40
                    color: "white"
                }
                
                RotationAnimation on rotation {
                    running: updateInProgress
                    loops: Animation.Infinite
                    duration: 1000
                    from: 0
                    to: 360
                }
            }
            
            Text {
                text: "Updating Application..."
                font.pixelSize: 20
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Please don't close the application"
                font.pixelSize: 14
                color: "#bdc3c7"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
    
    Timer {
        id: updateTimer
        interval: 3000
        onTriggered: {
            updateInProgress = false
            updateCompleted()
        }
    }
}
