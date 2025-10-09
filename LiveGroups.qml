import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 20
        
        ColumnLayout {
            width: parent.width
            spacing: 20
            
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
                    onClicked: navigateTo("/home")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "📡 Live Categories"
                        font.pixelSize: 32
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Browse channels by category"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Category Grid
            GridLayout {
                Layout.fillWidth: true
                columns: Math.max(1, Math.floor(parent.width / 300))
                rowSpacing: 20
                columnSpacing: 20
                
                Repeater {
                    model: [
                        { name: "Sports", icon: "⚽", color: "#e50914", channels: 45 },
                        { name: "News", icon: "📰", color: "#3498db", channels: 28 },
                        { name: "Entertainment", icon: "🎭", color: "#9b59b6", channels: 67 },
                        { name: "Movies", icon: "🎬", color: "#e74c3c", channels: 34 },
                        { name: "Kids", icon: "🧒", color: "#f39c12", channels: 23 },
                        { name: "Music", icon: "🎵", color: "#1abc9c", channels: 19 },
                        { name: "Documentary", icon: "📚", color: "#34495e", channels: 31 },
                        { name: "Lifestyle", icon: "🏠", color: "#e67e22", channels: 26 },
                        { name: "International", icon: "🌍", color: "#27ae60", channels: 89 },
                        { name: "Local", icon: "🏘️", color: "#8e44ad", channels: 15 }
                    ]
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 120
                        color: "#181818"
                        radius: 12
                        border.color: "#2f2f2f"
                        border.width: 1
                        
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 10
                            
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 15
                                
                                Rectangle {
                                    width: 40
                                    height: 40
                                    radius: 20
                                    color: modelData.color
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.icon
                                        font.pixelSize: 20
                                        color: "white"
                                    }
                                }
                                
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2
                                    
                                    Text {
                                        text: modelData.name
                                        font.pixelSize: 18
                                        font.bold: true
                                        color: "#ffffff"
                                    }
                                    
                                    Text {
                                        text: modelData.channels + " channels"
                                        font.pixelSize: 12
                                        color: "#b3b3b3"
                                    }
                                }
                            }
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: navigateTo("/live/channels?category=" + modelData.name)
                        }
                    }
                }
            }
        }
    }
}
