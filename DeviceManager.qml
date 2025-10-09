import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property int deviceLimit: 3
    property bool showLimitReachedModal: false
    property string deviceToRevoke: ""
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 800)
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
                    onClicked: navigateTo("/main")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "📱 Devices & Sessions"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Manage registered devices"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Device Limit Info
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 20
                    
                    Text {
                        text: "📊"
                        font.pixelSize: 40
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: "Device Usage: 3 of " + deviceLimit
                            font.pixelSize: 18
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Revoke a device to add a new one"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                    }
                    
                    Rectangle {
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 30
                        color: deviceLimit === 3 ? "#e74c3c" : "#27ae60"
                        radius: 15
                        
                        Text {
                            anchors.centerIn: parent
                            text: deviceLimit === 3 ? "LIMIT" : "AVAILABLE"
                            font.pixelSize: 10
                            font.bold: true
                            color: "white"
                        }
                    }
                }
            }
            
            // Registered Devices
            Text {
                text: "📱 Registered Devices"
                font.pixelSize: 24
                font.bold: true
                color: "#ffffff"
            }
            
            Repeater {
                model: [
                    { name: "Windows PC", type: "💻", location: "New York, USA", lastActive: "Active now", current: true },
                    { name: "iPhone 14 Pro", type: "📱", location: "New York, USA", lastActive: "2 hours ago", current: false },
                    { name: "Smart TV", type: "📺", location: "New York, USA", lastActive: "Yesterday", current: false }
                ]
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#181818"
                    radius: 8
                    border.color: modelData.current ? "#e50914" : "#2f2f2f"
                    border.width: modelData.current ? 2 : 1
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        // Device Icon
                        Rectangle {
                            width: 70
                            height: 70
                            radius: 35
                            color: "#2f2f2f"
                            Layout.alignment: Qt.AlignVCenter
                            
                            Text {
                                anchors.centerIn: parent
                                text: modelData.type
                                font.pixelSize: 35
                            }
                            
                            Rectangle {
                                anchors.top: parent.top
                                anchors.right: parent.right
                                width: 20
                                height: 20
                                radius: 10
                                color: "#27ae60"
                                visible: modelData.current
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "✓"
                                    font.pixelSize: 10
                                    font.bold: true
                                    color: "white"
                                }
                            }
                        }
                        
                        // Device Info
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Text {
                                text: modelData.name
                                font.pixelSize: 18
                                font.bold: true
                                color: "#ffffff"
                            }
                            
                            RowLayout {
                                spacing: 15
                                
                                Text {
                                    text: "📍 " + modelData.location
                                    font.pixelSize: 12
                                    color: "#b3b3b3"
                                }
                                
                                Text {
                                    text: "•"
                                    font.pixelSize: 12
                                    color: "#564d4d"
                                }
                                
                                Text {
                                    text: modelData.lastActive
                                    font.pixelSize: 12
                                    color: modelData.current ? "#27ae60" : "#b3b3b3"
                                }
                            }
                            
                            Text {
                                text: modelData.current ? "This device" : "Signed in"
                                font.pixelSize: 11
                                color: modelData.current ? "#e50914" : "#564d4d"
                            }
                        }
                        
                        // Revoke Button
                        Button {
                            text: "🗑️ Revoke"
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 40
                            enabled: !modelData.current
                            background: Rectangle {
                                color: parent.enabled ? "transparent" : "#2f2f2f"
                                radius: 4
                                border.color: parent.enabled ? "#e74c3c" : "#564d4d"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: parent.enabled ? "#e74c3c" : "#564d4d"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                deviceToRevoke = modelData.name
                            }
                        }
                    }
                }
            }
            
            // Help Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: "#f8f9fa"
                radius: 8
                border.color: "#dee2e6"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10
                    
                    Text {
                        text: "💡 Device Limit"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#495057"
                    }
                    
                    Text {
                        text: "Your current plan allows " + deviceLimit + " simultaneous devices. Revoke a device to free up a slot. You can add new devices at any time."
                        font.pixelSize: 14
                        color: "#6c757d"
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }
                }
            }
            
            // Revoke All Button
            Button {
                text: "🚫 Sign Out All Devices"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                background: Rectangle {
                    color: "transparent"
                    radius: 4
                    border.color: "#e74c3c"
                    border.width: 2
                }
                contentItem: Text {
                    text: parent.text
                    color: "#e74c3c"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: deviceToRevoke = "all"
            }
        }
    }
    
    // Limit Reached Modal
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: showLimitReachedModal ? 0.95 : 0
        visible: showLimitReachedModal
        z: 1000
        
        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }
        
        Rectangle {
            anchors.centerIn: parent
            width: 400
            height: 280
            color: "#181818"
            radius: 8
            border.color: "#e74c3c"
            border.width: 2
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 30
                spacing: 20
                
                Text {
                    text: "⚠️"
                    font.pixelSize: 50
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "Device Limit Reached"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "You've reached the maximum of " + deviceLimit + " devices for your plan. Please revoke a device or upgrade your plan."
                    font.pixelSize: 14
                    color: "#b3b3b3"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }
                
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 10
                    spacing: 15
                    
                    Button {
                        text: "Manage Devices"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "#e50914"
                            radius: 4
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: showLimitReachedModal = false
                    }
                    
                    Button {
                        text: "Upgrade Plan"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "transparent"
                            radius: 4
                            border.color: "#e50914"
                            border.width: 2
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#e50914"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            showLimitReachedModal = false
                            navigateTo("/billing/plans")
                        }
                    }
                }
            }
        }
    }
    
    // Revoke Confirmation
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: deviceToRevoke !== "" ? 0.95 : 0
        visible: deviceToRevoke !== ""
        z: 1000
        
        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }
        
        Rectangle {
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "#181818"
            radius: 8
            border.color: "#e74c3c"
            border.width: 2
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 30
                spacing: 20
                
                Text {
                    text: deviceToRevoke === "all" ? "Sign Out All Devices?" : "Revoke Device?"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: deviceToRevoke === "all" ? "This will sign out all devices except this one. You'll need to sign in again on those devices." : "This will sign out '" + deviceToRevoke + "'. You can add it back later."
                    font.pixelSize: 14
                    color: "#b3b3b3"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }
                
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 10
                    spacing: 15
                    
                    Button {
                        text: "Cancel"
                        Layout.fillWidth: true
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
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: deviceToRevoke = ""
                    }
                    
                    Button {
                        text: "Yes, Revoke"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "#e74c3c"
                            radius: 4
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: deviceToRevoke = ""
                    }
                }
            }
        }
    }
}

