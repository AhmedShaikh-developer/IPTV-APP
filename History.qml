import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: historyScreen
    color: "#000000"

    property string currentSort: "Most Recent"
    property var selectedFilters: ["All", "Live TV", "Movies", "Series", "Episodes"]
    property bool showFiltersDropdown: false
    property bool showClearDialog: false

    // Responsive breakpoints
    readonly property real screenWidth: parent.width
    readonly property bool isDesktop: screenWidth >= 1920
    readonly property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    readonly property bool isMobile: screenWidth < 1366

    // Mock history data with timestamps for grouping
    property var historyItems: [
        { id: "1", type: "live", title: "BBC News HD", subtitle: "Watched 2h ago", thumbnail: "📰", progress: 1.0, watchedAt: new Date(Date.now() - 2 * 60 * 60 * 1000) },
        { id: "2", type: "movie", title: "The Dark Knight", subtitle: "Movie • Watched 1d ago", thumbnail: "🎬", progress: 1.0, watchedAt: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000) },
        { id: "3", type: "episode", title: "Breaking Bad S05E14", subtitle: "Episode • Watched 3d ago", thumbnail: "🧪", progress: 0.8, watchedAt: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000) },
        { id: "4", type: "series", title: "Game of Thrones", subtitle: "Series • Watched 1w ago", thumbnail: "👑", progress: 1.0, watchedAt: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000) },
        { id: "5", type: "live", title: "ESPN Sports", subtitle: "Watched 2d ago", thumbnail: "⚽", progress: 0.6, watchedAt: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000) },
        { id: "6", type: "movie", title: "Inception", subtitle: "Movie • Watched 1w ago", thumbnail: "🎭", progress: 1.0, watchedAt: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000) },
        { id: "7", type: "episode", title: "Stranger Things S04E09", subtitle: "Episode • Watched 2w ago", thumbnail: "👻", progress: 1.0, watchedAt: new Date(Date.now() - 14 * 24 * 60 * 60 * 1000) },
        { id: "8", type: "live", title: "Discovery Channel", subtitle: "Watched 3d ago", thumbnail: "🌍", progress: 0.4, watchedAt: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000) }
    ]

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function removeFromHistory(id) {
        historyItems = historyItems.filter(item => item.id !== id)
    }

    function clearAllHistory() {
        historyItems = []
        showClearDialog = false
    }

    function getFilteredItems() {
        var filtered = historyItems
        
        // Apply filter selection
        if (!selectedFilters.includes("All")) {
            filtered = filtered.filter(function(item) {
                if (selectedFilters.includes("Live TV") && item.type === "live") return true
                if (selectedFilters.includes("Movies") && item.type === "movie") return true
                if (selectedFilters.includes("Series") && item.type === "series") return true
                if (selectedFilters.includes("Episodes") && item.type === "episode") return true
                return false
            })
        }
        
        // Apply sorting
        if (currentSort === "Alphabetical") {
            filtered.sort(function(a, b) { return a.title.localeCompare(b.title) })
        } else {
            filtered.sort(function(a, b) { return b.watchedAt - a.watchedAt })
        }
        
        return filtered
    }

    function getDateGroup(watchedAt) {
        var now = new Date()
        var diffMs = now - watchedAt
        var diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))
        
        if (diffDays === 0) return "Today"
        if (diffDays === 1) return "Yesterday"
        if (diffDays <= 7) return "This Week"
        return "Earlier"
    }

    function getGroupedItems() {
        var items = getFilteredItems()
        var grouped = {}
        
        items.forEach(function(item) {
            var group = getDateGroup(item.watchedAt)
            if (!grouped[group]) grouped[group] = []
            grouped[group].push(item)
        })
        
        return grouped
    }

    // Main content container
    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: Math.min(1200, parent.width - 80)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 40
            spacing: 0

            // Header Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 0
                    spacing: 0

                    // Back Button
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

                    // Title
                    Text {
                        text: "Recently Watched"
                        font.pixelSize: 32
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 24
                    }

                    // Spacer
                    Item { Layout.fillWidth: true }

                    // Clear All Button
                    Button {
                        text: "Clear All"
                        Layout.preferredHeight: 44
                        Layout.preferredWidth: 120
                        Layout.alignment: Qt.AlignVCenter
                        background: Rectangle {
                            color: parent.hovered ? "#E50914" : "#444444"
                            radius: 12
                            border.color: parent.hovered ? "#E50914" : "#666666"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 15
                            font.weight: Font.Medium
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: showClearDialog = true
                    }
                }
            }

            // Controls Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 0
                    spacing: 24

                    // Sort Label
                    Text {
                        text: "Sort by:"
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        color: "#B3B3B3"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    // Sort Buttons
                    RowLayout {
                        spacing: 16
                        Layout.alignment: Qt.AlignVCenter
                        
                        Repeater {
                            model: ["Most Recent", "Alphabetical"]
                            delegate: Button {
                                text: modelData
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 140
                                background: Rectangle {
                                    color: currentSort === modelData ? "#E50914" : "transparent"
                                    radius: 20
                                    border.color: currentSort === modelData ? "#E50914" : "#666666"
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
                                onClicked: currentSort = modelData
                            }
                        }
                    }

                    // Spacer
                    Item { Layout.fillWidth: true }

                    // Filters Button
                    Button {
                        text: "Filters"
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 100
                        Layout.alignment: Qt.AlignVCenter
                        background: Rectangle {
                            color: parent.hovered ? "#2A2A2A" : "transparent"
                            radius: 20
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
                        onClicked: showFiltersDropdown = !showFiltersDropdown

                        // Filters Dropdown
                        Rectangle {
                            anchors.top: parent.bottom
                            anchors.right: parent.right
                            anchors.topMargin: 8
                            width: 240
                            height: childrenRect.height + 24
                            color: "#181818"
                            radius: 12
                            border.color: "#333333"
                            border.width: 1
                            visible: showFiltersDropdown
                            z: 1000

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 8

                                Repeater {
                                    model: ["All", "Live TV", "Movies", "Series", "Episodes"]
                                    delegate: Button {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 36
                                        background: Rectangle {
                                            color: "transparent"
                                        }
                                        contentItem: RowLayout {
                                            spacing: 12

                                            Rectangle {
                                                Layout.preferredWidth: 16
                                                Layout.preferredHeight: 16
                                                radius: 8
                                                color: selectedFilters.includes(modelData) ? "#E50914" : "transparent"
                                                border.color: "#FFFFFF"
                                                border.width: 1

                                                Text {
                                                    anchors.centerIn: parent
                                                    text: "✓"
                                                    font.pixelSize: 10
                                                    color: "#FFFFFF"
                                                    visible: selectedFilters.includes(modelData)
                                                }
                                            }

                                            Text {
                                                text: modelData
                                                color: "#FFFFFF"
                                                font.pixelSize: 14
                                            }
                                        }
                                        onClicked: {
                                            if (modelData === "All") {
                                                selectedFilters = ["All", "Live TV", "Movies", "Series", "Episodes"]
                                            } else {
                                                if (selectedFilters.includes(modelData)) {
                                                    selectedFilters = selectedFilters.filter(f => f !== modelData)
                                                } else {
                                                    selectedFilters.push(modelData)
                                                }
                                                if (selectedFilters.includes("All")) {
                                                    selectedFilters = selectedFilters.filter(f => f !== "All")
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

            // Content Section
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 40

                    Repeater {
                        model: {
                            var grouped = getGroupedItems()
                            var groups = []
                            var order = ["Today", "Yesterday", "This Week", "Earlier"]
                            order.forEach(function(groupName) {
                                if (grouped[groupName] && grouped[groupName].length > 0) {
                                    groups.push({ name: groupName, items: grouped[groupName] })
                                }
                            })
                            return groups
                        }

                        delegate: ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            // Section Header
                            Text {
                                text: modelData.name
                                font.pixelSize: 20
                                font.weight: Font.Bold
                                color: "#FFFFFF"
                                Layout.fillWidth: true
                            }

                            // Section Divider
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 1
                                color: "#333333"
                            }

                            // Items in Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Repeater {
                                    model: modelData.items

                                    delegate: Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 96
                                        color: "#1A1A1A"
                                        radius: 16
                                        border.color: MouseArea.hovered ? "#E50914" : "#333333"
                                        border.width: 1

                                        RowLayout {
                                            anchors.fill: parent
                                            anchors.margins: 24
                                            spacing: 24

                                            // Thumbnail
                                            Rectangle {
                                                Layout.preferredWidth: 72
                                                Layout.preferredHeight: 72
                                                color: "#333333"
                                                radius: 12
                                                
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: modelData.thumbnail
                                                    font.pixelSize: 28
                                                    color: "#666666"
                                                }
                                            }

                                            // Content
                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                spacing: 6

                                                Text {
                                                    text: modelData.title
                                                    font.pixelSize: 18
                                                    font.weight: Font.Medium
                                                    color: "#FFFFFF"
                                                    Layout.fillWidth: true
                                                    elide: Text.ElideRight
                                                }

                                                Text {
                                                    text: modelData.subtitle
                                                    font.pixelSize: 15
                                                    color: "#B3B3B3"
                                                    Layout.fillWidth: true
                                                    elide: Text.ElideRight
                                                }

                                                // Progress Bar
                                                Rectangle {
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 6
                                                    color: "#333333"
                                                    radius: 3
                                                    visible: modelData.progress < 1.0

                                                    Rectangle {
                                                        width: parent.width * modelData.progress
                                                        height: parent.height
                                                        color: "#E50914"
                                                        radius: 3
                                                    }
                                                }
                                            }

                                            // Remove Button
                                            Button {
                                                Layout.preferredWidth: 36
                                                Layout.preferredHeight: 36
                                                Layout.alignment: Qt.AlignVCenter
                                                background: Rectangle {
                                                    color: parent.hovered ? "#E50914" : "#333333"
                                                    radius: 18
                                                    border.color: "#555555"
                                                    border.width: 1
                                                }
                                                contentItem: Text {
                                                    text: "×"
                                                    font.pixelSize: 18
                                                    color: "#FFFFFF"
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                }
                                                onClicked: removeFromHistory(modelData.id)

                                                ToolTip.visible: hovered
                                                ToolTip.text: "Remove"
                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onClicked: {
                                                if (modelData.type === "live") {
                                                    navigateTo("/player")
                                                } else if (modelData.type === "movie") {
                                                    navigateTo("/movie/" + modelData.id)
                                                } else if (modelData.type === "series") {
                                                    navigateTo("/series/details")
                                                } else if (modelData.type === "episode") {
                                                    navigateTo("/player")
                                                }
                                            }
                                        }

                                        // Hover Animation
                                        scale: MouseArea.hovered ? 1.02 : 1.0
                                        Behavior on scale {
                                            NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                                        }
                                        Behavior on border.color {
                                            ColorAnimation { duration: 200 }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Empty State
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.topMargin: 80
                        color: "transparent"
                        visible: getFilteredItems().length === 0

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 32

                            Text {
                                text: "📺"
                                font.pixelSize: 100
                                color: "#666666"
                                Layout.alignment: Qt.AlignHCenter
                            }

                            ColumnLayout {
                                spacing: 12
                                Layout.alignment: Qt.AlignHCenter

                                Text {
                                    text: "No watch history yet"
                                    font.pixelSize: 28
                                    font.bold: true
                                    color: "#FFFFFF"
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                Text {
                                    text: "Start watching content to build your history"
                                    font.pixelSize: 16
                                    color: "#B3B3B3"
                                    Layout.alignment: Qt.AlignHCenter
                                }
                            }

                            RowLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 20

                                Button {
                                    text: "Browse Live TV"
                                    Layout.preferredHeight: 48
                                    Layout.preferredWidth: 160
                                    background: Rectangle {
                                        color: parent.hovered ? "#F5191F" : "#E50914"
                                        radius: 12
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 16
                                        font.bold: true
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: navigateTo("/live/groups")
                                }

                                Button {
                                    text: "Browse Movies"
                                    Layout.preferredHeight: 48
                                    Layout.preferredWidth: 160
                                    background: Rectangle {
                                        color: "transparent"
                                        radius: 12
                                        border.color: "#666666"
                                        border.width: 2
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 16
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: navigateTo("/movies")
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Clear All Confirmation Dialog
    Rectangle {
        anchors.fill: parent
        color: showClearDialog ? "#000000E6" : "transparent"
        visible: showClearDialog
        z: 9999

        Behavior on color {
            ColorAnimation { duration: 200; easing.type: Easing.OutQuad }
        }

        Rectangle {
            width: 480
            height: childrenRect.height + 56
            anchors.centerIn: parent
            color: "#1F1F1F"
            radius: 20
            border.color: "#404040"
            border.width: 1

            // Enhanced Shadow with blur effect
            Rectangle {
                anchors.fill: parent
                anchors.margins: -12
                radius: parent.radius + 6
                color: "#00000080"
                z: -1
                
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -8
                    radius: parent.radius + 4
                    color: "#00000040"
                    z: -1
                }
            }

            // Scale and fade animation
            scale: showClearDialog ? 1.0 : 0.85
            opacity: showClearDialog ? 1.0 : 0.0

            Behavior on scale {
                NumberAnimation { duration: 250; easing.type: Easing.OutBack }
            }
            Behavior on opacity {
                NumberAnimation { duration: 250; easing.type: Easing.OutQuad }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 32
                spacing: 24

                // Warning Icon
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 64
                    Layout.preferredHeight: 64
                    color: "#E5091415"
                    radius: 32
                    border.color: "#E5091433"
                    border.width: 2

                    Text {
                        anchors.centerIn: parent
                        text: "⚠️"
                        font.pixelSize: 32
                        color: "#E50914"
                    }
                }

                // Title
                Text {
                    text: "Clear All History"
                    font.pixelSize: 24
                    font.weight: Font.Bold
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 8
                }

                // Divider
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#404040"
                    Layout.topMargin: 4
                }

                // Description
                Text {
                    text: "This will permanently remove all items from your watch history.\nThis action cannot be undone."
                    font.pixelSize: 15
                    color: "#B8B8B8"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    Layout.maximumWidth: 380
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    lineHeight: 1.4
                }

                // Buttons
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 32
                    spacing: 16

                    Button {
                        text: "Cancel"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 48
                        background: Rectangle {
                            color: parent.hovered ? "#2D2D2D" : "transparent"
                            radius: 14
                            border.color: parent.hovered ? "#FFFFFF" : "#666666"
                            border.width: 2
                            
                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                            Behavior on border.color {
                                ColorAnimation { duration: 150 }
                            }
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 16
                            font.weight: Font.Medium
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: showClearDialog = false
                    }

                    Button {
                        text: "Clear All"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 48
                        background: Rectangle {
                            color: parent.hovered ? "#CC0810" : "#E50914"
                            radius: 14
                            border.color: parent.hovered ? "#FF1A1A" : "#E50914"
                            border.width: 1
                            
                            // Subtle glow effect
                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: -2
                                radius: parent.radius + 2
                                color: "transparent"
                                border.color: parent.parent.hovered ? "#E5091466" : "transparent"
                                border.width: 2
                                opacity: parent.parent.hovered ? 0.8 : 0
                                
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                            
                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 16
                            font.weight: Font.Bold
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: clearAllHistory()
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: showClearDialog = false
        }
    }

    // Close dropdowns on background click
    MouseArea {
        anchors.fill: parent
        enabled: showFiltersDropdown
        onClicked: showFiltersDropdown = false
    }

    // Keyboard shortcuts
    Keys.onEscapePressed: {
        if (showClearDialog) {
            showClearDialog = false
        } else if (showFiltersDropdown) {
            showFiltersDropdown = false
        } else {
            navigateTo("/home")
        }
    }
}