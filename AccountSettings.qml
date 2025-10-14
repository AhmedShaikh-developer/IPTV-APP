import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: accountSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock account data
    property string userName: "John Doe"
    property string userEmail: "john.doe@example.com"
    property string avatarUrl: ""
    property int deviceLimit: 5
    property var devices: [
        { name: "Desktop PC", location: "Home", lastActive: "2 hours ago", isCurrent: true },
        { name: "iPhone 14", location: "Mobile", lastActive: "1 day ago", isCurrent: false },
        { name: "iPad Pro", location: "Tablet", lastActive: "3 days ago", isCurrent: false }
    ]

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function showToast(message) {
        console.log("Toast:", message)
    }

    function showConfirmDialog(title, message, callback) {
        console.log("Confirm:", title, message)
        if (callback) callback()
    }

    function showEditProfileDialog() {
        console.log("Show edit profile dialog")
    }

    function showDeviceManagerDialog() {
        console.log("Show device manager dialog")
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
                        text: "Account"
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

                // Profile Section
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
                            text: "Profile"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Profile Card
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 100
                            color: "#171717"
                            radius: 12
                            border.color: "#2A2A2A"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 16

                                // Avatar
                                Rectangle {
                                    Layout.preferredWidth: 68
                                    Layout.preferredHeight: 68
                                    radius: 34
                                    color: "#E50914"

                                    Text {
                                        anchors.centerIn: parent
                                        text: userName.charAt(0).toUpperCase()
                                        font.pixelSize: 28
                                        font.weight: Font.Bold
                                        color: "#FFFFFF"
                                    }
                                }

                                // Profile Info
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4

                                    Text {
                                        text: userName
                                        font.pixelSize: 20
                                        font.weight: Font.Bold
                                        color: "#FFFFFF"
                                    }

                                    Text {
                                        text: userEmail
                                        font.pixelSize: 14
                                        color: "#B3B3B3"
                                    }

                                    Text {
                                        text: "Premium Member"
                                        font.pixelSize: 12
                                        color: "#E50914"
                                        font.weight: Font.Medium
                                    }
                                }

                                // Edit Button
                                Button {
                                    text: "Edit Profile"
                                    Layout.preferredHeight: 36
                                    Layout.preferredWidth: 120
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

                                    onClicked: showEditProfileDialog()
                                }
                            }
                        }
                    }
                }

                // Account Actions Section
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
                            text: "Account Actions"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Sign Out Button
                        Button {
                            text: "Sign Out"
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

                            onClicked: {
                                showConfirmDialog("Sign Out", "Are you sure you want to sign out of your account?", function() {
                                    showToast("Signed out successfully")
                                })
                            }
                        }

                        // Delete Account Button
                        Button {
                            text: "Delete Account"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48

                            background: Rectangle {
                                color: parent.hovered ? "#CC0810" : "transparent"
                                radius: 12
                                border.color: "#E50914"
                                border.width: 2
                            }

                            contentItem: Text {
                                text: parent.text
                                color: "#E50914"
                                font.pixelSize: 15
                                font.weight: Font.Medium
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            onClicked: {
                                showConfirmDialog("Delete Account", "This action cannot be undone. Are you sure you want to permanently delete your account?", function() {
                                    showToast("Account deletion requested")
                                })
                            }
                        }

                        // Export Data Button
                        Button {
                            text: "Export My Data"
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

                            onClicked: {
                                showToast("Download started - you will receive an email when ready")
                            }
                        }
                    }
                }

                // Device Management Section
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

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            Text {
                                text: "Device Management"
                                font.pixelSize: 20
                                font.weight: Font.Bold
                                color: "#FFFFFF"
                            }

                            Item { Layout.fillWidth: true }

                            Button {
                                text: "Manage Devices"
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

                                onClicked: showDeviceManagerDialog()
                            }
                        }

                        Text {
                            text: "Device Limit: " + devices.length + "/" + deviceLimit + " devices"
                            font.pixelSize: 14
                            color: "#B3B3B3"
                        }

                        // Device List
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            Repeater {
                                model: devices

                                delegate: Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 80
                                    color: "#171717"
                                    radius: 12
                                    border.color: "#2A2A2A"
                                    border.width: 1

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 16
                                        spacing: 16

                                        // Device Icon
                                        Rectangle {
                                            Layout.preferredWidth: 48
                                            Layout.preferredHeight: 48
                                            radius: 24
                                            color: modelData.isCurrent ? "#E50914" : "#666666"

                                            Text {
                                                anchors.centerIn: parent
                                                text: modelData.name.includes("PC") ? "🖥️" : modelData.name.includes("iPhone") ? "📱" : "📱"
                                                font.pixelSize: 20
                                            }
                                        }

                                        // Device Info
                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            spacing: 4

                                            RowLayout {
                                                Layout.fillWidth: true
                                                spacing: 8

                                                Text {
                                                    text: modelData.name
                                                    font.pixelSize: 16
                                                    font.weight: Font.Medium
                                                    color: "#FFFFFF"
                                                }

                                                Text {
                                                    text: modelData.isCurrent ? "(Current)" : ""
                                                    font.pixelSize: 12
                                                    color: "#E50914"
                                                    font.weight: Font.Medium
                                                }
                                            }

                                            Text {
                                                text: modelData.location + " • " + modelData.lastActive
                                                font.pixelSize: 13
                                                color: "#B3B3B3"
                                            }
                                        }

                                        // Sign Out Button
                                        Button {
                                            text: "Sign Out"
                                            Layout.preferredHeight: 32
                                            Layout.preferredWidth: 80
                                            Layout.alignment: Qt.AlignVCenter
                                            visible: !modelData.isCurrent

                                            background: Rectangle {
                                                color: parent.hovered ? "#CC0810" : "transparent"
                                                radius: 16
                                                border.color: "#E50914"
                                                border.width: 1
                                            }

                                            contentItem: Text {
                                                text: parent.text
                                                color: "#E50914"
                                                font.pixelSize: 12
                                                font.weight: Font.Medium
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }

                                            onClicked: {
                                                showConfirmDialog("Sign Out Device", "Sign out " + modelData.name + "?", function() {
                                                    showToast("Device signed out")
                                                })
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
