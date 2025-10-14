import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: liveTvSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock settings state
    property string navigation: "Default"
    property real channelNumberTimeout: 3.0
    property string channelLogoSize: "Medium"

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
                    text: "Live TV"
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
                        navigation = "Default"
                        channelNumberTimeout = 3.0
                        channelLogoSize = "Medium"
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

                // Navigation Section
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
                                text: "🧭"
                                font.pixelSize: 20
                            }
                        }

                        // Text Content
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 2

                            Text {
                                text: "Navigation"
                                font.pixelSize: 16
                                font.weight: Font.SemiBold
                                color: "#FFFFFF"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Text {
                                text: "Start EPG on channel enter / Return behavior"
                                font.pixelSize: 13
                                color: "#CCCCCC"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                                Layout.maximumWidth: 280
                            }
                        }

                        // ComboBox
                        ComboBox {
                            Layout.preferredWidth: 160
                            Layout.preferredHeight: 40
                            Layout.alignment: Qt.AlignVCenter
                            model: ["Default", "Start EPG on Enter", "Return to Previous", "Stay on Channel"]
                            currentIndex: model.indexOf(navigation)
                            
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
                                elide: Text.ElideRight
                            }

                            onCurrentIndexChanged: navigation = model[currentIndex]
                        }
                    }
                }

                // Channel Number Entry Timeout Section
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
                                    text: "⏱️"
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
                                        text: "Channel Number Entry Timeout"
                                        font.pixelSize: 16
                                        font.weight: Font.SemiBold
                                        color: "#FFFFFF"
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                    }

                                    Text {
                                        text: Math.round(channelNumberTimeout) + "s"
                                        font.pixelSize: 16
                                        font.weight: Font.Bold
                                        color: "#E50914"
                                    }
                                }

                                Text {
                                    text: "How long to wait before processing channel number input"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }
                        }

                        // Slider
                        Slider {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            from: 1
                            to: 5
                            stepSize: 0.5
                            value: channelNumberTimeout

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

                            onValueChanged: channelNumberTimeout = value
                        }
                    }
                }

                // Logo Size Section
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
                                    text: "📺"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Logo Size"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Size of channel logos in the channel list and guide"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }
                        }

                        // SegmentedControl
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            Layout.alignment: Qt.AlignHCenter

                            Repeater {
                                model: ["Small", "Medium", "Large"]

                                Button {
                                    text: modelData
                                    Layout.preferredHeight: 36
                                    Layout.preferredWidth: 80
                                    background: Rectangle {
                                        color: channelLogoSize === modelData ? "#E50914" : "transparent"
                                        radius: 18
                                        border.color: channelLogoSize === modelData ? "#E50914" : "#666666"
                                        border.width: 1
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#FFFFFF"
                                        font.pixelSize: 14
                                        font.weight: Font.Medium
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: channelLogoSize = modelData
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}