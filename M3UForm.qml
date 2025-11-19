import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import IPTVBackend 1.0

Rectangle {
    color: "#000000"
    
    property bool isFileMode: false
    property bool saving: false
    
    FilePicker {
        id: filePicker
        Component.onCompleted: {
            console.log("=== FilePicker Component.onCompleted ===")
            console.log("FilePicker object:", filePicker)
            console.log("FilePicker has openFileDialog:", typeof filePicker.openFileDialog)
        }
        Component.onDestruction: {
            console.log("FilePicker component destroyed")
        }
        onFileSelected: function(filePath) {
            console.log("=== FilePicker signal received ===")
            console.log("filePath:", filePath)
            playlistField.text = filePath
            console.log("File selected and set to field:", filePath)
        }
    }
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 600)
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
                    onClicked: navigateTo("/sources/add")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "📄 M3U / M3U8"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Add playlist URL or local file"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Source Type Toggle
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Button {
                    text: "🌐 URL"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    background: Rectangle {
                        color: !isFileMode ? "#e50914" : "transparent"
                        radius: 4
                        border.color: "#e50914"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: !isFileMode ? "white" : "#e50914"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: isFileMode = false
                }
                
                Button {
                    text: "📁 Local File"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    background: Rectangle {
                        color: isFileMode ? "#e50914" : "transparent"
                        radius: 4
                        border.color: "#e50914"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: isFileMode ? "white" : "#e50914"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: isFileMode = true
                }
            }
            
            // Playlist Name
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Playlist Name"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: nameField
                        placeholderText: "My M3U Playlist"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Playlist URL/File
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: isFileMode ? "Playlist File" : "Playlist URL"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        
                        TextField {
                            id: playlistField
                            placeholderText: isFileMode ? "Browse to select file..." : "http://example.com/playlist.m3u8"
                            font.pixelSize: 16
                            color: "#ffffff"
                            Layout.fillWidth: true
                            readOnly: isFileMode
                            background: Rectangle {
                                color: "transparent"
                            }
                        }
                        
                        Button {
                            visible: isFileMode
                            text: "Browse"
                            height: 35
                            enabled: true
                            background: Rectangle {
                                color: parent.enabled ? "#2f2f2f" : "#564d4d"
                                radius: 4
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                console.log("=== Browse button clicked ===")
                                console.log("isFileMode:", isFileMode)
                                console.log("filePicker object:", filePicker)
                                console.log("filePicker type:", typeof filePicker)
                                
                                if (!filePicker) {
                                    console.error("ERROR: filePicker is null or undefined!")
                                    return
                                }
                                
                                if (typeof filePicker.openFileDialog !== "function") {
                                    console.error("ERROR: openFileDialog is not a function!")
                                    console.log("filePicker methods:", Object.keys(filePicker))
                                    return
                                }
                                
                                console.log("Calling filePicker.openFileDialog...")
                                try {
                                    filePicker.openFileDialog("Select M3U File", "M3U Files (*.m3u *.m3u8);;All Files (*)")
                                    console.log("openFileDialog call completed")
                                } catch(e) {
                                    console.error("ERROR calling openFileDialog:", e.toString())
                                }
                            }
                        }
                    }
                }
            }
            
            // EPG URL (Optional)
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "EPG URL (Optional)"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: epgField
                        placeholderText: "http://example.com/epg.xml"
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Custom User-Agent
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Custom User-Agent (Optional)"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextField {
                        id: userAgentField
                        placeholderText: "Mozilla/5.0..."
                        font.pixelSize: 16
                        color: "#ffffff"
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Custom Headers
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "#181818"
                radius: 4
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 5
                    
                    Text {
                        text: "Custom Headers (Optional)"
                        font.pixelSize: 12
                        color: "#b3b3b3"
                    }
                    
                    TextArea {
                        id: headersField
                        placeholderText: "Referer: http://example.com\nAuthorization: Bearer token"
                        font.pixelSize: 14
                        color: "#ffffff"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
            
            // Error Message
            Rectangle {
                id: errorRect
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: "#e50914"
                radius: 4
                visible: PlaylistManager.errorMessage !== ""
                
                Text {
                    anchors.centerIn: parent
                    text: PlaylistManager.errorMessage
                    font.pixelSize: 14
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            
            // Save Buttons
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Button {
                    text: saving ? "Saving..." : "💾 Save"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    enabled: !saving
                    background: Rectangle {
                        color: saving ? "#564d4d" : "#e50914"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        if (nameField.text.trim() === "" || playlistField.text.trim() === "") {
                            errorRect.visible = true
                            return
                        }
                        saving = true
                        if (isFileMode) {
                            PlaylistManager.addM3UFilePlaylist(
                                nameField.text.trim(),
                                playlistField.text.trim()
                            )
                        } else {
                            PlaylistManager.addM3UUrlPlaylist(
                                nameField.text.trim(),
                                playlistField.text.trim()
                            )
                        }
                    }
                }
                
                Button {
                    text: saving ? "Saving..." : "💾 Save & Sync"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    enabled: !saving
                    background: Rectangle {
                        color: saving ? "#564d4d" : "#27ae60"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        if (nameField.text.trim() === "" || playlistField.text.trim() === "") {
                            errorRect.visible = true
                            return
                        }
                        saving = true
                        if (isFileMode) {
                            PlaylistManager.addM3UFilePlaylist(
                                nameField.text.trim(),
                                playlistField.text.trim()
                            )
                        } else {
                            PlaylistManager.addM3UUrlPlaylist(
                                nameField.text.trim(),
                                playlistField.text.trim()
                            )
                        }
                    }
                }
            }
        }
    }
    
    Connections {
        target: PlaylistManager
        function onPlaylistAdded(id) {
            saving = false
            navigateTo("/sources/manage")
        }
        function onErrorMessageChanged() {
            if (PlaylistManager.errorMessage !== "") {
                errorRect.visible = true
                saving = false
            }
        }
    }
}

