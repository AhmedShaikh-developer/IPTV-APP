import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: helpCenter
    color: "#0E0E0E"
    
    // Fade-in animation
    opacity: 0
    Component.onCompleted: {
        fadeInAnimation.start()
    }
    
    OpacityAnimator {
        id: fadeInAnimation
        target: helpCenter
        from: 0
        to: 1
        duration: 150
        easing.type: Easing.OutCubic
    }

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1080
    property bool isTablet: screenWidth >= 768 && screenWidth < 1080
    property bool isMobile: screenWidth < 768

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    function showToast(message) {
        console.log("Toast:", message)
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
            anchors.topMargin: isMobile ? 20 : 40
            anchors.bottomMargin: isMobile ? 40 : 80
            spacing: 24

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
                    onClicked: navigateTo("/home")
                }

                // Title
                Text {
                    text: "Help Center"
                    font.pixelSize: 28
                    font.weight: Font.Bold
                    color: "#FFFFFF"
                }

                // Spacer
                Item { Layout.fillWidth: true }
            }

            // Search Bar
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 44
                color: "#171717"
                radius: 12
                border.color: "#2A2A2A"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    Text {
                        text: "🔍"
                        font.pixelSize: 16
                        color: "#E50914"
                    }

                    Text {
                        text: "Search help articles..."
                        font.pixelSize: 14
                        color: "#A0A0A0"
                        Layout.fillWidth: true
                    }
                }
            }

            // General Usage Section
            ColumnLayout {
                Layout.fillWidth: true
                Layout.topMargin: 32
                spacing: 8

                Text {
                    text: "General Usage"
                    font.pixelSize: 18
                    font.weight: Font.DemiBold
                    color: "#FFFFFF"
                    Layout.fillWidth: true
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#2A2A2A"
                    opacity: 0.6
                }
            }

            // FAQ Cards
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 16

                Repeater {
                    model: [
                        {
                            question: "How do I add IPTV sources?",
                            answer: "Go to Settings > Sources and choose your preferred method: Xtream Codes, M3U playlist, or Stalker Portal. Enter your credentials or upload your playlist file."
                        },
                        {
                            question: "Can I use multiple IPTV providers?",
                            answer: "Yes, you can add multiple IPTV sources from different providers. Each source will appear as a separate category in your channel list."
                        },
                        {
                            question: "How do I create custom channel groups?",
                            answer: "Navigate to Live TV > Custom Groups and click 'Create Group'. Select channels from your available sources and organize them as needed."
                        }
                    ]

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? generalQuestionText.height + generalAnswerText.height + 60 : generalQuestionText.height + 40
                        Layout.bottomMargin: 14
                        color: hovered ? "#1E1E1E" : "#171717"
                        radius: 16
                        border.color: "#2A2A2A"
                        border.width: 1

                        property bool expanded: false
                        property bool hovered: false

                        Behavior on Layout.preferredHeight {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }

                        // Shadow effect on hover
                        Rectangle {
                            anchors.fill: parent
                            anchors.topMargin: hovered ? 2 : 0
                            color: "transparent"
                            border.color: Qt.rgba(0, 0, 0, 0.4)
                            border.width: hovered ? 1 : 0
                            radius: 16
                            opacity: hovered ? 0.3 : 0
                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                            Behavior on anchors.topMargin {
                                NumberAnimation { duration: 200 }
                            }
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 8

                            // Question Row
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12

                                // Accent Icon
                                Rectangle {
                                    Layout.preferredWidth: 24
                                    Layout.preferredHeight: 24
                                    color: "#E50914"
                                    radius: 12

                                    Text {
                                        anchors.centerIn: parent
                                        text: "?"
                                        font.pixelSize: 14
                                        font.weight: Font.Bold
                                        color: "#FFFFFF"
                                    }
                                }

                                Text {
                                    id: generalQuestionText
                                    text: modelData.question
                                    font.pixelSize: 16
                                    font.weight: Font.DemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                    Layout.maximumWidth: parent.width * 0.85
                                }

                                Text {
                                    text: "▼"
                                    font.pixelSize: 16
                                    color: "#E50914"
                                    Layout.alignment: Qt.AlignRight

                                    Behavior on rotation {
                                        NumberAnimation { duration: 200 }
                                    }
                                    rotation: parent.parent.expanded ? 90 : 0
                                }
                            }

                            // Answer (when expanded)
                            Text {
                                id: generalAnswerText
                                text: modelData.answer
                                font.pixelSize: 15
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                                lineHeight: 1.5
                                visible: parent.parent.expanded
                                Layout.topMargin: 8

                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: parent.hovered = true
                            onExited: parent.hovered = false
                            onClicked: parent.expanded = !parent.expanded
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }

            // Playback Issues Section
            ColumnLayout {
                Layout.fillWidth: true
                Layout.topMargin: 32
                spacing: 8

                Text {
                    text: "Playback Issues"
                    font.pixelSize: 18
                    font.weight: Font.DemiBold
                    color: "#FFFFFF"
                    Layout.fillWidth: true
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#2A2A2A"
                    opacity: 0.6
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 16

                Repeater {
                    model: [
                        {
                            question: "Video won't play or shows error",
                            answer: "Check your internet connection and verify your IPTV provider credentials. Try switching between different video players in Settings > Playback."
                        },
                        {
                            question: "Channels load slowly or buffer",
                            answer: "This is usually network-related. Try switching to a different CDN server in Settings > Network, or contact your IPTV provider for server status."
                        },
                        {
                            question: "No audio or wrong audio track",
                            answer: "Go to Settings > Playback and check your audio settings. Some channels have multiple audio tracks - use the audio menu during playback to switch tracks."
                        }
                    ]

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? playbackQuestionText.height + playbackAnswerText.height + 60 : playbackQuestionText.height + 40
                        Layout.bottomMargin: 14
                        color: hovered ? "#1E1E1E" : "#171717"
                        radius: 16
                        border.color: "#2A2A2A"
                        border.width: 1

                        property bool expanded: false
                        property bool hovered: false

                        Behavior on Layout.preferredHeight {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }

                        // Shadow effect on hover
                        Rectangle {
                            anchors.fill: parent
                            anchors.topMargin: hovered ? 2 : 0
                            color: "transparent"
                            border.color: Qt.rgba(0, 0, 0, 0.4)
                            border.width: hovered ? 1 : 0
                            radius: 16
                            opacity: hovered ? 0.3 : 0
                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                            Behavior on anchors.topMargin {
                                NumberAnimation { duration: 200 }
                            }
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12

                                // Accent Icon
                                Rectangle {
                                    Layout.preferredWidth: 24
                                    Layout.preferredHeight: 24
                                    color: "#E50914"
                                    radius: 12

                                    Text {
                                        anchors.centerIn: parent
                                        text: "🔧"
                                        font.pixelSize: 14
                                        color: "#FFFFFF"
                                    }
                                }

                                Text {
                                    id: playbackQuestionText
                                    text: modelData.question
                                    font.pixelSize: 16
                                    font.weight: Font.DemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                    Layout.maximumWidth: parent.width * 0.85
                                }

                                Text {
                                    text: "▼"
                                    font.pixelSize: 16
                                    color: "#E50914"
                                    Layout.alignment: Qt.AlignRight

                                    Behavior on rotation {
                                        NumberAnimation { duration: 200 }
                                    }
                                    rotation: parent.parent.expanded ? 90 : 0
                                }
                            }

                            Text {
                                id: playbackAnswerText
                                text: modelData.answer
                                font.pixelSize: 15
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                                lineHeight: 1.5
                                visible: parent.parent.expanded
                                Layout.topMargin: 8

                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: parent.hovered = true
                            onExited: parent.hovered = false
                            onClicked: parent.expanded = !parent.expanded
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }

            // Account & Billing Section
            ColumnLayout {
                Layout.fillWidth: true
                Layout.topMargin: 32
                spacing: 8

                Text {
                    text: "Account & Billing"
                    font.pixelSize: 18
                    font.weight: Font.DemiBold
                    color: "#FFFFFF"
                    Layout.fillWidth: true
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#2A2A2A"
                    opacity: 0.6
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 16

                Repeater {
                    model: [
                        {
                            question: "How do I manage my subscription?",
                            answer: "Go to Settings > Account to view your subscription details, manage devices, and update payment information. For billing issues, contact your IPTV provider directly."
                        },
                        {
                            question: "Can I use IPTV Pro on multiple devices?",
                            answer: "Yes, IPTV Pro supports multiple devices. Check your subscription plan for the exact number of simultaneous connections allowed."
                        }
                    ]

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: expanded ? accountQuestionText.height + accountAnswerText.height + 60 : accountQuestionText.height + 40
                        Layout.bottomMargin: 14
                        color: hovered ? "#1E1E1E" : "#171717"
                        radius: 16
                        border.color: "#2A2A2A"
                        border.width: 1

                        property bool expanded: false
                        property bool hovered: false

                        Behavior on Layout.preferredHeight {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }

                        // Shadow effect on hover
                        Rectangle {
                            anchors.fill: parent
                            anchors.topMargin: hovered ? 2 : 0
                            color: "transparent"
                            border.color: Qt.rgba(0, 0, 0, 0.4)
                            border.width: hovered ? 1 : 0
                            radius: 16
                            opacity: hovered ? 0.3 : 0
                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                            Behavior on anchors.topMargin {
                                NumberAnimation { duration: 200 }
                            }
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12

                                // Accent Icon
                                Rectangle {
                                    Layout.preferredWidth: 24
                                    Layout.preferredHeight: 24
                                    color: "#E50914"
                                    radius: 12

                                    Text {
                                        anchors.centerIn: parent
                                        text: "💳"
                                        font.pixelSize: 14
                                        color: "#FFFFFF"
                                    }
                                }

                                Text {
                                    id: accountQuestionText
                                    text: modelData.question
                                    font.pixelSize: 16
                                    font.weight: Font.DemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                    Layout.maximumWidth: parent.width * 0.85
                                }

                                Text {
                                    text: "▼"
                                    font.pixelSize: 16
                                    color: "#E50914"
                                    Layout.alignment: Qt.AlignRight

                                    Behavior on rotation {
                                        NumberAnimation { duration: 200 }
                                    }
                                    rotation: parent.parent.expanded ? 90 : 0
                                }
                            }

                            Text {
                                id: accountAnswerText
                                text: modelData.answer
                                font.pixelSize: 15
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                                lineHeight: 1.5
                                visible: parent.parent.expanded
                                Layout.topMargin: 8

                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: parent.hovered = true
                            onExited: parent.hovered = false
                            onClicked: parent.expanded = !parent.expanded
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }
        }
    }

    // Floating Contact Support Button
    Button {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 24
        anchors.rightMargin: 24
        width: 140
        height: 40
        
        background: Rectangle {
            color: "#E50914"
            radius: 20
            border.width: 0
            
            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
        
        contentItem: Text {
            text: "Contact Support"
            font.pixelSize: 14
            font.weight: Font.Medium
            color: "#FFFFFF"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: navigateTo("/help/report")
        
        // Hover effect
        onHoveredChanged: {
            background.color = hovered ? "#FF1E1E" : "#E50914"
        }
    }
}