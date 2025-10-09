import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property string currentCategory: ""
    
    RowLayout {
        anchors.fill: parent
        spacing: 0
        
        // Left Panel - Filters
        Rectangle {
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            color: "#141414"
            border.color: "#2f2f2f"
            border.width: 1
            
            ScrollView {
                anchors.fill: parent
                anchors.margins: 20
                
                ColumnLayout {
                    width: parent.width
                    spacing: 20
                    
                    Text {
                        text: "Filters"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#ffffff"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    TextField {
                        Layout.fillWidth: true
                        placeholderText: "Search channels..."
                        background: Rectangle {
                            color: "#2f2f2f"
                            radius: 6
                        }
                        color: "#ffffff"
                        font.pixelSize: 14
                    }
                    
                    Text {
                        text: "Categories"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#e50914"
                    }
                    
                    Repeater {
                        model: ["All", "Sports", "News", "Entertainment", "Movies", "Kids", "Music"]
                        
                        Button {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 35
                            text: modelData
                            background: Rectangle {
                                color: currentCategory === modelData ? "#e50914" : "transparent"
                                radius: 4
                            }
                            contentItem: Text {
                                text: parent.text
                                color: currentCategory === modelData ? "white" : "#b3b3b3"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignLeft
                                leftPadding: 10
                            }
                            onClicked: currentCategory = modelData
                        }
                    }
                    
                    Text {
                        text: "Quality"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#e50914"
                        Layout.topMargin: 20
                    }
                    
                    CheckBox {
                        text: "HD"
                        checked: true
                        font.pixelSize: 14
                        indicator: Rectangle {
                            implicitWidth: 20
                            implicitHeight: 20
                            x: parent.leftPadding
                            y: parent.height / 2 - height / 2
                            radius: 3
                            border.color: parent.checked ? "#e50914" : "#b3b3b3"
                            color: parent.checked ? "#e50914" : "transparent"
                            
                            Text {
                                text: "✓"
                                color: "white"
                                font.pixelSize: 12
                                anchors.centerIn: parent
                                visible: parent.parent.checked
                            }
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#ffffff"
                            font: parent.font
                            leftPadding: parent.indicator.width + parent.spacing
                        }
                    }
                    
                    CheckBox {
                        text: "4K"
                        checked: false
                        font.pixelSize: 14
                        indicator: Rectangle {
                            implicitWidth: 20
                            implicitHeight: 20
                            x: parent.leftPadding
                            y: parent.height / 2 - height / 2
                            radius: 3
                            border.color: parent.checked ? "#e50914" : "#b3b3b3"
                            color: parent.checked ? "#e50914" : "transparent"
                            
                            Text {
                                text: "✓"
                                color: "white"
                                font.pixelSize: 12
                                anchors.centerIn: parent
                                visible: parent.parent.checked
                            }
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#ffffff"
                            font: parent.font
                            leftPadding: parent.indicator.width + parent.spacing
                        }
                    }
                }
            }
        }
        
        // Main Content - Channel Grid
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#000000"
            
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                
                // Header
                RowLayout {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    Layout.margins: 20
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
                        onClicked: navigateTo("/live/groups")
                    }
                    
                    Text {
                        text: currentCategory === "" ? "All Channels" : currentCategory
                        font.pixelSize: 24
                        font.bold: true
                        color: "#ffffff"
                        Layout.fillWidth: true
                    }
                    
                    RowLayout {
                        spacing: 10
                        
                        Button {
                            text: "Grid"
                            Layout.preferredWidth: 80
                            Layout.preferredHeight: 35
                            background: Rectangle {
                                color: "#e50914"
                                radius: 4
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        
                        Button {
                            text: "List"
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
                            }
                        }
                    }
                }
                
                // Channel Grid
                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 20
                    
                    GridLayout {
                        width: parent.width
                        columns: Math.max(1, Math.floor(parent.width / 280))
                        rowSpacing: 20
                        columnSpacing: 20
                        
                        Repeater {
                            model: [
                                { name: "BBC One", logo: "📺", now: "BBC News", next: "EastEnders", hd: true, catchup: true, favorite: false },
                                { name: "ITV", logo: "📺", now: "Coronation Street", next: "ITV News", hd: true, catchup: true, favorite: true },
                                { name: "Channel 4", logo: "📺", now: "The Great British Bake Off", next: "Channel 4 News", hd: true, catchup: false, favorite: false },
                                { name: "Sky Sports", logo: "⚽", now: "Premier League", next: "Championship", hd: true, catchup: true, favorite: true },
                                { name: "ESPN", logo: "🏀", now: "NBA Live", next: "NFL Highlights", hd: true, catchup: false, favorite: false },
                                { name: "CNN", logo: "📰", now: "Breaking News", next: "Anderson Cooper", hd: true, catchup: true, favorite: false },
                                { name: "Discovery", logo: "🌍", now: "Planet Earth", next: "Blue Planet", hd: true, catchup: true, favorite: true },
                                { name: "Cartoon Network", logo: "🧒", now: "Adventure Time", next: "Regular Show", hd: false, catchup: true, favorite: false }
                            ]
                            
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 200
                                color: "#181818"
                                radius: 12
                                border.color: "#2f2f2f"
                                border.width: 1
                                
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 10
                                    
                                    // Channel Header
                                    RowLayout {
                                        Layout.fillWidth: true
                                        
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
                                        
                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            spacing: 2
                                            
                                            Text {
                                                text: modelData.name
                                                font.pixelSize: 16
                                                font.bold: true
                                                color: "#ffffff"
                                                Layout.fillWidth: true
                                            }
                                            
                                            RowLayout {
                                                spacing: 5
                                                
                                                Rectangle {
                                                    width: 30
                                                    height: 16
                                                    radius: 8
                                                    color: modelData.hd ? "#e50914" : "#564d4d"
                                                    visible: modelData.hd
                                                    
                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: "HD"
                                                        font.pixelSize: 10
                                                        font.bold: true
                                                        color: "white"
                                                    }
                                                }
                                                
                                                Rectangle {
                                                    width: 30
                                                    height: 16
                                                    radius: 8
                                                    color: "#27ae60"
                                                    visible: modelData.catchup
                                                    
                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: "C+"
                                                        font.pixelSize: 10
                                                        font.bold: true
                                                        color: "white"
                                                    }
                                                }
                                            }
                                        }
                                        
                                        Button {
                                            text: modelData.favorite ? "❤️" : "🤍"
                                            Layout.preferredWidth: 35
                                            Layout.preferredHeight: 35
                                            background: Rectangle {
                                                color: "transparent"
                                            }
                                            onClicked: {
                                                // Toggle favorite
                                                model.setProperty(index, "favorite", !modelData.favorite)
                                            }
                                        }
                                    }
                                    
                                    // Now Playing
                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 60
                                        color: "#2f2f2f"
                                        radius: 6
                                        
                                        ColumnLayout {
                                            anchors.fill: parent
                                            anchors.margins: 10
                                            spacing: 5
                                            
                                            Text {
                                                text: "Now"
                                                font.pixelSize: 12
                                                color: "#e50914"
                                                font.bold: true
                                            }
                                            
                                            Text {
                                                text: modelData.now
                                                font.pixelSize: 14
                                                color: "#ffffff"
                                                Layout.fillWidth: true
                                                wrapMode: Text.WordWrap
                                            }
                                        }
                                    }
                                    
                                    // Next
                                    Text {
                                        text: "Next: " + modelData.next
                                        font.pixelSize: 12
                                        color: "#b3b3b3"
                                        Layout.fillWidth: true
                                        wrapMode: Text.WordWrap
                                    }
                                }
                                
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: navigateTo("/live/channel/" + index)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
