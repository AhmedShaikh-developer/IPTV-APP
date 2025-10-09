import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property string channelId: ""
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 20
        
        ColumnLayout {
            width: parent.width
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
                    onClicked: navigateTo("/live/channels")
                }
                
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
                            text: "📺"
                            font.pixelSize: 40
                        }
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: "BBC One"
                            font.pixelSize: 28
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Channel 1 • HD Available • Catch-up Available"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                        
                        RowLayout {
                            spacing: 10
                            
                            Button {
                                text: "Start Watching"
                                Layout.preferredWidth: 150
                                Layout.preferredHeight: 40
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
                            }
                            
                            Button {
                                text: "❤️ Add to Favorites"
                                Layout.preferredWidth: 150
                                Layout.preferredHeight: 40
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
                            }
                        }
                    }
                }
            }
            
            // Day Schedule
            Text {
                text: "Today's Schedule"
                font.pixelSize: 20
                font.bold: true
                color: "#ffffff"
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 300
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 15
                    
                    ColumnLayout {
                        width: parent.width
                        spacing: 10
                        
                        Repeater {
                            model: [
                                { time: "06:00", title: "BBC Breakfast", duration: "3h", genre: "News" },
                                { time: "09:00", title: "Morning Live", duration: "1h", genre: "Lifestyle" },
                                { time: "10:00", title: "Homes Under the Hammer", duration: "1h", genre: "Property" },
                                { time: "11:00", title: "Escape to the Country", duration: "1h", genre: "Property" },
                                { time: "12:00", title: "BBC News at Noon", duration: "30m", genre: "News" },
                                { time: "12:30", title: "Bargain Hunt", duration: "45m", genre: "Entertainment" },
                                { time: "13:15", title: "BBC News", duration: "30m", genre: "News" },
                                { time: "13:45", title: "Doctors", duration: "30m", genre: "Drama" },
                                { time: "14:15", title: "Moving On", duration: "45m", genre: "Drama" },
                                { time: "15:00", title: "BBC News", duration: "15m", genre: "News" },
                                { time: "15:15", title: "Antiques Roadshow", duration: "1h", genre: "Entertainment" },
                                { time: "16:15", title: "Flog It!", duration: "45m", genre: "Entertainment" },
                                { time: "17:00", title: "Pointless", duration: "45m", genre: "Quiz" },
                                { time: "17:45", title: "BBC News at Six", duration: "30m", genre: "News" },
                                { time: "18:15", title: "The One Show", duration: "30m", genre: "Entertainment" },
                                { time: "18:45", title: "EastEnders", duration: "30m", genre: "Drama" },
                                { time: "19:15", title: "BBC News", duration: "15m", genre: "News" },
                                { time: "19:30", title: "MasterChef", duration: "1h", genre: "Entertainment" },
                                { time: "20:30", title: "The Apprentice", duration: "1h", genre: "Reality" },
                                { time: "21:30", title: "BBC News at Ten", duration: "30m", genre: "News" },
                                { time: "22:00", title: "Question Time", duration: "1h", genre: "Politics" },
                                { time: "23:00", title: "BBC News", duration: "15m", genre: "News" },
                                { time: "23:15", title: "Match of the Day", duration: "1h", genre: "Sport" },
                                { time: "00:15", title: "BBC News", duration: "15m", genre: "News" }
                            ]
                            
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                color: index % 2 === 0 ? "#2f2f2f" : "#1a1a1a"
                                radius: 6
                                
                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 15
                                    
                                    Text {
                                        text: modelData.time
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: "#e50914"
                                        Layout.preferredWidth: 60
                                    }
                                    
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2
                                        
                                        Text {
                                            text: modelData.title
                                            font.pixelSize: 16
                                            color: "#ffffff"
                                            Layout.fillWidth: true
                                        }
                                        
                                        Text {
                                            text: modelData.duration + " • " + modelData.genre
                                            font.pixelSize: 12
                                            color: "#b3b3b3"
                                            Layout.fillWidth: true
                                        }
                                    }
                                    
                                    Button {
                                        text: "Watch"
                                        Layout.preferredWidth: 80
                                        Layout.preferredHeight: 30
                                        background: Rectangle {
                                            color: "#e50914"
                                            radius: 4
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            color: "white"
                                            font.pixelSize: 12
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // Add to Group Section
            Text {
                text: "Add to Group"
                font.pixelSize: 20
                font.bold: true
                color: "#ffffff"
                Layout.topMargin: 20
            }
            
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Repeater {
                    model: ["Favorites", "Sports", "News", "Kids"]
                    
                    Button {
                        text: "+ " + modelData
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 40
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
                    }
                }
            }
        }
    }
}
