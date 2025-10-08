import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property var profiles: [
        { name: "John", avatar: "👨", color: "#e50914", isKid: false, lastUsed: true },
        { name: "Sarah", avatar: "👩", color: "#0080ff", isKid: false, lastUsed: false },
        { name: "Kids", avatar: "🧒", color: "#46d369", isKid: true, lastUsed: false },
        { name: "Guest", avatar: "👤", color: "#564d4d", isKid: false, lastUsed: false }
    ]
    
    property string selectedProfile: ""
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 60
        width: Math.min(parent.width * 0.9, 1000)
        
        // Header
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Text {
                text: "Who's watching?"
                font.pixelSize: 48
                font.bold: true
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Select your profile to continue"
                font.pixelSize: 18
                color: "#b3b3b3"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
        
        // Profiles Grid
        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            columns: 4
            rowSpacing: 40
            columnSpacing: 40
            
            Repeater {
                model: profiles
                
                Item {
                    width: 180
                    height: 220
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 15
                        
                        // Profile Avatar
                        Rectangle {
                            width: 180
                            height: 180
                            radius: 8
                            color: modelData.color
                            border.color: modelData.lastUsed ? "#ffffff" : "transparent"
                            border.width: 3
                            Layout.alignment: Qt.AlignHCenter
                            
                            // Last used indicator
                            Rectangle {
                                anchors.top: parent.top
                                anchors.right: parent.right
                                anchors.margins: 10
                                width: 30
                                height: 30
                                radius: 15
                                color: "#27ae60"
                                visible: modelData.lastUsed
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "✓"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "white"
                                }
                            }
                            
                            // Kids badge
                            Rectangle {
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                anchors.margins: 10
                                width: 50
                                height: 25
                                radius: 12
                                color: "#f39c12"
                                visible: modelData.isKid
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "KIDS"
                                    font.pixelSize: 10
                                    font.bold: true
                                    color: "white"
                                }
                            }
                            
                            Text {
                                anchors.centerIn: parent
                                text: modelData.avatar
                                font.pixelSize: 80
                            }
                            
                            // Hover effect
                            Rectangle {
                                anchors.fill: parent
                                color: "white"
                                opacity: profileHover.containsMouse ? 0.1 : 0
                                radius: parent.radius
                                
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                            
                            MouseArea {
                                id: profileHover
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    selectedProfile = modelData.name
                                    // If kids profile, may need PIN
                                    if (modelData.isKid) {
                                        navigateTo("/main")
                                    } else {
                                        // Adult profile might need PIN if enabled
                                        navigateTo("/main")
                                    }
                                }
                            }
                            
                            // Scale animation on hover
                            scale: profileHover.containsMouse ? 1.05 : 1.0
                            Behavior on scale {
                                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                            }
                        }
                        
                        // Profile Name
                        Text {
                            text: modelData.name
                            font.pixelSize: 20
                            color: profileHover.containsMouse ? "#ffffff" : "#b3b3b3"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                            Layout.fillWidth: true
                            
                            Behavior on color {
                                ColorAnimation { duration: 200 }
                            }
                        }
                    }
                }
            }
            
            // Add Profile Button
            Item {
                width: 180
                height: 220
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 15
                    
                    Rectangle {
                        width: 180
                        height: 180
                        radius: 8
                        color: "#2f2f2f"
                        border.color: "#564d4d"
                        border.width: 2
                        Layout.alignment: Qt.AlignHCenter
                        
                        Text {
                            anchors.centerIn: parent
                            text: "+"
                            font.pixelSize: 80
                            color: "#b3b3b3"
                        }
                        
                        Rectangle {
                            anchors.fill: parent
                            color: "white"
                            opacity: addProfileHover.containsMouse ? 0.1 : 0
                            radius: parent.radius
                            
                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                        }
                        
                        MouseArea {
                            id: addProfileHover
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: navigateTo("/profiles/manage")
                        }
                        
                        scale: addProfileHover.containsMouse ? 1.05 : 1.0
                        Behavior on scale {
                            NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                        }
                    }
                    
                    Text {
                        text: "Add Profile"
                        font.pixelSize: 20
                        color: addProfileHover.containsMouse ? "#ffffff" : "#b3b3b3"
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                        Layout.fillWidth: true
                        
                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }
            }
        }
        
        // Manage Profiles Button
        Button {
            text: "⚙️ Manage Profiles"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 45
            background: Rectangle {
                color: "transparent"
                radius: 4
                border.color: "#564d4d"
                border.width: 2
            }
            contentItem: Text {
                text: parent.text
                color: "#b3b3b3"
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: navigateTo("/profiles/manage")
        }
    }
}

