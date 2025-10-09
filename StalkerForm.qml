import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
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
                        text: "📺 Stalker / MAG"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Configure Stalker portal"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Portal URL
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
                        text: "Portal URL"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: portalField
                        placeholderText: "http://portal.example.com/stalker_portal/c"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Virtual MAC
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 90
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Text {
                            text: "Virtual MAC Address"
                            font.pixelSize: 12
                            color: "#b3b3b3"
                            Layout.fillWidth: true
                        }
                        
                        Button {
                            text: "🎲 Random"
                            height: 30
                            background: Rectangle {
                                color: "#2f2f2f"
                                radius: 4
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 11
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                var mac = "00:1A:79:"
                                for(var i = 0; i < 3; i++) {
                                    var hex = Math.floor(Math.random() * 256).toString(16).toUpperCase()
                                    mac += (hex.length === 1 ? "0" : "") + hex + (i < 2 ? ":" : "")
                                }
                                macField.text = mac
                            }
                        }
                    }
                    
                    TextField {
                        id: macField
                        placeholderText: "00:1A:79:XX:XX:XX"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Profile Name
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
                        text: "Profile Name"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: profileField
                        placeholderText: "My Stalker Portal"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Info Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "#fff3cd"
                radius: 8
                border.color: "#ffeaa7"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 15
                    
                    Text {
                        text: "ℹ️"
                        font.pixelSize: 30
                    }
                    
                    Text {
                        text: "MAC address must be in format: 00:1A:79:XX:XX:XX\nSome portals only accept specific MAC ranges."
                        font.pixelSize: 13
                        color: "#856404"
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
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

