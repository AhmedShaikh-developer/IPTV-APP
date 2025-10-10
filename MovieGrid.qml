import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: movieGrid
    color: "#000000"

    property string genreId: ""
    property string genreName: "Action"

    // Responsive grid calculations
    readonly property int cardsPerRow: {
        if (parent.width > 1600) return 6
        if (parent.width > 1200) return 5
        if (parent.width > 800) return 4
        if (parent.width > 600) return 3
        return 2
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 24

            Item { Layout.preferredHeight: 32 }

            // Header with Breadcrumb
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
                    onClicked: console.log("Navigate back to movies hub")
                }

                Text {
                    text: "Movies › " + genreName
                    font.pixelSize: 14
                    color: "#B3B3B3"
                }

                Item { Layout.fillWidth: true }

                // Sort chips
                Row {
                    spacing: 12
                    
                    Button {
                        text: "Popular"
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
                        onClicked: console.log("Sort: Popular")
                    }

                    Button {
                        text: "A-Z"
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
                        onClicked: console.log("Sort: A-Z")
                    }

                    Button {
                        text: "Year"
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
                        onClicked: console.log("Sort: Year")
                    }
                }
            }

            // Movies Grid
            GridLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                columns: cardsPerRow
                rowSpacing: 24
                columnSpacing: 20

                Repeater {
                    model: 24 // Mock data for 24 movies

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 400
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

                            // Movie poster
                            Rectangle {
                                width: parent.width
                                height: parent.height * 0.75
                                color: "#333333"
                                radius: 12

                                Text {
                                    anchors.centerIn: parent
                                    text: "🎬"
                                    font.pixelSize: 64
                                    color: "#666666"
                                }

                                // Hover overlay
                                Rectangle {
                                    anchors.fill: parent
                                    color: "black"
                                    opacity: parent.parent.parent.hovered ? 0.7 : 0.0
                                    radius: 12

                                    Behavior on opacity {
                                        NumberAnimation { duration: 200 }
                                    }

                                    Row {
                                        anchors.centerIn: parent
                                        spacing: 20

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
                                                onClicked: console.log("Play movie " + index)
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
                                                text: "+"
                                                font.pixelSize: 24
                                                color: "#FFFFFF"
                                            }

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: console.log("Add to list " + index)
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
                                                onClicked: console.log("Navigate to movie details")
                                            }
                                        }
                                    }
                                }
                            }

                            // Movie info
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
                                        text: "Movie Title " + (index + 1)
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#FFFFFF"
                                        wrapMode: Text.WordWrap
                                    }

                                    Text {
                                        width: parent.width
                                        text: "2024 • Action • 2h 15m"
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
                            onClicked: console.log("Navigate to movie details")
                        }
                    }
                }
            }

            Item { Layout.preferredHeight: 32 }
        }
    }
}
