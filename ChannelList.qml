import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import IPTVBackend 1.0

Rectangle {
    color: "#000000"
    
    property string currentCategory: ""
    
    Component.onCompleted: {
        console.log("=== ChannelList loaded ===")
        console.log("PlaylistManager.liveChannelsModel.count:", PlaylistManager.liveChannelsModel.count)
        console.log("Current category:", currentCategory)
    }
    
    // Note: QAbstractListModel doesn't have a countChanged signal
    // Instead, we rely on the model's rowCount() property which is bound automatically
    // The Repeater will update when items are added/removed from the model
    
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
                            // Always try to use backend model first
                            id: channelRepeater
                            model: PlaylistManager.liveChannelsModel
                            
                            onModelChanged: {
                                console.log("=== ChannelList Repeater model changed ===")
                                console.log("Model count:", PlaylistManager.liveChannelsModel.count)
                            }
                            
                            Component.onCompleted: {
                                console.log("=== ChannelList Repeater component completed ===")
                                console.log("Model type:", typeof PlaylistManager.liveChannelsModel)
                                console.log("Model count:", PlaylistManager.liveChannelsModel.count)
                                if (PlaylistManager.liveChannelsModel.count === 0) {
                                    console.warn("WARNING: No channels in model! Showing empty list.")
                                    console.log("If you expected channels, make sure you clicked 'Play' on a playlist first.")
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 200
                                color: channelMouseArea.containsMouse ? "#2f2f2f" : "#181818"
                                radius: 12
                                border.color: channelMouseArea.containsMouse ? "#e50914" : "#2f2f2f"
                                border.width: channelMouseArea.containsMouse ? 2 : 1
                                
                                Behavior on color {
                                    ColorAnimation { duration: 200 }
                                }
                                Behavior on border.color {
                                    ColorAnimation { duration: 200 }
                                }
                                
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
                                                text: model.logo ? model.logo : "📺"
                                                font.pixelSize: 24
                                            }
                                        }
                                        
                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            spacing: 2
                                            
                                            Text {
                                                text: model.name ? model.name : "Unknown Channel"
                                                font.pixelSize: 16
                                                font.bold: true
                                                color: "#ffffff"
                                                Layout.fillWidth: true
                                            }
                                            
                                            RowLayout {
                                                spacing: 5
                                                
                                                // HD badge - show if URL suggests HD or if group contains HD
                                                Rectangle {
                                                    width: 30
                                                    height: 16
                                                    radius: 8
                                                    color: "#e50914"
                                                    visible: (model.url && model.url.toLowerCase().indexOf("hd") !== -1) || 
                                                            (model.groupTitle && model.groupTitle.toLowerCase().indexOf("hd") !== -1)
                                                    
                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: "HD"
                                                        font.pixelSize: 10
                                                        font.bold: true
                                                        color: "white"
                                                    }
                                                }
                                                
                                                // Category/Group badge
                                                Rectangle {
                                                    width: Math.min(80, (model.groupTitle ? model.groupTitle.length * 6 : 40))
                                                    height: 16
                                                    radius: 8
                                                    color: "#27ae60"
                                                    visible: model.groupTitle && model.groupTitle !== ""
                                                    
                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: model.groupTitle || ""
                                                        font.pixelSize: 9
                                                        font.bold: true
                                                        color: "white"
                                                        elide: Text.ElideRight
                                                    }
                                                }
                                            }
                                        }
                                        
                                        // Play button in header (alternative to clicking the card)
                                        Button {
                                            text: "▶ Play"
                                            Layout.preferredWidth: 80
                                            Layout.preferredHeight: 35
                                            background: Rectangle {
                                                color: channelMouseArea.containsMouse ? "#e50914" : "#564d4d"
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
                                                // Same click handler as MouseArea
                                                console.log("=== Play button clicked ===")
                                                var channelName = model.name || "Unknown Channel"
                                                var channelUrl = model.url || ""
                                                
                                                console.log("Channel name:", channelName)
                                                console.log("Channel URL:", channelUrl)
                                                
                                                if (!channelUrl || channelUrl === "") {
                                                    var channel = PlaylistManager.liveChannelsModel.getChannel(index)
                                                    if (channel) {
                                                        channelUrl = channel.url || ""
                                                        channelName = channel.name || channelName
                                                        console.log("Got from getChannel() - URL:", channelUrl)
                                                    }
                                                }
                                                
                                                if (channelUrl && channelUrl !== "") {
                                                    console.log("✓ Playing:", channelName)
                                                    console.log("✓ URL:", channelUrl)
                                                    // Navigate first, then play - this ensures PlayerPage is loaded to receive the signal
                                                    navigateTo("/player")
                                                    // Use a small delay to ensure PlayerPage is fully loaded
                                                    Qt.callLater(function() {
                                                        console.log("Calling playSingleStream after navigation...")
                                                        PlaylistManager.playSingleStream(channelUrl)
                                                    })
                                                } else {
                                                    console.error("✗ ERROR: Channel URL is empty!")
                                                }
                                            }
                                        }
                                    }
                                    
                                    // Now Playing / Info section with Play Button
                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 60
                                        color: channelMouseArea.containsMouse ? "#3f3f3f" : "#2f2f2f"
                                        radius: 6
                                        
                                        Behavior on color {
                                            ColorAnimation { duration: 200 }
                                        }
                                        
                                        // Play button - always visible
                                        Rectangle {
                                            anchors.right: parent.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.margins: 10
                                            width: 40
                                            height: 40
                                            radius: 20
                                            color: channelMouseArea.containsMouse ? "#e50914" : "#564d4d"
                                            
                                            Behavior on color {
                                                ColorAnimation { duration: 200 }
                                            }
                                            
                                            Text {
                                                anchors.centerIn: parent
                                                text: "▶"
                                                font.pixelSize: 16
                                                color: "white"
                                            }
                                        }
                                        
                                        ColumnLayout {
                                            anchors.fill: parent
                                            anchors.margins: 10
                                            anchors.rightMargin: 60  // Make room for play button
                                            spacing: 5
                                            
                                            Text {
                                                text: "Click to Play"
                                                font.pixelSize: 12
                                                color: "#e50914"
                                                font.bold: true
                                            }
                                            
                                            Text {
                                                text: model.groupTitle ? ("Category: " + model.groupTitle) : "Live Channel"
                                                font.pixelSize: 12
                                                color: "#ffffff"
                                                Layout.fillWidth: true
                                                wrapMode: Text.WordWrap
                                            }
                                        }
                                    }
                                    
                                    // Next - Show group for backend model
                                    Text {
                                        text: PlaylistManager.liveChannelsModel.count > 0 ? 
                                              ("Group: " + (model.groupTitle || "Default")) : 
                                              ("Next: " + (modelData ? modelData.next : ""))
                                        font.pixelSize: 12
                                        color: "#b3b3b3"
                                        Layout.fillWidth: true
                                        wrapMode: Text.WordWrap
                                    }
                                }
                                
                                MouseArea {
                                    id: channelMouseArea
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onClicked: {
                                        console.log("=== Channel clicked ===")
                                        console.log("PlaylistManager.liveChannelsModel.count:", PlaylistManager.liveChannelsModel.count)
                                        console.log("Repeater index:", index)
                                        
                                        // Try to get URL from model - QAbstractListModel exposes properties directly as model.url
                                        var channelName = model.name || "Unknown Channel"
                                        var channelUrl = model.url || ""
                                        
                                        console.log("Channel name from model:", channelName)
                                        console.log("Channel URL from model:", channelUrl)
                                        console.log("Model.name type:", typeof model.name)
                                        console.log("Model.url type:", typeof model.url)
                                        
                                        // Debug: Try to access model properties
                                        try {
                                            console.log("Trying model.name:", model.name)
                                            console.log("Trying model.url:", model.url)
                                            console.log("Trying model.groupTitle:", model.groupTitle)
                                            console.log("Trying model.logo:", model.logo)
                                        } catch (e) {
                                            console.error("Error accessing model properties:", e)
                                        }
                                        
                                        // If URL is still empty, try accessing via the model's getChannel method
                                        if (!channelUrl || channelUrl === "") {
                                            console.log("URL empty, trying to get from model index:", index)
                                            try {
                                                var channel = PlaylistManager.liveChannelsModel.getChannel(index)
                                                if (channel) {
                                                    channelUrl = channel.url || ""
                                                    channelName = channel.name || channelName
                                                    console.log("Got from model.getChannel() - URL:", channelUrl)
                                                    console.log("Got from model.getChannel() - Name:", channelName)
                                                } else {
                                                    console.error("getChannel returned null for index:", index)
                                                }
                                            } catch (e) {
                                                console.error("Error using model.getChannel():", e)
                                            }
                                        }
                                        
                                        if (channelUrl && channelUrl !== "") {
                                            console.log("✓ Playing channel:", channelName)
                                            console.log("✓ URL:", channelUrl)
                                            // Navigate first, then play - this ensures PlayerPage is loaded to receive the signal
                                            navigateTo("/player")
                                            // Use a small delay to ensure PlayerPage is fully loaded
                                            Qt.callLater(function() {
                                                console.log("Calling playSingleStream after navigation...")
                                                PlaylistManager.playSingleStream(channelUrl)
                                            })
                                        } else {
                                            console.error("✗ ERROR: Channel URL is empty!")
                                            console.error("Cannot play channel:", channelName)
                                            console.log("Model properties available:", Object.keys(model))
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
