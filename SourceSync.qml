import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import IPTVBackend 1.0

Rectangle {
    color: "#000000"
    
    property int currentStep: 0
    property int totalChannels: PlaylistManager.liveChannelsModel ? PlaylistManager.liveChannelsModel.rowCount : 0
    property int totalVodItems: PlaylistManager.vodItemsModel ? PlaylistManager.vodItemsModel.rowCount : 0
    property int processedChannels: 0
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 700)
        
        // Progress Icon
        Rectangle {
            width: 120
            height: 120
            radius: 60
            color: "#e50914"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: currentStep < 5 ? "🔄" : "✓"
                font.pixelSize: 60
                color: "white"
            }
            
            RotationAnimation on rotation {
                running: currentStep < 5
                loops: Animation.Infinite
                duration: 2000
                from: 0
                to: 360
            }
        }
        
        // Title
        Text {
            text: currentStep < 5 ? "Syncing Source..." : "Sync Complete!"
            font.pixelSize: 36
            font.bold: true
            color: "#ffffff"
            Layout.alignment: Qt.AlignHCenter
        }
        
        // Progress Steps
        Column {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 15
            
            SyncStep {
                stepText: "Parsing playlist..."
                isActive: currentStep === 0
                isDone: currentStep > 0
            }
            
            SyncStep {
                stepText: "Downloading channel logos..."
                isActive: currentStep === 1
                isDone: currentStep > 1
            }
            
            SyncStep {
                stepText: "Merging EPG data..."
                isActive: currentStep === 2
                isDone: currentStep > 2
            }
            
            SyncStep {
                stepText: "Building channel index..."
                isActive: currentStep === 3
                isDone: currentStep > 3
            }
            
            SyncStep {
                stepText: "Finalizing..."
                isActive: currentStep === 4
                isDone: currentStep > 4
            }
        }
        
        // Stats
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "#181818"
            radius: 8
            visible: currentStep >= 5
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 30
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5
                    
                    Text {
                        text: totalChannels.toLocaleString(Qt.locale(), "f", 0)
                        font.pixelSize: 32
                        font.bold: true
                        color: "#e50914"
                    }
                    
                    Text {
                        text: "Channels"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                }
                
                Rectangle {
                    width: 1
                    height: 60
                    color: "#2f2f2f"
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5
                    
                    Text {
                        text: totalVodItems.toLocaleString(Qt.locale(), "f", 0)
                        font.pixelSize: 32
                        font.bold: true
                        color: "#27ae60"
                    }
                    
                    Text {
                        text: totalVodItems === 1 ? "VOD Item" : "VOD Items"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                }
                
                Rectangle {
                    width: 1
                    height: 60
                    color: "#2f2f2f"
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5
                    
                    Text {
                        text: "EPG: 7 days"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#3498db"
                    }
                    
                    Text {
                        text: "Program Guide"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                }
            }
        }
        
        // Done Button
        Button {
            text: "✓ Done"
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            visible: currentStep >= 5
            background: Rectangle {
                color: "#27ae60"
                radius: 4
            }
            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: 18
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: navigateTo("/sources/manage")
        }
    }
    
    component SyncStep: Row {
        property string stepText: ""
        property bool isActive: false
        property bool isDone: false
        spacing: 15
        
        Text {
            text: isDone ? "✓" : (isActive ? "⏳" : "○")
            font.pixelSize: 20
            color: isDone ? "#27ae60" : (isActive ? "#e50914" : "#564d4d")
        }
        
        Text {
            text: stepText
            font.pixelSize: 18
            color: isDone ? "#ffffff" : (isActive ? "#ffffff" : "#564d4d")
        }
    }
    
    Timer {
        interval: 1500
        repeat: true
        running: currentStep < 5
        onTriggered: {
            if (currentStep < 5) {
                currentStep++
                console.log("Sync step:", currentStep, "Channels:", totalChannels, "VOD:", totalVodItems)
            } else {
                console.log("Sync complete! Channels:", totalChannels, "VOD:", totalVodItems)
            }
        }
    }
    
    Component.onCompleted: {
        console.log("=== SourceSync screen loaded ===")
        console.log("Initial channels:", totalChannels)
        console.log("Initial VOD items:", totalVodItems)
        currentStep = 0  // Start sync animation
    }
}

