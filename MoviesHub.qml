import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: moviesHub
    color: "#000000"

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 40

            Item { Layout.preferredHeight: 32 }

            // Header with Sort/Filter
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                spacing: 20

                // Back Button
                Button {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    background: Rectangle {
                        color: parent.hovered ? "#2A2A2A" : "transparent"
                        radius: 22
                        border.color: "#444444"
                        border.width: 1
                        Behavior on color { ColorAnimation { duration: 200 } }
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
                    text: "🎬 Movies"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }

                // Sort/Filter Drawer
                Row {
                    spacing: 12
                    
                    Button {
                        text: "Sort ▼"
                        background: Rectangle {
                            color: parent.hovered ? "#E50914" : "#333333"
                            radius: 20
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Sort drawer")
                    }

                    Button {
                        text: "Filter ▼"
                        background: Rectangle {
                            color: parent.hovered ? "#E50914" : "#333333"
                            radius: 20
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Filter drawer")
                    }
                }
            }

            // Featured Hero Row
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: 400
                radius: 12
                color: "#111111"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Rectangle {
                        Layout.preferredWidth: 200
                        Layout.fillHeight: true
                        radius: 8
                        color: "#333333"

                        Text {
                            anchors.centerIn: parent
                            text: "🎬"
                            font.pixelSize: 80
                            color: "#666666"
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        Text {
                            text: "Featured Movie"
                            font.pixelSize: 28
                            font.bold: true
                            color: "#FFFFFF"
                        }

                        Text {
                            Layout.fillWidth: true
                            text: "An epic adventure that takes you on a journey through time and space. Join our heroes as they battle against impossible odds."
                            font.pixelSize: 16
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.4
                        }

                        RowLayout {
                            spacing: 12
                            Text {
                                text: "2024"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                            Text {
                                text: "•"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                            Text {
                                text: "Action, Adventure"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                            Text {
                                text: "•"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                            Text {
                                text: "2h 15m"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                        }

                        RowLayout {
                            spacing: 16

                            Button {
                                text: "▶ Play"
                                Layout.preferredWidth: 120
                                Layout.preferredHeight: 44
                                background: Rectangle {
                                    color: "#E50914"
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
                                onClicked: console.log("Play featured movie")
                            }

                            Button {
                                text: "❤ Add to List"
                                Layout.preferredWidth: 140
                                Layout.preferredHeight: 44
                                background: Rectangle {
                                    color: "transparent"
                                    border.color: "#666666"
                                    border.width: 2
                                    radius: 6
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "#FFFFFF"
                                    font.pixelSize: 16
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    console.log("Add to watchlist")
                                    
                                    // Add to favorites JSON
                                    var favorites = parent.parent.parent.parent.readJson("favoritesJson", {"channels":[],"movies":[],"series":[]})
                                    var movieId = "featured_movie" // Using placeholder ID
                                    
                                    if (!favorites.movies.includes(movieId)) {
                                        favorites.movies.push(movieId)
                                        parent.parent.parent.parent.writeJson("favoritesJson", favorites)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Trending Now Section
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: childrenRect.height
                color: "transparent"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {
                            text: "🔥 Trending Now"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 4
                            color: "#E50914"
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 300
                        clip: true

                        Row {
                            spacing: 20
                            Repeater {
                                model: 8
                                delegate: Rectangle {
                                    width: 180
                                    height: 270
                                    radius: 12
                                    color: "#111111"
                                    border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                                    border.width: 2
                                    scale: parent.hovered || parent.activeFocus ? 1.08 : 1.0

                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    Behavior on border.color {
                                        ColorAnimation { duration: 200 }
                                    }

                                    Column {
                                        width: parent.width
                                        height: parent.height

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.8
                                            color: "#333333"
                                            radius: 12

                                            Text {
                                                anchors.centerIn: parent
                                                text: "🎬"
                                                font.pixelSize: 48
                                                color: "#666666"
                                            }
                                        }

                                        Text {
                                            width: parent.width
                                            height: parent.height * 0.2
                                            text: "Trending " + (index + 1)
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#FFFFFF"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            anchors.margins: 8
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: console.log("Navigate to movie details")
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // New Releases Section
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: childrenRect.height
                color: "transparent"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {
                            text: "🆕 New Releases"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 4
                            color: "#E50914"
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 300
                        clip: true

                        Row {
                            spacing: 20
                            Repeater {
                                model: 6
                                delegate: Rectangle {
                                    width: 180
                                    height: 270
                                    radius: 12
                                    color: "#111111"
                                    border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                                    border.width: 2
                                    scale: parent.hovered || parent.activeFocus ? 1.08 : 1.0

                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    Behavior on border.color {
                                        ColorAnimation { duration: 200 }
                                    }

                                    Column {
                                        width: parent.width
                                        height: parent.height

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.8
                                            color: "#333333"
                                            radius: 12

                                            Text {
                                                anchors.centerIn: parent
                                                text: "🎬"
                                                font.pixelSize: 48
                                                color: "#666666"
                                            }
                                        }

                                        Text {
                                            width: parent.width
                                            height: parent.height * 0.2
                                            text: "New " + (index + 1)
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#FFFFFF"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            anchors.margins: 8
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: console.log("Navigate to movie details")
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Genres Section
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: childrenRect.height
                color: "transparent"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {
                            text: "🎭 Genres"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 4
                            color: "#E50914"
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 200
                        clip: true

                        Row {
                            spacing: 20
                            Repeater {
                                model: ["Action", "Comedy", "Drama", "Horror", "Sci-Fi", "Romance"]
                                delegate: Rectangle {
                                    width: 160
                                    height: 120
                                    radius: 12
                                    color: "#111111"
                                    border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                                    border.width: 2
                                    scale: parent.hovered || parent.activeFocus ? 1.08 : 1.0

                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    Behavior on border.color {
                                        ColorAnimation { duration: 200 }
                                    }

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData
                                        font.pixelSize: 18
                                        font.bold: true
                                        color: "#FFFFFF"
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: console.log("Navigate to genre grid: " + modelData)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item { Layout.preferredHeight: 32 }
        }
    }
}
