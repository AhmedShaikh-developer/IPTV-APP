import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: searchResultsScreen
    color: "#000000"

    property string searchQuery: ""
    property int currentTab: 0
    property var tabs: ["All", "Movies", "Series", "Channels"]

    // Mock search results data
    property var allResults: [
        { type: "movie", title: "The Dark Knight", year: "2008", poster: "🎬" },
        { type: "series", title: "Breaking Bad", year: "2008-2013", poster: "📺" },
        { type: "channel", title: "BBC News HD", category: "News", poster: "📰" },
        { type: "movie", title: "Inception", year: "2010", poster: "🎬" },
        { type: "series", title: "Game of Thrones", year: "2011-2019", poster: "📺" },
        { type: "channel", title: "ESPN Sports", category: "Sports", poster: "⚽" },
        { type: "movie", title: "Interstellar", year: "2014", poster: "🎬" },
        { type: "series", title: "Stranger Things", year: "2016-2022", poster: "📺" }
    ]

    property var filteredResults: {
        var query = searchQuery.toLowerCase()
        var filtered = allResults.filter(function(item) {
            return item.title.toLowerCase().includes(query)
        })
        
        if (currentTab === 0) return filtered // All
        if (currentTab === 1) return filtered.filter(function(item) { return item.type === "movie" })
        if (currentTab === 2) return filtered.filter(function(item) { return item.type === "series" })
        if (currentTab === 3) return filtered.filter(function(item) { return item.type === "channel" })
        return filtered
    }

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function navigateToDetail(item) {
        if (item.type === "movie") {
            navigateTo("/movie/" + encodeURIComponent(item.title))
        } else if (item.type === "series") {
            navigateTo("/series/details")
        } else if (item.type === "channel") {
            navigateTo("/player")
        }
    }

    Component.onCompleted: {
        // Parse query from route if available
        // This would normally come from route parameters
        searchQuery = "The Dark Knight" // Mock query for demo
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
                onClicked: navigateTo("/search")
            }

            Text {
                text: "Search Results"
                font.pixelSize: 32
                font.bold: true
                color: "#FFFFFF"
            }

            Item { Layout.fillWidth: true }

            // Results count
            Text {
                text: filteredResults.length + " results"
                font.pixelSize: 16
                color: "#B3B3B3"
            }
        }

        // Search Query Chip
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            color: "#111111"
            radius: 20
            border.color: "#333333"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8

                Text {
                    text: "🔍"
                    font.pixelSize: 16
                    color: "#B3B3B3"
                }

                Text {
                    text: '"' + searchQuery + '"'
                    font.pixelSize: 16
                    color: "#FFFFFF"
                    Layout.fillWidth: true
                }

                Button {
                    width: 24
                    height: 24
                    background: Rectangle {
                        color: parent.hovered ? "#2A2A2A" : "transparent"
                        radius: 12
                    }
                    contentItem: Text {
                        text: "×"
                        font.pixelSize: 16
                        color: "#B3B3B3"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/search")
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
                        
                        // Underline for active tab
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: 3
                            color: "#E50914"
                            visible: index === currentTab
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

        // Sort/Filter Pills
        ScrollView {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            clip: true
            ScrollBar.horizontal: ScrollBar { policy: ScrollBar.AlwaysOff }

            RowLayout {
                spacing: 12
                Repeater {
                    model: ["Recent", "A–Z", "Popular"]
                    delegate: Button {
                        text: modelData
                        Layout.preferredHeight: 32
                        padding: 0
                        background: Rectangle {
                            color: parent.hovered ? "#2A2A2A" : "#111111"
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
                            // Mock sort functionality
                            console.log("Sort by:", modelData)
                        }
                    }
                }
            }
        }

        // Results Grid
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.floor(parent.width / 200))
                columnSpacing: 20
                rowSpacing: 20

                Repeater {
                    model: filteredResults

                    delegate: Button {
                        Layout.preferredWidth: 180
                        Layout.preferredHeight: 280
                        padding: 0
                        background: Rectangle {
                            color: parent.hovered ? "#1A1A1A" : "transparent"
                            radius: 12
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 12

                            // Poster
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 240
                                color: "#333333"
                                radius: 8
                                border.color: parent.parent.parent.hovered ? "#E50914" : "transparent"
                                border.width: 2

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.poster
                                    font.pixelSize: 48
                                    color: "#666666"
                                }

                                // Type indicator
                                Rectangle {
                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    anchors.margins: 8
                                    width: 24
                                    height: 24
                                    radius: 12
                                    color: modelData.type === "movie" ? "#E50914" : 
                                           modelData.type === "series" ? "#3498db" : "#27ae60"

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.type === "movie" ? "🎬" : 
                                              modelData.type === "series" ? "📺" : "📡"
                                        font.pixelSize: 12
                                        color: "#FFFFFF"
                                    }
                                }
                            }

                            // Title and Info
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 4

                                Text {
                                    text: modelData.title
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "#FFFFFF"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: modelData.year || modelData.category || ""
                                    font.pixelSize: 14
                                    color: "#B3B3B3"
                                    Layout.fillWidth: true
                                }
                            }
                        }

                        onClicked: {
                            navigateToDetail(modelData)
                        }

                        // Hover animations
                        scale: parent.hovered ? 1.08 : 1.0
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
            visible: filteredResults.length === 0

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "🔍"
                    font.pixelSize: 64
                    color: "#666666"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "No results found"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: 'No results found for "' + searchQuery + '"'
                    font.pixelSize: 16
                    color: "#B3B3B3"
                    Layout.alignment: Qt.AlignHCenter
                }

                Button {
                    text: "Try a different search"
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
                    onClicked: navigateTo("/search")
                }
            }
        }
    }
}
