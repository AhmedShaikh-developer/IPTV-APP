import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: seriesDetails
    color: "#000000"

    property string seriesId: ""
    property url heroImage: ""
    property color dominantColor: "#1a1a1a"

    // Background gradient from hero image
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: dominantColor }
            GradientStop { position: 1.0; color: "#000000" }
        }
        opacity: 0.8
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 0

            // Hero Banner (50-60% of viewport)
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: Math.max(600, parent.parent.height * 0.6)
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 40
                    spacing: 40

                    // Series poster
                    Rectangle {
                        Layout.preferredWidth: 300
                        Layout.fillHeight: true
                        radius: 12
                        color: "#111111"

                        Text {
                            anchors.centerIn: parent
                            text: "📺"
                            font.pixelSize: 120
                            color: "#666666"
                        }
                    }

                    // Series info
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 20

                        // Title and rating
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            Text {
                                text: "Epic Series Title"
                                font.pixelSize: 36
                                font.bold: true
                                color: "#FFFFFF"
                                wrapMode: Text.WordWrap
                            }

                            Item { Layout.fillWidth: true }

                            Rectangle {
                                width: 60
                                height: 60
                                radius: 30
                                color: "#E50914"

                                Text {
                                    anchors.centerIn: parent
                                    text: "9.2"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "#FFFFFF"
                                }
                            }
                        }

                        // Synopsis
                        Text {
                            Layout.fillWidth: true
                            text: "An epic series that takes you on a journey through time and space. Follow our heroes across multiple seasons as they battle against impossible odds to save the universe from destruction. This thrilling masterpiece combines stunning visuals with compelling storylines that will keep you coming back for more."
                            font.pixelSize: 16
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.4
                        }

                        // Series details
                        Row {
                            spacing: 20
                            
                            Text {
                                text: "2020-2024"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                            
                            Text {
                                text: "•"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                            
                            Text {
                                text: "Drama, Action"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                            
                            Text {
                                text: "•"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                            
                            Text {
                                text: "4 Seasons"
                                font.pixelSize: 14
                                color: "#9A9A9A"
                            }
                        }

                        // Action buttons
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Button {
                                text: "▶ Play"
                                Layout.preferredWidth: 120
                                Layout.preferredHeight: 50
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
                                onClicked: console.log("Navigate to player")
                            }

                            Button {
                                text: "⏸ Resume"
                                Layout.preferredWidth: 120
                                Layout.preferredHeight: 50
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
                                onClicked: console.log("Navigate to player")
                            }

                            Button {
                                text: "❤ Add to Watchlist"
                                Layout.preferredWidth: 160
                                Layout.preferredHeight: 50
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
                                onClicked: console.log("Toggle watchlist")
                            }

                            Item { Layout.fillWidth: true }
                        }
                    }
                }
            }

            // Continue Season Card (if progress exists)
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                Layout.leftMargin: 40
                Layout.rightMargin: 40
                Layout.bottomMargin: 20
                color: "#111111"
                radius: 12
                border.color: "#E50914"
                border.width: 2

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Rectangle {
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 60
                        color: "#333333"
                        radius: 8

                        Text {
                            anchors.centerIn: parent
                            text: "📺"
                            font.pixelSize: 32
                            color: "#666666"
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 4

                        Text {
                            text: "Continue Season 2"
                            font.pixelSize: 18
                            font.bold: true
                            color: "#FFFFFF"
                        }

                        Text {
                            text: "Episode 5: The Battle Begins"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 6
                            color: "#333333"
                            radius: 3
                            Rectangle {
                                width: parent.width * 0.65
                                height: parent.height
                                color: "#E50914"
                                radius: 3
                            }
                        }
                    }

                    Button {
                        text: "▶ Continue"
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 40
                        background: Rectangle {
                            color: "#E50914"
                            radius: 6
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Continue watching")
                    }
                }
            }

            // Seasons Tabs (sticky on scroll)
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "#111111"
                border.color: "#333333"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Text {
                        text: "Seasons:"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#FFFFFF"
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        clip: true

                        Row {
                            spacing: 12
                            Repeater {
                                model: 4
                                delegate: Button {
                                    text: "Season " + (index + 1)
                                    width: 120
                                    height: 40
                                    background: Rectangle {
                                        color: parent.checked ? "#E50914" : "#333333"
                                        radius: 20
                                        border.color: parent.checked ? "#E50914" : "transparent"
                                        border.width: 2
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 14
                                        font.bold: parent.checked
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    checked: index === 1 // Season 2 selected by default
                                    onClicked: console.log("Navigate to season " + (index + 1))
                                }
                            }
                        }
                    }
                }
            }

            // Tabs section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 40
                    spacing: 40

                    TabButton {
                        text: "Overview"
                        background: Rectangle {
                            color: parent.checked ? "#E50914" : "transparent"
                            radius: 6
                        }
                        contentItem: Text {
                            text: parent.text
                            color: parent.checked ? "#FFFFFF" : "#B3B3B3"
                            font.pixelSize: 16
                            font.bold: parent.checked
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        checked: true
                        onClicked: console.log("Tab: Overview")
                    }

                    TabButton {
                        text: "Seasons"
                        background: Rectangle {
                            color: parent.checked ? "#E50914" : "transparent"
                            radius: 6
                        }
                        contentItem: Text {
                            text: parent.text
                            color: parent.checked ? "#FFFFFF" : "#B3B3B3"
                            font.pixelSize: 16
                            font.bold: parent.checked
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Tab: Seasons")
                    }

                    TabButton {
                        text: "Related"
                        background: Rectangle {
                            color: parent.checked ? "#E50914" : "transparent"
                            radius: 6
                        }
                        contentItem: Text {
                            text: parent.text
                            color: parent.checked ? "#FFFFFF" : "#B3B3B3"
                            font.pixelSize: 16
                            font.bold: parent.checked
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Tab: Related")
                    }

                    Item { Layout.fillWidth: true }
                }
            }

            // Content area
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 400
                color: "transparent"
                anchors.margins: 40

                // Related series carousel
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 20

                    Text {
                        text: "More Like This"
                        font.pixelSize: 24
                        font.bold: true
                        color: "#FFFFFF"
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true

                        Row {
                            spacing: 20
                            Repeater {
                                model: 6
                                delegate: Rectangle {
                                    width: 160
                                    height: 240
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
                                        anchors.fill: parent

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.8
                                            color: "#333333"
                                            radius: 12

                                            Text {
                                                anchors.centerIn: parent
                                                text: "📺"
                                                font.pixelSize: 48
                                                color: "#666666"
                                            }
                                        }

                                        Text {
                                            width: parent.width
                                            height: parent.height * 0.2
                                            text: "Related " + (index + 1)
                                            font.pixelSize: 12
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
                                        onClicked: console.log("Navigate to related series")
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
