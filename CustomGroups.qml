import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: customGroupsScreen
    color: "#000000"

    property var customGroups: [
        { id: "1", name: "My Sports", channelCount: 8, channels: ["ESPN", "Fox Sports", "NFL Network", "NBA TV"] },
        { id: "2", name: "News & Weather", channelCount: 5, channels: ["BBC News", "CNN", "Weather Channel", "Sky News"] },
        { id: "3", name: "Kids & Family", channelCount: 6, channels: ["Disney Channel", "Cartoon Network", "Nickelodeon"] }
    ]

    property bool showCreateGroup: false

    // Responsive breakpoints
    readonly property real screenWidth: parent.width
    readonly property bool isDesktop: screenWidth >= 1440
    readonly property bool isTablet: screenWidth >= 1080 && screenWidth < 1440
    readonly property bool isMobile: screenWidth < 1080

    // Responsive dimensions
    readonly property real maxContentWidth: isDesktop ? 1200 : Math.min(1200, screenWidth - 80)
    readonly property real cardSpacing: isDesktop ? 24 : 16
    readonly property real contentPadding: isDesktop ? 40 : (isTablet ? 32 : 20)

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function deleteGroup(id) {
        customGroups = customGroups.filter(group => group.id !== id)
    }

    function addGroup(name, channels) {
        var newGroup = {
            id: (customGroups.length + 1).toString(),
            name: name,
            channelCount: channels.length,
            channels: channels
        }
        customGroups.push(newGroup)
        showCreateGroup = false
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: contentPadding
        spacing: 24

        // Sticky Header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#000000"
            z: 10

            RowLayout {
                anchors.fill: parent
                anchors.margins: 0
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
                    onClicked: navigateTo("/live/groups")
                }

                Text {
                    text: "My Channel Groups"
                    font.pixelSize: isDesktop ? 36 : 28
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }

                Button {
                    text: "Create Group"
                    Layout.preferredHeight: 48
                    Layout.preferredWidth: 140
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 24 // Pill style
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
                    onClicked: showCreateGroup = true
                }
            }
        }

        // Groups List - Responsive Grid/Column
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            // Centered content container
            Item {
                width: Math.min(maxContentWidth, parent.width)
                anchors.horizontalCenter: parent.horizontalCenter
                
                Flow {
                    anchors.fill: parent
                    spacing: cardSpacing

                    Repeater {
                        model: customGroups
                        delegate: Rectangle {
                            width: isDesktop ? (parent.width - cardSpacing) / 2 : parent.width
                            height: 120
                            color: "#111111"
                            radius: 12
                            border.color: "#2A2A2A"
                            border.width: 1

                            // Soft shadow
                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: -4
                                radius: parent.radius + 4
                                color: "#00000020"
                                z: -1
                                visible: parent.parent.hovered
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 20
                                spacing: 16

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 8

                                    Text {
                                        text: modelData.name
                                        font.pixelSize: isDesktop ? 20 : 18
                                        font.bold: true
                                        color: "#FFFFFF"
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                    }

                                    Text {
                                        text: modelData.channelCount + " channels"
                                        font.pixelSize: 14
                                        color: "#B3B3B3"
                                        Layout.fillWidth: true
                                    }

                                    // Channel preview chips
                                    RowLayout {
                                        spacing: 8
                                        Repeater {
                                            model: Math.min(isDesktop ? 6 : 4, modelData.channels.length)
                                            delegate: Rectangle {
                                                Layout.preferredWidth: 60
                                                Layout.preferredHeight: 24
                                                color: "#333333"
                                                radius: 12
                                                
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: modelData[0] // Channel name
                                                    font.pixelSize: 10
                                                    color: "#FFFFFF"
                                                    elide: Text.ElideRight
                                                    anchors.margins: 4
                                                }
                                            }
                                        }
                                        
                                        Text {
                                            visible: modelData.channels.length > (isDesktop ? 6 : 4)
                                            text: "+" + (modelData.channels.length - (isDesktop ? 6 : 4)) + " more"
                                            font.pixelSize: 10
                                            color: "#B3B3B3"
                                        }
                                    }
                                }

                                // Actions - Responsive layout
                                RowLayout {
                                    spacing: isMobile ? 8 : 12

                                    Button {
                                        text: "Open"
                                        Layout.preferredWidth: isMobile ? 60 : 80
                                        Layout.preferredHeight: 36
                                        background: Rectangle {
                                            color: parent.hovered ? "#2A2A2A" : "transparent"
                                            radius: 6
                                            border.color: "#444444"
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
                                            console.log("Opening group:", modelData.name)
                                            navigateTo("/live/channels")
                                        }
                                    }

                                    Button {
                                        text: "Edit"
                                        Layout.preferredWidth: isMobile ? 50 : 60
                                        Layout.preferredHeight: 36
                                        background: Rectangle {
                                            color: parent.hovered ? "#2A2A2A" : "transparent"
                                            radius: 6
                                            border.color: "#444444"
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
                                            console.log("Editing group:", modelData.name)
                                        }
                                    }

                                    Button {
                                        text: "Delete"
                                        Layout.preferredWidth: isMobile ? 60 : 70
                                        Layout.preferredHeight: 36
                                        background: Rectangle {
                                            color: parent.hovered ? "#E50914" : "#444444"
                                            radius: 6
                                            border.color: "#E50914"
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
                                            deleteGroup(modelData.id)
                                        }
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    console.log("Group clicked:", modelData.name)
                                }
                            }

                            // Hover animations
                            scale: parent.hovered ? 1.02 : 1.0
                            Behavior on scale {
                                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                            }
                            Behavior on border.color {
                                ColorAnimation { duration: 150 }
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
            visible: customGroups.length === 0

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
                    text: "No custom groups yet"
                    font.pixelSize: isDesktop ? 28 : 24
                    font.bold: true
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "Create one to organize your favorite channels"
                    font.pixelSize: 16
                    color: "#B3B3B3"
                    Layout.alignment: Qt.AlignHCenter
                }

                Button {
                    text: "Create Your First Group"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredHeight: 48
                    Layout.preferredWidth: 200
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 24
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
                    onClicked: showCreateGroup = true
                }
            }
        }
    }

    // Create Group Modal
    CreateGroupSheet {
        visible: showCreateGroup
        onConfirmed: function(name, channels) {
            addGroup(name, channels)
        }
        onCancelled: {
            showCreateGroup = false
        }
    }
}
