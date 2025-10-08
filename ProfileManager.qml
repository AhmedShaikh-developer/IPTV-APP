import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property bool isEditing: false
    property string editingProfile: ""
    property var availableAvatars: ["👨", "👩", "👦", "👧", "🧒", "👶", "👴", "👵", "🧑", "👤", "😀", "😎", "🤓", "🥳", "🐶", "🐱", "🐼", "🦊", "🦁", "🐯"]
    property var availableColors: ["#e50914", "#0080ff", "#46d369", "#f39c12", "#9b59b6", "#e74c3c", "#1abc9c", "#34495e"]
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 800)
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
                    onClicked: {
                        if (isEditing) {
                            isEditing = false
                        } else {
                            navigateTo("/profiles/pick")
                        }
                    }
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: isEditing ? "Edit Profile" : "Manage Profiles"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: isEditing ? "Customize your profile settings" : "Create, edit, and manage your profiles"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Profile List (when not editing)
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 20
                visible: !isEditing
                
                Text {
                    text: "📋 All Profiles"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                }
                
                // Profile Items
                Repeater {
                    model: [
                        { name: "John", avatar: "👨", color: "#e50914", isKid: false, devices: 3 },
                        { name: "Sarah", avatar: "👩", color: "#0080ff", isKid: false, devices: 2 },
                        { name: "Kids", avatar: "🧒", color: "#46d369", isKid: true, devices: 1 }
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
                            
                            // Avatar
                            Rectangle {
                                width: 60
                                height: 60
                                radius: 8
                                color: modelData.color
                                
                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    anchors.right: parent.right
                                    anchors.margins: 5
                                    width: 25
                                    height: 15
                                    radius: 7
                                    color: "#f39c12"
                                    visible: modelData.isKid
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: "KID"
                                        font.pixelSize: 8
                                        font.bold: true
                                        color: "white"
                                    }
                                }
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.avatar
                                    font.pixelSize: 30
                                }
                            }
                            
                            // Profile Info
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 5
                                
                                Text {
                                    text: modelData.name
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                
                                Text {
                                    text: modelData.devices + " device" + (modelData.devices > 1 ? "s" : "") + " • " + (modelData.isKid ? "Kids profile" : "Adult profile")
                                    font.pixelSize: 14
                                    color: "#b3b3b3"
                                }
                            }
                            
                            // Edit Button
                            Button {
                                text: "✏️ Edit"
                                Layout.preferredWidth: 100
                                Layout.preferredHeight: 40
                                background: Rectangle {
                                    color: "transparent"
                                    radius: 4
                                    border.color: "#e50914"
                                    border.width: 1
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "#e50914"
                                    font.pixelSize: 14
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    isEditing = true
                                    editingProfile = modelData.name
                                }
                            }
                            
                            // Delete Button
                            Button {
                                text: "🗑️"
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                background: Rectangle {
                                    color: "#2f2f2f"
                                    radius: 4
                                }
                                contentItem: Text {
                                    text: parent.text
                                    font.pixelSize: 16
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    // Delete profile
                                }
                            }
                        }
                    }
                }
                
                // Add New Profile Button
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "#2f2f2f"
                    radius: 8
                    border.color: "#564d4d"
                    border.width: 2
                    
                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 15
                        
                        Text {
                            text: "+"
                            font.pixelSize: 40
                            color: "#b3b3b3"
                        }
                        
                        Text {
                            text: "Add New Profile"
                            font.pixelSize: 20
                            color: "#b3b3b3"
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            isEditing = true
                            editingProfile = ""
                        }
                    }
                }
            }
            
            // Edit Profile Form (when editing)
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 30
                visible: isEditing
                
                // Avatar Selection
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 15
                    
                    Text {
                        text: "Choose Avatar"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    GridLayout {
                        Layout.fillWidth: true
                        columns: 10
                        rowSpacing: 10
                        columnSpacing: 10
                        
                        Repeater {
                            model: availableAvatars
                            
                            Rectangle {
                                width: 60
                                height: 60
                                radius: 8
                                color: "#2f2f2f"
                                border.color: index === 0 ? "#e50914" : "#564d4d"
                                border.width: 2
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: modelData
                                    font.pixelSize: 30
                                }
                                
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        // Select avatar
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Color Selection
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 15
                    
                    Text {
                        text: "Profile Color"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    RowLayout {
                        spacing: 15
                        
                        Repeater {
                            model: availableColors
                            
                            Rectangle {
                                width: 50
                                height: 50
                                radius: 25
                                color: modelData
                                border.color: index === 0 ? "#ffffff" : "transparent"
                                border.width: 3
                                
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        // Select color
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Profile Name
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
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
                            id: profileNameField
                            placeholderText: "Enter profile name"
                            text: editingProfile
                            font.pixelSize: 16
                            color: "#ffffff"
                            Layout.fillWidth: true
                            background: Rectangle {
                                color: "transparent"
                            }
                        }
                    }
                }
                
                // Kids Profile Toggle
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "#181818"
                    radius: 4
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5
                            
                            Text {
                                text: "👶 Kids Profile"
                                font.pixelSize: 16
                                font.bold: true
                                color: "#ffffff"
                            }
                            
                            Text {
                                text: "Shows only age-appropriate content"
                                font.pixelSize: 14
                                color: "#b3b3b3"
                            }
                        }
                        
                        Switch {
                            id: kidsToggle
                            checked: false
                        }
                    }
                }
                
                // Auto-Play Toggle
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "#181818"
                    radius: 4
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5
                            
                            Text {
                                text: "▶️ Auto-Play Next Episode"
                                font.pixelSize: 16
                                font.bold: true
                                color: "#ffffff"
                            }
                            
                            Text {
                                text: "Automatically play next episode"
                                font.pixelSize: 14
                                color: "#b3b3b3"
                            }
                        }
                        
                        Switch {
                            id: autoPlayToggle
                            checked: true
                        }
                    }
                }
                
                // Save & Cancel Buttons
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 20
                    spacing: 20
                    
                    Button {
                        text: "💾 Save Profile"
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
                        onClicked: {
                            isEditing = false
                        }
                    }
                    
                    Button {
                        text: "Cancel"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
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
                        onClicked: {
                            isEditing = false
                        }
                    }
                }
            }
            
            // Parental Settings Link
            Button {
                text: "🔒 Parental Controls"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                visible: !isEditing
                background: Rectangle {
                    color: "#2f2f2f"
                    radius: 4
                }
                contentItem: Text {
                    text: parent.text
                    color: "#ffffff"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/settings/parental")
            }
        }
    }
}

