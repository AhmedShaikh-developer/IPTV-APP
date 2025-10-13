import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: favoritesScreen
    color: "#000000"

    property int currentTab: 0
    property var tabs: ["Channels", "Movies", "Series", "Episodes"]
    property string currentSort: "Recently Added"

    // Mock favorites data
    property var favoriteChannels: [
        { id: "1", name: "BBC News HD", logo: "📰", category: "News" },
        { id: "2", name: "ESPN Sports", logo: "⚽", category: "Sports" },
        { id: "3", name: "Discovery", logo: "🌍", category: "Documentary" },
        { id: "4", name: "HBO", logo: "🎬", category: "Entertainment" },
        { id: "5", name: "CNN", logo: "📺", category: "News" }
    ]

    property var favoriteMovies: [
        { id: "1", title: "The Dark Knight", year: "2008", poster: "🎬", rating: "9.0" },
        { id: "2", title: "Inception", year: "2010", poster: "🎭", rating: "8.8" },
        { id: "3", title: "Interstellar", year: "2014", poster: "🚀", rating: "8.6" },
        { id: "4", title: "Pulp Fiction", year: "1994", poster: "💀", rating: "8.9" }
    ]

    property var favoriteSeries: [
        { id: "1", title: "Breaking Bad", year: "2008-2013", poster: "🧪", rating: "9.5" },
        { id: "2", title: "Game of Thrones", year: "2011-2019", poster: "👑", rating: "9.3" },
        { id: "3", title: "Stranger Things", year: "2016-2022", poster: "👻", rating: "8.7" }
    ]

    property var favoriteEpisodes: [
        { id: "1", title: "Breaking Bad S05E14", series: "Breaking Bad", poster: "🧪", progress: 0.8 },
        { id: "2", title: "Game of Thrones S08E06", series: "Game of Thrones", poster: "👑", progress: 1.0 },
        { id: "3", title: "Stranger Things S04E09", series: "Stranger Things", poster: "👻", progress: 0.3 }
    ]

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function removeFavorite(type, id) {
        if (type === "channel") {
            favoriteChannels = favoriteChannels.filter(item => item.id !== id)
        } else if (type === "movie") {
            favoriteMovies = favoriteMovies.filter(item => item.id !== id)
        } else if (type === "series") {
            favoriteSeries = favoriteSeries.filter(item => item.id !== id)
        } else if (type === "episode") {
            favoriteEpisodes = favoriteEpisodes.filter(item => item.id !== id)
        }
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
                text: "My Favorites"
                font.pixelSize: 32
                font.bold: true
                color: "#FFFFFF"
            }

            Item { Layout.fillWidth: true }

            // Sort & Filter
            Button {
                text: "Sort & Filter"
                Layout.preferredHeight: 40
                padding: 0
                background: Rectangle {
                    color: parent.hovered ? "#2A2A2A" : "transparent"
                    radius: 6
                    border.color: "#444444"
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
                    // Mock sort/filter functionality
                    console.log("Sort & Filter clicked")
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

        // Content Area
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            StackLayout {
                width: parent.width
                currentIndex: currentTab

                // Channels Tab
                GridLayout {
                    columns: Math.max(1, Math.floor(parent.width / 300))
                    columnSpacing: 20
                    rowSpacing: 20

                    Repeater {
                        model: favoriteChannels
                        delegate: Rectangle {
                            Layout.preferredWidth: 280
                            Layout.preferredHeight: 120
                            color: "#111111"
                            radius: 12
                            border.color: parent.hovered ? "#E50914" : "transparent"
                            border.width: 2

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 16

                                Rectangle {
                                    Layout.preferredWidth: 60
                                    Layout.preferredHeight: 60
                                    color: "#333333"
                                    radius: 8
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.logo
                                        font.pixelSize: 24
                                        color: "#FFFFFF"
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4

                                    Text {
                                        text: modelData.name
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#FFFFFF"
                                        Layout.fillWidth: true
                                    }

                                    Text {
                                        text: modelData.category
                                        font.pixelSize: 14
                                        color: "#B3B3B3"
                                        Layout.fillWidth: true
                                    }
                                }

                                Button {
                                    Layout.preferredWidth: 32
                                    Layout.preferredHeight: 32
                                    background: Rectangle {
                                        color: parent.hovered ? "#E50914" : "#333333"
                                        radius: 16
                                    }
                                    contentItem: Text {
                                        text: "❤️"
                                        font.pixelSize: 16
                                        color: "#FFFFFF"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: removeFavorite("channel", modelData.id)
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: navigateTo("/player")
                            }

                            scale: parent.hovered ? 1.02 : 1.0
                            Behavior on scale {
                                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                            }
                        }
                    }
                }

                // Movies Tab
                GridLayout {
                    columns: Math.max(1, Math.floor(parent.width / 200))
                    columnSpacing: 20
                    rowSpacing: 20

                    Repeater {
                        model: favoriteMovies
                        delegate: Button {
                            Layout.preferredWidth: 160
                            Layout.preferredHeight: 240
                            padding: 0
                            background: Rectangle {
                                color: parent.hovered ? "#1A1A1A" : "transparent"
                                radius: 12
                            }

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 8

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 200
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

                                    // Heart button
                                    Button {
                                        anchors.top: parent.top
                                        anchors.right: parent.right
                                        anchors.margins: 8
                                        width: 32
                                        height: 32
                                        background: Rectangle {
                                            color: parent.hovered ? "#E50914" : "#333333"
                                            radius: 16
                                        }
                                        contentItem: Text {
                                            text: "❤️"
                                            font.pixelSize: 16
                                            color: "#FFFFFF"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: removeFavorite("movie", modelData.id)
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2

                                    Text {
                                        text: modelData.title
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: "#FFFFFF"
                                        wrapMode: Text.WordWrap
                                        Layout.fillWidth: true
                                    }

                                    Text {
                                        text: modelData.year + " • " + modelData.rating
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                        Layout.fillWidth: true
                                    }
                                }
                            }

                            onClicked: navigateTo("/movie/" + modelData.id)

                            scale: parent.hovered ? 1.08 : 1.0
                            Behavior on scale {
                                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                            }
                        }
                    }
                }

                // Series Tab
                GridLayout {
                    columns: Math.max(1, Math.floor(parent.width / 200))
                    columnSpacing: 20
                    rowSpacing: 20

                    Repeater {
                        model: favoriteSeries
                        delegate: Button {
                            Layout.preferredWidth: 160
                            Layout.preferredHeight: 240
                            padding: 0
                            background: Rectangle {
                                color: parent.hovered ? "#1A1A1A" : "transparent"
                                radius: 12
                            }

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 8

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 200
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

                                    Button {
                                        anchors.top: parent.top
                                        anchors.right: parent.right
                                        anchors.margins: 8
                                        width: 32
                                        height: 32
                                        background: Rectangle {
                                            color: parent.hovered ? "#E50914" : "#333333"
                                            radius: 16
                                        }
                                        contentItem: Text {
                                            text: "❤️"
                                            font.pixelSize: 16
                                            color: "#FFFFFF"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: removeFavorite("series", modelData.id)
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2

                                    Text {
                                        text: modelData.title
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: "#FFFFFF"
                                        wrapMode: Text.WordWrap
                                        Layout.fillWidth: true
                                    }

                                    Text {
                                        text: modelData.year + " • " + modelData.rating
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                        Layout.fillWidth: true
                                    }
                                }
                            }

                            onClicked: navigateTo("/series/details")

                            scale: parent.hovered ? 1.08 : 1.0
                            Behavior on scale {
                                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                            }
                        }
                    }
                }

                // Episodes Tab
                ColumnLayout {
                    spacing: 16

                    Repeater {
                        model: favoriteEpisodes
                        delegate: Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 120
                            color: "#111111"
                            radius: 12
                            border.color: parent.hovered ? "#E50914" : "transparent"
                            border.width: 2

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 16

                                Rectangle {
                                    Layout.preferredWidth: 80
                                    Layout.preferredHeight: 80
                                    color: "#333333"
                                    radius: 8
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.poster
                                        font.pixelSize: 32
                                        color: "#666666"
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 8

                                    Text {
                                        text: modelData.title
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#FFFFFF"
                                        Layout.fillWidth: true
                                    }

                                    Text {
                                        text: modelData.series
                                        font.pixelSize: 14
                                        color: "#B3B3B3"
                                        Layout.fillWidth: true
                                    }

                                    // Progress bar
                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 4
                                        color: "#333333"
                                        radius: 2

                                        Rectangle {
                                            width: parent.width * modelData.progress
                                            height: parent.height
                                            color: "#E50914"
                                            radius: 2
                                        }
                                    }
                                }

                                Button {
                                    Layout.preferredWidth: 32
                                    Layout.preferredHeight: 32
                                    background: Rectangle {
                                        color: parent.hovered ? "#E50914" : "#333333"
                                        radius: 16
                                    }
                                    contentItem: Text {
                                        text: "❤️"
                                        font.pixelSize: 16
                                        color: "#FFFFFF"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: removeFavorite("episode", modelData.id)
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: navigateTo("/player")
                            }

                            scale: parent.hovered ? 1.02 : 1.0
                            Behavior on scale {
                                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                            }
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
            visible: {
                if (currentTab === 0) return favoriteChannels.length === 0
                if (currentTab === 1) return favoriteMovies.length === 0
                if (currentTab === 2) return favoriteSeries.length === 0
                if (currentTab === 3) return favoriteEpisodes.length === 0
                return false
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "❤️"
                    font.pixelSize: 64
                    color: "#666666"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "No favorites yet"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "Start adding your favorite content to see it here"
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
