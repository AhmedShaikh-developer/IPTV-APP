import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: historyScreen
    color: "#000000"

    property int currentTab: 0
    property var tabs: ["All", "Live TV", "Movies", "Series", "Episodes"]
    property string currentSort: "Most Recent"

    // Mock history data
    property var historyItems: [
        { id: "1", type: "live", title: "BBC News HD", subtitle: "Watched 2h ago", thumbnail: "📰", progress: 1.0 },
        { id: "2", type: "movie", title: "The Dark Knight", subtitle: "Movie • Watched 1d ago", thumbnail: "🎬", progress: 1.0 },
        { id: "3", type: "episode", title: "Breaking Bad S05E14", subtitle: "Episode • Watched 3d ago", thumbnail: "🧪", progress: 0.8 },
        { id: "4", type: "series", title: "Game of Thrones", subtitle: "Series • Watched 1w ago", thumbnail: "👑", progress: 1.0 },
        { id: "5", type: "live", title: "ESPN Sports", subtitle: "Watched 2d ago", thumbnail: "⚽", progress: 0.6 },
        { id: "6", type: "movie", title: "Inception", subtitle: "Movie • Watched 1w ago", thumbnail: "🎭", progress: 1.0 },
        { id: "7", type: "episode", title: "Stranger Things S04E09", subtitle: "Episode • Watched 2w ago", thumbnail: "👻", progress: 1.0 },
        { id: "8", type: "live", title: "Discovery Channel", subtitle: "Watched 3d ago", thumbnail: "🌍", progress: 0.4 }
    ]

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function removeFromHistory(id) {
        historyItems = historyItems.filter(item => item.id !== id)
    }

    function clearAllHistory() {
        historyItems = []
    }

    function getFilteredItems() {
        var filtered = historyItems
        
        if (currentTab === 0) return filtered // All
        if (currentTab === 1) return filtered.filter(item => item.type === "live")
        if (currentTab === 2) return filtered.filter(item => item.type === "movie")
        if (currentTab === 3) return filtered.filter(item => item.type === "series")
        if (currentTab === 4) return filtered.filter(item => item.type === "episode")
        
        return filtered
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 30

        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            Button {
                width: 44
                height: 44
                background: Rectangle {
                    color: parent.hovered ? "#2A2A2A" : "transparent"
                    radius: 22
                    border.color: "#444444"
                    border.width: 1
                }
                contentItem: Text {
                    text: "←"
                    font.pixelSize: 20
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/home")
            }

            Text {
                text: "Recently Watched"
                font.pixelSize: 32
                font.bold: true
                color: "#FFFFFF"
            }

            Item { Layout.fillWidth: true }

            // Clear All Button
            Button {
                text: "Clear All"
                Layout.preferredHeight: 40
                padding: 0
                background: Rectangle {
                    color: parent.hovered ? "#E50914" : "#444444"
                    radius: 6
                    border.color: "#666666"
                    border.width: 1
                }
                contentItem: Text {
                    text: parent.text
                    color: "#FFFFFF"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // Show confirmation dialog
                    clearAllHistory()
                }
            }
        }

        // Tabs
        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            Repeater {
                model: tabs
                delegate: Button {
                    Layout.preferredHeight: 50
                    Layout.fillWidth: true
                    padding: 0
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "transparent"
                        
                        // Animated underline for active tab
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: 3
                            color: "#E50914"
                            visible: index === currentTab
                            
                            Behavior on anchors.leftMargin {
                                NumberAnimation { duration: 200 }
                            }
                            Behavior on anchors.rightMargin {
                                NumberAnimation { duration: 200 }
                            }
                        }
                    }
                    contentItem: Text {
                        text: parent.text
                        color: index === currentTab ? "#FFFFFF" : "#B3B3B3"
                        font.pixelSize: 16
                        font.bold: index === currentTab
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        currentTab = index
                    }
                }
            }
        }

        // Sort Options
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Text {
                text: "Sort by:"
                font.pixelSize: 14
                color: "#B3B3B3"
            }

            Repeater {
                model: ["Most Recent", "Alphabetical"]
                delegate: Button {
                    text: modelData
                    Layout.preferredHeight: 32
                    padding: 0
                    background: Rectangle {
                        color: parent.hovered ? "#2A2A2A" : (currentSort === modelData ? "#E50914" : "#111111")
                        radius: 16
                        border.color: "#333333"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        currentSort = modelData
                        // Mock sort functionality
                        console.log("Sort by:", modelData)
                    }
                }
            }

            Item { Layout.fillWidth: true }
        }

        // History List
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 16

                Repeater {
                    model: getFilteredItems()
                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100
                        color: "#111111"
                        radius: 12
                        border.color: "#333333"
                        border.width: 1

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 16

                            // Thumbnail
                            Rectangle {
                                Layout.preferredWidth: 80
                                Layout.preferredHeight: 80
                                color: "#333333"
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.thumbnail
                                    font.pixelSize: 32
                                    color: "#666666"
                                }

                                // Type indicator
                                Rectangle {
                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    anchors.margins: 4
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: {
                                        if (modelData.type === "live") return "#E50914"
                                        if (modelData.type === "movie") return "#3498db"
                                        if (modelData.type === "series") return "#9b59b6"
                                        if (modelData.type === "episode") return "#27ae60"
                                        return "#666666"
                                    }

                                    Text {
                                        anchors.centerIn: parent
                                        text: {
                                            if (modelData.type === "live") return "📡"
                                            if (modelData.type === "movie") return "🎬"
                                            if (modelData.type === "series") return "📺"
                                            if (modelData.type === "episode") return "🎭"
                                            return "?"
                                        }
                                        font.pixelSize: 10
                                        color: "#FFFFFF"
                                    }
                                }
                            }

                            // Content
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: modelData.title
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: modelData.subtitle
                                    font.pixelSize: 14
                                    color: "#B3B3B3"
                                    Layout.fillWidth: true
                                }

                                // Progress bar (for partially watched)
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 4
                                    color: "#333333"
                                    radius: 2
                                    visible: modelData.progress < 1.0

                                    Rectangle {
                                        width: parent.width * modelData.progress
                                        height: parent.height
                                        color: "#E50914"
                                        radius: 2
                                    }
                                }
                            }

                            // Remove button
                            Button {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                background: Rectangle {
                                    color: parent.hovered ? "#E50914" : "#333333"
                                    radius: 16
                                }
                                contentItem: Text {
                                    text: "×"
                                    font.pixelSize: 18
                                    color: "#FFFFFF"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: removeFromHistory(modelData.id)
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                // Navigate to appropriate page based on type
                                if (modelData.type === "live") {
                                    navigateTo("/player")
                                } else if (modelData.type === "movie") {
                                    navigateTo("/movie/" + modelData.id)
                                } else if (modelData.type === "series") {
                                    navigateTo("/series/details")
                                } else if (modelData.type === "episode") {
                                    navigateTo("/player")
                                }
                            }
                        }

                        scale: parent.hovered ? 1.02 : 1.0
                        Behavior on scale {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                        }
                    }
                }
            }
        }

        // Empty State
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
            visible: getFilteredItems().length === 0

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "📺"
                    font.pixelSize: 64
                    color: "#666666"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "You haven't watched anything yet"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "Start watching content to see your history here"
                    font.pixelSize: 16
                    color: "#B3B3B3"
                    Layout.alignment: Qt.AlignHCenter
                }

                Button {
                    text: "Browse Content"
                    Layout.alignment: Qt.AlignHCenter
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/home")
                }
            }
        }
    }
}
