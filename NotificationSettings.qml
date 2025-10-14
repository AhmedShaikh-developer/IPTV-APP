import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: notificationSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock settings state
    property bool allowReminders: true
    property string reminderTime: "10"
    property bool appNotifications: true
    property bool quietHoursEnabled: false
    property string quietHoursStart: "22:00"
    property string quietHoursEnd: "08:00"

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
                        text: "Notifications"
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
                            allowReminders = true
                            reminderTime = "10"
                            appNotifications = true
                            quietHoursEnabled = false
                            quietHoursStart = "22:00"
                            quietHoursEnd = "08:00"
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

                // Reminders Section
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
                            text: "Reminders"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Allow Reminders Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Allow Reminders"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: allowReminders
                                        onCheckedChanged: allowReminders = checked

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
                                        text: allowReminders ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: allowReminders ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Enable program reminders and notifications"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Reminder Time Selection
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20
                            visible: allowReminders

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Remind Me"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                ComboBox {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    model: ["5", "10", "15"]
                                    currentIndex: model.indexOf(reminderTime)
                                    
                                    background: Rectangle {
                                        color: "#171717"
                                        radius: 12
                                        border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                        border.width: 1
                                    }

                                    contentItem: Text {
                                        text: model[currentIndex] + " min before"
                                        color: "#FFFFFF"
                                        font.pixelSize: 15
                                        leftPadding: 16
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    onCurrentIndexChanged: reminderTime = model[currentIndex]
                                }

                                Text {
                                    text: "How long before a program to show the reminder"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }

                // App Notifications Section
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
                            text: "App Notifications"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // App Notifications Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "App Notifications"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: appNotifications
                                        onCheckedChanged: appNotifications = checked

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
                                        text: appNotifications ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: appNotifications ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Enable system notifications from the app"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Quiet Hours Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20
                            enabled: appNotifications

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Quiet Hours"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: appNotifications ? "#FFFFFF" : "#666666"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: quietHoursEnabled
                                        onCheckedChanged: quietHoursEnabled = checked
                                        enabled: appNotifications

                                        indicator: Rectangle {
                                            implicitWidth: 48
                                            implicitHeight: 28
                                            x: parent.leftPadding
                                            y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                            radius: 14
                                            color: parent.enabled && parent.checked ? "#E50914" : "#666666"
                                            border.color: parent.enabled && parent.checked ? "#E50914" : "#999999"
                                            opacity: parent.enabled ? 1.0 : 0.5

                                            Rectangle {
                                                x: parent.parent.checked ? parent.width - width : 0
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
                                        text: quietHoursEnabled ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: appNotifications ? (quietHoursEnabled ? "#E50914" : "#B3B3B3") : "#666666"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Disable notifications during specified hours"
                                    font.pixelSize: 13
                                    color: appNotifications ? "#B3B3B3" : "#666666"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Quiet Hours Time Range
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20
                            visible: quietHoursEnabled && appNotifications

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 16

                                    // Start Time
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 8

                                        Text {
                                            text: "Start Time"
                                            font.pixelSize: 14
                                            font.weight: Font.Medium
                                            color: "#FFFFFF"
                                        }

                                        ComboBox {
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 40
                                            model: ["20:00", "21:00", "22:00", "23:00", "00:00"]
                                            currentIndex: model.indexOf(quietHoursStart)
                                            
                                            background: Rectangle {
                                                color: "#171717"
                                                radius: 8
                                                border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                                border.width: 1
                                            }

                                            contentItem: Text {
                                                text: model[currentIndex]
                                                color: "#FFFFFF"
                                                font.pixelSize: 14
                                                leftPadding: 12
                                                verticalAlignment: Text.AlignVCenter
                                            }

                                            onCurrentIndexChanged: quietHoursStart = model[currentIndex]
                                        }
                                    }

                                    // End Time
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 8

                                        Text {
                                            text: "End Time"
                                            font.pixelSize: 14
                                            font.weight: Font.Medium
                                            color: "#FFFFFF"
                                        }

                                        ComboBox {
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 40
                                            model: ["06:00", "07:00", "08:00", "09:00", "10:00"]
                                            currentIndex: model.indexOf(quietHoursEnd)
                                            
                                            background: Rectangle {
                                                color: "#171717"
                                                radius: 8
                                                border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                                border.width: 1
                                            }

                                            contentItem: Text {
                                                text: model[currentIndex]
                                                color: "#FFFFFF"
                                                font.pixelSize: 14
                                                leftPadding: 12
                                                verticalAlignment: Text.AlignVCenter
                                            }

                                            onCurrentIndexChanged: quietHoursEnd = model[currentIndex]
                                        }
                                    }
                                }

                                Text {
                                    text: "Notifications will be disabled from " + quietHoursStart + " to " + quietHoursEnd
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
