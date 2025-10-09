import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 900)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 40
            
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
                        text: "📡 Add Source"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Choose a method to add your IPTV source"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Method Cards
            GridLayout {
                Layout.fillWidth: true
                columns: 2
                rowSpacing: 20
                columnSpacing: 20
                
                // Xtream Codes
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    color: "#181818"
                    radius: 8
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15
                        
                        Text {
                            text: "🔐"
                            font.pixelSize: 40
                        }
                        
                        Text {
                            text: "Xtream Codes"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Login with server, username & password"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: navigateTo("/sources/xtream")
                    }
                }
                
                // M3U/M3U8
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    color: "#181818"
                    radius: 8
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15
                        
                        Text {
                            text: "📄"
                            font.pixelSize: 40
                        }
                        
                        Text {
                            text: "M3U / M3U8"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Playlist URL or local file"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: navigateTo("/sources/m3u")
                    }
                }
                
                // Stalker/MAG
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    color: "#181818"
                    radius: 8
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15
                        
                        Text {
                            text: "📺"
                            font.pixelSize: 40
                        }
                        
                        Text {
                            text: "Stalker / MAG"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Portal URL with MAC address"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: navigateTo("/sources/stalker")
                    }
                }
                
                // Single URL
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    color: "#181818"
                    radius: 8
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15
                        
                        Text {
                            text: "🎬"
                            font.pixelSize: 40
                        }
                        
                        Text {
                            text: "Single URL"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Quick play or save single stream"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: navigateTo("/sources/single")
                    }
                }
            }
            
            // Manage Sources Button
            Button {
                text: "⚙️ Manage Existing Sources"
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                Layout.topMargin: 20
                background: Rectangle {
                    color: "transparent"
                    radius: 4
                    border.color: "#e50914"
                    border.width: 2
                }
                contentItem: Text {
                    text: parent.text
                    color: "#e50914"
                    font.pixelSize: 18
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/sources/manage")
            }
        }
    }
}

