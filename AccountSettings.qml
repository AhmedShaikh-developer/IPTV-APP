import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: accountSettings
    color: "#0E0E0E"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1080
    property bool isTablet: screenWidth >= 768 && screenWidth < 1080
    property bool isMobile: screenWidth < 768

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
            spacing: 26

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
                    text: "Account"
                    font.pixelSize: 32
                    font.weight: Font.Bold
                    color: "#FFFFFF"
                }

                // Spacer
                Item { Layout.fillWidth: true }
            }

            // Profile Card
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

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 20

                    // Avatar
                    Rectangle {
                        Layout.preferredWidth: 60
                        Layout.preferredHeight: 60
                        radius: 30
                        color: "#E50914"
                        border.color: "#FFFFFF"
                        border.width: 2

                        Text {
                            anchors.centerIn: parent
                            text: userName.charAt(0).toUpperCase()
                            font.pixelSize: 24
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }
                    }

                    // Profile Info
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        spacing: 4

                        Text {
                            text: userName
                            font.pixelSize: 21
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                        }

                        Text {
                            text: userEmail
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                            wrapMode: Text.WordWrap
                        }

                        Rectangle {
                            Layout.preferredWidth: 80
                            Layout.preferredHeight: 18
                            radius: 9
                            color: "#E50914"
                            Layout.topMargin: 4

                            Text {
                                anchors.centerIn: parent
                                text: "Premium"
                                font.pixelSize: 12
                                font.weight: Font.Bold
                                color: "#FFFFFF"
                            }
                        }
                    }

                    // Edit Button
                    Button {
                        text: "Edit"
                        Layout.preferredHeight: 36
                        Layout.preferredWidth: 80
                        Layout.alignment: Qt.AlignVCenter

                        background: Rectangle {
                            color: parent.hovered ? "#2A2A2A" : "transparent"
                            radius: 16
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

                        onClicked: showEditProfileDialog()
                    }
                }
            }

            // Account Actions Card
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

                    // Title
                    Text {
                        text: "Account Actions"
                        font.pixelSize: 18
                        font.weight: Font.SemiBold
                        color: "#FFFFFF"
                        Layout.fillWidth: true
                    }

                    // Action Buttons
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        Button {
                            text: "Change Password"
                            Layout.preferredHeight: 40
                            Layout.preferredWidth: 160

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

                            onClicked: {
                                showToast("Change password dialog")
                            }
                        }

                        Button {
                            text: "Sign Out"
                            Layout.preferredHeight: 40
                            Layout.preferredWidth: 120

                            background: Rectangle {
                                color: parent.hovered ? "#CC0810" : "#E50914"
                                radius: 12
                                Behavior on color { ColorAnimation { duration: 200 } }
                            }

                            contentItem: Text {
                                text: parent.text
                                color: "#FFFFFF"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            onClicked: {
                                showConfirmDialog("Sign Out", "Are you sure you want to sign out?", function() {
                                    showToast("Signed out successfully")
                                })
                            }
                        }
                    }

                    // Helper Text
                    Text {
                        text: "Manage your account settings and security preferences"
                        font.pixelSize: 14
                        color: "#B3B3B3"
                        Layout.fillWidth: true
                        Layout.topMargin: 8
                        wrapMode: Text.WordWrap
                    }
                }
            }

            // Device Management Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 320
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

                    // Header Row
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        Text {
                            text: "Device Management"
                            font.pixelSize: 18
                            font.weight: Font.SemiBold
                            color: "#FFFFFF"
                            Layout.fillWidth: true
                        }

                        Button {
                            text: "Manage"
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 100
                            Layout.alignment: Qt.AlignVCenter

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

                            onClicked: showDeviceManagerDialog()
                        }
                    }

                    // Device Limit
                    Text {
                        text: "Device Limit: " + devices.length + "/" + deviceLimit + " devices"
                        font.pixelSize: 14
                        color: "#B3B3B3"
                        Layout.fillWidth: true
                    }

                    // Device List
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 14

                        Repeater {
                            model: devices

                            delegate: Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 64
                                color: "#0F0F0F"
                                radius: 12
                                border.color: "#2A2A2A"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 20
                                    spacing: 16

                                    // Device Icon
                                    Rectangle {
                                        Layout.preferredWidth: 32
                                        Layout.preferredHeight: 32
                                        radius: 16
                                        color: modelData.isCurrent ? "#E50914" : "#444444"
                                        border.color: modelData.isCurrent ? "#FFFFFF" : "transparent"
                                        border.width: 1

                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData.name.includes("PC") ? "🖥️" : modelData.name.includes("iPhone") ? "📱" : "📱"
                                            font.pixelSize: 16
                                        }
                                    }

                                    // Device Info
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignVCenter
                                        spacing: 2

                                        Text {
                                            text: modelData.name
                                            font.pixelSize: 16
                                            font.weight: Font.SemiBold
                                            color: "#FFFFFF"
                                            Layout.fillWidth: true
                                            elide: Text.ElideRight
                                        }

                                        Text {
                                            text: modelData.location + " • " + modelData.lastActive
                                            font.pixelSize: 13
                                            color: "#B3B3B3"
                                            Layout.fillWidth: true
                                            elide: Text.ElideRight
                                        }
                                    }

                                    // Status Badge
                                    Rectangle {
                                        Layout.preferredWidth: modelData.isCurrent ? 70 : 90
                                        Layout.preferredHeight: 28
                                        radius: 14
                                        color: modelData.isCurrent ? "#E50914" : "transparent"
                                        border.color: "#E50914"
                                        border.width: 1
                                        Layout.alignment: Qt.AlignVCenter

                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData.isCurrent ? "Active" : "Sign Out"
                                            font.pixelSize: 12
                                            font.weight: Font.Bold
                                            color: modelData.isCurrent ? "#FFFFFF" : "#E50914"
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            enabled: !modelData.isCurrent
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