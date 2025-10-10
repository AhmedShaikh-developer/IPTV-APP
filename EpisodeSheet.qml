import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: episodeSheet
    color: "transparent"
    visible: false

    property string episodeId: ""
    property string episodeTitle: ""
    property string episodeDescription: ""
    property int episodeNumber: 1
    property int seasonNumber: 1
    property bool hasProgress: false
    property real progress: 0.0
    property bool hasNextEpisode: true

    // Glass backdrop
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.8

        MouseArea {
            anchors.fill: parent
            onClicked: episodeSheet.hide()
        }
    }

    // Center modal card
    Rectangle {
        anchors.centerIn: parent
        width: Math.min(500, parent.width * 0.9)
        height: Math.min(600, parent.height * 0.8)
        color: "#0D0D0DB3"
        radius: 16
        border.color: "#333333"
        border.width: 1

        // Blur effect simulation (glass appearance)
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            border.color: "#E50914"
            border.width: 1
            opacity: 0.3
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 20

            // Header with close button
            RowLayout {
                Layout.fillWidth: true
                spacing: 16

                Text {
                    text: "Episode " + episodeNumber
                    font.pixelSize: 20
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }

                Button {
                    text: "✕"
                    width: 32
                    height: 32
                    background: Rectangle {
                        color: parent.hovered ? "#333333" : "transparent"
                        radius: 16
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: episodeSheet.hide()
                }
            }

            // Episode thumbnail
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: "#333333"
                radius: 12

                Text {
                    anchors.centerIn: parent
                    text: "📺"
                    font.pixelSize: 64
                    color: "#666666"
                }

                // Episode number badge
                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 12
                    width: 40
                    height: 40
                    radius: 20
                    color: "#E50914"

                    Text {
                        anchors.centerIn: parent
                        text: episodeNumber
                        font.pixelSize: 16
                        font.bold: true
                        color: "#FFFFFF"
                    }
                }
            }

            // Episode title and description
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    Layout.fillWidth: true
                    text: episodeTitle || "Episode " + episodeNumber + " - The Journey Continues"
                    font.pixelSize: 18
                    font.bold: true
                    color: "#FFFFFF"
                    wrapMode: Text.WordWrap
                }

                Text {
                    Layout.fillWidth: true
                    text: episodeDescription || "Our heroes face new challenges as they continue their epic journey. This episode brings unexpected twists and character development."
                    font.pixelSize: 14
                    color: "#B3B3B3"
                    wrapMode: Text.WordWrap
                    lineHeight: 1.4
                }

                Row {
                    spacing: 12
                    
                    Text {
                        text: "S" + seasonNumber + "E" + episodeNumber
                        font.pixelSize: 12
                        color: "#9A9A9A"
                    }
                    
                    Text {
                        text: "•"
                        font.pixelSize: 12
                        color: "#9A9A9A"
                    }
                    
                    Text {
                        text: "45 min"
                        font.pixelSize: 12
                        color: "#9A9A9A"
                    }
                }
            }

            // Action buttons
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 12

                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    text: hasProgress ? "⏸ Resume" : "▶ Play"
                    background: Rectangle {
                        color: "#E50914"
                        radius: 8
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        console.log("Navigate to player")
                        episodeSheet.hide()
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 44
                        text: "⬇ Download"
                        background: Rectangle {
                            color: "transparent"
                            border.color: "#666666"
                            border.width: 2
                            radius: 8
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Download episode")
                    }

                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 44
                        text: "❤ Add to List"
                        background: Rectangle {
                            color: "transparent"
                            border.color: "#666666"
                            border.width: 2
                            radius: 8
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Add to watchlist")
                    }
                }
            }

            // Audio/Subtitles selectors
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 12

                Text {
                    text: "Audio & Subtitles"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#FFFFFF"
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    ComboBox {
                        Layout.fillWidth: true
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
                        Layout.fillWidth: true
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

            // Next Up preview (if available)
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#1a1a1a"
                radius: 8
                border.color: "#333333"
                border.width: 1
                visible: hasNextEpisode

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    Rectangle {
                        Layout.preferredWidth: 56
                        Layout.preferredHeight: 56
                        color: "#333333"
                        radius: 8

                        Text {
                            anchors.centerIn: parent
                            text: "📺"
                            font.pixelSize: 24
                            color: "#666666"
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 2

                        Text {
                            Layout.fillWidth: true
                            text: "Up Next: Episode " + (episodeNumber + 1)
                            font.pixelSize: 14
                            font.bold: true
                            color: "#FFFFFF"
                            wrapMode: Text.WordWrap
                        }

                        Text {
                            Layout.fillWidth: true
                            text: "45 min • Available in 5s"
                            font.pixelSize: 12
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                        }
                    }

                    Button {
                        text: "▶"
                        width: 40
                        height: 40
                        background: Rectangle {
                            color: "#E50914"
                            radius: 20
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Play next episode")
                    }
                }
            }
        }
    }

    function show() {
        visible = true
    }

    function hide() {
        visible = false
    }

    // Animation for show/hide
    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }
}
