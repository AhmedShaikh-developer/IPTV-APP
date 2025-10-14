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
                        text: "General"
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
                            startupPage = "Home"
                            language = "English"
                            region = "United States"
                            use24HourFormat = false
                            contentRatingSystem = "MPAA"
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

                // Startup Section
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
                            text: "Startup"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Startup Page Setting
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Startup Page"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                ComboBox {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    model: ["Home", "Live TV", "TV Guide", "Movies", "Series"]
                                    currentIndex: model.indexOf(startupPage)
                                    
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

                                    onCurrentIndexChanged: startupPage = model[currentIndex]
                                }

                                Text {
                                    text: "Choose which page to show when the app starts"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }

                // Language & Region Section
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
                            text: "Language & Region"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Language Setting
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Language"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                ComboBox {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    model: ["English", "Spanish", "French", "German", "Italian", "Portuguese", "Chinese", "Japanese", "Korean"]
                                    currentIndex: model.indexOf(language)
                                    
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

                                    onCurrentIndexChanged: language = model[currentIndex]
                                }

                                Text {
                                    text: "Interface language for menus and navigation"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Region Setting
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Region"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                ComboBox {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    model: ["United States", "United Kingdom", "Canada", "Australia", "Germany", "France", "Spain", "Italy", "Brazil", "Mexico"]
                                    currentIndex: model.indexOf(region)
                                    
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

                                    onCurrentIndexChanged: region = model[currentIndex]
                                }

                                Text {
                                    text: "Regional settings for content and formatting"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }

                // Time & Content Section
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
                            text: "Time & Content"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Time Format Setting
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Time Format"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 16

                                    Button {
                                        text: "12 Hour"
                                        Layout.preferredHeight: 40
                                        Layout.preferredWidth: 100
                                        background: Rectangle {
                                            color: !use24HourFormat ? "#E50914" : "transparent"
                                            radius: 20
                                            border.color: !use24HourFormat ? "#E50914" : "#666666"
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
                                        onClicked: use24HourFormat = false
                                    }

                                    Button {
                                        text: "24 Hour"
                                        Layout.preferredHeight: 40
                                        Layout.preferredWidth: 100
                                        background: Rectangle {
                                            color: use24HourFormat ? "#E50914" : "transparent"
                                            radius: 20
                                            border.color: use24HourFormat ? "#E50914" : "#666666"
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
                                        onClicked: use24HourFormat = true
                                    }
                                }

                                Text {
                                    text: "Display time in 12-hour (AM/PM) or 24-hour format"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Content Rating System Setting
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Content Rating System"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                ComboBox {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    model: ["MPAA", "BBFC", "PEGI", "ESRB", "CERO", "USK"]
                                    currentIndex: model.indexOf(contentRatingSystem)
                                    
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

                                    onCurrentIndexChanged: contentRatingSystem = model[currentIndex]
                                }

                                Text {
                                    text: "Rating system used for parental controls (UI-only)"
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
