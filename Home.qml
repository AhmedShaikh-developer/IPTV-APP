import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property bool showMiniPlayer: false
    
    // Background gradient
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#0D0D0D" }
        GradientStop { position: 1.0; color: "#000000" }
    }
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 32
        
        ColumnLayout {
            width: parent.width
            spacing: 48
            
            // Continue Watching Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: "transparent"
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 16
                    
                    // Section Header
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16
                        
                        Text {
                            text: "Continue Watching"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 2
                            color: "#E50914"
                            radius: 1
                        }
                    }
                    
                    // Media Cards Row
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        
                        Row {
                            spacing: 24
                            
                            Repeater {
                                model: [
                                    { title: "The Crown", subtitle: "Drama", progress: 0.65 },
                                    { title: "Stranger Things", subtitle: "Sci-Fi", progress: 0.30 },
                                    { title: "Ozark", subtitle: "Crime", progress: 0.80 },
                                    { title: "The Witcher", subtitle: "Fantasy", progress: 0.45 },
                                    { title: "Money Heist", subtitle: "Thriller", progress: 0.20 },
                                    { title: "Dark", subtitle: "Mystery", progress: 0.90 }
                                ]
                                
                                Rectangle {
                                    width: 220
                                    height: 130
                                    radius: 12
                                    color: "#111111"
                                    
                                    // Simple shadow effect
                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.margins: -4
                                        anchors.topMargin: 0
                                        radius: parent.radius + 2
                                        color: "#00000080"
                                        z: -1
                                    }
                                    
                                    // Hover animation
                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    
                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        
                                        onEntered: {
                                            parent.scale = 1.08
                                        }
                                        
                                        onExited: {
                                            parent.scale = 1.0
                                        }
                                        
                                        onClicked: {
                                            console.log("Clicked:", modelData.title)
                                        }
                                    }
                                    
                                    // Card content
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: parent.radius
                                        color: "#1A1A1A"
                                        border.color: parent.scale > 1.0 ? "#E50914" : "transparent"
                                        border.width: 2
                                        
                                        // Icon placeholder
                                        Text {
                                            anchors.centerIn: parent
                                            text: "🎬"
                                            font.pixelSize: 40
                                            color: "#666666"
                                        }
                                        
                                        // Progress bar
                                        Rectangle {
                                            anchors.bottom: parent.bottom
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            height: 4
                                            radius: 2
                                            color: "transparent"
                                            
                                            Rectangle {
                                                anchors.fill: parent
                                                color: "#333333"
                                                radius: 2
                                                
                                                Rectangle {
                                                    width: parent.width * modelData.progress
                                                    height: parent.height
                                                    color: "#E50914"
                                                    radius: 2
                                                }
                                            }
                                        }
                                        
                                        // Title overlay
                                        Rectangle {
                                            anchors.bottom: parent.bottom
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            height: 60
                                            gradient: Gradient {
                                                GradientStop { position: 0.0; color: "transparent" }
                                                GradientStop { position: 1.0; color: "#000000CC" }
                                            }
                                            radius: parent.radius
                                            
                                            ColumnLayout {
                                                anchors.fill: parent
                                                anchors.margins: 12
                                                spacing: 4
                                                
                                                Text {
                                                    text: modelData.title
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    color: "#FFFFFF"
                                                    wrapMode: Text.WordWrap
                                                    maximumLineCount: 2
                                                    elide: Text.ElideRight
                                                }
                                                
                                                Text {
                                                    text: modelData.subtitle
                                                    font.pixelSize: 12
                                                    color: "#B3B3B3"
                                                    wrapMode: Text.WordWrap
                                                    maximumLineCount: 1
                                                    elide: Text.ElideRight
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
            
            // My List Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: "transparent"
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 16
                    
                    // Section Header
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16
                        
                        Text {
                            text: "My List"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 2
                            color: "#E50914"
                            radius: 1
                        }
                    }
                    
                    // Media Cards Row
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        
                        Row {
                            spacing: 24
                            
                            Repeater {
                                model: [
                                    { title: "Breaking Bad", subtitle: "Crime Drama" },
                                    { title: "Game of Thrones", subtitle: "Fantasy" },
                                    { title: "House of Cards", subtitle: "Political" },
                                    { title: "Narcos", subtitle: "Crime" },
                                    { title: "Black Mirror", subtitle: "Sci-Fi" },
                                    { title: "The Office", subtitle: "Comedy" }
                                ]
                                
                                Rectangle {
                                    width: 220
                                    height: 130
                                    radius: 12
                                    color: "#111111"
                                    
                                    // Simple shadow effect
                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.margins: -4
                                        anchors.topMargin: 0
                                        radius: parent.radius + 2
                                        color: "#00000080"
                                        z: -1
                                    }
                                    
                                    // Hover animation
                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    
                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        
                                        onEntered: {
                                            parent.scale = 1.08
                                        }
                                        
                                        onExited: {
                                            parent.scale = 1.0
                                        }
                                        
                                        onClicked: {
                                            console.log("Clicked:", modelData.title)
                                        }
                                    }
                                    
                                    // Card content
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: parent.radius
                                        color: "#1A1A1A"
                                        border.color: parent.scale > 1.0 ? "#E50914" : "transparent"
                                        border.width: 2
                                        
                                        // Icon placeholder
                                        Text {
                                            anchors.centerIn: parent
                                            text: "🎬"
                                            font.pixelSize: 40
                                            color: "#666666"
                                        }
                                        
                                        // Title overlay
                                        Rectangle {
                                            anchors.bottom: parent.bottom
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            height: 60
                                            gradient: Gradient {
                                                GradientStop { position: 0.0; color: "transparent" }
                                                GradientStop { position: 1.0; color: "#000000CC" }
                                            }
                                            radius: parent.radius
                                            
                                            ColumnLayout {
                                                anchors.fill: parent
                                                anchors.margins: 12
                                                spacing: 4
                                                
                                                Text {
                                                    text: modelData.title
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    color: "#FFFFFF"
                                                    wrapMode: Text.WordWrap
                                                    maximumLineCount: 2
                                                    elide: Text.ElideRight
                                                }
                                                
                                                Text {
                                                    text: modelData.subtitle
                                                    font.pixelSize: 12
                                                    color: "#B3B3B3"
                                                    wrapMode: Text.WordWrap
                                                    maximumLineCount: 1
                                                    elide: Text.ElideRight
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
            
            // Live Categories Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: "transparent"
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 16
                    
                    // Section Header
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16
                        
                        Text {
                            text: "Live Categories"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 2
                            color: "#E50914"
                            radius: 1
                        }
                    }
                    
                    // Media Cards Row
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        
                        Row {
                            spacing: 24
                            
                            Repeater {
                                model: [
                                    { title: "Sports", subtitle: "Live", icon: "⚽" },
                                    { title: "News", subtitle: "24/7", icon: "📰" },
                                    { title: "Entertainment", subtitle: "Variety", icon: "🎭" },
                                    { title: "Movies", subtitle: "Cinema", icon: "🎬" },
                                    { title: "Kids", subtitle: "Family", icon: "🧒" },
                                    { title: "Music", subtitle: "Concerts", icon: "🎵" }
                                ]
                                
                                Rectangle {
                                    width: 220
                                    height: 130
                                    radius: 12
                                    color: "#111111"
                                    
                                    // Simple shadow effect
                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.margins: -4
                                        anchors.topMargin: 0
                                        radius: parent.radius + 2
                                        color: "#00000080"
                                        z: -1
                                    }
                                    
                                    // Hover animation
                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    
                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        
                                        onEntered: {
                                            parent.scale = 1.08
                                        }
                                        
                                        onExited: {
                                            parent.scale = 1.0
                                        }
                                        
                                        onClicked: {
                                            console.log("Clicked:", modelData.title)
                                        }
                                    }
                                    
                                    // Card content
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: parent.radius
                                        color: "#1A1A1A"
                                        border.color: parent.scale > 1.0 ? "#E50914" : "transparent"
                                        border.width: 2
                                        
                                        // Icon
                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData.icon
                                            font.pixelSize: 40
                                            color: "#FFFFFF"
                                        }
                                        
                                        // Title overlay
                                        Rectangle {
                                            anchors.bottom: parent.bottom
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            height: 60
                                            gradient: Gradient {
                                                GradientStop { position: 0.0; color: "transparent" }
                                                GradientStop { position: 1.0; color: "#000000CC" }
                                            }
                                            radius: parent.radius
                                            
                                            ColumnLayout {
                                                anchors.fill: parent
                                                anchors.margins: 12
                                                spacing: 4
                                                
                                                Text {
                                                    text: modelData.title
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    color: "#FFFFFF"
                                                    wrapMode: Text.WordWrap
                                                    maximumLineCount: 2
                                                    elide: Text.ElideRight
                                                }
                                                
                                                Text {
                                                    text: modelData.subtitle
                                                    font.pixelSize: 12
                                                    color: "#B3B3B3"
                                                    wrapMode: Text.WordWrap
                                                    maximumLineCount: 1
                                                    elide: Text.ElideRight
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
}