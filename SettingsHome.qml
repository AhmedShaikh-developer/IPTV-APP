import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: settingsHome
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366
    property bool isSmall: screenWidth <= 1024

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function showConfirmDialog(title, message, callback) {
        console.log("Confirm:", title, message)
        if (callback) callback()
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: Math.min(1200, parent.width - 64)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: {
                if (isDesktop) return 32
                if (isTablet) return 24
                return 16
            }
            anchors.bottomMargin: {
                if (isDesktop) return 32
                if (isTablet) return 24
                return 16
            }
            spacing: 32

            // Header Section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                color: "transparent"

                ColumnLayout {
                    width: parent.width
                    spacing: 24

                    // Title Row
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16

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
                            onClicked: navigateTo("/home")
                        }

                        Text {
                            text: "Settings"
                            font.pixelSize: 36
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.fillWidth: true
                        }

                        // Quick Actions
                        RowLayout {
                            spacing: 12

                            Button {
                                text: "Reset All"
                                Layout.preferredHeight: 36
                                Layout.preferredWidth: 100
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
                                    showConfirmDialog("Reset All Settings", "This will reset all settings to their default values. This action cannot be undone.", function() {
                                        console.log("Reset all settings")
                                    })
                                }
                            }

                            Button {
                                text: "Restore Defaults"
                                Layout.preferredHeight: 36
                                Layout.preferredWidth: 140
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
                                    showConfirmDialog("Restore Defaults", "This will restore all settings to their original default values. Are you sure?", function() {
                                        console.log("Restore defaults")
                                    })
                                }
                            }
                        }
                    }

                    // Subtitle
                    Text {
                        text: "Customize your IPTV Pro experience"
                        font.pixelSize: 16
                        color: "#B3B3B3"
                        Layout.fillWidth: true
                    }

                    // Section Divider
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: "#2A2A2A"
                    }
                }
            }

            // Settings Cards Grid
            GridLayout {
                Layout.fillWidth: true
                columns: {
                    if (isDesktop) return 4
                    if (isTablet) return 3
                    if (isSmall) return 1
                    return 2
                }
                rowSpacing: 20
                columnSpacing: 20

                // General Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "⚙️"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "General"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Startup, language, and basic preferences"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/general")
                }

                // Appearance Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "🎨"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "Appearance"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Theme, density, and visual preferences"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/appearance")
                }

                // Playback Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "▶️"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "Playback"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Video, audio, and hardware settings"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/playback")
                }

                // Live TV Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "📺"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "Live TV"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Channel navigation and mini-EPG settings"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/live")
                }

                // EPG Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "📅"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "EPG"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Electronic Program Guide configuration"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/epg")
                }

                // Integrations Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "🔗"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "Integrations"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Casting, DLNA, and external services"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/integrations")
                }

                // Network Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "🌐"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "Network"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Proxy, headers, and advanced network settings"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/network")
                }

                // Notifications Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "🔔"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "Notifications"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Reminders, alerts, and quiet hours"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/notifications")
                }

                // Account Settings Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "👤"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "Account"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Profile, devices, and account management"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/account")
                }

                // About & Diagnostics Card
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "#171717"
                        radius: 16
                        border.color: parent.hovered ? "#E50914" : "#2A2A2A"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            radius: 16
                            border.color: parent.parent.parent.activeFocus ? "#FFFFFF" : "transparent"
                            border.width: 2
                        }
                    }

                    contentItem: ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 12

                        Text {
                            text: "ℹ️"
                            font.pixelSize: 32
                            color: "#E50914"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "About"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Version info, diagnostics, and licenses"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }

                    onClicked: navigateTo("/settings/about")
                }
            }
        }
    }
}