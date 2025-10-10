import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property int currentDay: 0
    property int currentHour: 12
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Header with Date/Time Navigation
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#141414"
            border.color: "#2f2f2f"
            border.width: 1
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
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
                
                Text {
                    text: "📅 TV Guide"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                }
                
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Button {
                        text: "←"
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
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
                    }
                    
                    Text {
                        text: "Today, Dec 15"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.preferredWidth: 120
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    Button {
                        text: "→"
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
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
                    }
                    
                    Rectangle {
                        Layout.preferredWidth: 1
                        Layout.fillHeight: true
                        color: "#2f2f2f"
                    }
                    
                    Button {
                        text: "Now"
                        Layout.preferredWidth: 60
                        Layout.preferredHeight: 35
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
                    }
                    
                    Button {
                        text: "Jump to..."
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 35
                        background: Rectangle {
                            color: "transparent"
                            radius: 4
                            border.color: "#564d4d"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#b3b3b3"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
        
        // EPG Grid
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#000000"
            
            RowLayout {
                anchors.fill: parent
                spacing: 0
                
                // Channel List
                Rectangle {
                    Layout.preferredWidth: 200
                    Layout.fillHeight: true
                    color: "#141414"
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    ScrollView {
                        anchors.fill: parent
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 0
                            
                            // Time header
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                color: "#2f2f2f"
                                border.color: "#2f2f2f"
                                border.width: 1
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "Channels"
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: "#ffffff"
                                }
                            }
                            
                            Repeater {
                                model: [
                                    { name: "BBC One", logo: "📺" },
                                    { name: "BBC Two", logo: "📺" },
                                    { name: "ITV", logo: "📺" },
                                    { name: "Channel 4", logo: "📺" },
                                    { name: "Channel 5", logo: "📺" },
                                    { name: "Sky Sports", logo: "⚽" },
                                    { name: "ESPN", logo: "🏀" },
                                    { name: "CNN", logo: "📰" },
                                    { name: "Discovery", logo: "🌍" },
                                    { name: "Cartoon Network", logo: "🧒" }
                                ]
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 60
                                    color: index % 2 === 0 ? "#1a1a1a" : "#141414"
                                    border.color: "#2f2f2f"
                                    border.width: 1
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 10
                                        spacing: 10
                                        
                                        Text {
                                            text: modelData.logo
                                            font.pixelSize: 20
                                        }
                                        
                                        Text {
                                            text: modelData.name
                                            font.pixelSize: 12
                                            color: "#ffffff"
                                            Layout.fillWidth: true
                                            wrapMode: Text.WordWrap
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Program Grid
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#000000"
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    ScrollView {
                        anchors.fill: parent
                        
                        ColumnLayout {
                            width: Math.max(parent.width, 2400) // 24 hours * 100px per hour
                            spacing: 0
                            
                            // Time header
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                color: "#2f2f2f"
                                border.color: "#2f2f2f"
                                border.width: 1
                                
                                RowLayout {
                                    anchors.fill: parent
                                    spacing: 0
                                    
                                    Repeater {
                                        model: 24
                                        
                                        Rectangle {
                                            Layout.preferredWidth: 100
                                            Layout.fillHeight: true
                                            color: "transparent"
                                            border.color: "#2f2f2f"
                                            border.width: 1
                                            
                                            Text {
                                                anchors.centerIn: parent
                                                text: index.toString().padStart(2, '0') + ":00"
                                                font.pixelSize: 12
                                                color: "#ffffff"
                                            }
                                        }
                                    }
                                }
                            }
                            
                            // Program rows
                            Repeater {
                                model: 10 // Number of channels
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 60
                                    color: index % 2 === 0 ? "#1a1a1a" : "#141414"
                                    border.color: "#2f2f2f"
                                    border.width: 1
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        spacing: 0
                                        
                                        Repeater {
                                            model: 24 // 24 hours
                                            
                                            Rectangle {
                                                Layout.preferredWidth: 100
                                                Layout.fillHeight: true
                                                color: {
                                                    var colors = ["#e50914", "#3498db", "#27ae60", "#f39c12", "#9b59b6", "#e74c3c"]
                                                    return colors[index % colors.length]
                                                }
                                                border.color: "#2f2f2f"
                                                border.width: 1
                                                opacity: 0.8
                                                
                                                ColumnLayout {
                                                    anchors.fill: parent
                                                    anchors.margins: 5
                                                    spacing: 2
                                                    
                                                    Text {
                                                        text: ["BBC News", "Coronation Street", "MasterChef", "EastEnders", "The Apprentice", "Question Time"][index % 6]
                                                        font.pixelSize: 10
                                                        color: "#ffffff"
                                                        Layout.fillWidth: true
                                                        wrapMode: Text.WordWrap
                                                    }
                                                    
                                                    Text {
                                                        text: (index).toString().padStart(2, '0') + ":00 - " + (index + 1).toString().padStart(2, '0') + ":00"
                                                        font.pixelSize: 8
                                                        color: "#b3b3b3"
                                                        Layout.fillWidth: true
                                                    }
                                                }
                                                
                                                MouseArea {
                                                    anchors.fill: parent
                                                    cursorShape: Qt.PointingHandCursor
                                                    onClicked: {
                                                        // Navigate to player to watch live/start over
                                                        navigateTo("/player")
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
}
