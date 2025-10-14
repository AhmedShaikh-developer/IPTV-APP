import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: generalSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock settings state
    property string startupPage: "Home"
    property string language: "English"
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

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: Math.min(900, parent.width - 80)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 32
            anchors.bottomMargin: 32
            spacing: 20

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
                    text: "General"
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
                spacing: 20

                // Startup Section
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
                                text: "🏠"
                                font.pixelSize: 20
                            }
                        }

                        // Text Content
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 2

                            Text {
                                text: "Start Page"
                                font.pixelSize: 16
                                font.weight: Font.SemiBold
                                color: "#FFFFFF"
                            }

                            Text {
                                text: "Choose which page to show when the app starts"
                                font.pixelSize: 13
                                color: "#CCCCCC"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                                Layout.maximumWidth: 300
                            }
                        }

                        // Control
                        ComboBox {
                            Layout.preferredWidth: 180
                            Layout.preferredHeight: 40
                            Layout.alignment: Qt.AlignVCenter
                            model: ["Home", "Live TV", "TV Guide", "Movies", "Series"]
                            currentIndex: model.indexOf(startupPage)
                            
                            background: Rectangle {
                                color: "#2A2A2A"
                                radius: 6
                                border.color: parent.activeFocus ? "#E50914" : "#444444"
                                border.width: 1
                            }

                            contentItem: Text {
                                text: model[currentIndex]
                                color: "#FFFFFF"
                                font.pixelSize: 14
                                leftPadding: 12
                                verticalAlignment: Text.AlignVCenter
                            }

                            onCurrentIndexChanged: startupPage = model[currentIndex]
                        }
                    }
                }

                // Language & Region Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 240
                    color: "#1A1A1A"
                    radius: 12
                    border.color: "#333333"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 16

                        Text {
                            text: "Language & Region"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.bottomMargin: 8
                        }

                        // Language Setting
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
                                    text: "🌐"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "App Language"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: "Interface language for menus and navigation"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 300
                                }
                            }

                            ComboBox {
                                Layout.preferredWidth: 180
                                Layout.preferredHeight: 40
                                Layout.alignment: Qt.AlignVCenter
                                model: ["English", "Spanish", "French", "German", "Italian", "Portuguese", "Chinese", "Japanese", "Korean"]
                                currentIndex: model.indexOf(language)
                                
                                background: Rectangle {
                                    color: "#2A2A2A"
                                    radius: 6
                                    border.color: parent.activeFocus ? "#E50914" : "#444444"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: model[currentIndex]
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onCurrentIndexChanged: language = model[currentIndex]
                            }
                        }

                        // Region Setting
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
                                    text: "🗺️"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Region"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: "Regional settings for content and formatting"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 300
                                }
                            }

                            ComboBox {
                                Layout.preferredWidth: 180
                                Layout.preferredHeight: 40
                                Layout.alignment: Qt.AlignVCenter
                                model: ["United States", "United Kingdom", "Canada", "Australia", "Germany", "France", "Spain", "Italy", "Brazil", "Mexico"]
                                currentIndex: model.indexOf(region)
                                
                                background: Rectangle {
                                    color: "#2A2A2A"
                                    radius: 6
                                    border.color: parent.activeFocus ? "#E50914" : "#444444"
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
                    }
                }

                // Time & Content Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 240
                    color: "#1A1A1A"
                    radius: 12
                    border.color: "#333333"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 16

                        Text {
                            text: "Time & Content"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                            Layout.bottomMargin: 8
                        }

                        // Time Format Setting
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
                                    text: "🕐"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Time Format"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: "Display time in 12-hour (AM/PM) or 24-hour format"
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
                                    text: "12 Hour"
                                    Layout.preferredHeight: 36
                                    Layout.preferredWidth: 80
                                    background: Rectangle {
                                        color: !use24HourFormat ? "#E50914" : "transparent"
                                        radius: 18
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
                                    Layout.preferredHeight: 36
                                    Layout.preferredWidth: 80
                                    background: Rectangle {
                                        color: use24HourFormat ? "#E50914" : "transparent"
                                        radius: 18
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
                                    text: "🎭"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Content Rating System"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: "Rating system used for parental controls (UI-only)"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 300
                                }
                            }

                            ComboBox {
                                Layout.preferredWidth: 180
                                Layout.preferredHeight: 40
                                Layout.alignment: Qt.AlignVCenter
                                model: ["MPAA", "BBFC", "PEGI", "ESRB", "CERO", "USK"]
                                currentIndex: model.indexOf(contentRatingSystem)
                                
                                background: Rectangle {
                                    color: "#2A2A2A"
                                    radius: 6
                                    border.color: parent.activeFocus ? "#E50914" : "#444444"
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
    }
}