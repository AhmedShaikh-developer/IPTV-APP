import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import IPTVBackend 1.0

Rectangle {
    color: "#000000"
    
    property bool mergeView: false
    
    function loadPlaylists() {
        var playlists = PlaylistManager.getPlaylists()
        playlistModel.clear()
        for (var i = 0; i < playlists.length; i++) {
            playlistModel.append(playlists[i])
        }
    }
    
    Component.onCompleted: {
        loadPlaylists()
    }
    
    ListModel {
        id: playlistModel
    }
    
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
                    onClicked: navigateTo("/main")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "⚙️ Source Manager"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Manage your IPTV sources"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
                
                Button {
                    text: "+ Add New"
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
                        leftPadding: 20
                        rightPadding: 20
                    }
                    onClicked: navigateTo("/sources/add")
                }
            }
            
            // View Toggle
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Text {
                    text: "View Mode:"
                    font.pixelSize: 16
                    color: "#b3b3b3"
                }
                
                Button {
                    text: "📋 Separate"
                    Layout.preferredHeight: 40
                    background: Rectangle {
                        color: !mergeView ? "#e50914" : "transparent"
                        radius: 4
                        border.color: "#e50914"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: !mergeView ? "white" : "#e50914"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: mergeView = false
                }
                
                Button {
                    text: "🔀 Merged"
                    Layout.preferredHeight: 40
                    background: Rectangle {
                        color: mergeView ? "#e50914" : "transparent"
                        radius: 4
                        border.color: "#e50914"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: mergeView ? "white" : "#e50914"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: mergeView = true
                }
            }
            
            // Source List
            Repeater {
                model: playlistModel
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#181818"
                    radius: 8
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20
                        
                        // Drag Handle
                        Rectangle {
                            width: 30
                            height: 60
                            color: "transparent"
                            
                            Column {
                                anchors.centerIn: parent
                                spacing: 3
                                Repeater {
                                    model: 3
                                    Rectangle {
                                        width: 20
                                        height: 3
                                        color: "#564d4d"
                                        radius: 1
                                    }
                                }
                            }
                        }
                        
                        // Source Info
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            RowLayout {
                                spacing: 10
                                
                                Text {
                                    text: model.name || "Unnamed Playlist"
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
                                        text: "ACTIVE"
                                        font.pixelSize: 10
                                        font.bold: true
                                        color: "white"
                                    }
                                }
                            }
                            
                            Text {
                                text: (model.type || "Unknown") + " • " + (model.channelCount || 0) + " channels" + (model.vodCount > 0 ? " • " + model.vodCount + " VOD" : "")
                                font.pixelSize: 14
                                color: "#b3b3b3"
                            }
                            
                            Text {
                                text: "Last synced: " + (model.lastSynced || "Never")
                                font.pixelSize: 12
                                color: "#564d4d"
                            }
                        }
                        
                        // Actions
                        RowLayout {
                            spacing: 10
                            
                            Button {
                                text: "🔄"
                                Layout.preferredWidth: 45
                                Layout.preferredHeight: 45
                                background: Rectangle {
                                    color: "#2f2f2f"
                                    radius: 4
                                }
                                contentItem: Text {
                                    text: parent.text
                                    font.pixelSize: 20
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    PlaylistManager.setActivePlaylist(model.id)
                                    PlaylistManager.refreshActivePlaylist()
                                    navigateTo("/home")
                                }
                            }
                            
                            Button {
                                text: "▶️"
                                Layout.preferredWidth: 45
                                Layout.preferredHeight: 45
                                background: Rectangle {
                                    color: "#2f2f2f"
                                    radius: 4
                                }
                                contentItem: Text {
                                    text: parent.text
                                    font.pixelSize: 20
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    console.log("=== Play button clicked ===")
                                    console.log("Playlist ID:", model.id)
                                    console.log("Playlist name:", model.name)
                                    PlaylistManager.setActivePlaylist(model.id)
                                    // Navigate to Live TV groups to show channels
                                    navigateTo("/live/groups")
                                    console.log("Navigating to Live TV groups...")
                                }
                            }
                            
                            Button {
                                text: "🗑️"
                                Layout.preferredWidth: 45
                                Layout.preferredHeight: 45
                                background: Rectangle {
                                    color: "#2f2f2f"
                                    radius: 4
                                }
                                contentItem: Text {
                                    text: parent.text
                                    font.pixelSize: 20
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    PlaylistManager.removePlaylist(model.id)
                                    loadPlaylists()
                                }
                            }
                        }
                    }
                }
            }
            
            // Metadata Providers Link
            Button {
                text: "🔧 Metadata Providers Settings"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.topMargin: 20
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
                onClicked: navigateTo("/sources/metadata")
            }
        }
    }
    
    Connections {
        target: PlaylistManager
        function onPlaylistAdded(id) {
            loadPlaylists()
        }
        function onPlaylistRemoved(id) {
            loadPlaylists()
        }
    }
}

