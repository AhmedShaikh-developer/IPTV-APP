import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 20
        
        ColumnLayout {
            width: parent.width
            spacing: 20
            
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
                    onClicked: navigateTo("/home")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "⏰ Reminders"
                        font.pixelSize: 32
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Your upcoming program reminders"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Reminders List
            Repeater {
                model: [
                    {
                        title: "MasterChef",
                        channel: "BBC One",
                        date: "Today",
                        time: "19:30",
                        logo: "🎬",
                        synopsis: "The remaining contestants face their biggest challenge yet",
                        isToday: true,
                        isUpcoming: true
                    },
                    {
                        title: "The Apprentice",
                        channel: "BBC One",
                        date: "Today",
                        time: "20:30",
                        logo: "💼",
                        synopsis: "Lord Sugar's candidates compete in a business challenge",
                        isToday: true,
                        isUpcoming: true
                    },
                    {
                        title: "EastEnders",
                        channel: "BBC One",
                        date: "Today",
                        time: "18:45",
                        logo: "🏘️",
                        synopsis: "Drama unfolds in Albert Square",
                        isToday: true,
                        isUpcoming: true
                    },
                    {
                        title: "Premier League Live",
                        channel: "Sky Sports",
                        date: "Tomorrow",
                        time: "14:30",
                        logo: "⚽",
                        synopsis: "Manchester United vs Liverpool - Live coverage",
                        isToday: false,
                        isUpcoming: true
                    },
                    {
                        title: "Planet Earth III",
                        channel: "BBC One",
                        date: "Tomorrow",
                        time: "20:00",
                        logo: "🌍",
                        synopsis: "David Attenborough presents the latest nature documentary",
                        isToday: false,
                        isUpcoming: true
                    },
                    {
                        title: "Breaking Bad",
                        channel: "Netflix",
                        date: "Yesterday",
                        time: "21:00",
                        logo: "🧪",
                        synopsis: "Walter White's transformation continues",
                        isToday: false,
                        isUpcoming: false
                    }
                ]
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: modelData.isToday ? "#1a2f1a" : (modelData.isUpcoming ? "#181818" : "#2a2a2a")
                    radius: 12
                    border.color: modelData.isToday ? "#27ae60" : "#2f2f2f"
                    border.width: modelData.isToday ? 2 : 1
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        Rectangle {
                            width: 60
                            height: 60
                            radius: 30
                            color: "#2f2f2f"
                            
                            Text {
                                anchors.centerIn: parent
                                text: modelData.logo
                                font.pixelSize: 28
                            }
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5
                            
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 10
                                
                                Text {
                                    text: modelData.title
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                
                                Rectangle {
                                    width: 60
                                    height: 20
                                    radius: 10
                                    color: modelData.isToday ? "#27ae60" : (modelData.isUpcoming ? "#f39c12" : "#95a5a6")
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.isToday ? "TODAY" : (modelData.isUpcoming ? "UPCOMING" : "PAST")
                                        font.pixelSize: 10
                                        font.bold: true
                                        color: "white"
                                    }
                                }
                            }
                            
                            Text {
                                text: modelData.channel + " • " + modelData.date + " at " + modelData.time
                                font.pixelSize: 14
                                color: "#b3b3b3"
                            }
                            
                            Text {
                                text: modelData.synopsis
                                font.pixelSize: 14
                                color: "#ffffff"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                                maximumLineCount: 2
                                elide: Text.ElideRight
                            }
                        }
                        
                        ColumnLayout {
                            spacing: 10
                            
                            Button {
                                text: modelData.isUpcoming ? "▶️ Watch" : "👁️ View"
                                Layout.preferredWidth: 100
                                Layout.preferredHeight: 35
                                background: Rectangle {
                                    color: modelData.isUpcoming ? "#e50914" : "#2f2f2f"
                                    radius: 6
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "white"
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    if (modelData.isUpcoming) {
                                        console.log("Watch clicked for:", modelData.title)
                                    } else {
                                        console.log("View clicked for:", modelData.title)
                                    }
                                }
                            }
                            
                            Button {
                                text: "✕ Remove"
                                Layout.preferredWidth: 100
                                Layout.preferredHeight: 35
                                background: Rectangle {
                                    color: "transparent"
                                    radius: 6
                                    border.color: "#564d4d"
                                    border.width: 1
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "#b3b3b3"
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    console.log("Remove reminder for:", modelData.title)
                                }
                            }
                        }
                    }
                }
            }
            
            // Empty State
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: "transparent"
                visible: false // Set to true when no reminders exist
                
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 20
                    
                    Text {
                        text: "📅"
                        font.pixelSize: 60
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    Text {
                        text: "No Reminders"
                        font.pixelSize: 24
                        font.bold: true
                        color: "#ffffff"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    Text {
                        text: "You haven't set any program reminders yet.\nBrowse the TV guide to add some!"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }
                    
                    Button {
                        text: "Browse TV Guide"
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
                        onClicked: navigateTo("/guide")
                    }
                }
            }
        }
    }
}
