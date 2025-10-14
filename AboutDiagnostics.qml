import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: aboutDiagnostics
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock diagnostic data
    property bool pingTestRunning: false
    property var pingResults: null

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
                        text: "About & Diagnostics"
                        font.pixelSize: 28
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Item { Layout.fillWidth: true }
                }
            }

            // Settings Content
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 32

                // App Information Section
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
                            text: "App Information"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // App Version
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Text {
                                text: "App Version"
                                font.pixelSize: 16
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            Item { Layout.fillWidth: true }

                            Text {
                                text: "2.1.4 (Build 214)"
                                font.pixelSize: 16
                                color: "#B3B3B3"
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            color: "#2A2A2A"
                        }

                        // Qt Version
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Text {
                                text: "Qt Version"
                                font.pixelSize: 16
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            Item { Layout.fillWidth: true }

                            Text {
                                text: "6.9.2"
                                font.pixelSize: 16
                                color: "#B3B3B3"
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            color: "#2A2A2A"
                        }

                        // Codecs
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Supported Codecs"
                                font.pixelSize: 16
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            Text {
                                text: "H.264, H.265/HEVC, VP9, AV1, AAC, MP3, AC-3, DTS"
                                font.pixelSize: 14
                                color: "#B3B3B3"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                            }
                        }
                    }
                }

                // CDN/Edge Section
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
                            text: "CDN/Edge"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        Text {
                            text: "Primary CDN: edge-us-west.iptvpro.com"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }

                        Text {
                            text: "Backup CDN: edge-us-east.iptvpro.com"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }

                        Button {
                            text: pingTestRunning ? "Testing..." : "Run Test"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48
                            enabled: !pingTestRunning

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

                            onClicked: runPingTest()
                        }

                        // Ping Results
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12
                            visible: pingResults !== null && pingResults.length > 0

                            Repeater {
                                model: pingResults

                                delegate: Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 60
                                    color: "#171717"
                                    radius: 8
                                    border.color: "#2A2A2A"
                                    border.width: 1

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 12

                                        Rectangle {
                                            Layout.preferredWidth: 8
                                            Layout.preferredHeight: 8
                                            radius: 4
                                            color: "#12B886"
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            spacing: 2

                                            Text {
                                                text: modelData.name
                                                font.pixelSize: 14
                                                font.weight: Font.Medium
                                                color: "#FFFFFF"
                                            }

                                            Text {
                                                text: modelData.status + " • " + modelData.latency
                                                font.pixelSize: 12
                                                color: "#B3B3B3"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Diagnostics Section
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
                            text: "Diagnostics"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Export Logs Button
                        Button {
                            text: "Export Logs"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48

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

                            onClicked: exportLogs()
                        }

                        Text {
                            text: "Export application logs for troubleshooting and support"
                            font.pixelSize: 13
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }
                    }
                }

                // Open Source Licenses Section
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
                            text: "Open Source Licenses"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        ScrollView {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 200
                            clip: true

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
}
