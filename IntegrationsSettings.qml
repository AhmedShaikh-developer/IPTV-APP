import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: integrationsSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock settings state
    property bool chromecastEnabled: false
    property bool airplayEnabled: false
    property bool dlnaEnabled: false
    property string openSubtitlesUsername: ""
    property string openSubtitlesPassword: ""
    property bool autoDownloadSubs: false

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
                        text: "Integrations"
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
                            chromecastEnabled = false
                            airplayEnabled = false
                            dlnaEnabled = false
                            openSubtitlesUsername = ""
                            openSubtitlesPassword = ""
                            autoDownloadSubs = false
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

                // Casting Section
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
                            text: "Casting & Streaming"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Chromecast Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Chromecast"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: chromecastEnabled
                                        onCheckedChanged: chromecastEnabled = checked

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
                                        text: chromecastEnabled ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: chromecastEnabled ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Cast content to Chromecast devices on your network"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // AirPlay Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "AirPlay"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: airplayEnabled
                                        onCheckedChanged: airplayEnabled = checked

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
                                        text: airplayEnabled ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: airplayEnabled ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Stream content to Apple TV and AirPlay-compatible devices"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // DLNA/UPnP Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "DLNA/UPnP"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: dlnaEnabled
                                        onCheckedChanged: dlnaEnabled = checked

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
                                        text: dlnaEnabled ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: dlnaEnabled ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Stream content to DLNA/UPnP compatible devices"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }

                // OpenSubtitles Section
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
                            text: "OpenSubtitles"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Username Field
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Username"
                                font.pixelSize: 16
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            TextField {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 48
                                text: openSubtitlesUsername
                                placeholderText: "Enter your OpenSubtitles username"
                                selectByMouse: true

                                background: Rectangle {
                                    color: "#171717"
                                    radius: 12
                                    border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                    border.width: 1
                                }

                                color: "#FFFFFF"
                                font.pixelSize: 15
                                leftPadding: 16
                                rightPadding: 16

                                onTextChanged: openSubtitlesUsername = text
                            }
                        }

                        // Password Field
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Password"
                                font.pixelSize: 16
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            TextField {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 48
                                text: openSubtitlesPassword
                                placeholderText: "Enter your password"
                                echoMode: TextInput.Password
                                selectByMouse: true

                                background: Rectangle {
                                    color: "#171717"
                                    radius: 12
                                    border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                    border.width: 1
                                }

                                color: "#FFFFFF"
                                font.pixelSize: 15
                                leftPadding: 16
                                rightPadding: 16

                                onTextChanged: openSubtitlesPassword = text
                            }
                        }

                        // Sign In Button
                        Button {
                            text: "Sign In"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48
                            enabled: openSubtitlesUsername.length > 0 && openSubtitlesPassword.length > 0

                            background: Rectangle {
                                color: parent.enabled && parent.hovered ? "#CC0810" : "#E50914"
                                opacity: parent.enabled ? 1.0 : 0.5
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

                            onClicked: {
                                if (openSubtitlesUsername.length > 0 && openSubtitlesPassword.length > 0) {
                                    showToast("Successfully signed in to OpenSubtitles")
                                }
                            }
                        }

                        // Auto Download Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Auto-download Matching Subs"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: autoDownloadSubs
                                        onCheckedChanged: autoDownloadSubs = checked

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
                                        text: autoDownloadSubs ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: autoDownloadSubs ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Automatically download matching subtitles when available"
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
}
