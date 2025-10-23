import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: generalSettings
    color: "#0E0E0E"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1080
    property bool isTablet: screenWidth >= 768 && screenWidth < 1080
    property bool isMobile: screenWidth < 768

    // Settings state
    property string startupPage: appSettings ? appSettings.startupRoute : "Home"
    property string language: appSettings ? appSettings.language : "en"
    property string region: "United States"
    property bool use24HourFormat: false
    property string contentRatingSystem: "MPAA"

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
        ', generalSettings)
        
        writeTimers[key].start()
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
            width: Math.min(1200, parent.width - 80)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.bottomMargin: 80
            spacing: 20

            // Header Row
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
                    text: "General"
                    font.pixelSize: 32
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
                        startupPage = "Home"
                        language = "English"
                        region = "United States"
                        use24HourFormat = false
                        contentRatingSystem = "MPAA"
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
                    onClicked: applySettings()
                }
            }

            // Settings Content
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 16

                // Startup Setting
                SettingsRow {
                    Layout.fillWidth: true
                    icon: "🏠"
                    title: "Start Page"
                    subtitle: "Choose which page to show when the app starts"
                    
                    control: ComboBox {
                        width: 180
                        height: 40
                        model: ["Home", "Live TV", "TV Guide", "Movies", "Series"]
                        currentIndex: model.indexOf(startupPage)
                        
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

                        onCurrentIndexChanged: {
                            startupPage = model[currentIndex]
                            writeSetting("startupRoute", model[currentIndex])
                        }
                    }
                }

                // Language Setting
                SettingsRow {
                    Layout.fillWidth: true
                    icon: "🌐"
                    title: "App Language"
                    subtitle: "Interface language for menus and navigation"
                    
                    control: ComboBox {
                        width: 180
                        height: 40
                        model: ["English", "Spanish", "French", "German", "Italian", "Portuguese", "Chinese", "Japanese", "Korean"]
                        currentIndex: model.indexOf(language)
                        
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

                        onCurrentIndexChanged: {
                            language = model[currentIndex]
                            writeSetting("language", model[currentIndex])
                        }
                    }
                }

                // Region Setting
                SettingsRow {
                    Layout.fillWidth: true
                    icon: "🗺️"
                    title: "Region"
                    subtitle: "Regional settings for content and formatting"
                    
                    control: ComboBox {
                        width: 180
                        height: 40
                        model: ["United States", "United Kingdom", "Canada", "Australia", "Germany", "France", "Spain", "Italy", "Brazil", "Mexico"]
                        currentIndex: model.indexOf(region)
                        
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

                        onCurrentIndexChanged: region = model[currentIndex]
                    }
                }

                // Time Format Setting
                SettingsRow {
                    Layout.fillWidth: true
                    icon: "🕐"
                    title: "Time Format"
                    subtitle: "Display time in 12-hour (AM/PM) or 24-hour format"
                    
                    control: RowLayout {
                        spacing: 8
                        
                        Button {
                            text: "12 Hour"
                            height: 32
                            width: 80
                            background: Rectangle {
                                color: !use24HourFormat ? "#E50914" : "transparent"
                                radius: 12
                                border.color: !use24HourFormat ? "#E50914" : "#666666"
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
                            onClicked: use24HourFormat = false
                        }

                        Button {
                            text: "24 Hour"
                            height: 32
                            width: 80
                            background: Rectangle {
                                color: use24HourFormat ? "#E50914" : "transparent"
                                radius: 12
                                border.color: use24HourFormat ? "#E50914" : "#666666"
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
                            onClicked: use24HourFormat = true
                        }
                    }
                }

                // Content Rating System Setting
                SettingsRow {
                    Layout.fillWidth: true
                    icon: "🎭"
                    title: "Content Rating System"
                    subtitle: "Rating system used for parental controls (UI-only)"
                    
                    control: ComboBox {
                        width: 180
                        height: 40
                        model: ["MPAA", "BBFC", "PEGI", "ESRB", "CERO", "USK"]
                        currentIndex: model.indexOf(contentRatingSystem)
                        
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

                        onCurrentIndexChanged: contentRatingSystem = model[currentIndex]
                    }
                }
            }
        }
    }
}