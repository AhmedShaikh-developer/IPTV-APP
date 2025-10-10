import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: seasonEpisodes
    color: "#000000"

    property string seriesId: ""
    property int seasonNumber: 1
    property string seasonTitle: "Season 1"

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            Item { Layout.preferredHeight: 32 }

            // Header with Download All button
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                spacing: 20

                Button {
                    text: "← Back"
                    background: Rectangle {
                        color: parent.hovered ? "#333333" : "#222222"
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: console.log("Navigate back to series details")
                }

                Text {
                    text: seasonTitle
                    font.pixelSize: 24
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }

                Button {
                    text: "⬇ Download All"
                    Layout.preferredWidth: 140
                    Layout.preferredHeight: 40
                    background: Rectangle {
                        color: parent.hovered ? "#E50914" : "#333333"
                        radius: 6
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: console.log("Download all episodes")
                }
            }

            // Sticky Season Header
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: 80
                color: "#111111"
                radius: 12
                border.color: "#333333"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Rectangle {
                        Layout.preferredWidth: 60
                        Layout.preferredHeight: 40
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
                        spacing: 4

                        Text {
                            text: seasonTitle
                            font.pixelSize: 20
                            font.bold: true
                            color: "#FFFFFF"
                        }

                        Text {
                            text: "12 Episodes • 2023"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                        }
                    }

                    Text {
                        text: "TV-14"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#9A9A9A"
                        Layout.alignment: Qt.AlignVCenter
                    }
                }
            }

            // Episodes List
            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                spacing: 16

                Repeater {
                    model: 12 // Mock data for 12 episodes

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 120
                        color: "#111111"
                        radius: 12
                        border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2

                        Behavior on border.color {
                            ColorAnimation { duration: 200 }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 16

                            // Episode thumbnail
                            Rectangle {
                                Layout.preferredWidth: 120
                                Layout.preferredHeight: 88
                                color: "#333333"
                                radius: 8

                                Text {
                                    anchors.centerIn: parent
                                    text: "📺"
                                    font.pixelSize: 32
                                    color: "#666666"
                                }

                                // Episode number overlay
                                Rectangle {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 8
                                    width: 24
                                    height: 24
                                    radius: 12
                                    color: "#E50914"

                                    Text {
                                        anchors.centerIn: parent
                                        text: index + 1
                                        font.pixelSize: 12
                                        font.bold: true
                                        color: "#FFFFFF"
                                    }
                                }

                                // Play/Progress overlay
                                Rectangle {
                                    anchors.fill: parent
                                    color: "black"
                                    opacity: parent.parent.parent.parent.hovered ? 0.7 : 0.0
                                    radius: 8

                                    Behavior on opacity {
                                        NumberAnimation { duration: 200 }
                                    }

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 50
                                        height: 50
                                        radius: 25
                                        color: "#E50914"
                                        border.color: "#FFFFFF"
                                        border.width: 2

                                        Text {
                                            anchors.centerIn: parent
                                            text: "▶"
                                            font.pixelSize: 20
                                            color: "#FFFFFF"
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: console.log("Play episode " + (index + 1))
                                        }
                                    }
                                }
                            }

                            // Episode info
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 8

                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 12

                                    Text {
                                        text: "Episode " + (index + 1)
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#FFFFFF"
                                    }

                                    Text {
                                        text: "•"
                                        font.pixelSize: 14
                                        color: "#9A9A9A"
                                    }

                                    Text {
                                        text: "45 min"
                                        font.pixelSize: 14
                                        color: "#9A9A9A"
                                    }

                                    Item { Layout.fillWidth: true }

                                    Button {
                                        text: "⬇"
                                        width: 32
                                        height: 32
                                        background: Rectangle {
                                            color: parent.hovered ? "#333333" : "transparent"
                                            radius: 16
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            color: "#B3B3B3"
                                            font.pixelSize: 16
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: console.log("Download episode " + (index + 1))
                                    }
                                }

                                Text {
                                    Layout.fillWidth: true
                                    text: "Episode " + (index + 1) + " - " + ["The Beginning", "The Journey", "The Discovery", "The Conflict", "The Battle", "The Victory", "The Loss", "The Return", "The Truth", "The End", "The New Beginning", "The Final Chapter"][index]
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "#FFFFFF"
                                    wrapMode: Text.WordWrap
                                }

                                Text {
                                    Layout.fillWidth: true
                                    text: "Our heroes face new challenges as they continue their epic journey. This episode brings unexpected twists and character development that will leave you wanting more."
                                    font.pixelSize: 14
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                    lineHeight: 1.3
                                }

                                // Progress bar (for episodes with progress)
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 4
                                    color: "#333333"
                                    radius: 2
                                    visible: index < 3 // Show progress for first 3 episodes

                                    Rectangle {
                                        width: parent.width * (0.2 + index * 0.3)
                                        height: parent.height
                                        color: "#E50914"
                                        radius: 2
                                    }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: console.log("Open episode sheet for episode " + (index + 1))
                        }
                    }
                }
            }

            Item { Layout.preferredHeight: 32 }
        }
    }
}
