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
    property bool autoDownloadSubs: false
    property string openSubtitlesUsername: ""
    property string openSubtitlesPassword: ""

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
            width: Math.min(900, parent.width - 80)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 32
            anchors.bottomMargin: 40
            spacing: 16

            // Header Row
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                spacing: 24

                // Back Button
                Button {
                    Layout.preferredWidth: 48
                    Layout.preferredHeight: 48
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

                // Title
                Text {
                    text: "Integrations"
                    font.pixelSize: 28
                    font.weight: Font.Bold
                    color: "#FFFFFF"
                }

                // Spacer
                Item { Layout.fillWidth: true }

                // Reset Button
                Button {
                    text: "Reset"
                    Layout.preferredHeight: 36
                    Layout.preferredWidth: 80
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
                        autoDownloadSubs = false
                        openSubtitlesUsername = ""
                        openSubtitlesPassword = ""
                        showToast("Settings reset to defaults")
                    }
                }

                // Apply Button
                Button {
                    text: "Apply"
                    Layout.preferredHeight: 36
                    Layout.preferredWidth: 80
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

            // Settings Content
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 16

                // Casting & Streaming Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    color: "#1A1A1A"
                    radius: 12
                    border.color: "#333333"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 16

                        // Header Row
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Rectangle {
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                color: "#E50914"
                                radius: 20

                                Text {
                                    anchors.centerIn: parent
                                    text: "📺"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Casting & Streaming"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Stream content to external devices"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }

                            // Stacked Toggles Column
                            ColumnLayout {
                                spacing: 12
                                Layout.alignment: Qt.AlignVCenter

                                // Chromecast Toggle
                                RowLayout {
                                    spacing: 8

                                    Switch {
                                        checked: chromecastEnabled
                                        onCheckedChanged: chromecastEnabled = checked
                                        Layout.preferredWidth: 50
                                        Layout.preferredHeight: 30

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
                                        text: "Chromecast"
                                        font.pixelSize: 14
                                        color: chromecastEnabled ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                // AirPlay Toggle
                                RowLayout {
                                    spacing: 8

                                    Switch {
                                        checked: airplayEnabled
                                        onCheckedChanged: airplayEnabled = checked
                                        Layout.preferredWidth: 50
                                        Layout.preferredHeight: 30

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
                                        text: "AirPlay"
                                        font.pixelSize: 14
                                        color: airplayEnabled ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }
                            }
                        }
                    }
                }

                // Auto-Matching Subtitles Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    color: "#1A1A1A"
                    radius: 12
                    border.color: "#333333"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 16

                        // Header Row
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Rectangle {
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                color: "#E50914"
                                radius: 20

                                Text {
                                    anchors.centerIn: parent
                                    text: "📝"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Auto-Matching Subtitles"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Automatically download matching subtitles when available"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }

                            // Toggle Switch
                            RowLayout {
                                spacing: 8
                                Layout.alignment: Qt.AlignVCenter

                                Switch {
                                    checked: autoDownloadSubs
                                    onCheckedChanged: autoDownloadSubs = checked
                                    Layout.preferredWidth: 50
                                    Layout.preferredHeight: 30

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
                                    horizontalAlignment: Text.AlignLeft
                                }
                            }
                        }

                        // Credentials Fields (when enabled)
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12
                            visible: autoDownloadSubs

                            TextField {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 36
                                text: openSubtitlesUsername
                                placeholderText: "Username"
                                enabled: autoDownloadSubs
                                selectByMouse: true

                                background: Rectangle {
                                    color: autoDownloadSubs ? "#2A2A2A" : "#1A1A1A"
                                    radius: 6
                                    border.color: parent.activeFocus ? "#E50914" : "#444444"
                                    border.width: 1
                                    opacity: autoDownloadSubs ? 1.0 : 0.5
                                }

                                color: autoDownloadSubs ? "#FFFFFF" : "#666666"
                                font.pixelSize: 14
                                leftPadding: 12
                                rightPadding: 12

                                onTextChanged: openSubtitlesUsername = text
                            }

                            TextField {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 36
                                text: openSubtitlesPassword
                                placeholderText: "Password"
                                echoMode: TextInput.Password
                                enabled: autoDownloadSubs
                                selectByMouse: true

                                background: Rectangle {
                                    color: autoDownloadSubs ? "#2A2A2A" : "#1A1A1A"
                                    radius: 6
                                    border.color: parent.activeFocus ? "#E50914" : "#444444"
                                    border.width: 1
                                    opacity: autoDownloadSubs ? 1.0 : 0.5
                                }

                                color: autoDownloadSubs ? "#FFFFFF" : "#666666"
                                font.pixelSize: 14
                                leftPadding: 12
                                rightPadding: 12

                                onTextChanged: openSubtitlesPassword = text
                            }
                        }
                    }
                }
            }
        }
    }
}