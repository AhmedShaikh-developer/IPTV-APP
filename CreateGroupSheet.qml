import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: createGroupSheet
    color: "#00000000"

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
    readonly property bool isSmallMobile: screenWidth <= 1024

    // Responsive dimensions
    readonly property real modalWidth: {
        if (isDesktop) return Math.min(900, screenWidth * 0.7)
        if (isTablet) return Math.min(800, screenWidth * 0.8)
        if (isSmallMobile) return screenWidth - 40
        return Math.min(700, screenWidth * 0.85)
    }
    readonly property real modalHeight: Math.min(700, screenHeight * 0.85)
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

    // Glass overlay background with blur effect
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.6
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00000030" }
            GradientStop { position: 0.5; color: "#00000070" }
            GradientStop { position: 1.0; color: "#00000030" }
        }
    }

    // Fade-in animation
    OpacityAnimator {
        target: createGroupSheet
        from: 0.0
        to: 1.0
        duration: 200
        running: true
    }

    // Modal content with slide-up animation
    Rectangle {
        id: modalContainer
        width: modalWidth
        height: modalHeight
        anchors.centerIn: parent
        color: "#111111EE"
        radius: 16
        border.color: "#333333"
        border.width: 1

        // Soft drop shadow
        Rectangle {
            anchors.fill: parent
            anchors.margins: -12
            radius: parent.radius + 12
            color: "#00000040"
            z: -1
        }

        // Slide-up animation
        NumberAnimation {
            target: modalContainer
            property: "y"
            from: parent.height
            to: modalContainer.y
            duration: 250
            easing.type: Easing.OutCubic
            running: true
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 32
            spacing: 0

            // Header Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
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
                            font.pixelSize: isDesktop ? 28 : 24
                            font.bold: true
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Item { Layout.fillWidth: true }

                        Button {
                            width: 40
                            height: 40
                            background: Rectangle {
                                color: parent.hovered ? "#2A2A2A" : "transparent"
                                radius: 20
                                border.color: "#666666"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: "×"
                                font.pixelSize: 24
                                color: "#FFFFFF"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: cancelled()
                        }
                    }

                    // Subtext
                    Text {
                        text: "Select channels to include in this group"
                        font.pixelSize: 16
                        color: "#B3B3B3"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Group Name Input
            ColumnLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                spacing: 12

                Text {
                    text: "Group Name"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#FFFFFF"
                }

                TextField {
                    id: nameField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    placeholderText: "Enter group name"
                    placeholderTextColor: "#888888"
                    color: "#FFFFFF"
                    font.pixelSize: 16
                    background: Rectangle {
                        color: "#1B1B1B"
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
                    Layout.preferredHeight: 60
                    color: "transparent"

                    RowLayout {
                        anchors.fill: parent
                        spacing: 16

                        TextField {
                            id: searchField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 44
                            placeholderText: "Search channels..."
                            placeholderTextColor: "#888888"
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            background: Rectangle {
                                color: "#1B1B1B"
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
                            Layout.preferredHeight: 44
                            Layout.preferredWidth: 120
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
                    Layout.maximumHeight: 400
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
                                Layout.preferredHeight: 56
                                padding: 0
                                background: Rectangle {
                                    color: selectedChannels.includes(modelData) ? "#E50914" : "#333333"
                                    radius: 12
                                    border.color: selectedChannels.includes(modelData) ? "#FFFFFF" : "#444444"
                                    border.width: selectedChannels.includes(modelData) ? 2 : 1
                                    
                                    // Subtle elevation for selected state
                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.margins: -2
                                        radius: parent.radius + 2
                                        color: "#00000020"
                                        z: -1
                                        visible: selectedChannels.includes(modelData)
                                    }
                                }
                                contentItem: RowLayout {
                                    spacing: 12
                                    anchors.centerIn: parent
                                    anchors.margins: 16

                                    // Circular checkbox
                                    Rectangle {
                                        width: 24
                                        height: 24
                                        radius: 12
                                        color: selectedChannels.includes(modelData) ? "#FFFFFF" : "transparent"
                                        border.color: "#FFFFFF"
                                        border.width: 2

                                        Text {
                                            anchors.centerIn: parent
                                            text: "✓"
                                            font.pixelSize: 14
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
                                scale: parent.hovered ? 1.02 : 1.0
                                Behavior on scale {
                                    NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                                }
                                Behavior on opacity {
                                    NumberAnimation { duration: 150 }
                                }
                            }
                        }
                    }
                }
            }

            // Sticky Footer Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    spacing: 20

                    Text {
                        text: selectedChannels.length + " channels selected"
                        font.pixelSize: 14
                        color: "#B3B3B3"
                    }

                    Item { Layout.fillWidth: true }

                    Button {
                        text: "Cancel"
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 48
                        background: Rectangle {
                            color: "transparent"
                            radius: 24
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
                        Layout.preferredWidth: 160
                        Layout.preferredHeight: 48
                        enabled: groupName.trim() !== "" && selectedChannels.length > 0
                        background: Rectangle {
                            color: parent.hovered ? "#F5191F" : "#E50914"
                            radius: 24
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
