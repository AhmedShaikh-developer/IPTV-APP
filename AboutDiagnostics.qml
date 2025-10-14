import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: aboutDiagnostics
    color: "#0E0E0E"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1080
    property bool isTablet: screenWidth >= 768 && screenWidth < 1080
    property bool isMobile: screenWidth < 768

    // Mock diagnostic data
    property bool pingTestRunning: false
    property var pingResults: null
    property bool licensesExpanded: false

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function showToast(message) {
        console.log("Toast:", message)
    }

    function runPingTest() {
        pingTestRunning = true
        showToast("Running connectivity test...")
        pingTimer.start()
    }

    function exportLogs() {
        showToast("Export started - logs will be saved to Downloads folder")
    }

    // Simulated ping timer (must be a QML element, not inside a JS function)
    Timer {
        id: pingTimer
        interval: 2000
        repeat: false
        onTriggered: {
            pingTestRunning = false
            pingResults = [
                { name: "Primary CDN", status: "Connected", latency: "45ms" },
                { name: "Backup CDN", status: "Connected", latency: "67ms" },
                { name: "Metadata Server", status: "Connected", latency: "23ms" },
                { name: "Auth Server", status: "Connected", latency: "34ms" }
            ]
            showToast("Connectivity test completed")
        }
    }

    // Background gradient
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0E0E0E" }
            GradientStop { position: 1.0; color: "#151515" }
        }
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: Math.min(1080, parent.width - 80)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.bottomMargin: 80
            spacing: 22

            // Fixed Header Row
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                spacing: 20

                // Back Button
                Button {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    background: Rectangle {
                        color: parent.hovered ? "#2A2A2A" : "transparent"
                        radius: 22
                        border.color: "#444444"
                        border.width: 1
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                    contentItem: Text {
                        text: "←"
                        font.pixelSize: 20
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/settings")
                }

                // Title
                Text {
                    text: "About & Diagnostics"
                    font.pixelSize: 32
                    font.weight: Font.Bold
                    color: "#FFFFFF"
                }

                // Spacer
                Item { Layout.fillWidth: true }
            }

            // App Information Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 160
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                // Subtle shadow effect
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    color: "transparent"
                    radius: 14
                    border.color: "#333333"
                    border.width: 0.5
                    opacity: 0.3
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 20

                    Text {
                        text: "App Information"
                        font.pixelSize: 18
                        font.weight: Font.SemiBold
                        color: "#FFFFFF"
                    }

                    // App Information Grid
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        // App Version Row
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Text {
                                text: "App Version"
                                font.pixelSize: 15
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                                Layout.preferredWidth: 140
                            }

                            Text {
                                text: "2.1.4 (Build 214)"
                                font.pixelSize: 15
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                        }

                        // Qt Version Row
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Text {
                                text: "Qt Version"
                                font.pixelSize: 15
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                                Layout.preferredWidth: 140
                            }

                            Text {
                                text: "6.9.2"
                                font.pixelSize: 15
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                        }

                        // Supported Codecs Row
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Text {
                                text: "Supported Codecs"
                                font.pixelSize: 15
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                                Layout.preferredWidth: 140
                            }

                            Text {
                                text: "H.264, H.265/HEVC, VP9, AV1, AAC, MP3, AC-3, DTS"
                                font.pixelSize: 15
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                }
            }

            // Run Test Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                // Subtle shadow effect
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    color: "transparent"
                    radius: 14
                    border.color: "#333333"
                    border.width: 0.5
                    opacity: 0.3
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true

                        Text {
                            text: "Connectivity Test"
                            font.pixelSize: 18
                            font.weight: Font.SemiBold
                            color: "#FFFFFF"
                            Layout.fillWidth: true
                        }

                        Button {
                            text: pingTestRunning ? "Testing..." : "Run Test"
                            Layout.preferredHeight: 40
                            Layout.preferredWidth: 120
                            enabled: !pingTestRunning

                            background: Rectangle {
                                color: parent.enabled && parent.hovered ? "#CC0810" : "#E50914"
                                opacity: parent.enabled ? 1.0 : 0.5
                                radius: 12
                            }

                            contentItem: Text {
                                text: parent.text
                                color: "#FFFFFF"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            onClicked: runPingTest()
                        }
                    }

                    Text {
                        text: "Test connectivity to CDN and edge servers"
                        font.pixelSize: 14
                        color: "#B3B3B3"
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                        Layout.topMargin: 4
                    }

                    // Ping Results
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        visible: pingResults !== null && pingResults.length > 0
                        Layout.topMargin: 12

                        Repeater {
                            model: pingResults

                            delegate: Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 32
                                color: "#0F0F0F"
                                radius: 8
                                border.color: "#2A2A2A"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 12

                                    Rectangle {
                                        Layout.preferredWidth: 6
                                        Layout.preferredHeight: 6
                                        radius: 3
                                        color: "#12B886"
                                        Layout.alignment: Qt.AlignVCenter
                                    }

                                    Text {
                                        text: modelData.name + ": " + modelData.status + " • " + modelData.latency
                                        font.pixelSize: 13
                                        color: "#B3B3B3"
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Diagnostics Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                // Subtle shadow effect
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    color: "transparent"
                    radius: 14
                    border.color: "#333333"
                    border.width: 0.5
                    opacity: 0.3
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 16

                    Text {
                        text: "Diagnostics"
                        font.pixelSize: 18
                        font.weight: Font.SemiBold
                        color: "#FFFFFF"
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        RowLayout {
                            Layout.fillWidth: true

                            Button {
                                text: "Export Logs"
                                Layout.preferredHeight: 36
                                Layout.preferredWidth: 120

                                background: Rectangle {
                                    color: parent.hovered ? "#2A2A2A" : "transparent"
                                    radius: 12
                                    border.color: "#666666"
                                    border.width: 1
                                    Behavior on color { ColorAnimation { duration: 200 } }
                                }

                                contentItem: Text {
                                    text: parent.text
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked: exportLogs()
                            }

                            Item { Layout.fillWidth: true }
                        }

                        Text {
                            text: "Export application logs for troubleshooting and support"
                            font.pixelSize: 13
                            color: "#B3B3B3"
                            Layout.fillWidth: true
                            wrapMode: Text.WordWrap
                            Layout.maximumWidth: 400
                            Layout.alignment: Qt.AlignLeft
                        }
                    }
                }
            }

            // Open Source Licenses Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: licensesExpanded ? 400 : 80
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                // Subtle shadow effect
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    color: "transparent"
                    radius: 14
                    border.color: "#333333"
                    border.width: 0.5
                    opacity: 0.3
                }

                Behavior on Layout.preferredHeight {
                    NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 20

                    RowLayout {
                        Layout.fillWidth: true

                        Text {
                            text: "Open Source Licenses"
                            font.pixelSize: 18
                            font.weight: Font.SemiBold
                            color: "#FFFFFF"
                            Layout.fillWidth: true
                        }

                        Button {
                            text: licensesExpanded ? "Collapse" : "Expand"
                            Layout.preferredHeight: 32
                            Layout.preferredWidth: 80

                            background: Rectangle {
                                color: parent.hovered ? "#2A2A2A" : "transparent"
                                radius: 10
                                border.color: "#666666"
                                border.width: 1
                                Behavior on color { ColorAnimation { duration: 200 } }
                            }

                            contentItem: Text {
                                text: parent.text
                                color: "#FFFFFF"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            onClicked: licensesExpanded = !licensesExpanded
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredHeight: licensesExpanded ? 280 : 0
                        clip: true
                        visible: licensesExpanded

                        Behavior on Layout.preferredHeight {
                            NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                        }

                        Text {
                            width: parent.width
                            text: "Qt Framework\nCopyright (C) 2024 The Qt Company Ltd.\nLicensed under the GNU Lesser General Public License (LGPL) version 3.\n\nFFmpeg\nCopyright (c) 2000-2024 the FFmpeg developers\nLicensed under the GNU Lesser General Public License (LGPL) version 2.1 or later.\n\nOpenSSL\nCopyright (c) 1998-2024 The OpenSSL Project\nLicensed under the OpenSSL License.\n\nSQLite\nPublic domain software.\n\nJSON for Modern C++\nCopyright (c) 2013-2024 Niels Lohmann\nLicensed under the MIT License.\n\nThis application uses various open source libraries. Full license texts are available in the application bundle."
                            font.pixelSize: 12
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.4
                        }
                    }
                }
            }
        }
    }
}
