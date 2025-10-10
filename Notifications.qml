import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
            ScrollView {
                anchors.fill: parent
                anchors.margins: Math.max(20, parent.width * 0.05)
                
                ColumnLayout {
                    width: parent.width
                    spacing: 30
            
                    // Header
                    RowLayout {
                Layout.fillWidth: true
                spacing: 20
                
                Button {
                    text: "←"
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#2f2f2f"
                        radius: 25
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#ffffff"
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/main")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "📬 Notifications"
                        font.pixelSize: Math.min(parent.parent.width / 25, 36)
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Upcoming programs and app messages"
                        font.pixelSize: Math.min(parent.parent.width / 50, 16)
                        color: "#b3b3b3"
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }
                }
                
                Button {
                    text: "Clear All"
                    Layout.preferredHeight: 40
                    background: Rectangle {
                        color: "transparent"
                        radius: 4
                        border.color: "#564d4d"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#b3b3b3"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 15
                        rightPadding: 15
                    }
                }
            }
            
            // Upcoming Programs Section
            Text {
                text: "📅 Upcoming Programs"
                font.pixelSize: Math.min(parent.parent.width / 40, 20)
                font.bold: true
                color: "#ffffff"
            }
            
            Repeater {
                model: [
                    { channel: "HBO", program: "Game of Thrones S08E06", time: "Today at 9:00 PM", minutes: 45 },
                    { channel: "ESPN", program: "NBA Finals", time: "Today at 8:30 PM", minutes: 75 },
                    { channel: "BBC News", program: "Evening News", time: "Today at 7:00 PM", minutes: 15 }
                ]
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    color: "#181818"
                    radius: 8
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        Rectangle {
                            width: 60
                            height: 60
                            radius: 30
                            color: "#e50914"
                            
                            Text {
                                anchors.centerIn: parent
                                text: "📺"
                                font.pixelSize: 30
                            }
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5
                            
                            Text {
                                text: modelData.program
                                font.pixelSize: 16
                                font.bold: true
                                color: "#ffffff"
                            }
                            
                            Text {
                                text: modelData.channel + " • " + modelData.time
                                font.pixelSize: 14
                                color: "#b3b3b3"
                            }
                            
                            Text {
                                text: "Starts in " + modelData.minutes + " minutes"
                                font.pixelSize: 12
                                color: "#e50914"
                            }
                        }
                        
                        Button {
                            text: "⏰"
                            Layout.preferredWidth: 45
                            Layout.preferredHeight: 45
                            background: Rectangle {
                                color: "#2f2f2f"
                                radius: 22
                            }
                            contentItem: Text {
                                text: parent.text
                                font.pixelSize: 20
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }
            }
            
            // App Messages Section
            Text {
                text: "💬 App Messages"
                font.pixelSize: Math.min(parent.parent.width / 40, 20)
                font.bold: true
                color: "#ffffff"
                Layout.topMargin: 20
            }
            
            Repeater {
                model: [
                    { type: "info", title: "New Channels Added", message: "128 new HD channels available in Sports category", time: "2 hours ago" },
                    { type: "update", title: "EPG Updated", message: "TV Guide updated with 7 days of programming", time: "5 hours ago" },
                    { type: "warning", title: "Source Sync Required", message: "Premium IPTV source needs refresh", time: "1 day ago" }
                ]
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#181818"
                    radius: 8
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        Rectangle {
                            width: 50
                            height: 50
                            radius: 25
                            color: {
                                if (modelData.type === "info") return "#3498db"
                                if (modelData.type === "update") return "#27ae60"
                                return "#f39c12"
                            }
                            
                            Text {
                                anchors.centerIn: parent
                                text: {
                                    if (modelData.type === "info") return "ℹ️"
                                    if (modelData.type === "update") return "✓"
                                    return "⚠️"
                                }
                                font.pixelSize: 24
                            }
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Text {
                                text: modelData.title
                                font.pixelSize: 16
                                font.bold: true
                                color: "#ffffff"
                            }
                            
                            Text {
                                text: modelData.message
                                font.pixelSize: 14
                                color: "#b3b3b3"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                            }
                            
                            Text {
                                text: modelData.time
                                font.pixelSize: 12
                                color: "#564d4d"
                            }
                        }
                        
                        Button {
                            text: "✕"
                            Layout.preferredWidth: 35
                            Layout.preferredHeight: 35
                            background: Rectangle {
                                color: "#2f2f2f"
                                radius: 17
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#b3b3b3"
                                font.pixelSize: 16
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }
            }
        }
    }
}

