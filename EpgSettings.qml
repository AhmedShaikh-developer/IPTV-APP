import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: epgSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock settings state
    property real timelineZoom: 50.0
    property string defaultDay: "Today"
    property string timezoneOffset: "UTC+0"
    property bool showGenresAndIcons: true

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
                        text: "EPG"
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
                            timelineZoom = 50.0
                            defaultDay = "Today"
                            timezoneOffset = "UTC+0"
                            showGenresAndIcons = true
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

                // Timeline Section
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
                            text: "Timeline"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Timeline Zoom
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "Timeline Zoom"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: Math.round(timelineZoom) + "%"
                                    font.pixelSize: 16
                                    font.weight: Font.Bold
                                    color: "#E50914"
                                }

                                Item { Layout.fillWidth: true }
                            }

                            Slider {
                                Layout.fillWidth: true
                                from: 25
                                to: 200
                                stepSize: 25
                                value: timelineZoom

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

                                onValueChanged: timelineZoom = value
                            }

                            // Timeline Preview
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 80
                                color: "#171717"
                                radius: 8
                                border.color: "#2A2A2A"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 8

                                    Rectangle {
                                        Layout.preferredWidth: 60 * (timelineZoom / 100)
                                        Layout.preferredHeight: 40
                                        color: "#E50914"
                                        radius: 4

                                        Text {
                                            anchors.centerIn: parent
                                            text: "20:00"
                                            font.pixelSize: 12
                                            color: "#FFFFFF"
                                            font.weight: Font.Bold
                                        }
                                    }

                                    Rectangle {
                                        Layout.preferredWidth: 60 * (timelineZoom / 100)
                                        Layout.preferredHeight: 40
                                        color: "#E50914"
                                        radius: 4

                                        Text {
                                            anchors.centerIn: parent
                                            text: "21:00"
                                            font.pixelSize: 12
                                            color: "#FFFFFF"
                                            font.weight: Font.Bold
                                        }
                                    }

                                    Rectangle {
                                        Layout.preferredWidth: 60 * (timelineZoom / 100)
                                        Layout.preferredHeight: 40
                                        color: "#E50914"
                                        radius: 4

                                        Text {
                                            anchors.centerIn: parent
                                            text: "22:00"
                                            font.pixelSize: 12
                                            color: "#FFFFFF"
                                            font.weight: Font.Bold
                                        }
                                    }
                                }
                            }

                            Text {
                                text: "Adjust the zoom level of the EPG timeline for better readability"
                                font.pixelSize: 13
                                color: "#B3B3B3"
                                wrapMode: Text.WordWrap
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

                        // Default Day
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Default Day"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                ComboBox {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    model: ["Today", "Tomorrow", "Last viewed"]
                                    currentIndex: model.indexOf(defaultDay)
                                    
                                    background: Rectangle {
                                        color: "#171717"
                                        radius: 12
                                        border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                        border.width: 1
                                    }

                                    contentItem: Text {
                                        text: model[currentIndex]
                                        color: "#FFFFFF"
                                        font.pixelSize: 15
                                        leftPadding: 16
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    onCurrentIndexChanged: defaultDay = model[currentIndex]
                                }

                                Text {
                                    text: "Which day to show when opening the EPG"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Show Genres and Icons Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Show Genres & Icons"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: showGenresAndIcons
                                        onCheckedChanged: showGenresAndIcons = checked

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
                                        text: showGenresAndIcons ? "Enabled" : "Disabled"
                                        font.pixelSize: 14
                                        color: showGenresAndIcons ? "#E50914" : "#B3B3B3"
                                        Layout.alignment: Qt.AlignVCenter
                                    }
                                }

                                Text {
                                    text: "Display program genres and icons in the EPG"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }

                // Timezone Section
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
                            text: "Timezone"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Timezone Offset
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Timezone Offset"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                ComboBox {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    model: ["UTC-12", "UTC-11", "UTC-10", "UTC-9", "UTC-8", "UTC-7", "UTC-6", "UTC-5", "UTC-4", "UTC-3", "UTC-2", "UTC-1", "UTC+0", "UTC+1", "UTC+2", "UTC+3", "UTC+4", "UTC+5", "UTC+6", "UTC+7", "UTC+8", "UTC+9", "UTC+10", "UTC+11", "UTC+12"]
                                    currentIndex: model.indexOf(timezoneOffset)
                                    
                                    background: Rectangle {
                                        color: "#171717"
                                        radius: 12
                                        border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                        border.width: 1
                                    }

                                    contentItem: Text {
                                        text: model[currentIndex]
                                        color: "#FFFFFF"
                                        font.pixelSize: 15
                                        leftPadding: 16
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    onCurrentIndexChanged: timezoneOffset = model[currentIndex]
                                }

                                Text {
                                    text: "UI-only setting, does not alter device clock"
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
