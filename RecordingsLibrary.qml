import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: recordingsLibrary
    color: "#000000"

    property string currentTab: "All"
    property bool isGridView: true
    property var selectedItems: []
    property bool showFreeSpaceDialog: false

    // Mock recorded content data
    property var recordedContent: [
        { id: "1", title: "BBC News at Six", channel: "BBC One", channelLogo: "📺", recordedDate: "2024-01-15", duration: "30 min", size: "1.2 GB", progress: 1.0, type: "News", thumbnail: "📰" },
        { id: "2", title: "The Great British Bake Off", channel: "Channel 4", channelLogo: "📺", recordedDate: "2024-01-14", duration: "90 min", size: "3.8 GB", progress: 0.6, type: "Series", thumbnail: "🧁" },
        { id: "3", title: "Premier League Highlights", channel: "Sky Sports", channelLogo: "⚽", recordedDate: "2024-01-13", duration: "45 min", size: "2.1 GB", progress: 1.0, type: "Sports", thumbnail: "⚽" },
        { id: "4", title: "Planet Earth II", channel: "BBC Two", channelLogo: "📺", recordedDate: "2024-01-12", duration: "60 min", size: "4.2 GB", progress: 0.0, type: "Movies", thumbnail: "🌍" },
        { id: "5", title: "Breaking News Special", channel: "BBC One", channelLogo: "📺", recordedDate: "2024-01-11", duration: "20 min", size: "800 MB", progress: 0.3, type: "News", thumbnail: "📰" },
        { id: "6", title: "Formula 1 Qualifying", channel: "Sky Sports", channelLogo: "⚽", recordedDate: "2024-01-10", duration: "120 min", size: "5.1 GB", progress: 1.0, type: "Sports", thumbnail: "🏎️" }
    ]

    // Storage info
    property real storageUsed: 17.2 // GB
    property real storageTotal: 100.0 // GB

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function getFilteredContent() {
        if (currentTab === "All") return recordedContent
        return recordedContent.filter(item => item.type.toLowerCase() === currentTab.toLowerCase())
    }

    function deleteRecording(id) {
        recordedContent = recordedContent.filter(item => item.id !== id)
        selectedItems = selectedItems.filter(item => item !== id)
    }

    function deleteSelected() {
        selectedItems.forEach(id => deleteRecording(id))
        selectedItems = []
    }

    function playRecording(recording) {
        // Navigate to player with mock recording data
        navigateTo("/player")
    }

    function renameRecording(id, newTitle) {
        for (var i = 0; i < recordedContent.length; i++) {
            if (recordedContent[i].id === id) {
                recordedContent[i].title = newTitle
                break
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: Math.min(1200, parent.width - 80)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 40
            spacing: 24

            // Header
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    spacing: 24

                    Button {
                        Layout.preferredWidth: 48
                        Layout.preferredHeight: 48
                        Layout.alignment: Qt.AlignVCenter
                        background: Rectangle {
                            color: parent.hovered ? "#2A2A2A" : "transparent"
                            radius: 24
                            border.color: "#444444"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: "←"
                            font.pixelSize: 22
                            color: "#FFFFFF"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: navigateTo("/home")
                    }

                    Text {
                        text: "Recorded Library"
                        font.pixelSize: 28
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Item { Layout.fillWidth: true }

                    // Storage indicator
                    RowLayout {
                        spacing: 16
                        Layout.alignment: Qt.AlignVCenter

                        Text {
                            text: Math.round(storageUsed) + " / " + Math.round(storageTotal) + " GB"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                        }

                        Rectangle {
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 6
                            color: "#333333"
                            radius: 3

                            Rectangle {
                                width: parent.width * (storageUsed / storageTotal)
                                height: parent.height
                                color: storageUsed / storageTotal > 0.8 ? "#F44336" : "#E50914"
                                radius: 3
                            }
                        }

                        Button {
                            text: "Free Up Space"
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 120
                            background: Rectangle {
                                color: parent.hovered ? "#2A2A2A" : "transparent"
                                radius: 8
                                border.color: "#666666"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#FFFFFF"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: showFreeSpaceDialog = true
                        }
                    }
                }
            }

            // Tabs and View Toggle
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    spacing: 24

                    // Category Tabs
                    RowLayout {
                        spacing: 8

                        Repeater {
                            model: ["All", "Movies", "Series", "Sports", "News"]
                            delegate: Button {
                                text: modelData
                                Layout.preferredHeight: 36
                                Layout.preferredWidth: 80
                                background: Rectangle {
                                    color: currentTab === modelData ? "#E50914" : "transparent"
                                    radius: 18
                                    border.color: currentTab === modelData ? "#E50914" : "#666666"
                                    border.width: 2
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: currentTab = modelData
                            }
                        }
                    }

                    Item { Layout.fillWidth: true }

                    // View Toggle
                    RowLayout {
                        spacing: 4

                        Button {
                            text: "Grid"
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 60
                            background: Rectangle {
                                color: isGridView ? "#E50914" : "transparent"
                                radius: 18
                                border.color: isGridView ? "#E50914" : "#666666"
                                border.width: 2
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#FFFFFF"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: isGridView = true
                        }

                        Button {
                            text: "List"
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 60
                            background: Rectangle {
                                color: !isGridView ? "#E50914" : "transparent"
                                radius: 18
                                border.color: !isGridView ? "#E50914" : "#666666"
                                border.width: 2
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#FFFFFF"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: isGridView = false
                        }
                    }
                }
            }

            // Bulk Actions Bar
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "#1A1A1A"
                radius: 12
                border.color: "#2A2A2A"
                border.width: 1
                visible: selectedItems.length > 0

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    Text {
                        text: selectedItems.length + " selected"
                        font.pixelSize: 14
                        font.weight: Font.Medium
                        color: "#FFFFFF"
                    }

                    Item { Layout.fillWidth: true }

                    Button {
                        text: "Delete Selected"
                        Layout.preferredHeight: 36
                        Layout.preferredWidth: 140
                        background: Rectangle {
                            color: parent.hovered ? "#CC0810" : "#E50914"
                            radius: 8
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: deleteSelected()
                    }
                }
            }

            // Content Grid/List
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                GridLayout {
                    anchors.fill: parent
                    columns: isGridView ? 4 : 1
                    rowSpacing: 20
                    columnSpacing: 20

                    Repeater {
                        model: getFilteredContent()

                        delegate: Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: isGridView ? 280 : 100
                            Layout.preferredWidth: isGridView ? 250 : undefined
                            color: "#1A1A1A"
                            radius: 16
                            border.color: selectedItems.includes(modelData.id) ? "#E50914" : "#2A2A2A"
                            border.width: selectedItems.includes(modelData.id) ? 2 : 1

                            // Grid View Layout
                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 12
                                visible: isGridView

                                // Thumbnail
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 140
                                    color: "#333333"
                                    radius: 12

                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 8

                                        Text {
                                            text: modelData.thumbnail
                                            font.pixelSize: 48
                                            color: "#666666"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: modelData.channel
                                            font.pixelSize: 12
                                            color: "#B3B3B3"
                                            Layout.alignment: Qt.AlignHCenter
                                        }
                                    }

                                    // Progress overlay
                                    Rectangle {
                                        anchors.bottom: parent.bottom
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        height: 4
                                        color: "#333333"

                                        Rectangle {
                                            width: parent.width * modelData.progress
                                            height: parent.height
                                            color: "#E50914"
                                        }
                                    }

                                    // Watched badge
                                    Rectangle {
                                        anchors.top: parent.top
                                        anchors.right: parent.right
                                        anchors.margins: 8
                                        width: childrenRect.width + 8
                                        height: 20
                                        color: modelData.progress === 1.0 ? "#4CAF50" : "#FFC107"
                                        radius: 10
                                        visible: modelData.progress > 0

                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData.progress === 1.0 ? "Watched" : "Partial"
                                            font.pixelSize: 9
                                            color: "#FFFFFF"
                                            font.weight: Font.Bold
                                        }
                                    }
                                }

                                // Title and Info
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4

                                    Text {
                                        text: modelData.title
                                        font.pixelSize: 14
                                        font.weight: Font.Medium
                                        color: "#FFFFFF"
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                        wrapMode: Text.WordWrap
                                        maximumLineCount: 2
                                    }

                                    Text {
                                        text: modelData.recordedDate + " • " + modelData.duration
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                        Layout.fillWidth: true
                                    }

                                    Text {
                                        text: modelData.size
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                        Layout.fillWidth: true
                                    }
                                }

                                // Actions
                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 8

                                    Button {
                                        text: "Play"
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        background: Rectangle {
                                            color: parent.hovered ? "#CC0810" : "#E50914"
                                            radius: 6
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            color: "#FFFFFF"
                                            font.pixelSize: 12
                                            font.weight: Font.Medium
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: playRecording(modelData)
                                    }

                                    Button {
                                        text: "⋯"
                                        Layout.preferredWidth: 32
                                        Layout.preferredHeight: 32
                                        background: Rectangle {
                                            color: parent.hovered ? "#2A2A2A" : "transparent"
                                            radius: 6
                                            border.color: "#666666"
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
                                            // Show context menu (mock)
                                            console.log("Context menu for:", modelData.title)
                                        }
                                    }
                                }
                            }

                            // List View Layout
                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 16
                                visible: !isGridView

                                // Checkbox
                                Rectangle {
                                    Layout.preferredWidth: 20
                                    Layout.preferredHeight: 20
                                    color: selectedItems.includes(modelData.id) ? "#E50914" : "transparent"
                                    radius: 10
                                    border.color: "#666666"
                                    border.width: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "✓"
                                        font.pixelSize: 12
                                        color: "#FFFFFF"
                                        visible: selectedItems.includes(modelData.id)
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            if (selectedItems.includes(modelData.id)) {
                                                selectedItems = selectedItems.filter(id => id !== modelData.id)
                                            } else {
                                                selectedItems.push(modelData.id)
                                            }
                                        }
                                    }
                                }

                                // Thumbnail
                                Rectangle {
                                    Layout.preferredWidth: 60
                                    Layout.preferredHeight: 60
                                    color: "#333333"
                                    radius: 8

                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 2

                                        Text {
                                            text: modelData.thumbnail
                                            font.pixelSize: 20
                                            color: "#666666"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: modelData.channel
                                            font.pixelSize: 8
                                            color: "#B3B3B3"
                                            Layout.alignment: Qt.AlignHCenter
                                        }
                                    }
                                }

                                // Content
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    spacing: 4

                                    Text {
                                        text: modelData.title
                                        font.pixelSize: 16
                                        font.weight: Font.Medium
                                        color: "#FFFFFF"
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 16

                                        Text {
                                            text: modelData.recordedDate
                                            font.pixelSize: 14
                                            color: "#B3B3B3"
                                        }

                                        Text {
                                            text: modelData.duration
                                            font.pixelSize: 14
                                            color: "#B3B3B3"
                                        }

                                        Text {
                                            text: modelData.size
                                            font.pixelSize: 14
                                            color: "#B3B3B3"
                                        }
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

                                // Actions
                                RowLayout {
                                    spacing: 8

                                    Button {
                                        text: "Play"
                                        Layout.preferredHeight: 32
                                        Layout.preferredWidth: 60
                                        background: Rectangle {
                                            color: parent.hovered ? "#CC0810" : "#E50914"
                                            radius: 6
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            color: "#FFFFFF"
                                            font.pixelSize: 12
                                            font.weight: Font.Medium
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: playRecording(modelData)
                                    }

                                    Button {
                                        text: "Delete"
                                        Layout.preferredHeight: 32
                                        Layout.preferredWidth: 60
                                        background: Rectangle {
                                            color: parent.hovered ? "#CC0810" : "#E50914"
                                            radius: 6
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            color: "#FFFFFF"
                                            font.pixelSize: 12
                                            font.weight: Font.Medium
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: deleteRecording(modelData.id)
                                    }
                                }
                            }

                            // Hover animation
                            scale: MouseArea.hovered ? 1.02 : 1.0
                            Behavior on scale {
                                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                            }
                            Behavior on border.color {
                                ColorAnimation { duration: 150 }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                            }
                        }
                    }
                }

                // Empty State
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    visible: getFilteredContent().length === 0

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 24

                        Text {
                            text: "📺"
                            font.pixelSize: 80
                            color: "#666666"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        ColumnLayout {
                            spacing: 8
                            Layout.alignment: Qt.AlignHCenter

                            Text {
                                text: "No recorded content"
                                font.pixelSize: 24
                                font.bold: true
                                color: "#FFFFFF"
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: "Your recorded shows will appear here"
                                font.pixelSize: 16
                                color: "#B3B3B3"
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }
            }
        }
    }

    // Free Up Space Dialog
    Rectangle {
        anchors.fill: parent
        color: showFreeSpaceDialog ? "#000000CC" : "transparent"
        visible: showFreeSpaceDialog
        z: 9999

        Behavior on color {
            ColorAnimation { duration: 150; easing.type: Easing.OutQuad }
        }

        Rectangle {
            width: 600
            height: childrenRect.height + 48
            anchors.centerIn: parent
            color: "#1A1A1A"
            radius: 16
            border.color: "#2A2A2A"
            border.width: 1

            // Shadow
            Rectangle {
                anchors.fill: parent
                anchors.margins: -8
                radius: parent.radius + 4
                color: "#00000099"
                z: -1
            }

            // Animation
            scale: showFreeSpaceDialog ? 1.0 : 0.9
            opacity: showFreeSpaceDialog ? 1.0 : 0.0

            Behavior on scale {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }
            Behavior on opacity {
                NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 24
                spacing: 20

                Text {
                    text: "Free Up Space"
                    font.pixelSize: 22
                    font.weight: Font.Bold
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#333333"
                }

                Text {
                    text: "Large recordings that can be deleted to free up space:"
                    font.pixelSize: 14
                    color: "#B3B3B3"
                    Layout.alignment: Qt.AlignHCenter
                }

                // Large files list
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Repeater {
                        model: [
                            { title: "Formula 1 Qualifying", size: "5.1 GB", date: "2024-01-10" },
                            { title: "Planet Earth II", size: "4.2 GB", date: "2024-01-12" },
                            { title: "The Great British Bake Off", size: "3.8 GB", date: "2024-01-14" }
                        ]

                        delegate: RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Text {
                                text: modelData.title
                                font.pixelSize: 14
                                color: "#FFFFFF"
                                Layout.fillWidth: true
                            }

                            Text {
                                text: modelData.size
                                font.pixelSize: 14
                                color: "#E50914"
                                font.weight: Font.Bold
                            }

                            Text {
                                text: modelData.date
                                font.pixelSize: 14
                                color: "#B3B3B3"
                            }

                            Button {
                                text: "Delete"
                                Layout.preferredHeight: 28
                                Layout.preferredWidth: 60
                                background: Rectangle {
                                    color: parent.hovered ? "#CC0810" : "#E50914"
                                    radius: 6
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "#FFFFFF"
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: {
                                    // Mock delete
                                    console.log("Delete:", modelData.title)
                                }
                            }
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 16
                    spacing: 16

                    Button {
                        text: "Close"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 44
                        background: Rectangle {
                            color: parent.hovered ? "#2A2A2A" : "transparent"
                            radius: 12
                            border.color: "#666666"
                            border.width: 2
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 15
                            font.weight: Font.Medium
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: showFreeSpaceDialog = false
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: showFreeSpaceDialog = false
        }
    }
}
