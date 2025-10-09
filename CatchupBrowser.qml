import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property string selectedTimeframe: "24h"
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Header
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
                    text: "⏪ Catch-up TV"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                }
                
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Repeater {
                        model: [
                            { id: "24h", label: "24h", hours: 24 },
                            { id: "48h", label: "48h", hours: 48 },
                            { id: "7d", label: "7 days", hours: 168 }
                        ]
                        
                        Button {
                            text: modelData.label
                            Layout.preferredWidth: 80
                            Layout.preferredHeight: 35
                            background: Rectangle {
                                color: selectedTimeframe === modelData.id ? "#e50914" : "transparent"
                                radius: 4
                                border.color: "#564d4d"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: selectedTimeframe === modelData.id ? "white" : "#b3b3b3"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: selectedTimeframe = modelData.id
                        }
                    }
                }
            }
        }
        
        // Content
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 20
            
            ColumnLayout {
                width: parent.width
                spacing: 30
                
                // Channels with Catch-up
                Repeater {
                    model: [
                        {
                            name: "BBC One",
                            logo: "📺",
                            programs: [
                                { title: "BBC Breakfast", time: "06:00", duration: "3h", description: "Morning news and current affairs" },
                                { title: "Morning Live", time: "09:00", duration: "1h", description: "Lifestyle magazine show" },
                                { title: "Homes Under the Hammer", time: "10:00", duration: "1h", description: "Property renovation show" },
                                { title: "BBC News at Noon", time: "12:00", duration: "30m", description: "Lunchtime news bulletin" },
                                { title: "Bargain Hunt", time: "12:30", duration: "45m", description: "Antiques treasure hunting" },
                                { title: "Doctors", time: "13:45", duration: "30m", description: "Medical drama series" },
                                { title: "Antiques Roadshow", time: "15:15", duration: "1h", description: "Antiques valuation show" },
                                { title: "Pointless", time: "17:00", duration: "45m", description: "Quiz show with Alexander Armstrong" },
                                { title: "BBC News at Six", time: "17:45", duration: "30m", description: "Evening news bulletin" },
                                { title: "The One Show", time: "18:15", duration: "30m", description: "Entertainment magazine show" },
                                { title: "EastEnders", time: "18:45", duration: "30m", description: "Long-running soap opera" },
                                { title: "MasterChef", time: "19:30", duration: "1h", description: "Cooking competition show" },
                                { title: "The Apprentice", time: "20:30", duration: "1h", description: "Business reality show" },
                                { title: "BBC News at Ten", time: "21:30", duration: "30m", description: "Late evening news bulletin" },
                                { title: "Question Time", time: "22:00", duration: "1h", description: "Political discussion program" }
                            ]
                        },
                        {
                            name: "ITV",
                            logo: "📺",
                            programs: [
                                { title: "Good Morning Britain", time: "06:00", duration: "3h", description: "Morning news and current affairs" },
                                { title: "This Morning", time: "10:00", duration: "2h", description: "Lifestyle and entertainment show" },
                                { title: "ITV News at 1:30", time: "13:30", duration: "30m", description: "Lunchtime news bulletin" },
                                { title: "Coronation Street", time: "19:00", duration: "30m", description: "Long-running soap opera" },
                                { title: "Emmerdale", time: "19:30", duration: "30m", description: "Rural soap opera" },
                                { title: "ITV News at Ten", time: "22:00", duration: "30m", description: "Evening news bulletin" },
                                { title: "The Chase", time: "17:00", duration: "1h", description: "Quiz show with Bradley Walsh" },
                                { title: "Tipping Point", time: "16:00", duration: "1h", description: "Quiz show with Ben Shephard" }
                            ]
                        },
                        {
                            name: "Channel 4",
                            logo: "📺",
                            programs: [
                                { title: "Channel 4 News", time: "19:00", duration: "1h", description: "Evening news and current affairs" },
                                { title: "The Great British Bake Off", time: "20:00", duration: "1h", description: "Baking competition show" },
                                { title: "Gogglebox", time: "21:00", duration: "1h", description: "People watching TV shows" },
                                { title: "First Dates", time: "22:00", duration: "1h", description: "Blind dating reality show" }
                            ]
                        },
                        {
                            name: "Sky Sports",
                            logo: "⚽",
                            programs: [
                                { title: "Premier League Live", time: "14:30", duration: "3h", description: "Live football coverage" },
                                { title: "Match of the Day", time: "22:30", duration: "1h", description: "Football highlights show" },
                                { title: "Sky Sports News", time: "18:00", duration: "1h", description: "Sports news and updates" },
                                { title: "Championship Football", time: "19:45", duration: "2h", description: "Live Championship match" }
                            ]
                        }
                    ]
                    
                    Rectangle {
                        Layout.fillWidth: true
                        color: "transparent"
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 15
                            
                            // Channel Header
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 15
                                
                                Rectangle {
                                    width: 50
                                    height: 50
                                    radius: 25
                                    color: "#2f2f2f"
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.logo
                                        font.pixelSize: 24
                                    }
                                }
                                
                                Text {
                                    text: modelData.name
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                
                                Rectangle {
                                    width: 80
                                    height: 25
                                    radius: 12
                                    color: "#27ae60"
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.programs.length + " programs"
                                        font.pixelSize: 12
                                        font.bold: true
                                        color: "white"
                                    }
                                }
                            }
                            
                            // Programs Grid
                            GridLayout {
                                Layout.fillWidth: true
                                columns: Math.max(1, Math.floor(parent.width / 300))
                                rowSpacing: 15
                                columnSpacing: 15
                                
                                Repeater {
                                    model: modelData.programs
                                    
                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 140
                                        color: "#181818"
                                        radius: 8
                                        border.color: "#2f2f2f"
                                        border.width: 1
                                        
                                        ColumnLayout {
                                            anchors.fill: parent
                                            anchors.margins: 15
                                            spacing: 8
                                            
                                            RowLayout {
                                                Layout.fillWidth: true
                                                spacing: 10
                                                
                                                Text {
                                                    text: modelData.time
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    color: "#e50914"
                                                    Layout.preferredWidth: 60
                                                }
                                                
                                                Text {
                                                    text: modelData.duration
                                                    font.pixelSize: 12
                                                    color: "#b3b3b3"
                                                }
                                            }
                                            
                                            Text {
                                                text: modelData.title
                                                font.pixelSize: 16
                                                font.bold: true
                                                color: "#ffffff"
                                                Layout.fillWidth: true
                                                wrapMode: Text.WordWrap
                                            }
                                            
                                            Text {
                                                text: modelData.description
                                                font.pixelSize: 12
                                                color: "#b3b3b3"
                                                Layout.fillWidth: true
                                                wrapMode: Text.WordWrap
                                                maximumLineCount: 2
                                                elide: Text.ElideRight
                                            }
                                            
                                            Button {
                                                text: "▶️ Watch"
                                                Layout.preferredWidth: 100
                                                Layout.preferredHeight: 30
                                                background: Rectangle {
                                                    color: "#e50914"
                                                    radius: 4
                                                }
                                                contentItem: Text {
                                                    text: parent.text
                                                    color: "white"
                                                    font.pixelSize: 12
                                                    font.bold: true
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                }
                                                onClicked: {
                                                    console.log("Watch catch-up program:", modelData.title)
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
