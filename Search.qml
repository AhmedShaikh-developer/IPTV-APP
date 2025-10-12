import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: searchScreen
    color: "#000000"

    // Mock data
    property var recentSearches: ["The Dark Knight", "Breaking Bad", "Inception", "Game of Thrones"]
    property var suggestions: ["Action Movies", "Comedy Series", "Sports Channels", "News", "Kids Content"]
    property var categories: ["All", "Movies", "Series", "Live TV"]

    property bool showSuggestions: searchField.text.length > 0

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 30

        // Search Header
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
                text: "Search"
                font.pixelSize: 32
                font.bold: true
                color: "#FFFFFF"
            }

            Item { Layout.fillWidth: true }

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
                    text: "🎤"
                    font.pixelSize: 20
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/search/voice")
            }
        }

        // Search Input
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            radius: 12
            color: "#111111"
            border.color: searchField.activeFocus ? "#E50914" : "#333333"
            border.width: 2

            Rectangle {
                anchors.fill: parent
                anchors.margins: 2
                radius: parent.radius - 2
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#1A1A1A" }
                    GradientStop { position: 1.0; color: "#111111" }
                }
            }

            TextField {
                id: searchField
                anchors.fill: parent
                anchors.margins: 16
                placeholderText: "Search for movies, series, or channels..."
                placeholderTextColor: "#888888"
                color: "#FFFFFF"
                font.pixelSize: 18
                background: Rectangle {
                    color: "transparent"
                }

                onAccepted: {
                    if (text.trim() !== "") {
                        navigateTo("/search/results?q=" + encodeURIComponent(text.trim()))
                    }
                }

                Keys.onReturnPressed: {
                    if (text.trim() !== "") {
                        navigateTo("/search/results?q=" + encodeURIComponent(text.trim()))
                    }
                }
            }
        }

        // Categories Row
        ScrollView {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            clip: true
            ScrollBar.horizontal: ScrollBar { policy: ScrollBar.AlwaysOff }

            RowLayout {
                spacing: 16
                Repeater {
                    model: categories
                    delegate: Button {
                        text: modelData
                        Layout.preferredHeight: 40
                        padding: 0
                        background: Rectangle {
                            color: parent.hovered ? "#2A2A2A" : "transparent"
                            radius: 20
                            border.color: "#444444"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            searchField.text = modelData
                            navigateTo("/search/results?q=" + encodeURIComponent(modelData))
                        }
                    }
                }
            }
        }

        // Content Area
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 30

                // Search Suggestions (when typing)
                ColumnLayout {
                    Layout.fillWidth: true
                    visible: showSuggestions && searchField.text.length > 0
                    spacing: 16

                    Text {
                        text: "Suggestions"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#FFFFFF"
                    }

                    Repeater {
                        model: suggestions.filter(function(item) {
                            return item.toLowerCase().includes(searchField.text.toLowerCase())
                        })
                        delegate: Button {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            background: Rectangle {
                                color: parent.hovered ? "#2A2A2A" : "transparent"
                                radius: 8
                            }
                            contentItem: RowLayout {
                                spacing: 12
                                Text {
                                    text: "🔍"
                                    font.pixelSize: 16
                                }
                                Text {
                                    text: modelData
                                    color: "#FFFFFF"
                                    font.pixelSize: 16
                                    Layout.fillWidth: true
                                }
                            }
                            onClicked: {
                                searchField.text = modelData
                                navigateTo("/search/results?q=" + encodeURIComponent(modelData))
                            }
                        }
                    }
                }

                // Recent Searches
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Recent Searches"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        Item { Layout.fillWidth: true }
                        Button {
                            text: "Clear"
                            Layout.preferredHeight: 32
                            padding: 0
                            background: Rectangle {
                                color: parent.hovered ? "#2A2A2A" : "transparent"
                                radius: 4
                                border.color: "#444444"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#888888"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                recentSearches = []
                            }
                        }
                    }

                    Repeater {
                        model: recentSearches
                        delegate: Button {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            background: Rectangle {
                                color: parent.hovered ? "#2A2A2A" : "transparent"
                                radius: 8
                            }
                            contentItem: RowLayout {
                                spacing: 12
                                Text {
                                    text: "🕒"
                                    font.pixelSize: 16
                                }
                                Text {
                                    text: modelData
                                    color: "#FFFFFF"
                                    font.pixelSize: 16
                                    Layout.fillWidth: true
                                }
                            }
                            onClicked: {
                                searchField.text = modelData
                                navigateTo("/search/results?q=" + encodeURIComponent(modelData))
                            }
                        }
                    }
                }

                // Popular Categories
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    Text {
                        text: "Popular Categories"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#FFFFFF"
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        columns: 2
                        columnSpacing: 16
                        rowSpacing: 16

                        Repeater {
                            model: ["Action", "Comedy", "Drama", "Thriller", "Sci-Fi", "Horror"]
                            delegate: Button {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                background: Rectangle {
                                    color: parent.hovered ? "#2A2A2A" : "#111111"
                                    radius: 12
                                    border.color: "#333333"
                                    border.width: 1
                                }
                                contentItem: Text {
                                    text: modelData
                                    color: "#FFFFFF"
                                    font.pixelSize: 16
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    searchField.text = modelData
                                    navigateTo("/search/results?q=" + encodeURIComponent(modelData))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
