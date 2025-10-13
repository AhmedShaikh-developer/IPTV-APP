import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: recordScheduleForm
    color: "#000000"

    property bool isProgramMode: true
    property var programData: null

    // Mock data
    property var channels: [
        { id: "1", name: "BBC One", logo: "📺" },
        { id: "2", name: "BBC Two", logo: "📺" },
        { id: "3", name: "ITV", logo: "📺" },
        { id: "4", name: "Channel 4", logo: "📺" },
        { id: "5", name: "Sky Sports", logo: "⚽" },
        { id: "6", name: "Discovery", logo: "🌍" }
    ]

    property string selectedChannel: "1"
    property string recordingTitle: ""
    property date recordingDate: new Date()
    property string startTime: "20:00"
    property string endTime: "21:00"
    property string keepUntil: "Forever"
    property int prePadding: 2
    property int postPadding: 2
    property string quality: "Auto"
    property string repeat: "Once"

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function validateForm() {
        if (recordingTitle.trim() === "") return false
        if (startTime >= endTime) return false
        return true
    }

    function scheduleRecording() {
        if (!validateForm()) return
        
        // Mock toast notification
        console.log("Recording scheduled:", recordingTitle)
        navigateTo("/record/scheduled")
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: Math.min(800, parent.width - 80)
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

                    ColumnLayout {
                        Layout.alignment: Qt.AlignVCenter
                        spacing: 4

                        Text {
                            text: "Schedule Recording"
                            font.pixelSize: 28
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        Text {
                            text: "UI-only mock recording scheduler"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                        }
                    }

                    Item { Layout.fillWidth: true }
                }
            }

            // Main Form Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height + 48
                color: "#1A1A1A"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 32
                    spacing: 24

                    // Tab Selection
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 48
                        color: "#333333"
                        radius: 12

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 4
                            spacing: 0

                            Button {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                background: Rectangle {
                                    color: isProgramMode ? "#E50914" : "transparent"
                                    radius: 8
                                }
                                contentItem: Text {
                                    text: "Program"
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: isProgramMode = true
                            }

                            Button {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                background: Rectangle {
                                    color: !isProgramMode ? "#E50914" : "transparent"
                                    radius: 8
                                }
                                contentItem: Text {
                                    text: "Manual"
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: isProgramMode = false
                            }
                        }
                    }

                    // Form Fields
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        // Channel Selection
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Channel"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            ComboBox {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 48
                                model: channels
                                currentIndex: channels.findIndex(c => c.id === selectedChannel)
                                
                                background: Rectangle {
                                    color: "#333333"
                                    radius: 8
                                    border.color: "#555555"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: channels[currentIndex] ? channels[currentIndex].name : ""
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 16
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onCurrentIndexChanged: {
                                    if (currentIndex >= 0) {
                                        selectedChannel = channels[currentIndex].id
                                    }
                                }
                            }
                        }

                        // Title Field
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Recording Title"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            TextField {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 48
                                text: recordingTitle
                                placeholderText: "Enter recording title"
                                
                                background: Rectangle {
                                    color: "#333333"
                                    radius: 8
                                    border.color: parent.activeFocus ? "#E50914" : "#555555"
                                    border.width: 1
                                }

                                color: "#FFFFFF"
                                font.pixelSize: 14
                                leftPadding: 16
                                rightPadding: 16

                                onTextChanged: recordingTitle = text
                            }
                        }

                        // Date and Time Row
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            // Date
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Date"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    text: recordingDate.toLocaleDateString()
                                    
                                    background: Rectangle {
                                        color: "#333333"
                                        radius: 8
                                        border.color: parent.activeFocus ? "#E50914" : "#555555"
                                        border.width: 1
                                    }

                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 16
                                    rightPadding: 16
                                }
                            }

                            // Start Time
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Start Time"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    text: startTime
                                    placeholderText: "HH:MM"
                                    
                                    background: Rectangle {
                                        color: "#333333"
                                        radius: 8
                                        border.color: parent.activeFocus ? "#E50914" : "#555555"
                                        border.width: 1
                                    }

                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 16
                                    rightPadding: 16

                                    onTextChanged: startTime = text
                                }
                            }

                            // End Time
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "End Time"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    text: endTime
                                    placeholderText: "HH:MM"
                                    
                                    background: Rectangle {
                                        color: "#333333"
                                        radius: 8
                                        border.color: parent.activeFocus ? "#E50914" : "#555555"
                                        border.width: 1
                                    }

                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 16
                                    rightPadding: 16

                                    onTextChanged: endTime = text
                                }
                            }
                        }

                        // Validation Error
                        Text {
                            text: startTime >= endTime ? "End time must be after start time" : ""
                            font.pixelSize: 12
                            color: "#E50914"
                            visible: startTime >= endTime
                        }
                    }

                    // Options Section
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: "#333333"
                    }

                    Text {
                        text: "Recording Options"
                        font.pixelSize: 16
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                    }

                    // Options Grid
                    GridLayout {
                        Layout.fillWidth: true
                        columns: 2
                        rowSpacing: 16
                        columnSpacing: 24

                        // Keep Until
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Keep Until"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            ComboBox {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                model: ["Forever", "Until Watched", "1 Week", "1 Month"]
                                currentIndex: 0
                                
                                background: Rectangle {
                                    color: "#333333"
                                    radius: 8
                                    border.color: "#555555"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: model[currentIndex]
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onCurrentIndexChanged: keepUntil = model[currentIndex]
                            }
                        }

                        // Quality
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Quality"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            ComboBox {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                model: ["Auto", "HD", "SD"]
                                currentIndex: 0
                                
                                background: Rectangle {
                                    color: "#333333"
                                    radius: 8
                                    border.color: "#555555"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: model[currentIndex]
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onCurrentIndexChanged: quality = model[currentIndex]
                            }
                        }

                        // Pre-Padding
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Pre-Padding"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            ComboBox {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                model: ["0 min", "2 min", "5 min", "10 min"]
                                currentIndex: 1
                                
                                background: Rectangle {
                                    color: "#333333"
                                    radius: 8
                                    border.color: "#555555"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: model[currentIndex]
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onCurrentIndexChanged: prePadding = [0, 2, 5, 10][currentIndex]
                            }
                        }

                        // Post-Padding
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Post-Padding"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            ComboBox {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                model: ["0 min", "2 min", "5 min", "10 min"]
                                currentIndex: 1
                                
                                background: Rectangle {
                                    color: "#333333"
                                    radius: 8
                                    border.color: "#555555"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: model[currentIndex]
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onCurrentIndexChanged: postPadding = [0, 2, 5, 10][currentIndex]
                            }
                        }
                    }

                    // Storage Info
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 80
                        color: "#333333"
                        radius: 12

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 8

                            Text {
                                text: "Storage"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "Available: 2.1 TB"
                                    font.pixelSize: 12
                                    color: "#B3B3B3"
                                }

                                Text {
                                    text: "Used: 847 GB"
                                    font.pixelSize: 12
                                    color: "#B3B3B3"
                                }

                                Item { Layout.fillWidth: true }

                                Rectangle {
                                    Layout.preferredWidth: 120
                                    Layout.preferredHeight: 6
                                    color: "#555555"
                                    radius: 3

                                    Rectangle {
                                        width: parent.width * 0.4
                                        height: parent.height
                                        color: "#E50914"
                                        radius: 3
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Footer Buttons
            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 16
                spacing: 16

                Item { Layout.fillWidth: true }

                Button {
                    text: "Cancel"
                    Layout.preferredHeight: 48
                    Layout.preferredWidth: 120
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
                    onClicked: navigateTo("/home")
                }

                Button {
                    text: "Schedule"
                    Layout.preferredHeight: 48
                    Layout.preferredWidth: 120
                    enabled: validateForm()
                    background: Rectangle {
                        color: parent.enabled ? (parent.hovered ? "#CC0810" : "#E50914") : "#444444"
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
                    onClicked: scheduleRecording()
                }
            }
        }
    }
}
