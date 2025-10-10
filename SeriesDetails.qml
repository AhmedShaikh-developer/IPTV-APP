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


    // Floating back button (always visible at top)
    Button {
        id: backButton
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        z: 1000
        text: "← Back"
        width: 110
        height: 44
        background: Rectangle {
            color: parent.hovered ? "#E50914" : "#1a1a1a"
            radius: 22
            border.color: parent.hovered ? "#E50914" : "#444444"
            border.width: 1
            
            // Subtle shadow effect
            Rectangle {
                anchors.fill: parent
                anchors.margins: -1
                radius: parent.radius + 1
                color: "#00000040"
                z: -1
            }
            
            Behavior on color {
                ColorAnimation { duration: 200 }
            }
            Behavior on border.color {
                ColorAnimation { duration: 200 }
            }
        }
        contentItem: Text {
            text: parent.text
            color: "#FFFFFF"
            font.pixelSize: 15
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        onClicked: {
            console.log("Navigate back to series hub")
            if (typeof navigateTo !== 'undefined') {
                navigateTo("/series")
            }
        }
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
                Layout.preferredHeight: Math.max(500, parent.parent.height * 0.55)
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 32
                    spacing: 32

                    // Series poster
                    Rectangle {
                        Layout.preferredWidth: Math.min(300, parent.width * 0.35)
                        Layout.fillHeight: true
                        radius: 16
                        color: "#111111"
                        border.color: "#333333"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: "📺"
                            font.pixelSize: 100
                            color: "#666666"
                        }

                        // Shadow effect
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -4
                            anchors.topMargin: 0
                            radius: parent.radius + 2
                            color: "#00000080"
                            z: -1
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
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.bottomMargin: 24
                color: "#1a1a1a"
                radius: 16
                border.color: "#E50914"
                border.width: 1

                // Gradient background
                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#1a1a1a" }
                        GradientStop { position: 1.0; color: "#111111" }
                    }
                    opacity: 0.8
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    // TV Icon
                    Rectangle {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        color: "#333333"
                        radius: 10
                        border.color: "#555555"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: "📺"
                            font.pixelSize: 24
                            color: "#666666"
                        }
                    }

                    // Text Content - Fixed width to prevent clipping
                    Column {
                        Layout.preferredWidth: 250
                        Layout.fillHeight: true
                        spacing: 6
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: "Continue Season 2"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#FFFFFF"
                            width: parent.width
                            wrapMode: Text.Wrap
                        }

                        Text {
                            text: "Episode 5: The Battle Begins"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            width: parent.width
                            wrapMode: Text.Wrap
                        }

                        Rectangle {
                            width: parent.width
                            height: 4
                            color: "#333333"
                            radius: 2
                            Rectangle {
                                width: parent.width * 0.65
                                height: parent.height
                                color: "#E50914"
                                radius: 2
                            }
                        }
                    }

                    // Flexible spacer
                    Item { 
                        Layout.fillWidth: true 
                    }

                    // Continue Button
                    Button {
                        text: "▶ Continue"
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 40
                        background: Rectangle {
                            color: "#E50914"
                            radius: 20
                            border.color: "#E50914"
                            border.width: 1
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
                Layout.preferredHeight: 64
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                color: "#1a1a1a"
                border.color: "#333333"
                border.width: 1
                radius: 12

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 20

                    Text {
                        text: "Seasons:"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#FFFFFF"
                        Layout.alignment: Qt.AlignVCenter
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
                                    width: 100
                                    height: 36
                                    background: Rectangle {
                                        color: parent.checked ? "#E50914" : "#333333"
                                        radius: 18
                                        border.color: parent.checked ? "#E50914" : "#555555"
                                        border.width: 1
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 13
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
                Layout.preferredHeight: 64
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 24

                    TabButton {
                        text: "Overview"
                        background: Rectangle {
                            color: parent.checked ? "#E50914" : "transparent"
                            radius: 18
                        }
                        contentItem: Text {
                            text: parent.text
                            color: parent.checked ? "#FFFFFF" : "#B3B3B3"
                            font.pixelSize: 14
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
                            radius: 18
                        }
                        contentItem: Text {
                            text: parent.text
                            color: parent.checked ? "#FFFFFF" : "#B3B3B3"
                            font.pixelSize: 14
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
                            radius: 18
                        }
                        contentItem: Text {
                            text: parent.text
                            color: parent.checked ? "#FFFFFF" : "#B3B3B3"
                            font.pixelSize: 14
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
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                color: "transparent"

                // Related series carousel
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 24

                    Text {
                        text: "More Like This"
                        font.pixelSize: 22
                        font.bold: true
                        color: "#FFFFFF"
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 240
                        clip: true

                        Row {
                            spacing: 16
                            Repeater {
                                model: 8
                                delegate: Rectangle {
                                    width: 150
                                    height: 220
                                    radius: 12
                                    color: "#1a1a1a"
                                    border.color: parent.hovered || parent.activeFocus ? "#E50914" : "#333333"
                                    border.width: 1
                                    scale: parent.hovered || parent.activeFocus ? 1.05 : 1.0

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

                                        Column {
                                            width: parent.width
                                            height: parent.height * 0.2
                                            spacing: 2
                                            anchors.margins: 8
                                            
                                            Text {
                                                text: "Related Series " + (index + 1)
                                                width: parent.width
                                                font.pixelSize: 12
                                                font.bold: true
                                                color: "#FFFFFF"
                                                wrapMode: Text.WordWrap
                                                horizontalAlignment: Text.AlignHCenter
                                            }
                                            
                                            Text {
                                                text: "2023 • Action • 8." + (index + 1)
                                                width: parent.width
                                                font.pixelSize: 10
                                                color: "#B3B3B3"
                                                wrapMode: Text.WordWrap
                                                horizontalAlignment: Text.AlignHCenter
                                            }
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
