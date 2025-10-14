import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: helpCenter
    color: "#0E0E0E"

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
            anchors.topMargin: 40
            anchors.bottomMargin: 80
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
                    font.weight: Font.SemiBold
                    color: "#FFFFFF"
                }

                // Spacer
                Item { Layout.fillWidth: true }
            }

            // Search Bar
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    Text {
                        text: "🔍"
                        font.pixelSize: 16
                        color: "#B3B3B3"
                    }

                    Text {
                        text: "Search help articles..."
                        font.pixelSize: 14
                        color: "#B3B3B3"
                        Layout.fillWidth: true
                    }
                }
            }

            // General Usage Section
            Text {
                text: "General Usage"
                font.pixelSize: 20
                font.weight: Font.Bold
                color: "#FFFFFF"
                Layout.fillWidth: true
                Layout.topMargin: 8
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
                        Layout.preferredHeight: expanded ? questionHeight + answerHeight + 40 : questionHeight + 20
                        color: "#171717"
                        radius: 16
                        border.color: "#2A2A2A"
                        border.width: 1

                        property bool expanded: false
                        property int questionHeight: 60
                        property int answerHeight: 80

                        Behavior on Layout.preferredHeight {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 12

                            // Question Row
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "❓"
                                    font.pixelSize: 20
                                    color: "#E50914"
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Text {
                                    text: modelData.question
                                    font.pixelSize: 18
                                    font.weight: Font.Bold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                }

                                Text {
                                    text: parent.parent.parent.expanded ? "▲" : "▼"
                                    font.pixelSize: 16
                                    color: "#B3B3B3"
                                    Layout.alignment: Qt.AlignVCenter
                                }
                            }

                            // Answer (when expanded)
                            Text {
                                text: modelData.answer
                                font.pixelSize: 14
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                                lineHeight: 1.5
                                visible: parent.parent.expanded
                                opacity: parent.parent.expanded ? 1 : 0
                                
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: parent.expanded = !parent.expanded
                        }
                    }
                }
            }

            // Playback Issues Section
            Text {
                text: "Playback Issues"
                font.pixelSize: 20
                font.weight: Font.Bold
                color: "#FFFFFF"
                Layout.fillWidth: true
                Layout.topMargin: 16
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
                        Layout.preferredHeight: expanded ? questionHeight + answerHeight + 40 : questionHeight + 20
                        color: "#171717"
                        radius: 16
                        border.color: "#2A2A2A"
                        border.width: 1

                        property bool expanded: false
                        property int questionHeight: 60
                        property int answerHeight: 80

                        Behavior on Layout.preferredHeight {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "🔧"
                                    font.pixelSize: 20
                                    color: "#E50914"
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Text {
                                    text: modelData.question
                                    font.pixelSize: 18
                                    font.weight: Font.Bold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                }

                                Text {
                                    text: parent.parent.parent.expanded ? "▲" : "▼"
                                    font.pixelSize: 16
                                    color: "#B3B3B3"
                                    Layout.alignment: Qt.AlignVCenter
                                }
                            }

                            Text {
                                text: modelData.answer
                                font.pixelSize: 14
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                                lineHeight: 1.5
                                visible: parent.parent.expanded
                                opacity: parent.parent.expanded ? 1 : 0
                                
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: parent.expanded = !parent.expanded
                        }
                    }
                }
            }

            // Account & Billing Section
            Text {
                text: "Account & Billing"
                font.pixelSize: 20
                font.weight: Font.Bold
                color: "#FFFFFF"
                Layout.fillWidth: true
                Layout.topMargin: 16
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
                        Layout.preferredHeight: expanded ? questionHeight + answerHeight + 40 : questionHeight + 20
                        color: "#171717"
                        radius: 16
                        border.color: "#2A2A2A"
                        border.width: 1

                        property bool expanded: false
                        property int questionHeight: 60
                        property int answerHeight: 80

                        Behavior on Layout.preferredHeight {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "👤"
                                    font.pixelSize: 20
                                    color: "#E50914"
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Text {
                                    text: modelData.question
                                    font.pixelSize: 18
                                    font.weight: Font.Bold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                }

                                Text {
                                    text: parent.parent.parent.expanded ? "▲" : "▼"
                                    font.pixelSize: 16
                                    color: "#B3B3B3"
                                    Layout.alignment: Qt.AlignVCenter
                                }
                            }

                            Text {
                                text: modelData.answer
                                font.pixelSize: 14
                                color: "#B3B3B3"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                                lineHeight: 1.5
                                visible: parent.parent.expanded
                                opacity: parent.parent.expanded ? 1 : 0
                                
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: parent.expanded = !parent.expanded
                        }
                    }
                }
            }
        }
    }
}
