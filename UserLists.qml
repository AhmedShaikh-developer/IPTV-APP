import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: userLists
    color: "#000000"

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 40

            Item { Layout.preferredHeight: 32 }

            // Header
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                spacing: 20

                Text {
                    text: "📋 My Lists"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }
            }

            // Continue Watching Section
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
                            text: "▶️ Continue Watching"
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
                                    width: 200
                                    height: 280
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
                                            height: parent.height * 0.7
                                            color: "#333333"
                                            radius: 12

                                            Text {
                                                anchors.centerIn: parent
                                                text: index < 4 ? "📺" : "🎬"
                                                font.pixelSize: 48
                                                color: "#666666"
                                            }

                                            // Progress ring
                                            Rectangle {
                                                anchors.fill: parent
                                                color: "transparent"
                                                radius: parent.radius
                                                border.color: "#E50914"
                                                border.width: 4

                                                // Progress arc (simplified as a partial border)
                                                Rectangle {
                                                    anchors.fill: parent
                                                    anchors.margins: 2
                                                    color: "transparent"
                                                    radius: parent.radius
                                                    border.color: "#E50914"
                                                    border.width: 2
                                                    rotation: -90
                                                    transformOrigin: Item.Center
                                                }
                                            }

                                            // Progress percentage
                                            Rectangle {
                                                anchors.centerIn: parent
                                                width: 40
                                                height: 40
                                                radius: 20
                                                color: "#E50914"

                                                Text {
                                                    anchors.centerIn: parent
                                                    text: Math.round((index + 1) * 12.5) + "%"
                                                    font.pixelSize: 12
                                                    font.bold: true
                                                    color: "#FFFFFF"
                                                }
                                            }
                                        }

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.3
                                            color: "transparent"
                                            anchors.margins: 12

                                            Column {
                                                anchors.fill: parent
                                                spacing: 4

                                                Text {
                                                    width: parent.width
                                                    text: (index < 4 ? "Series " : "Movie ") + (index + 1)
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    color: "#FFFFFF"
                                                    wrapMode: Text.WordWrap
                                                }

                                                Text {
                                                    width: parent.width
                                                    text: index < 4 ? "S2E5 - Episode Title" : "Action, Adventure"
                                                    font.pixelSize: 12
                                                    color: "#B3B3B3"
                                                    wrapMode: Text.WordWrap
                                                }

                                                Text {
                                                    width: parent.width
                                                    text: index < 4 ? "45 min remaining" : "2h 15m total"
                                                    font.pixelSize: 10
                                                    color: "#9A9A9A"
                                                    wrapMode: Text.WordWrap
                                                }
                                            }
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: console.log("Continue watching item " + (index + 1))
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // My Watchlist Section
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
                            text: "❤ My Watchlist"
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

                    // Grid layout for watchlist
                    GridLayout {
                        Layout.fillWidth: true
                        columns: {
                            if (parent.parent.parent.parent.width > 1600) return 6
                            if (parent.parent.parent.parent.width > 1200) return 5
                            if (parent.parent.parent.parent.width > 800) return 4
                            if (parent.parent.parent.parent.width > 600) return 3
                            return 2
                        }
                        rowSpacing: 20
                        columnSpacing: 20

                        Repeater {
                            model: 12 // Mock data for 12 watchlist items

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 320
                                radius: 12
                                color: "#111111"
                                border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                                border.width: 2
                                scale: parent.hovered || parent.activeFocus ? 1.05 : 1.0

                                Behavior on scale {
                                    NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                }
                                Behavior on border.color {
                                    ColorAnimation { duration: 200 }
                                }

                                Column {
                                    width: parent.width
                                    height: parent.height

                                    // Poster with remove button
                                    Rectangle {
                                        width: parent.width
                                        height: parent.height * 0.75
                                        color: "#333333"
                                        radius: 12

                                        Text {
                                            anchors.centerIn: parent
                                            text: index < 6 ? "📺" : "🎬"
                                            font.pixelSize: 64
                                            color: "#666666"
                                        }

                                        // Remove from list button
                                        Rectangle {
                                            anchors.top: parent.top
                                            anchors.right: parent.right
                                            anchors.margins: 8
                                            width: 28
                                            height: 28
                                            radius: 14
                                            color: "#E50914"

                                            Text {
                                                anchors.centerIn: parent
                                                text: "×"
                                                font.pixelSize: 16
                                                font.bold: true
                                                color: "#FFFFFF"
                                            }

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: console.log("Remove from watchlist " + (index + 1))
                                            }
                                        }

                                        // Watchlist badge
                                        Rectangle {
                                            anchors.top: parent.top
                                            anchors.left: parent.left
                                            anchors.margins: 8
                                            width: 60
                                            height: 24
                                            radius: 12
                                            color: "#E50914"

                                            Text {
                                                anchors.centerIn: parent
                                                text: "❤"
                                                font.pixelSize: 12
                                                color: "#FFFFFF"
                                            }
                                        }

                                        // Hover overlay
                                        Rectangle {
                                            anchors.fill: parent
                                            color: "black"
                                            opacity: parent.parent.parent.parent.hovered ? 0.7 : 0.0
                                            radius: 12

                                            Behavior on opacity {
                                                NumberAnimation { duration: 200 }
                                            }

                                            Row {
                                                anchors.centerIn: parent
                                                spacing: 16

                                                Rectangle {
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
                                                        onClicked: console.log("Play watchlist item " + (index + 1))
                                                    }
                                                }

                                                Rectangle {
                                                    width: 50
                                                    height: 50
                                                    radius: 25
                                                    color: "transparent"
                                                    border.color: "#FFFFFF"
                                                    border.width: 2

                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: "i"
                                                        font.pixelSize: 20
                                                        color: "#FFFFFF"
                                                    }

                                                    MouseArea {
                                                        anchors.fill: parent
                                                        onClicked: console.log("Navigate to details")
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    // Item info
                                    Rectangle {
                                        width: parent.width
                                        height: parent.height * 0.25
                                        color: "transparent"
                                        anchors.margins: 12

                                        Column {
                                            anchors.fill: parent
                                            spacing: 4

                                            Text {
                                                width: parent.width
                                                text: (index < 6 ? "Series " : "Movie ") + (index + 1)
                                                font.pixelSize: 14
                                                font.bold: true
                                                color: "#FFFFFF"
                                                wrapMode: Text.WordWrap
                                            }

                                            Text {
                                                width: parent.width
                                                text: index < 6 ? "Drama • 4 Seasons" : "Action • 2024"
                                                font.pixelSize: 12
                                                color: "#B3B3B3"
                                                wrapMode: Text.WordWrap
                                            }
                                        }
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: console.log("Navigate to watchlist item " + (index + 1))
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
