import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: liveTvSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock settings state
    property bool miniEpgOnZap: true
    property bool startOverByDefault: false
    property string channelLogoSize: "Medium"
    property real channelNumberTimeout: 3.0

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
                        text: "Live TV"
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
                            miniEpgOnZap = true
                            startOverByDefault = false
                            channelLogoSize = "Medium"
                            channelNumberTimeout = 3.0
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

                // Navigation Section
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
                            text: "Navigation"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Mini-EPG on Zap Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Mini-EPG on Zap"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: miniEpgOnZap
                                        onCheckedChanged: miniEpgOnZap = checked

                                        indicator: Rectangle {
                                            implicitWidth: 48
                                            implicitHeight: 28
                                            x: parent.leftPadding
                                            y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                            radius: 14
                                            color: parent.checked ? "#E50914" : "#666666"
                                            border.color: parent.checked ? "#E50914" : "#999999"

                                            Rectangle {
                                                x: parent.checked ? parent.width - width : 0
                                                width: 24
                                                height: 24
                                                radius: 12
                                                color: parent.parent.checked ? "#FFFFFF" : "#CCCCCC"
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.margins: 2

                                                Behavior on x {
                                                    NumberAnimation { duration: 200 }
                                                }
                                            }
                                        }
                                    }

                                    Text {
                                        text: miniEpgOnZap ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: miniEpgOnZap ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Show mini electronic program guide when changing channels"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Start-Over by Default Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Start-Over by Default"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: startOverByDefault
                                        onCheckedChanged: startOverByDefault = checked

                                        indicator: Rectangle {
                                            implicitWidth: 48
                                            implicitHeight: 28
                                            x: parent.leftPadding
                                            y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                            radius: 14
                                            color: parent.checked ? "#E50914" : "#666666"
                                            border.color: parent.checked ? "#E50914" : "#999999"

                                            Rectangle {
                                                x: parent.checked ? parent.width - width : 0
                                                width: 24
                                                height: 24
                                                radius: 12
                                                color: parent.parent.checked ? "#FFFFFF" : "#CCCCCC"
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.margins: 2

                                                Behavior on x {
                                                    NumberAnimation { duration: 200 }
                                                }
                                            }
                                        }
                                    }

                                    Text {
                                        text: startOverByDefault ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: startOverByDefault ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Automatically start programs from the beginning when available"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
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

                        // Channel Logo Size
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Channel Logo Size"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Repeater {
                                        model: ["Small", "Medium", "Large"]

                                        delegate: Button {
                                            text: modelData
                                            Layout.preferredHeight: 40
                                            Layout.preferredWidth: 80
                                            background: Rectangle {
                                                color: channelLogoSize === modelData ? "#E50914" : "transparent"
                                                radius: 20
                                                border.color: channelLogoSize === modelData ? "#E50914" : "#666666"
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
                                            onClicked: channelLogoSize = modelData
                                        }
                                    }
                                }

                                // Live Preview
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 60
                                    color: "#171717"
                                    radius: 8
                                    border.color: "#2A2A2A"
                                    border.width: 1

                                    RowLayout {
                                        anchors.centerIn: parent
                                        spacing: 12

                                        Rectangle {
                                            Layout.preferredWidth: channelLogoSize === "Small" ? 24 : channelLogoSize === "Medium" ? 32 : 40
                                            Layout.preferredHeight: channelLogoSize === "Small" ? 24 : channelLogoSize === "Medium" ? 32 : 40
                                            color: "#E50914"
                                            radius: 4

                                            Text {
                                                anchors.centerIn: parent
                                                text: "📺"
                                                font.pixelSize: channelLogoSize === "Small" ? 12 : channelLogoSize === "Medium" ? 16 : 20
                                            }
                                        }

                                        Text {
                                            text: "BBC One"
                                            font.pixelSize: 14
                                            color: "#FFFFFF"
                                        }
                                    }
                                }

                                Text {
                                    text: "Size of channel logos in the channel list and guide"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Channel Number Timeout
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "Channel Number Entry Timeout"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: channelNumberTimeout + "s"
                                    font.pixelSize: 16
                                    font.weight: Font.Bold
                                    color: "#E50914"
                                }

                                Item { Layout.fillWidth: true }
                            }

                            Slider {
                                Layout.fillWidth: true
                                from: 1
                                to: 5
                                stepSize: 0.5
                                value: channelNumberTimeout

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

                                onValueChanged: channelNumberTimeout = value
                            }

                            Text {
                                text: "How long to wait before processing channel number input"
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
