import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: createGroupSheet
    anchors.fill: parent
    color: "#00000000"
    z: 9999

    property string groupName: ""
    property var selectedChannels: []
    property var availableChannels: [
        "BBC News HD", "CNN International", "ESPN Sports", "Discovery Channel",
        "HBO", "Netflix", "Disney Channel", "Cartoon Network", "National Geographic",
        "History Channel", "MTV", "VH1", "Comedy Central", "Animal Planet",
        "Food Network", "HGTV", "TLC", "Lifetime", "Hallmark Channel", "FX"
    ]

    property var filteredChannels: availableChannels
    property string searchQuery: ""

    signal confirmed(string name, var channels)
    signal cancelled()

    // Responsive breakpoints
    readonly property real screenWidth: parent.width
    readonly property real screenHeight: parent.height
    readonly property bool isDesktop: screenWidth >= 1920
    readonly property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    readonly property bool isMobile: screenWidth < 1366

    // Responsive dimensions
    readonly property real modalWidth: {
        if (isDesktop) return Math.min(900, screenWidth * 0.7)
        if (isTablet) return Math.min(800, screenWidth * 0.8)
        return Math.min(700, screenWidth * 0.9)
    }
    readonly property real modalHeight: Math.min(600, screenHeight * 0.8)
    readonly property real gridColumns: {
        if (isDesktop) return 4
        if (isTablet) return 3
        return 2
    }

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function filterChannels() {
        if (searchQuery.trim() === "") {
            filteredChannels = availableChannels
        } else {
            filteredChannels = availableChannels.filter(function(channel) {
                return channel.toLowerCase().includes(searchQuery.toLowerCase())
            })
        }
    }

    // Backdrop overlay - dims background content
    Rectangle {
        id: backdropOverlay
        anchors.fill: parent
        color: "#000000CC"
        z: 1
    }

    // Fade-in animation for backdrop
    OpacityAnimator {
        target: backdropOverlay
        from: 0.0
        to: 1.0
        duration: 150
        running: true
    }

    // Modal content - perfectly centered
    Rectangle {
        id: modalContainer
        width: modalWidth
        height: modalHeight
        anchors.centerIn: parent
        color: "#111111"
        radius: 16
        border.color: "#333333"
        border.width: 1
        z: 2

        // Soft drop shadow
        Rectangle {
            anchors.fill: parent
            anchors.margins: -12
            radius: parent.radius + 12
            color: "#00000060"
            z: -1
        }

        // Scale and fade-in animation
        NumberAnimation {
            target: modalContainer
            property: "scale"
            from: 0.8
            to: 1.0
            duration: 200
            easing.type: Easing.OutCubic
            running: true
        }

        OpacityAnimator {
            target: modalContainer
            from: 0.0
            to: 1.0
            duration: 200
            running: true
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 0

            // Header Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "transparent"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 8

                    // Title and close button row
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        Text {
                            text: "Create Group"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Item { Layout.fillWidth: true }

                        Button {
                            width: 36
                            height: 36
                            background: Rectangle {
                                color: parent.hovered ? "#2A2A2A" : "transparent"
                                radius: 18
                                border.color: "#666666"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: "×"
                                font.pixelSize: 20
                                color: "#FFFFFF"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: cancelled()
                        }
                    }

                    // Subtext
                    Text {
                        text: "Select channels to include"
                        font.pixelSize: 14
                        color: "#B3B3B3"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Group Name Input
            ColumnLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                spacing: 8

                Text {
                    text: "Group Name"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#FFFFFF"
                }

                TextField {
                    id: nameField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 44
                    placeholderText: "Enter group name"
                    placeholderTextColor: "#888888"
                    color: "#FFFFFF"
                    font.pixelSize: 16
                    background: Rectangle {
                        color: "#171717"
                        radius: 12
                        border.color: nameField.activeFocus ? "#E50914" : "#333333"
                        border.width: 2
                    }
                    onTextChanged: groupName = text
                }
            }

            // Channel Selection
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 16

                // Sticky Filter Bar
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    color: "transparent"

                    RowLayout {
                        anchors.fill: parent
                        spacing: 12

                        TextField {
                            id: searchField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 36
                            placeholderText: "Search channels..."
                            placeholderTextColor: "#888888"
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            background: Rectangle {
                                color: "#171717"
                                radius: 12
                                border.color: searchField.activeFocus ? "#E50914" : "#333333"
                                border.width: 2
                            }
                            onTextChanged: {
                                searchQuery = text
                                filterChannels()
                            }
                        }

                        Button {
                            text: selectedChannels.length === availableChannels.length ? "Deselect All" : "Select All"
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 110
                            padding: 0
                            background: Rectangle {
                                color: parent.hovered ? "#2A2A2A" : "#444444"
                                radius: 12
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
                                if (selectedChannels.length === availableChannels.length) {
                                    selectedChannels = []
                                } else {
                                    selectedChannels = availableChannels.slice()
                                }
                            }
                        }
                    }
                }

                // Channel List - Scrollable area
                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.maximumHeight: 300
                    clip: true

                    GridLayout {
                        width: parent.width
                        columns: gridColumns
                        columnSpacing: 16
                        rowSpacing: 16

                        Repeater {
                            model: filteredChannels
                            delegate: Button {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 48
                                padding: 0
                                background: Rectangle {
                                    color: selectedChannels.includes(modelData) ? "#E50914" : "#171717"
                                    radius: 12
                                    border.color: selectedChannels.includes(modelData) ? "#FFFFFF" : "#444444"
                                    border.width: selectedChannels.includes(modelData) ? 2 : 1
                                }
                                contentItem: RowLayout {
                                    spacing: 10
                                    anchors.centerIn: parent
                                    anchors.margins: 12

                                    // Circular checkbox
                                    Rectangle {
                                        width: 20
                                        height: 20
                                        radius: 10
                                        color: selectedChannels.includes(modelData) ? "#FFFFFF" : "transparent"
                                        border.color: "#FFFFFF"
                                        border.width: 2

                                        Text {
                                            anchors.centerIn: parent
                                            text: "✓"
                                            font.pixelSize: 12
                                            color: "#E50914"
                                            visible: selectedChannels.includes(modelData)
                                        }
                                    }

                                    Text {
                                        text: modelData
                                        color: "#FFFFFF"
                                        font.pixelSize: 14
                                        font.bold: selectedChannels.includes(modelData)
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                    }
                                }
                                onClicked: {
                                    if (selectedChannels.includes(modelData)) {
                                        selectedChannels = selectedChannels.filter(ch => ch !== modelData)
                                    } else {
                                        selectedChannels.push(modelData)
                                    }
                                }

                                // Hover animations
                                scale: parent.hovered ? 1.05 : 1.0
                                Behavior on scale {
                                    NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                                }
                            }
                        }
                    }
                }
            }

            // Sticky Footer Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    spacing: 16

                    Text {
                        text: selectedChannels.length + " channels selected"
                        font.pixelSize: 14
                        color: "#B3B3B3"
                    }

                    Item { Layout.fillWidth: true }

                    Button {
                        text: "Cancel"
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 44
                        background: Rectangle {
                            color: "transparent"
                            radius: 12
                            border.color: "#FFFFFF"
                            border.width: 2
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: cancelled()
                    }

                    Button {
                        text: "Create Group"
                        Layout.preferredWidth: 140
                        Layout.preferredHeight: 44
                        enabled: groupName.trim() !== "" && selectedChannels.length > 0
                        background: Rectangle {
                            color: parent.hovered ? "#F5191F" : "#E50914"
                            radius: 12
                            opacity: parent.enabled ? 1.0 : 0.5
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
                        onClicked: {
                            if (groupName.trim() !== "" && selectedChannels.length > 0) {
                                confirmed(groupName.trim(), selectedChannels)
                            }
                        }
                    }
                }
            }
        }
    }

    // Close on background click
    MouseArea {
        anchors.fill: parent
        onClicked: cancelled()
    }

    // Keyboard shortcuts
    Keys.onEscapePressed: cancelled()
    Keys.onReturnPressed: {
        if (groupName.trim() !== "" && selectedChannels.length > 0) {
            confirmed(groupName.trim(), selectedChannels)
        }
    }

    Component.onCompleted: {
        forceActiveFocus()
    }
}
