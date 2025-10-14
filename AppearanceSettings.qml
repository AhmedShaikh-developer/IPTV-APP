import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: appearanceSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock settings state
    property string theme: "Dark"
    property string density: "Comfortable"
    property real overscanPercentage: 5.0
    property real accentIntensity: 80.0

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function showToast(message) {
        console.log("Toast:", message)
    }

    function applySettings() {
        showToast("Settings updated")
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: Math.min(1080, parent.width - 80)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: {
                if (isDesktop) return 32
                if (isTablet) return 20
                return 16
            }
            spacing: 24

            // Sticky Top Bar
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#000000"
                z: 100

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
                        onClicked: navigateTo("/settings")
                    }

                    Text {
                        text: "Appearance"
                        font.pixelSize: 28
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Item { Layout.fillWidth: true }

                    Button {
                        text: "Reset"
                        Layout.preferredHeight: 36
                        Layout.preferredWidth: 80
                        Layout.alignment: Qt.AlignVCenter
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
                            font.weight: Font.Medium
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            theme = "Dark"
                            density = "Comfortable"
                            overscanPercentage = 5.0
                            accentIntensity = 80.0
                            showToast("Settings reset to defaults")
                        }
                    }

                    Button {
                        text: "Apply"
                        Layout.preferredHeight: 36
                        Layout.preferredWidth: 80
                        Layout.alignment: Qt.AlignVCenter
                        background: Rectangle {
                            color: parent.hovered ? "#CC0810" : "#E50914"
                            radius: 18
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: applySettings()
                    }
                }
            }

            // Settings Content
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 32

                // Theme Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: childrenRect.height + 32
                    color: "#111111"
                    radius: 16
                    border.color: "#2A2A2A"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 20

                        Text {
                            text: "Theme"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Theme Selection
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            Repeater {
                                model: ["Light", "Dark", "System"]

                                delegate: Button {
                                    text: modelData
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    background: Rectangle {
                                        color: theme === modelData ? "#E50914" : "transparent"
                                        radius: 24
                                        border.color: theme === modelData ? "#E50914" : "#666666"
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
                                    onClicked: theme = modelData
                                }
                            }
                        }

                        Text {
                            text: "Choose your preferred theme. System follows your device settings."
                            font.pixelSize: 13
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                        }
                    }
                }

                // Density Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: childrenRect.height + 32
                    color: "#111111"
                    radius: 16
                    border.color: "#2A2A2A"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 20

                        Text {
                            text: "Density"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Density Selection
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Repeater {
                                model: ["Comfortable", "Compact"]

                                delegate: Button {
                                    text: modelData
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    background: Rectangle {
                                        color: density === modelData ? "#E50914" : "transparent"
                                        radius: 24
                                        border.color: density === modelData ? "#E50914" : "#666666"
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
                                    onClicked: density = modelData
                                }
                            }
                        }

                        // Preview Row
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: density === "Comfortable" ? 60 : 40
                            color: "#171717"
                            radius: 8
                            border.color: "#2A2A2A"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 12
                                spacing: 12

                                Rectangle {
                                    Layout.preferredWidth: 24
                                    Layout.preferredHeight: 24
                                    color: "#E50914"
                                    radius: 4
                                }

                                ColumnLayout {
                                    spacing: 2

                                    Text {
                                        text: "Preview Item"
                                        font.pixelSize: 14
                                        font.weight: Font.Medium
                                        color: "#FFFFFF"
                                    }

                                    Text {
                                        text: "This shows how list items will appear"
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                    }
                                }
                            }
                        }

                        Text {
                            text: "Adjust the spacing and size of interface elements"
                            font.pixelSize: 13
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                        }
                    }
                }

                // Display Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: childrenRect.height + 32
                    color: "#111111"
                    radius: 16
                    border.color: "#2A2A2A"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 20

                        Text {
                            text: "Display"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // TV Overscan Safe Area
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "TV Overscan Safe Area"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: Math.round(overscanPercentage) + "%"
                                    font.pixelSize: 16
                                    font.weight: Font.Bold
                                    color: "#E50914"
                                }

                                Item { Layout.fillWidth: true }
                            }

                            Slider {
                                Layout.fillWidth: true
                                from: 0
                                to: 15
                                stepSize: 1
                                value: overscanPercentage

                                background: Rectangle {
                                    x: parent.leftPadding
                                    y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                    implicitWidth: 200
                                    implicitHeight: 4
                                    width: parent.availableWidth
                                    height: implicitHeight
                                    radius: 2
                                    color: "#2A2A2A"

                                    Rectangle {
                                        width: parent.parent.visualPosition * parent.width
                                        height: parent.height
                                        color: "#E50914"
                                        radius: 2
                                    }
                                }

                                handle: Rectangle {
                                    x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
                                    y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                    implicitWidth: 20
                                    implicitHeight: 20
                                    radius: 10
                                    color: "#E50914"
                                    border.color: "#FFFFFF"
                                    border.width: 2
                                }

                                onValueChanged: overscanPercentage = value
                            }

                            // Live Preview
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 120
                                color: "#171717"
                                radius: 8
                                border.color: "#2A2A2A"
                                border.width: 1

                                Rectangle {
                                    anchors.fill: parent
                                    anchors.margins: parent.width * (overscanPercentage / 100)
                                    color: "#E5091415"
                                    radius: 4
                                    border.color: "#E50914"
                                    border.width: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "Safe Area Preview"
                                        font.pixelSize: 12
                                        color: "#E50914"
                                        font.weight: Font.Medium
                                    }
                                }
                            }

                            Text {
                                text: "Adjust the safe area to prevent content from being cut off on TV screens"
                                font.pixelSize: 13
                                color: "#B3B3B3"
                                wrapMode: Text.WordWrap
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            color: "#2A2A2A"
                        }

                        // Accent Intensity
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "Accent Intensity"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: Math.round(accentIntensity) + "%"
                                    font.pixelSize: 16
                                    font.weight: Font.Bold
                                    color: "#E50914"
                                }

                                Item { Layout.fillWidth: true }
                            }

                            Slider {
                                Layout.fillWidth: true
                                from: 0
                                to: 100
                                stepSize: 5
                                value: accentIntensity

                                background: Rectangle {
                                    x: parent.leftPadding
                                    y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                    implicitWidth: 200
                                    implicitHeight: 4
                                    width: parent.availableWidth
                                    height: implicitHeight
                                    radius: 2
                                    color: "#2A2A2A"

                                    Rectangle {
                                        width: parent.parent.visualPosition * parent.width
                                        height: parent.height
                                        color: "#E50914"
                                        radius: 2
                                    }
                                }

                                handle: Rectangle {
                                    x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
                                    y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                    implicitWidth: 20
                                    implicitHeight: 20
                                    radius: 10
                                    color: "#E50914"
                                    border.color: "#FFFFFF"
                                    border.width: 2
                                }

                                onValueChanged: accentIntensity = value
                            }

                            // Intensity Preview
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12

                                Rectangle {
                                    Layout.preferredWidth: 40
                                    Layout.preferredHeight: 40
                                    color: "#E50914"
                                    opacity: accentIntensity / 100
                                    radius: 8
                                }

                                Rectangle {
                                    Layout.preferredWidth: 40
                                    Layout.preferredHeight: 40
                                    color: "#E50914"
                                    opacity: accentIntensity / 100
                                    radius: 20
                                }

                                Rectangle {
                                    Layout.preferredWidth: 40
                                    Layout.preferredHeight: 40
                                    color: "#E50914"
                                    opacity: accentIntensity / 100
                                    radius: 4
                                }
                            }

                            Text {
                                text: "Control the visual intensity of accent colors throughout the interface"
                                font.pixelSize: 13
                                color: "#B3B3B3"
                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                }
            }
        }
    }
}
