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
    property bool remindersEnabled: true
    property bool doNotDisturbEnabled: false
    property string dndStartTime: "22:00"
    property string dndEndTime: "08:00"

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

    function getDndWindowText() {
        if (!doNotDisturbEnabled) return ""
        
        var startHour = parseInt(dndStartTime.split(":")[0])
        var startMin = dndStartTime.split(":")[1]
        var endHour = parseInt(dndEndTime.split(":")[0])
        var endMin = dndEndTime.split(":")[1]
        
        var startPeriod = startHour >= 12 ? "PM" : "AM"
        var endPeriod = endHour >= 12 ? "PM" : "AM"
        
        var startDisplayHour = startHour > 12 ? startHour - 12 : (startHour === 0 ? 12 : startHour)
        var endDisplayHour = endHour > 12 ? endHour - 12 : (endHour === 0 ? 12 : endHour)
        
        var startTime = startDisplayHour + ":" + startMin + " " + startPeriod
        var endTime = endDisplayHour + ":" + endMin + " " + endPeriod
        
        return "Quiet period: " + startTime + " - " + endTime
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
                    text: "Notifications"
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
                        remindersEnabled = true
                        doNotDisturbEnabled = false
                        dndStartTime = "22:00"
                        dndEndTime = "08:00"
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

                // Reminders Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    color: "#1A1A1A"
                    radius: 12
                    border.color: "#333333"
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 16

                        // Icon
                        Rectangle {
                            Layout.preferredWidth: 40
                            Layout.preferredHeight: 40
                            color: "#E50914"
                            radius: 20

                            Text {
                                anchors.centerIn: parent
                                text: "🔔"
                                font.pixelSize: 20
                            }
                        }

                        // Text Content
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 2

                            Text {
                                text: "Reminders"
                                font.pixelSize: 16
                                font.weight: Font.SemiBold
                                color: "#FFFFFF"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Text {
                                text: "Enable program reminders and notifications"
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
                                checked: remindersEnabled
                                onCheckedChanged: remindersEnabled = checked
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
                                text: remindersEnabled ? "Enabled" : "Disabled"
                                font.pixelSize: 14
                                color: remindersEnabled ? "#E50914" : "#B3B3B3"
                                Layout.alignment: Qt.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                            }
                        }
                    }
                }

                // Do Not Disturb Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: doNotDisturbEnabled ? 140 : 100
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
                                    text: "🌙"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Do Not Disturb"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Disable notifications during specified hours"
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
                                    checked: doNotDisturbEnabled
                                    onCheckedChanged: doNotDisturbEnabled = checked
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
                                    text: doNotDisturbEnabled ? "Enabled" : "Disabled"
                                    font.pixelSize: 14
                                    color: doNotDisturbEnabled ? "#E50914" : "#B3B3B3"
                                    Layout.alignment: Qt.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                }
                            }
                        }

                        // Time Pickers (horizontal with 12px gap, wrap to vertical under 640px)
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12
                            visible: doNotDisturbEnabled

                            // Start Time Picker
                            ComboBox {
                                Layout.preferredWidth: screenWidth < 640 ? Layout.fillWidth : 120
                                Layout.preferredHeight: 36
                                model: ["20:00", "21:00", "22:00", "23:00", "00:00"]
                                currentIndex: model.indexOf(dndStartTime)
                                
                                background: Rectangle {
                                    color: "#2A2A2A"
                                    radius: 6
                                    border.color: parent.activeFocus ? "#E50914" : "#444444"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: "Start: " + model[currentIndex]
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }

                                onCurrentIndexChanged: dndStartTime = model[currentIndex]
                            }

                            // End Time Picker
                            ComboBox {
                                Layout.preferredWidth: screenWidth < 640 ? Layout.fillWidth : 120
                                Layout.preferredHeight: 36
                                model: ["06:00", "07:00", "08:00", "09:00", "10:00"]
                                currentIndex: model.indexOf(dndEndTime)
                                
                                background: Rectangle {
                                    color: "#2A2A2A"
                                    radius: 6
                                    border.color: parent.activeFocus ? "#E50914" : "#444444"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: "End: " + model[currentIndex]
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }

                                onCurrentIndexChanged: dndEndTime = model[currentIndex]
                            }

                            // For screens under 640px, wrap to vertical stack
                            Layout.maximumWidth: screenWidth < 640 ? undefined : 280
                        }

                        // Computed window hint (subtle muted)
                        Text {
                            text: getDndWindowText()
                            font.pixelSize: 12
                            color: "#888888"
                            Layout.fillWidth: true
                            wrapMode: Text.WordWrap
                            visible: doNotDisturbEnabled && text !== ""
                        }
                    }
                }
            }
        }
    }
}