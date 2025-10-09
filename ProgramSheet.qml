import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property string programTitle: ""
    property string programSynopsis: ""
    property string startTime: ""
    property string endTime: ""
    property string cast: ""
    property string genre: ""
    property bool isLive: false
    property bool hasCatchup: false
    property bool hasRecording: false
    
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.8
        
        MouseArea {
            anchors.fill: parent
            onClicked: parent.parent.visible = false
        }
    }
    
    Rectangle {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.9, 600)
        height: Math.min(parent.height * 0.8, 700)
        color: "#181818"
        radius: 12
        border.color: "#2f2f2f"
        border.width: 1
        
        ScrollView {
            anchors.fill: parent
            anchors.margins: 30
            
            ColumnLayout {
                width: parent.width
                spacing: 20
                
                // Header
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 20
                    
                    Rectangle {
                        width: 80
                        height: 80
                        radius: 40
                        color: "#2f2f2f"
                        
                        Text {
                            anchors.centerIn: parent
                            text: "🎬"
                            font.pixelSize: 40
                        }
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: programTitle === "" ? "MasterChef" : programTitle
                            font.pixelSize: 24
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: startTime === "" ? "Today, 19:30" : startTime + " • " + (endTime === "" ? "20:30" : endTime)
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                        
                        RowLayout {
                            spacing: 10
                            
                            Rectangle {
                                width: 60
                                height: 20
                                radius: 10
                                color: "#e50914"
                                visible: isLive
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "LIVE"
                                    font.pixelSize: 10
                                    font.bold: true
                                    color: "white"
                                }
                            }
                            
                            Rectangle {
                                width: 80
                                height: 20
                                radius: 10
                                color: "#27ae60"
                                visible: hasCatchup
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "CATCH-UP"
                                    font.pixelSize: 10
                                    font.bold: true
                                    color: "white"
                                }
                            }
                            
                            Text {
                                text: genre === "" ? "Entertainment" : genre
                                font.pixelSize: 12
                                color: "#b3b3b3"
                            }
                        }
                    }
                    
                    Button {
                        text: "✕"
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        background: Rectangle {
                            color: "transparent"
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#b3b3b3"
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: parent.parent.parent.parent.visible = false
                    }
                }
                
                // Synopsis
                Text {
                    text: "Synopsis"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#e50914"
                }
                
                Text {
                    text: programSynopsis === "" ? "The remaining contestants face their biggest challenge yet as they cook for a panel of Michelin-starred chefs. The pressure is intense as they must create restaurant-quality dishes while being judged by some of the world's most demanding culinary experts." : programSynopsis
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                    lineHeight: 1.4
                }
                
                // Cast
                Text {
                    text: "Cast & Crew"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#e50914"
                    Layout.topMargin: 10
                }
                
                Text {
                    text: cast === "" ? "Gregg Wallace, John Torode, Marcus Wareing" : cast
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                }
                
                // Action Buttons
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 20
                    spacing: 15
                    
                    Button {
                        text: "▶️ Watch Live"
                        Layout.preferredWidth: 140
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "#e50914"
                            radius: 6
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            console.log("Watch Live clicked")
                            parent.parent.parent.parent.visible = false
                        }
                    }
                    
                    Button {
                        text: "🔄 Start Over"
                        Layout.preferredWidth: 140
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "transparent"
                            radius: 6
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
                        onClicked: {
                            console.log("Start Over clicked")
                        }
                    }
                    
                    Button {
                        text: "📹 Record"
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "transparent"
                            radius: 6
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
                        onClicked: {
                            console.log("Record clicked")
                        }
                    }
                    
                    Button {
                        text: "⏰ Remind Me"
                        Layout.preferredWidth: 140
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "transparent"
                            radius: 6
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
                        onClicked: {
                            console.log("Remind Me clicked")
                        }
                    }
                }
                
                // Additional Info
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#2f2f2f"
                    Layout.topMargin: 20
                }
                
                Text {
                    text: "Program Information"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#e50914"
                    Layout.topMargin: 20
                }
                
                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    rowSpacing: 10
                    columnSpacing: 20
                    
                    Text {
                        text: "Duration:"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    Text {
                        text: "1 hour"
                        font.pixelSize: 14
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Rating:"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    Text {
                        text: "PG"
                        font.pixelSize: 14
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Subtitles:"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    Text {
                        text: "Available"
                        font.pixelSize: 14
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Audio Description:"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    Text {
                        text: "Available"
                        font.pixelSize: 14
                        color: "#ffffff"
                    }
                }
            }
        }
    }
}
