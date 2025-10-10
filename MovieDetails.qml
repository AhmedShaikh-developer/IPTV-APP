import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: movieDetails
    color: "#000000"

    property string movieId: ""
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

                    // Movie poster
                    Rectangle {
                        Layout.preferredWidth: 300
                        Layout.fillHeight: true
                        radius: 12
                        color: "#111111"

                        Text {
                            anchors.centerIn: parent
                            text: "🎬"
                            font.pixelSize: 120
                            color: "#666666"
                        }
                    }

                    // Movie info
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 20

                        // Title and rating
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            Text {
                                text: "Epic Movie Title"
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
                                    text: "8.5"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "#FFFFFF"
                                }
                            }
                        }

                        // Synopsis
                        Text {
                            Layout.fillWidth: true
                            text: "An epic adventure that takes you on a journey through time and space. Join our heroes as they battle against impossible odds to save the universe from destruction. This thrilling masterpiece combines stunning visuals with a compelling storyline that will keep you on the edge of your seat."
                            font.pixelSize: 16
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.4
                        }

                        // Movie details
                        Row {
                            spacing: 20
                            
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
                                text: "⬇ Download"
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
                                onClicked: console.log("Open download sheet")
                            }

                            Button {
                                text: "❤ Add to List"
                                Layout.preferredWidth: 140
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

                        // Audio/Subtitles selectors
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            ComboBox {
                                Layout.preferredWidth: 120
                                model: ["English", "Spanish", "French", "German"]
                                background: Rectangle {
                                    color: "#222222"
                                    border.color: "#666666"
                                    border.width: 1
                                    radius: 6
                                }
                                contentItem: Text {
                                    text: parent.displayText
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                }
                                popup: Popup {
                                    y: parent.height
                                    width: parent.width
                                    height: 200
                                    background: Rectangle {
                                        color: "#1a1a1a"
                                        border.color: "#666666"
                                        border.width: 1
                                        radius: 6
                                    }
                                }
                                delegate: ItemDelegate {
                                    width: parent.width
                                    background: Rectangle {
                                        color: parent.hovered ? "#333333" : "transparent"
                                    }
                                    contentItem: Text {
                                        text: modelData
                                        color: "#FFFFFF"
                                        font.pixelSize: 14
                                        leftPadding: 12
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                            }

                            ComboBox {
                                Layout.preferredWidth: 120
                                model: ["None", "English", "Spanish", "French", "German"]
                                background: Rectangle {
                                    color: "#222222"
                                    border.color: "#666666"
                                    border.width: 1
                                    radius: 6
                                }
                                contentItem: Text {
                                    text: parent.displayText
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                }
                                popup: Popup {
                                    y: parent.height
                                    width: parent.width
                                    height: 200
                                    background: Rectangle {
                                        color: "#1a1a1a"
                                        border.color: "#666666"
                                        border.width: 1
                                        radius: 6
                                    }
                                }
                                delegate: ItemDelegate {
                                    width: parent.width
                                    background: Rectangle {
                                        color: parent.hovered ? "#333333" : "transparent"
                                    }
                                    contentItem: Text {
                                        text: modelData
                                        color: "#FFFFFF"
                                        font.pixelSize: 14
                                        leftPadding: 12
                                        verticalAlignment: Text.AlignVCenter
                                    }
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
                        text: "Cast"
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
                        onClicked: console.log("Tab: Cast")
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

                // Related titles carousel
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
                                model: 8
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
                                                text: "🎬"
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
                                        onClicked: console.log("Navigate to related movie")
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
