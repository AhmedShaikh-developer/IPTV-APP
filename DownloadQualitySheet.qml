import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: qualitySheet
    anchors.fill: parent
    color: "#00000080"
    visible: false
    z: 2000

    property string selectedQuality: "auto"
    property string itemTitle: "Video Title"
    property string itemType: "Movie"

    signal confirmed(string quality)
    signal cancelled()

    MouseArea {
        anchors.fill: parent
        onClicked: {
            qualitySheet.visible = false
            cancelled()
        }
    }

    Rectangle {
        anchors.centerIn: parent
        width: Math.min(480, parent.width * 0.9)
        height: Math.min(600, parent.height * 0.8)
        radius: 16
        color: "#111111"
        border.color: "#1A1A1A"
        border.width: 1

        MouseArea {
            anchors.fill: parent
            onClicked: {} // Prevent clicks from passing through
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 20

            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 16

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4

                    Text {
                        text: "Download Quality"
                        font.pixelSize: 22
                        font.bold: true
                        color: "#FFFFFF"
                    }

                    Text {
                        text: itemTitle
                        font.pixelSize: 14
                        color: "#B3B3B3"
                    }
                }

                Button {
                    width: 36
                    height: 36
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "transparent"
                        radius: 18
                    }
                    contentItem: Text {
                        text: "✕"
                        font.pixelSize: 18
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        qualitySheet.visible = false
                        cancelled()
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "#1A1A1A"
            }

            // Quality options
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ColumnLayout {
                    width: parent.width
                    spacing: 8

                    Repeater {
                        model: [
                            {
                                id: "auto",
                                label: "Auto (Recommended)",
                                bitrate: "Adapts to your connection",
                                size: "~1.5 GB"
                            },
                            {
                                id: "1080p",
                                label: "1080p (Full HD)",
                                bitrate: "5-8 Mbps",
                                size: "~2.5 GB"
                            },
                            {
                                id: "720p",
                                label: "720p (HD)",
                                bitrate: "3-5 Mbps",
                                size: "~1.5 GB"
                            },
                            {
                                id: "480p",
                                label: "480p (SD)",
                                bitrate: "1-2 Mbps",
                                size: "~800 MB"
                            },
                            {
                                id: "audio",
                                label: "Audio Only",
                                bitrate: "128 kbps",
                                size: "~50 MB"
                            }
                        ]

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 72
                            radius: 12
                            color: selectedQuality === modelData.id ? "#1A1A1A" : "transparent"
                            border.color: selectedQuality === modelData.id ? "#E50914" : "#333333"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 16

                                Rectangle {
                                    width: 20
                                    height: 20
                                    radius: 10
                                    border.color: selectedQuality === modelData.id ? "#E50914" : "#666666"
                                    border.width: 2
                                    color: "transparent"

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 10
                                        height: 10
                                        radius: 5
                                        color: "#E50914"
                                        visible: selectedQuality === modelData.id
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4

                                    Text {
                                        text: modelData.label
                                        font.pixelSize: 15
                                        font.bold: selectedQuality === modelData.id
                                        color: "#FFFFFF"
                                    }

                                    RowLayout {
                                        spacing: 8

                                        Text {
                                            text: modelData.bitrate
                                            font.pixelSize: 12
                                            color: "#B3B3B3"
                                        }

                                        Text {
                                            text: "•"
                                            font.pixelSize: 12
                                            color: "#B3B3B3"
                                        }

                                        Text {
                                            text: modelData.size
                                            font.pixelSize: 12
                                            color: "#B3B3B3"
                                        }
                                    }
                                }

                                Text {
                                    text: modelData.id === "auto" ? "⭐" : ""
                                    font.pixelSize: 16
                                    visible: modelData.id === "auto"
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selectedQuality = modelData.id
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "#1A1A1A"
            }

            // Action buttons
            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                Button {
                    text: "Cancel"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 48
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "transparent"
                        radius: 24
                        border.color: "#333333"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 15
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        qualitySheet.visible = false
                        cancelled()
                    }
                }

                Button {
                    text: "Download"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 48
                    background: Rectangle {
                        color: parent.hovered ? "#F5191F" : "#E50914"
                        radius: 24
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 15
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        qualitySheet.visible = false
                        confirmed(selectedQuality)
                    }
                }
            }
        }
    }

    function show(title, type) {
        itemTitle = title
        itemType = type
        selectedQuality = "auto"
        visible = true
    }
}

