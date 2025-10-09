import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property bool isFileMode: false
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 600)
            anchors.horizontalCenter: parent.horizontalCenter
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
                    onClicked: navigateTo("/sources/add")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "📄 M3U / M3U8"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Add playlist URL or local file"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Source Type Toggle
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Button {
                    text: "🌐 URL"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    background: Rectangle {
                        color: !isFileMode ? "#e50914" : "transparent"
                        radius: 4
                        border.color: "#e50914"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: !isFileMode ? "white" : "#e50914"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: isFileMode = false
                }
                
                Button {
                    text: "📁 Local File"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    background: Rectangle {
                        color: isFileMode ? "#e50914" : "transparent"
                        radius: 4
                        border.color: "#e50914"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: isFileMode ? "white" : "#e50914"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: isFileMode = true
                }
            }
            
            // Playlist URL/File
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: isFileMode ? "Playlist File" : "Playlist URL"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        
                        TextField {
                            id: playlistField
                            placeholderText: isFileMode ? "Browse to select file..." : "http://example.com/playlist.m3u8"
                            font.pixelSize: 16
                            color: "#ffffff"
                            Layout.fillWidth: true
                            readOnly: isFileMode
                            background: Rectangle {
                                color: "transparent"
                            }
                        }
                        
                        Button {
                            visible: isFileMode
                            text: "Browse"
                            height: 35
                            background: Rectangle {
                                color: "#2f2f2f"
                                radius: 4
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }
            }
            
            // EPG URL (Optional)
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "EPG URL (Optional)"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: epgField
                        placeholderText: "http://example.com/epg.xml"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Custom User-Agent
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Custom User-Agent (Optional)"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: userAgentField
                        placeholderText: "Mozilla/5.0..."
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Custom Headers
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Custom Headers (Optional)"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextArea {
                        id: headersField
                        placeholderText: "Referer: http://example.com\nAuthorization: Bearer token"
                        font.pixelSize: 14
                        color: "#ffffff"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Save Buttons
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Button {
                    text: "💾 Save"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#e50914"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/sources/manage")
                }
                
                Button {
                    text: "💾 Save & Sync"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#27ae60"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/sources/sync")
                }
            }
        }
    }
}

