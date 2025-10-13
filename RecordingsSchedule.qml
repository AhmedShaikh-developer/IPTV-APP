import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: recordingsSchedule
    color: "#000000"

    property string currentFilter: "All"
    property string currentSort: "Time"
    property var selectedItems: []

    // Mock scheduled recordings data
    property var scheduledRecordings: [
        { id: "1", title: "BBC News at Six", channel: "BBC One", channelLogo: "📺", date: "Today", startTime: "18:00", endTime: "18:30", status: "Queued", repeat: "Once", hasConflict: false },
        { id: "2", title: "Match of the Day", channel: "BBC One", channelLogo: "📺", date: "Today", startTime: "22:30", endTime: "23:45", status: "Queued", repeat: "Weekly", hasConflict: false },
        { id: "3", title: "The Great British Bake Off", channel: "Channel 4", channelLogo: "📺", date: "Tomorrow", startTime: "20:00", endTime: "21:30", status: "Queued", repeat: "Once", hasConflict: true },
        { id: "4", title: "Sky Sports News", channel: "Sky Sports", channelLogo: "⚽", date: "Tomorrow", startTime: "19:00", endTime: "19:30", status: "Recording", repeat: "Daily", hasConflict: false },
        { id: "5", title: "Discovery Documentary", channel: "Discovery", channelLogo: "🌍", date: "Next Week", startTime: "21:00", endTime: "22:00", status: "Failed", repeat: "Once", hasConflict: false }
    ]

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function getFilteredRecordings() {
        var filtered = scheduledRecordings
        
        if (currentFilter === "Today") {
            filtered = filtered.filter(r => r.date === "Today")
        } else if (currentFilter === "Next 7 Days") {
            filtered = filtered.filter(r => r.date === "Today" || r.date === "Tomorrow" || r.date === "Next Week")
        } else if (currentFilter === "Failed") {
            filtered = filtered.filter(r => r.status === "Failed")
        }
        
        // Sort
        if (currentSort === "Channel") {
            filtered.sort((a, b) => a.channel.localeCompare(b.channel))
        } else if (currentSort === "Title") {
            filtered.sort((a, b) => a.title.localeCompare(b.title))
        } else {
            filtered.sort((a, b) => {
                var timeA = a.startTime
                var timeB = b.startTime
                return timeA.localeCompare(timeB)
            })
        }
        
        return filtered
    }

    function cancelRecording(id) {
        scheduledRecordings = scheduledRecordings.filter(r => r.id !== id)
    }

    function cancelSelected() {
        selectedItems.forEach(id => cancelRecording(id))
        selectedItems = []
    }

    function editRecording(recording) {
        // Navigate to schedule form with prefilled data
        navigateTo("/record/schedule")
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
                        text: "Scheduled Recordings"
                        font.pixelSize: 28
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Item { Layout.fillWidth: true }

                    Button {
                        text: "Schedule New"
                        Layout.preferredHeight: 44
                        Layout.preferredWidth: 140
                        background: Rectangle {
                            color: parent.hovered ? "#CC0810" : "#E50914"
                            radius: 12
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 15
                            font.weight: Font.Bold
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: navigateTo("/record/schedule")
                    }
                }
            }

            // Filter and Sort Controls
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "transparent"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 16

                    // Filter Chips
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Text {
                            text: "Filter:"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignVCenter
                        }

                        Repeater {
                            model: ["All", "Today", "Next 7 Days", "Failed"]
                            delegate: Button {
                                text: modelData
                                Layout.preferredHeight: 32
                                Layout.preferredWidth: 100
                                background: Rectangle {
                                    color: currentFilter === modelData ? "#E50914" : "transparent"
                                    radius: 16
                                    border.color: currentFilter === modelData ? "#E50914" : "#666666"
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
                                onClicked: currentFilter = modelData
                            }
                        }
                    }

                    // Sort Options
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Text {
                            text: "Sort by:"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignVCenter
                        }

                        Repeater {
                            model: ["Time", "Channel", "Title"]
                            delegate: Button {
                                text: modelData
                                Layout.preferredHeight: 32
                                Layout.preferredWidth: 80
                                background: Rectangle {
                                    color: currentSort === modelData ? "#E50914" : "transparent"
                                    radius: 16
                                    border.color: currentSort === modelData ? "#E50914" : "#666666"
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
                                onClicked: currentSort = modelData
                            }
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
                        text: "Cancel Selected"
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
                        onClicked: cancelSelected()
                    }
                }
            }

            // Recordings List
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 16

                Repeater {
                    model: getFilteredRecordings()

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100
                        color: "#1A1A1A"
                        radius: 16
                        border.color: selectedItems.includes(modelData.id) ? "#E50914" : "#2A2A2A"
                        border.width: selectedItems.includes(modelData.id) ? 2 : 1

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 20

                            // Checkbox (for selection)
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

                            // Channel Logo with Date Badge
                            Rectangle {
                                Layout.preferredWidth: 60
                                Layout.preferredHeight: 60
                                color: "#333333"
                                radius: 8

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    spacing: 2

                                    Text {
                                        text: modelData.channelLogo
                                        font.pixelSize: 20
                                        color: "#666666"
                                        Layout.alignment: Qt.AlignHCenter
                                    }

                                    Text {
                                        text: modelData.date === "Today" ? "TODAY" : 
                                              modelData.date === "Tomorrow" ? "TOM" : "WEEK"
                                        font.pixelSize: 8
                                        font.weight: Font.Bold
                                        color: modelData.date === "Today" ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignHCenter
                                    }
                                }
                            }

                            // Content
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 4

                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 12

                                    Text {
                                        text: modelData.title
                                        font.pixelSize: 16
                                        font.weight: Font.Medium
                                        color: "#FFFFFF"
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                    }

                                    // Status indicators
                                    RowLayout {
                                        spacing: 8

                                        // Repeat badge
                                        Rectangle {
                                            Layout.preferredWidth: childrenRect.width + 8
                                            Layout.preferredHeight: 20
                                            color: "#333333"
                                            radius: 10

                                            Text {
                                                anchors.centerIn: parent
                                                text: modelData.repeat
                                                font.pixelSize: 10
                                                color: "#B3B3B3"
                                            }
                                        }

                                        // Conflict badge
                                        Rectangle {
                                            Layout.preferredWidth: childrenRect.width + 8
                                            Layout.preferredHeight: 20
                                            color: "#FF6B6B"
                                            radius: 10
                                            visible: modelData.hasConflict

                                            Text {
                                                anchors.centerIn: parent
                                                text: "CONFLICT"
                                                font.pixelSize: 9
                                                color: "#FFFFFF"
                                                font.weight: Font.Bold
                                            }
                                        }

                                        // Status dot
                                        Rectangle {
                                            Layout.preferredWidth: 12
                                            Layout.preferredHeight: 12
                                            color: {
                                                if (modelData.status === "Recording") return "#4CAF50"
                                                if (modelData.status === "Failed") return "#F44336"
                                                return "#FFC107"
                                            }
                                            radius: 6
                                        }
                                    }
                                }

                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 16

                                    Text {
                                        text: modelData.channel
                                        font.pixelSize: 14
                                        color: "#B3B3B3"
                                    }

                                    Text {
                                        text: modelData.startTime + " - " + modelData.endTime
                                        font.pixelSize: 14
                                        color: "#B3B3B3"
                                    }

                                    Text {
                                        text: modelData.status
                                        font.pixelSize: 14
                                        color: {
                                            if (modelData.status === "Recording") return "#4CAF50"
                                            if (modelData.status === "Failed") return "#F44336"
                                            return "#FFC107"
                                        }
                                        font.weight: Font.Medium
                                    }
                                }
                            }

                            // Actions
                            RowLayout {
                                spacing: 12

                                Button {
                                    text: "Edit"
                                    Layout.preferredHeight: 32
                                    Layout.preferredWidth: 60
                                    background: Rectangle {
                                        color: parent.hovered ? "#2A2A2A" : "transparent"
                                        radius: 6
                                        border.color: "#666666"
                                        border.width: 1
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: editRecording(modelData)
                                }

                                Button {
                                    text: "Cancel"
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
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: cancelRecording(modelData.id)
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

                // Empty State
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.topMargin: 80
                    color: "transparent"
                    visible: getFilteredRecordings().length === 0

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
                                text: "No scheduled recordings"
                                font.pixelSize: 24
                                font.bold: true
                                color: "#FFFFFF"
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: "Schedule your first recording to get started"
                                font.pixelSize: 16
                                color: "#B3B3B3"
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }

                        Button {
                            text: "Schedule Recording"
                            Layout.preferredHeight: 48
                            Layout.preferredWidth: 180
                            Layout.alignment: Qt.AlignHCenter
                            background: Rectangle {
                                color: parent.hovered ? "#CC0810" : "#E50914"
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
                            onClicked: navigateTo("/record/schedule")
                        }
                    }
                }
            }
        }
    }
}
