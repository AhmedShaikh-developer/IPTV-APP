import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property bool parentalControlsEnabled: true
    property string selectedRating: "PG-13"
    property var contentRatings: ["G", "PG", "PG-13", "R", "NC-17", "TV-Y", "TV-Y7", "TV-G", "TV-PG", "TV-14", "TV-MA"]
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 900)
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
                    onClicked: navigateTo("/profiles/manage")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "🔒 Parental Controls"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Manage content restrictions and viewing limits"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
                
                // PIN Lock Icon
                Rectangle {
                    width: 50
                    height: 50
                    radius: 25
                    color: "#e50914"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "🔐"
                        font.pixelSize: 24
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: navigateTo("/pin")
                    }
                }
            }
            
            // Master Toggle
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "#181818"
                radius: 8
                border.color: parentalControlsEnabled ? "#e50914" : "#2f2f2f"
                border.width: 2
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 20
                    
                    Rectangle {
                        width: 60
                        height: 60
                        radius: 30
                        color: parentalControlsEnabled ? "#e50914" : "#2f2f2f"
                        
                        Text {
                            anchors.centerIn: parent
                            text: parentalControlsEnabled ? "🔒" : "🔓"
                            font.pixelSize: 30
                        }
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: "Enable Parental Controls"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: parentalControlsEnabled ? "Parental controls are active" : "No restrictions applied"
                            font.pixelSize: 14
                            color: parentalControlsEnabled ? "#27ae60" : "#b3b3b3"
                        }
                    }
                    
                    Switch {
                        id: masterToggle
                        checked: parentalControlsEnabled
                        onCheckedChanged: parentalControlsEnabled = checked
                    }
                }
            }
            
            // Content Rating Restrictions
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 400
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 20
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Text {
                            text: "📺 Content Rating Restrictions"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                            Layout.fillWidth: true
                        }
                        
                        Rectangle {
                            width: 80
                            height: 30
                            radius: 15
                            color: "#e50914"
                            
                            Text {
                                anchors.centerIn: parent
                                text: selectedRating
                                font.pixelSize: 14
                                font.bold: true
                                color: "white"
                            }
                        }
                    }
                    
                    Text {
                        text: "Block content above this rating"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                        Layout.fillWidth: true
                    }
                    
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 10
                            
                            Repeater {
                                model: [
                                    { rating: "G", title: "General Audiences", desc: "All ages admitted" },
                                    { rating: "PG", title: "Parental Guidance", desc: "Some material may not be suitable for children" },
                                    { rating: "PG-13", title: "Parents Strongly Cautioned", desc: "Some material inappropriate for children under 13" },
                                    { rating: "R", title: "Restricted", desc: "Under 17 requires parent or guardian" },
                                    { rating: "NC-17", title: "Adults Only", desc: "No one 17 and under admitted" },
                                    { rating: "TV-MA", title: "Mature Audiences", desc: "Specifically for adults" }
                                ]
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 70
                                    color: modelData.rating === selectedRating ? "#2f2f2f" : "transparent"
                                    radius: 4
                                    border.color: modelData.rating === selectedRating ? "#e50914" : "#564d4d"
                                    border.width: 1
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 15
                                        spacing: 15
                                        
                                        Rectangle {
                                            width: 50
                                            height: 40
                                            radius: 4
                                            color: {
                                                if (index === 0) return "#27ae60"
                                                if (index === 1) return "#3498db"
                                                if (index === 2) return "#f39c12"
                                                if (index === 3) return "#e74c3c"
                                                return "#9b59b6"
                                            }
                                            
                                            Text {
                                                anchors.centerIn: parent
                                                text: modelData.rating
                                                font.pixelSize: 12
                                                font.bold: true
                                                color: "white"
                                            }
                                        }
                                        
                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            spacing: 5
                                            
                                            Text {
                                                text: modelData.title
                                                font.pixelSize: 14
                                                font.bold: true
                                                color: "#ffffff"
                                            }
                                            
                                            Text {
                                                text: modelData.desc
                                                font.pixelSize: 12
                                                color: "#b3b3b3"
                                                wrapMode: Text.WordWrap
                                                Layout.fillWidth: true
                                            }
                                        }
                                        
                                        RadioButton {
                                            checked: modelData.rating === selectedRating
                                            onClicked: selectedRating = modelData.rating
                                        }
                                    }
                                    
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: selectedRating = modelData.rating
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // Content Categories
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 350
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 20
                    
                    Text {
                        text: "🚫 Block Content Categories"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Hide specific types of content"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 15
                        
                        Repeater {
                            model: [
                                { icon: "🔞", title: "Adult Content", desc: "Block all mature/adult content" },
                                { icon: "🩸", title: "Violence", desc: "Block violent or graphic content" },
                                { icon: "😱", title: "Horror", desc: "Block horror and scary content" },
                                { icon: "💊", title: "Drug Use", desc: "Block content with drug references" }
                            ]
                            
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 70
                                color: "transparent"
                                radius: 4
                                border.color: "#564d4d"
                                border.width: 1
                                
                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 15
                                    
                                    Text {
                                        text: modelData.icon
                                        font.pixelSize: 30
                                    }
                                    
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 5
                                        
                                        Text {
                                            text: modelData.title
                                            font.pixelSize: 16
                                            font.bold: true
                                            color: "#ffffff"
                                        }
                                        
                                        Text {
                                            text: modelData.desc
                                            font.pixelSize: 12
                                            color: "#b3b3b3"
                                        }
                                    }
                                    
                                    Switch {
                                        checked: index === 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // Viewing Time Limits
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 250
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 20
                    
                    Text {
                        text: "⏰ Viewing Time Limits"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Set daily viewing time limits for kids profiles"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 10
                            
                            Text {
                                text: "Weekdays"
                                font.pixelSize: 16
                                color: "#ffffff"
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                color: "#2f2f2f"
                                radius: 4
                                
                                RowLayout {
                                    anchors.centerIn: parent
                                    spacing: 10
                                    
                                    Text {
                                        text: "⏱️"
                                        font.pixelSize: 20
                                    }
                                    
                                    SpinBox {
                                        from: 0
                                        to: 8
                                        value: 2
                                        editable: true
                                    }
                                    
                                    Text {
                                        text: "hours"
                                        font.pixelSize: 14
                                        color: "#b3b3b3"
                                    }
                                }
                            }
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 10
                            
                            Text {
                                text: "Weekends"
                                font.pixelSize: 16
                                color: "#ffffff"
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                color: "#2f2f2f"
                                radius: 4
                                
                                RowLayout {
                                    anchors.centerIn: parent
                                    spacing: 10
                                    
                                    Text {
                                        text: "⏱️"
                                        font.pixelSize: 20
                                    }
                                    
                                    SpinBox {
                                        from: 0
                                        to: 12
                                        value: 4
                                        editable: true
                                    }
                                    
                                    Text {
                                        text: "hours"
                                        font.pixelSize: 14
                                        color: "#b3b3b3"
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // PIN Management
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 20
                    
                    Text {
                        text: "🔐"
                        font.pixelSize: 40
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: "PIN Protection"
                            font.pixelSize: 18
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Change your parental control PIN"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                    }
                    
                    Button {
                        text: "Change PIN"
                        Layout.preferredWidth: 120
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
                        onClicked: navigateTo("/pin")
                    }
                }
            }
            
            // Save Button
            Button {
                text: "💾 Save Settings"
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                Layout.topMargin: 20
                background: Rectangle {
                    color: "#e50914"
                    radius: 4
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 18
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // Save settings
                    navigateTo("/profiles/manage")
                }
            }
        }
    }
}

