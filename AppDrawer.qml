import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Drawer {
    id: drawer
    width: Math.min(280, parent.width * 0.8)
    height: parent.height
    edge: Qt.LeftEdge
    
    Rectangle {
        anchors.fill: parent
        color: "#141414"
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            
            // Header
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#000000"
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15
                    
                    Rectangle {
                        width: 50
                        height: 50
                        radius: 6
                        color: "#e50914"
                        
                        Text {
                            anchors.centerIn: parent
                            text: "N"
                            font.pixelSize: 32
                            font.bold: true
                            color: "white"
                        }
                    }
                    
                    Text {
                        text: "IPTV Pro"
                        font.pixelSize: Math.min(22, parent.parent.width / 15)
                        font.bold: true
                        color: "#e50914"
                        Layout.fillWidth: true
                    }
                }
            }
            
            // Navigation Items
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                ColumnLayout {
                    width: parent.width
                    spacing: 5
                    
                    DrawerItem {
                        icon: "🏠"
                        label: "Home"
                        route: "/home"
                    }
                    
                    DrawerItem {
                        icon: "📡"
                        label: "Live TV"
                        route: "/live"
                    }
                    
                    DrawerItem {
                        icon: "📅"
                        label: "Guide"
                        route: "/guide"
                    }
                    
                    DrawerItem {
                        icon: "🎬"
                        label: "Movies"
                        route: "/movies"
                    }
                    
                    DrawerItem {
                        icon: "📺"
                        label: "Series"
                        route: "/series"
                    }
                    
                    DrawerItem {
                        icon: "⏮️"
                        label: "Catch-up"
                        route: "/catchup"
                    }
                    
                    DrawerItem {
                        icon: "📥"
                        label: "Downloads"
                        route: "/downloads"
                    }
                    
                    DrawerItem {
                        icon: "⭐"
                        label: "Favorites"
                        route: "/favorites"
                    }
                    
                    DrawerItem {
                        icon: "🔍"
                        label: "Search"
                        route: "/search"
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: "#2f2f2f"
                        Layout.topMargin: 10
                        Layout.bottomMargin: 10
                    }
                    
                    DrawerItem {
                        icon: "⚙️"
                        label: "Settings"
                        route: "/settings"
                    }
                    
                    DrawerItem {
                        icon: "👤"
                        label: "Account"
                        route: "/account"
                    }
                }
            }
            
            // Footer
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "#000000"
                
                RowLayout {
                    anchors.centerIn: parent
                    spacing: 15
                    
                    Button {
                        text: "📬"
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        background: Rectangle {
                            color: "#2f2f2f"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.pixelSize: 24
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            drawer.close()
                            navigateTo("/inbox")
                        }
                    }
                    
                    Text {
                        text: "v2.2.0"
                        font.pixelSize: 12
                        color: "#564d4d"
                    }
                }
            }
        }
    }
    
    component DrawerItem: Rectangle {
        property string icon: ""
        property string label: ""
        property string route: ""
        
        Layout.fillWidth: true
        Layout.preferredHeight: 56
        color: hoverArea.containsMouse ? "#2f2f2f" : "transparent"
        
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 15
            
            Text {
                text: icon
                font.pixelSize: 24
            }
            
            Text {
                text: label
                font.pixelSize: Math.min(16, parent.parent.parent.width / 20)
                color: "#ffffff"
                Layout.fillWidth: true
            }
        }
        
        MouseArea {
            id: hoverArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                drawer.close()
                navigateTo(route)
            }
        }
    }
}

