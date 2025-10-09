import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property bool showMiniPlayer: true
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Mini-Player Top Bar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: showMiniPlayer ? 80 : 0
            color: "#141414"
            visible: showMiniPlayer
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 20
                
                Rectangle {
                    width: 100
                    height: 56
                    radius: 4
                    color: "#2f2f2f"
                    
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
                        text: "BBC News HD"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "News • Live"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                }
                
                RowLayout {
                    spacing: 15
                    
                    Button {
                        text: "⏸️"
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        background: Rectangle {
                            color: "#e50914"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    
                    Button {
                        text: "✕"
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        background: Rectangle {
                            color: "#2f2f2f"
                            radius: 20
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#b3b3b3"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: showMiniPlayer = false
                    }
                }
            }
        }
        
        // Main Content
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            Rectangle {
                width: parent.width
                color: "transparent"
                anchors.margins: 20
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 40
                
                // Continue Watching Rail
                Column {
                    width: parent.width
                    spacing: 20
                    topPadding: 30
                    leftPadding: Math.max(20, parent.width * 0.05)
                    rightPadding: Math.max(20, parent.width * 0.05)
                    
                    Text {
                        text: "▶️ Continue Watching"
                        font.pixelSize: Math.min(parent.parent.width / 40, 24)
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Flow {
                        width: parent.width
                        spacing: 20
                        
                        Repeater {
                            model: 5
                            
                            Rectangle {
                                width: Math.min(280, parent.width / 4.5)
                                height: Math.min(160, parent.width / 7.5)
                                radius: 8
                                color: "#181818"
                                
                                Column {
                                    anchors.fill: parent
                                    
                                    Rectangle {
                                        width: parent.width
                                        height: 120
                                        radius: 8
                                        color: "#2f2f2f"
                                        
                                        Text {
                                            anchors.centerIn: parent
                                            text: "🎬"
                                            font.pixelSize: 40
                                        }
                                        
                                        Rectangle {
                                            anchors.bottom: parent.bottom
                                            width: parent.width * 0.65
                                            height: 4
                                            color: "#e50914"
                                        }
                                    }
                                    
                                    Text {
                                        text: "Movie Title " + (index + 1)
                                        font.pixelSize: 14
                                        color: "#ffffff"
                                        leftPadding: 10
                                        topPadding: 8
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Favorites Rail
                Column {
                    width: parent.width
                    spacing: 20
                    leftPadding: Math.max(20, parent.width * 0.05)
                    rightPadding: Math.max(20, parent.width * 0.05)
                    
                    Text {
                        text: "⭐ Favorites"
                        font.pixelSize: Math.min(parent.parent.width / 40, 24)
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Flow {
                        width: parent.width
                        spacing: 20
                        
                        Repeater {
                            model: 6
                            
                            Rectangle {
                                width: Math.min(180, parent.width / 5)
                                height: Math.min(100, parent.width / 9)
                                radius: 8
                                color: "#2f2f2f"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "📺"
                                    font.pixelSize: 40
                                }
                            }
                        }
                    }
                }
                
                // Live Categories Rail
                Column {
                    width: parent.width
                    spacing: 20
                    leftPadding: Math.max(20, parent.width * 0.05)
                    rightPadding: Math.max(20, parent.width * 0.05)
                    
                    Text {
                        text: "📡 Live Categories"
                        font.pixelSize: Math.min(parent.parent.width / 40, 24)
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Flow {
                        width: parent.width
                        spacing: 20
                        
                        Repeater {
                            model: ["Sports", "News", "Entertainment", "Kids", "Movies", "Music"]
                            
                            Rectangle {
                                width: Math.min(200, parent.width / 4)
                                height: Math.min(120, parent.width / 6.7)
                                radius: 8
                                color: "#181818"
                                border.color: "#2f2f2f"
                                border.width: 1
                                
                                Column {
                                    anchors.centerIn: parent
                                    spacing: 10
                                    
                                    Text {
                                        text: ["⚽", "📰", "🎭", "🧒", "🎬", "🎵"][index]
                                        font.pixelSize: 40
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                    
                                    Text {
                                        text: modelData
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#ffffff"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Movies Rail
                Column {
                    width: parent.width
                    spacing: 20
                    leftPadding: Math.max(20, parent.width * 0.05)
                    rightPadding: Math.max(20, parent.width * 0.05)
                    
                    Text {
                        text: "🎬 Movies"
                        font.pixelSize: Math.min(parent.parent.width / 40, 24)
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Flow {
                        width: parent.width
                        spacing: 20
                        
                        Repeater {
                            model: 6
                            
                            Rectangle {
                                width: Math.min(160, parent.width / 5.5)
                                height: Math.min(240, parent.width * 1.5)
                                radius: 8
                                color: "#2f2f2f"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "🎥"
                                    font.pixelSize: 50
                                }
                            }
                        }
                    }
                }
                
                // Series Rail
                Column {
                    width: parent.width
                    spacing: 20
                    leftPadding: Math.max(20, parent.width * 0.05)
                    rightPadding: Math.max(20, parent.width * 0.05)
                    
                    Text {
                        text: "📺 Series"
                        font.pixelSize: Math.min(parent.parent.width / 40, 24)
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Flow {
                        width: parent.width
                        spacing: 20
                        
                        Repeater {
                            model: 6
                            
                            Rectangle {
                                width: Math.min(160, parent.width / 5.5)
                                height: Math.min(240, parent.width * 1.5)
                                radius: 8
                                color: "#2f2f2f"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "📺"
                                    font.pixelSize: 50
                                }
                            }
                        }
                    }
                }
                
                // Catch-up Rail
                Column {
                    width: parent.width
                    spacing: 20
                    leftPadding: Math.max(20, parent.width * 0.05)
                    rightPadding: Math.max(20, parent.width * 0.05)
                    
                    Text {
                        text: "⏮️ Catch-up"
                        font.pixelSize: Math.min(parent.parent.width / 40, 24)
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Flow {
                        width: parent.width
                        spacing: 20
                        
                        Repeater {
                            model: 5
                            
                            Rectangle {
                                width: Math.min(280, parent.width / 4.5)
                                height: Math.min(160, parent.width / 7.5)
                                radius: 8
                                color: "#181818"
                                
                                Column {
                                    anchors.fill: parent
                                    spacing: 10
                                    topPadding: 10
                                    
                                    Rectangle {
                                        width: parent.width - 20
                                        height: 100
                                        radius: 6
                                        color: "#2f2f2f"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        
                                        Text {
                                            anchors.centerIn: parent
                                            text: "📡"
                                            font.pixelSize: 35
                                        }
                                    }
                                    
                                    Text {
                                        text: "Program " + (index + 1)
                                        font.pixelSize: 13
                                        color: "#ffffff"
                                        leftPadding: 10
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Recently Added Rail
                Column {
                    width: parent.width
                    spacing: 20
                    leftPadding: Math.max(20, parent.width * 0.05)
                    rightPadding: Math.max(20, parent.width * 0.05)
                    bottomPadding: 40
                    
                    Text {
                        text: "🆕 Recently Added"
                        font.pixelSize: Math.min(parent.parent.width / 40, 24)
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Flow {
                        width: parent.width
                        spacing: 20
                        
                        Repeater {
                            model: 6
                            
                            Rectangle {
                                width: Math.min(200, parent.width / 4)
                                height: Math.min(120, parent.width / 6.7)
                                radius: 8
                                color: "#181818"
                                border.color: "#e50914"
                                border.width: 1
                                
                                ColumnLayout {
                                    anchors.centerIn: parent
                                    spacing: 10
                                    
                                    Text {
                                        text: "🎬"
                                        font.pixelSize: 40
                                        Layout.alignment: Qt.AlignHCenter
                                    }
                                    
                                    Rectangle {
                                        Layout.preferredWidth: 60
                                        Layout.preferredHeight: 22
                                        radius: 11
                                        color: "#e50914"
                                        Layout.alignment: Qt.AlignHCenter
                                        
                                        Text {
                                            anchors.centerIn: parent
                                            text: "NEW"
                                            font.pixelSize: 10
                                            font.bold: true
                                            color: "white"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                }
            }
        }
    }
}

