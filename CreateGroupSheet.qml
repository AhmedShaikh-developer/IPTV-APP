import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: createGroupSheet
    color: "#000000CC" // Semi-transparent background

    property string groupName: ""
    property var selectedChannels: []
    property var availableChannels: [
        "BBC News HD", "CNN International", "ESPN Sports", "Discovery Channel",
        "HBO", "Netflix", "Disney Channel", "Cartoon Network", "National Geographic",
        "History Channel", "MTV", "VH1", "Comedy Central", "Animal Planet",
        "Food Network", "HGTV", "TLC", "Lifetime", "Hallmark Channel", "FX"
    ]

    signal confirmed(string name, var channels)
    signal cancelled()

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    // Background blur effect
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.8
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00000040" }
            GradientStop { position: 0.5; color: "#00000080" }
            GradientStop { position: 1.0; color: "#00000040" }
        }
    }

    // Modal content
    Rectangle {
        width: Math.min(600, parent.width * 0.8)
        height: Math.min(500, parent.height * 0.8)
        anchors.centerIn: parent
        color: "#111111"
        radius: 12
        border.color: "#333333"
        border.width: 1

        // Subtle shadow
        Rectangle {
            anchors.fill: parent
            anchors.margins: -4
            radius: parent.radius + 4
            color: "#00000080"
            z: -1
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20

            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 20

                Text {
                    text: "Create Channel Group"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }

                Button {
                    width: 32
                    height: 32
                    background: Rectangle {
                        color: parent.hovered ? "#2A2A2A" : "transparent"
                        radius: 16
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

            // Group Name Input
            ColumnLayout {
                Layout.fillWidth: true
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
                    placeholderText: "Enter group name..."
                    placeholderTextColor: "#888888"
                    color: "#FFFFFF"
                    font.pixelSize: 16
                    background: Rectangle {
                        color: "#1A1A1A"
                        radius: 6
                        border.color: nameField.activeFocus ? "#E50914" : "#333333"
                        border.width: 1
                    }
                    onTextChanged: groupName = text
                }
            }

            // Channel Selection
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 8

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Text {
                        text: "Select Channels"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#FFFFFF"
                    }

                    Text {
                        text: "(" + selectedChannels.length + " selected)"
                        font.pixelSize: 14
                        color: "#B3B3B3"
                    }

                    Item { Layout.fillWidth: true }

                    Button {
                        text: selectedChannels.length === availableChannels.length ? "Deselect All" : "Select All"
                        Layout.preferredHeight: 32
                        padding: 0
                        background: Rectangle {
                            color: parent.hovered ? "#2A2A2A" : "transparent"
                            radius: 4
                            border.color: "#444444"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 12
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

                // Channel List
                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    GridLayout {
                        width: parent.width
                        columns: 2
                        columnSpacing: 12
                        rowSpacing: 8

                        Repeater {
                            model: availableChannels
                            delegate: Button {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                padding: 0
                                background: Rectangle {
                                    color: selectedChannels.includes(modelData) ? "#E50914" : "#333333"
                                    radius: 6
                                    border.color: "#444444"
                                    border.width: 1
                                }
                                contentItem: RowLayout {
                                    spacing: 8
                                    anchors.centerIn: parent

                                    Rectangle {
                                        width: 16
                                        height: 16
                                        radius: 8
                                        color: selectedChannels.includes(modelData) ? "#FFFFFF" : "transparent"
                                        border.color: "#FFFFFF"
                                        border.width: 1

                                        Text {
                                            anchors.centerIn: parent
                                            text: "✓"
                                            font.pixelSize: 10
                                            color: "#E50914"
                                            visible: selectedChannels.includes(modelData)
                                        }
                                    }

                                    Text {
                                        text: modelData
                                        color: "#FFFFFF"
                                        font.pixelSize: 14
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                                onClicked: {
                                    if (selectedChannels.includes(modelData)) {
                                        selectedChannels = selectedChannels.filter(ch => ch !== modelData)
                                    } else {
                                        selectedChannels.push(modelData)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Action Buttons
            RowLayout {
                Layout.fillWidth: true
                spacing: 16

                Button {
                    text: "Cancel"
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 44
                    background: Rectangle {
                        color: parent.hovered ? "#2A2A2A" : "transparent"
                        radius: 6
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
                    onClicked: cancelled()
                }

                Item { Layout.fillWidth: true }

                Button {
                    text: "Create Group"
                    Layout.preferredWidth: 140
                    Layout.preferredHeight: 44
                    enabled: groupName.trim() !== "" && selectedChannels.length > 0
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 6
                        opacity: parent.enabled ? 1.0 : 0.5
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
