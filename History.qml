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

    // Responsive dimensions
    readonly property real maxContentWidth: {
        if (isDesktop) return Math.min(1280, screenWidth * 0.8)
        if (isTablet) return Math.min(1100, screenWidth * 0.85)
        return screenWidth - 40
    }
    readonly property real contentPadding: isDesktop ? 40 : (isTablet ? 32 : 20)

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
            width: {
                if (screenWidth >= 1920) return Math.min(1200, parent.width - 96)
                if (screenWidth >= 1366) return Math.min(1100, parent.width - 64)
                if (screenWidth <= 1024) return parent.width - 32
                return Math.min(1000, parent.width - 48)
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: {
                if (screenWidth <= 1024) return 16
                if (screenWidth >= 1920) return 48
                return 32
            }
            spacing: 24

            // Header Row
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                Layout.topMargin: 32
                spacing: 20

                Button {
                    width: 48
                    height: 48
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
                    text: "Recently Watched"
                    font.pixelSize: 28
                    font.weight: Font.Bold
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignVCenter
                }

                Item { Layout.fillWidth: true }

                Button {
                    text: "Clear All"
                    Layout.preferredHeight: 44
                    Layout.preferredWidth: 100
                    background: Rectangle {
                        color: parent.hovered ? "#E50914" : "#444444"
                        radius: 12
                        border.color: parent.hovered ? "#E50914" : "#666666"
                        border.width: 1
                        
                        // Subtle glow effect on hover
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -2
                            radius: parent.radius + 2
                            color: "transparent"
                            border.color: parent.parent.hovered ? "#E50914" : "transparent"
                            border.width: 1
                            opacity: parent.parent.hovered ? 0.3 : 0
                            
                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                        }
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

            // Sort & Filter Bar
            RowLayout {
                Layout.fillWidth: true
                spacing: 16

                Text {
                    text: "Sort by:"
                    font.pixelSize: 14
                    color: "#B3B3B3"
                }

                // Sort chips
                RowLayout {
                    spacing: 12
                    
                    Repeater {
                        model: ["Most Recent", "Alphabetical"]
                        delegate: Button {
                            text: modelData
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 120
                            padding: 0
                            background: Rectangle {
                                color: currentSort === modelData ? "#E50914" : "transparent"
                                radius: 18
                                border.color: currentSort === modelData ? "#E50914" : "#666666"
                                border.width: 2
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#FFFFFF"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                currentSort = modelData
                            }
                        }
                    }
                }

                Item { Layout.fillWidth: true }

                // Filters dropdown
                Button {
                    text: "Filters"
                    Layout.preferredHeight: 36
                    Layout.preferredWidth: 80
                    padding: 0
                    background: Rectangle {
                        color: parent.hovered ? "#2A2A2A" : "transparent"
                        radius: 18
                        border.color: "#666666"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: showFiltersDropdown = !showFiltersDropdown

                    // Glass dropdown
                    Rectangle {
                        anchors.top: parent.bottom
                        anchors.right: parent.right
                        anchors.topMargin: 8
                        width: 220
                        height: childrenRect.height + 16
                        color: "#181818D0"
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
                                    Layout.preferredHeight: 32
                                    padding: 0
                                    background: Rectangle {
                                        color: "transparent"
                                    }
                                    contentItem: RowLayout {
                                        spacing: 12

                                        Rectangle {
                                            width: 16
                                            height: 16
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
                                            // Remove "All" if specific filters are selected
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

            // History List - Grouped by date
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ColumnLayout {
                    width: {
                        if (screenWidth >= 1920) return Math.min(1200, parent.width)
                        if (screenWidth >= 1366) return Math.min(1100, parent.width)
                        if (screenWidth <= 1024) return parent.width - 32
                        return Math.min(1000, parent.width)
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 24

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
                            spacing: 16

                            // Date header with divider
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.topMargin: 24
                                spacing: 12

                                Text {
                                    text: modelData.name
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "#B3B3B3"
                                    Layout.leftMargin: 64 // Align with card text, not icons
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    color: "#333333"
                                }
                            }

                            // Items in this group
                            Repeater {
                                model: modelData.items

                                delegate: Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 80
                                    Layout.maximumWidth: {
                                        if (screenWidth >= 1920) return 1100
                                        if (screenWidth >= 1366) return 1000
                                        return parent.width - 40
                                    }
                                    Layout.alignment: Qt.AlignHCenter
                                    color: "#151515"
                                    radius: 12
                                    border.color: MouseArea.hovered ? "#E50914" : "#2A2A2A"
                                    border.width: 1

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 20
                                        spacing: 20

                                        // Left: Square icon tile
                                        Rectangle {
                                            Layout.preferredWidth: 64
                                            Layout.preferredHeight: 64
                                            Layout.alignment: Qt.AlignVCenter
                                            color: "#333333"
                                            radius: 8
                                            
                                            Text {
                                                anchors.centerIn: parent
                                                text: modelData.thumbnail
                                                font.pixelSize: 24
                                                color: "#666666"
                                            }
                                        }

                                        // Center: Text content
                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            Layout.alignment: Qt.AlignVCenter
                                            spacing: 4

                                            Text {
                                                text: modelData.title
                                                font.pixelSize: 16
                                                font.weight: Font.Medium
                                                color: "#FFFFFF"
                                                wrapMode: Text.WordWrap
                                                Layout.fillWidth: true
                                                elide: Text.ElideRight
                                            }

                                            Text {
                                                text: modelData.subtitle
                                                font.pixelSize: 14
                                                font.weight: Font.Normal
                                                color: "#B3B3B3"
                                                Layout.fillWidth: true
                                                elide: Text.ElideRight
                                            }

                                            // Progress bar (if available)
                                            Rectangle {
                                                Layout.fillWidth: true
                                                Layout.preferredHeight: 4
                                                color: "#333333"
                                                radius: 2
                                                visible: modelData.progress < 1.0

                                                Rectangle {
                                                    width: parent.width * modelData.progress
                                                    height: parent.height
                                                    color: "#E50914"
                                                    radius: 2
                                                }
                                            }
                                        }

                                        // Right: Remove button
                                        Button {
                                            Layout.preferredWidth: 32
                                            Layout.preferredHeight: 32
                                            Layout.alignment: Qt.AlignVCenter
                                            background: Rectangle {
                                                color: parent.hovered ? "#E50914" : "#2A2A2A"
                                                radius: 16
                                                border.color: "#444444"
                                                border.width: 1
                                            }
                                            contentItem: Text {
                                                text: "×"
                                                font.pixelSize: 16
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
                                            // Navigate to appropriate page based on type
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

                                    // Hover animations
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
            }

            // Empty State
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                visible: getFilteredItems().length === 0

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 24

                    Text {
                        text: "📺"
                        font.pixelSize: 80
                        color: "#666666"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: "No watch history yet."
                        font.pixelSize: isDesktop ? 28 : 24
                        font.bold: true
                        color: "#FFFFFF"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: "Start watching Live TV or Movies."
                        font.pixelSize: 16
                        color: "#B3B3B3"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 16

                        Button {
                            text: "Browse Live TV"
                            Layout.preferredHeight: 44
                            Layout.preferredWidth: 140
                            background: Rectangle {
                                color: parent.hovered ? "#F5191F" : "#E50914"
                                radius: 12
                                border.color: parent.activeFocus ? "#FFFFFF" : "transparent"
                                border.width: parent.activeFocus ? 2 : 0
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
                            Layout.preferredHeight: 44
                            Layout.preferredWidth: 140
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

    // Clear All Confirmation Dialog
    Rectangle {
        anchors.fill: parent
        color: showClearDialog ? "#000000BF" : "transparent"
        visible: showClearDialog
        z: 9999

        // Fade animation
        Behavior on color {
            ColorAnimation { duration: 150; easing.type: Easing.OutQuad }
        }

        Rectangle {
            width: {
                if (screenWidth >= 1920) return 440
                if (screenWidth >= 1366) return 400
                return Math.min(screenWidth * 0.8, 360)
            }
            height: childrenRect.height + 48
            anchors.centerIn: parent
            anchors.margins: screenWidth >= 1920 ? screenWidth * 0.25 : 0
            color: "#181818"
            radius: 16
            border.color: "#333333"
            border.width: 1

            // Soft shadow
            Rectangle {
                anchors.fill: parent
                anchors.margins: -8
                radius: parent.radius + 4
                color: "#00000099"
                z: -1
            }

            // Scale animation
            scale: showClearDialog ? 1.0 : 0.9
            opacity: showClearDialog ? 1.0 : 0.0

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

                // Header with divider
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Text {
                        text: "Clear All History"
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
                }

                // Body text
                Text {
                    text: "This will remove all items from your watch history. This action cannot be undone."
                    font.pixelSize: 14
                    color: "#B3B3B3"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 16
                    Layout.maximumWidth: 360
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }

                // Buttons
                GridLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 8
                    columns: screenWidth <= 1280 ? 1 : 2
                    rowSpacing: 16
                    columnSpacing: 16

                    Button {
                        text: "Cancel"
                        Layout.preferredWidth: screenWidth <= 1280 ? Layout.fillWidth : 140
                        Layout.fillWidth: screenWidth <= 1280
                        Layout.preferredHeight: 44
                        background: Rectangle {
                            color: parent.hovered ? "#2A2A2A" : "transparent"
                            radius: 12
                            border.color: parent.hovered ? "#FFFFFF" : "#666666"
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
                        onClicked: showClearDialog = false
                    }

                    Button {
                        text: "Clear All"
                        Layout.preferredWidth: screenWidth <= 1280 ? Layout.fillWidth : 140
                        Layout.fillWidth: screenWidth <= 1280
                        Layout.preferredHeight: 44
                        background: Rectangle {
                            color: parent.hovered ? "#CC0810" : "#E50914"
                            radius: 12
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 15
                            font.weight: Font.Medium
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
