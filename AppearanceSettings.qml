import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Backend 1.0

Rectangle {
    id: appearanceSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Settings state
    property string theme: AppState.get("theme", appSettings ? appSettings.theme : "system")
    property string density: "Comfortable"
    property real overscanPercentage: 5.0
    property real accentIntensity: 80.0

    // Listen for live updates from AppState and refresh bindings
    Connections {
        target: settingsChanged
        function onSettingsChanged(key, value) {
            if (key === "theme") {
                // Force property refresh by reassigning
                theme = AppState.get("theme", appSettings ? appSettings.theme : "system")
            }
        }
    }

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

    // Debouncing for settings writes
    property var writeTimers: ({})
    
    function writeSetting(key, value) {
        if (!appSettings) return
        
        // Only update if value actually changed
        if (appSettings[key] === value) return
        
        // Debounce rapid writes
        if (writeTimers[key]) {
            writeTimers[key].stop()
        }
        
        writeTimers[key] = Qt.createQmlObject('
            import QtQuick 2.15
            Timer {
                interval: 300
                repeat: false
                onTriggered: {
                    if (appSettings) {
                        appSettings.' + key + ' = "' + value + '"
                    }
                }
            }
        ', appearanceSettings)
        
        writeTimers[key].start()
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
                    text: "Appearance"
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
                        theme = "Dark"
                        density = "Comfortable"
                        overscanPercentage = 5.0
                        accentIntensity = 80.0
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

                // Theme Section
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
                                text: "🎨"
                                font.pixelSize: 20
                            }
                        }

                        // Text Content
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 2

                            Text {
                                text: "Theme"
                                font.pixelSize: 16
                                font.weight: Font.SemiBold
                                color: "#FFFFFF"
                            }

                            Text {
                                text: "Choose your preferred theme. System follows your device settings."
                                font.pixelSize: 13
                                color: "#CCCCCC"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                                Layout.maximumWidth: 300
                            }
                        }

                        // SegmentedControl
                        RowLayout {
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 6

                            Repeater {
                                model: ["Light", "Dark", "System"]

                                Button {
                                    text: modelData
                                    Layout.preferredHeight: 36
                                    Layout.preferredWidth: 70
                                    background: Rectangle {
                                        color: theme === modelData ? "#E50914" : "transparent"
                                        radius: 18
                                        border.color: theme === modelData ? "#E50914" : "#666666"
                                        border.width: 1
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 12
                                        font.weight: Font.Medium
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        theme = modelData
                                        AppState.set("theme", modelData)
                                        writeSetting("theme", modelData)
                                    }
                                }
                            }
                        }
                    }
                }

                // Density Section
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
                        spacing: 12

                        // Density Selection Row
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
                                    text: "📏"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Interface Density"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: "Adjust the spacing and size of interface elements"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 300
                                }
                            }

                            RowLayout {
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 6

                                Button {
                                    text: "Comfortable"
                                    Layout.preferredHeight: 36
                                    Layout.preferredWidth: 100
                                    background: Rectangle {
                                        color: density === "Comfortable" ? "#E50914" : "transparent"
                                        radius: 18
                                        border.color: density === "Comfortable" ? "#E50914" : "#666666"
                                        border.width: 1
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 12
                                        font.weight: Font.Medium
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: density = "Comfortable"
                                }

                                Button {
                                    text: "Compact"
                                    Layout.preferredHeight: 36
                                    Layout.preferredWidth: 80
                                    background: Rectangle {
                                        color: density === "Compact" ? "#E50914" : "transparent"
                                        radius: 18
                                        border.color: density === "Compact" ? "#E50914" : "#666666"
                                        border.width: 1
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 12
                                        font.weight: Font.Medium
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: density = "Compact"
                                }
                            }
                        }

                        // Preview
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            color: "#171717"
                            radius: 8
                            border.color: "#2A2A2A"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 12
                                spacing: 12

                                Rectangle {
                                    Layout.preferredWidth: 16
                                    Layout.preferredHeight: 16
                                    color: "#E50914"
                                    radius: 3
                                }

                                Text {
                                    text: "Preview: This shows how list items will appear"
                                    font.pixelSize: 12
                                    color: "#CCCCCC"
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }

                // Accent Preview Section
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
                                text: "🎨"
                                font.pixelSize: 20
                            }
                        }

                        // Text Content
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 2

                            Text {
                                text: "Accent Preview"
                                font.pixelSize: 16
                                font.weight: Font.SemiBold
                                color: "#FFFFFF"
                            }

                            Text {
                                text: "Control the intensity of accent colors throughout the interface"
                                font.pixelSize: 13
                                color: "#CCCCCC"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                                Layout.maximumWidth: 300
                            }
                        }

                        // Preview Pills
                        RowLayout {
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 8

                            Rectangle {
                                Layout.preferredWidth: 28
                                Layout.preferredHeight: 28
                                color: "#E50914"
                                opacity: accentIntensity / 100
                                radius: 6
                            }

                            Rectangle {
                                Layout.preferredWidth: 28
                                Layout.preferredHeight: 28
                                color: "#E50914"
                                opacity: accentIntensity / 100
                                radius: 14
                            }

                            Rectangle {
                                Layout.preferredWidth: 28
                                Layout.preferredHeight: 28
                                color: "#E50914"
                                opacity: accentIntensity / 100
                                radius: 3
                            }
                        }
                    }
                }

                // Safe Area Section
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
                        spacing: 12

                        // Safe Area Header Row
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

                                RowLayout {
                                    spacing: 8

                                    Text {
                                        text: "Display Safe Area"
                                        font.pixelSize: 16
                                        font.weight: Font.SemiBold
                                        color: "#FFFFFF"
                                    }

                                    Text {
                                        text: Math.round(overscanPercentage) + "%"
                                        font.pixelSize: 16
                                        font.weight: Font.Bold
                                        color: "#E50914"
                                    }
                                }

                                Text {
                                    text: "Adjust the safe area to prevent content from being cut off on TV screens"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 300
                                }
                            }
                        }

                        // Slider
                        Slider {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            from: 0
                            to: 15
                            stepSize: 1
                            value: overscanPercentage

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

                            onValueChanged: overscanPercentage = value
                        }
                    }
                }
            }
        }
    }
}