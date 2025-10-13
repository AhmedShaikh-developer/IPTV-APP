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
        anchors.margins: 40
        spacing: 30

        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            Button {
                width: 44
                height: 44
                background: Rectangle {
                    color: parent.hovered ? "#2A2A2A" : "transparent"
                    radius: 22
                    border.color: "#444444"
                    border.width: 1
                }
                contentItem: Text {
                    text: "←"
                    font.pixelSize: 20
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/live/groups")
            }

            Text {
                text: "My Channel Groups"
                font.pixelSize: 32
                font.bold: true
                color: "#FFFFFF"
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "Create Group"
                Layout.preferredHeight: 44
                background: Rectangle {
                    color: parent.hovered ? "#F5191F" : "#E50914"
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
                onClicked: showCreateGroup = true
            }
        }

        // Groups List
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 16

                Repeater {
                    model: customGroups
                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100
                        color: "#111111"
                        radius: 12
                        border.color: "#333333"
                        border.width: 1

                        // Subtle shadow
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -2
                            radius: parent.radius + 2
                            color: "#00000040"
                            z: -1
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: modelData.name
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: modelData.channelCount + " channels"
                                    font.pixelSize: 14
                                    color: "#B3B3B3"
                                    Layout.fillWidth: true
                                }

                                // Channel preview
                                RowLayout {
                                    spacing: 8
                                    Repeater {
                                        model: Math.min(4, modelData.channels.length)
                                        delegate: Rectangle {
                                            Layout.preferredWidth: 60
                                            Layout.preferredHeight: 20
                                            color: "#333333"
                                            radius: 4
                                            
                                            Text {
                                                anchors.centerIn: parent
                                                text: modelData[0] // Channel name
                                                font.pixelSize: 10
                                                color: "#FFFFFF"
                                                elide: Text.ElideRight
                                            }
                                        }
                                    }
                                    
                                    Text {
                                        visible: modelData.channels.length > 4
                                        text: "+" + (modelData.channels.length - 4) + " more"
                                        font.pixelSize: 10
                                        color: "#B3B3B3"
                                    }
                                }
                            }

                            RowLayout {
                                spacing: 12

                                Button {
                                    text: "Open"
                                    Layout.preferredWidth: 80
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
                                        // Mock: navigate to filtered channel list
                                        console.log("Opening group:", modelData.name)
                                        navigateTo("/live/channels")
                                    }
                                }

                                Button {
                                    text: "Edit"
                                    Layout.preferredWidth: 60
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
                                        // Mock: open edit dialog
                                        console.log("Editing group:", modelData.name)
                                    }
                                }

                                Button {
                                    text: "Delete"
                                    Layout.preferredWidth: 70
                                    Layout.preferredHeight: 36
                                    background: Rectangle {
                                        color: parent.hovered ? "#E50914" : "#444444"
                                        radius: 6
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 14
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        // Show confirmation dialog
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

                        scale: parent.hovered ? 1.02 : 1.0
                        Behavior on scale {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
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
                spacing: 20

                Text {
                    text: "📺"
                    font.pixelSize: 64
                    color: "#666666"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "No custom groups yet"
                    font.pixelSize: 24
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
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
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
