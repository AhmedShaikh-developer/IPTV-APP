import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 700)
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
                    onClicked: navigateTo("/sources/manage")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "🔧 Metadata Providers"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Configure external metadata sources"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // TMDb Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
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
                            text: "🎬 TMDb (The Movie Database)"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                            Layout.fillWidth: true
                        }
                        
                        Switch {
                            id: tmdbSwitch
                            checked: true
                        }
                    }
                    
                    Text {
                        text: "Get movie & TV show metadata, posters, and ratings"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: tmdbKeyField
                        placeholderText: "TMDb API Key (v3)"
                        font.pixelSize: 14
                        color: "#ffffff"
                        Layout.fillWidth: true
                        enabled: tmdbSwitch.checked
                        background: Rectangle {
                            color: "#2f2f2f"
                            radius: 4
                        }
                        leftPadding: 15
                        rightPadding: 15
                        topPadding: 12
                        bottomPadding: 12
                    }
                    
                    RowLayout {
                        spacing: 10
                        
                        Text {
                            text: "📖"
                            font.pixelSize: 16
                        }
                        
                        Text {
                            text: "Get your free API key from: themoviedb.org/settings/api"
                            font.pixelSize: 12
                            color: "#3498db"
                            Layout.fillWidth: true
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: Qt.openUrlExternally("https://www.themoviedb.org/settings/api")
                            }
                        }
                    }
                }
            }
            
            // OpenSubtitles Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 260
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
                            text: "💬 OpenSubtitles"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                            Layout.fillWidth: true
                        }
                        
                        Switch {
                            id: subsSwitch
                            checked: false
                        }
                    }
                    
                    Text {
                        text: "Download subtitles for movies and TV shows"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        placeholderText: "Username"
                        font.pixelSize: 14
                        color: "#ffffff"
                        Layout.fillWidth: true
                        enabled: subsSwitch.checked
                        background: Rectangle {
                            color: "#2f2f2f"
                            radius: 4
                        }
                        leftPadding: 15
                        rightPadding: 15
                        topPadding: 12
                        bottomPadding: 12
                    }
                    
                    TextField {
                        placeholderText: "Password"
                        font.pixelSize: 14
                        color: "#ffffff"
                        echoMode: TextInput.Password
                        Layout.fillWidth: true
                        enabled: subsSwitch.checked
                        background: Rectangle {
                            color: "#2f2f2f"
                            radius: 4
                        }
                        leftPadding: 15
                        rightPadding: 15
                        topPadding: 12
                        bottomPadding: 12
                    }
                    
                    RowLayout {
                        spacing: 10
                        
                        Text {
                            text: "📖"
                            font.pixelSize: 16
                        }
                        
                        Text {
                            text: "Create account at: opensubtitles.org"
                            font.pixelSize: 12
                            color: "#3498db"
                            Layout.fillWidth: true
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: Qt.openUrlExternally("https://www.opensubtitles.org")
                            }
                        }
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
                onClicked: navigateTo("/sources/manage")
            }
        }
    }
}

