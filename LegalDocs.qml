import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: legalDocs
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
                    text: "Legal Information"
                    font.pixelSize: 28
                    font.weight: Font.SemiBold
                    color: "#FFFFFF"
                }

                // Spacer
                Item { Layout.fillWidth: true }
            }

            // Terms of Service Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 300
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    Text {
                        text: "Terms of Service"
                        font.pixelSize: 18
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                        Layout.fillWidth: true
                        Layout.bottomMargin: 8
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true

                        Text {
                            width: parent.width
                            text: "Last updated: January 1, 2025\n\n1. Acceptance of Terms\nBy using IPTV Pro, you agree to be bound by these Terms of Service and all applicable laws and regulations.\n\n2. Use License\nPermission is granted to temporarily download one copy of IPTV Pro for personal, non-commercial transitory viewing only.\n\n3. Disclaimer\nThe materials on IPTV Pro are provided on an 'as is' basis. IPTV Pro makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties.\n\n4. Limitations\nIn no event shall IPTV Pro or its suppliers be liable for any damages arising out of the use or inability to use the materials on IPTV Pro.\n\n5. Accuracy of Materials\nThe materials appearing on IPTV Pro could include technical, typographical, or photographic errors.\n\n6. Links\nIPTV Pro has not reviewed all of the sites linked to our application and is not responsible for the contents of any such linked site."
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.5
                        }
                    }
                }
            }

            // Privacy Policy Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 300
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    Text {
                        text: "Privacy Policy"
                        font.pixelSize: 18
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                        Layout.fillWidth: true
                        Layout.bottomMargin: 8
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true

                        Text {
                            width: parent.width
                            text: "Last updated: January 1, 2025\n\n1. Information We Collect\nWe may collect information you provide directly to us, such as when you create an account, contact us, or use our services.\n\n2. How We Use Your Information\nWe use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.\n\n3. Information Sharing\nWe do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.\n\n4. Data Security\nWe implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.\n\n5. Cookies and Tracking\nWe may use cookies and similar tracking technologies to collect and use personal information about you.\n\n6. Your Rights\nYou have the right to access, update, or delete the information we have on you. You may also opt out of certain communications from us.\n\n7. Changes to This Policy\nWe may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page."
                            font.pixelSize: 14
                            color: "#B3B3B3"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.5
                        }
                    }
                }
            }

            // Disclaimer Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    Text {
                        text: "Disclaimer"
                        font.pixelSize: 18
                        font.weight: Font.Bold
                        color: "#FFFFFF"
                        Layout.fillWidth: true
                        Layout.bottomMargin: 8
                    }

                    Text {
                        text: "IPTV Pro is a media player application that does not provide or host any content. This application only acts as a player for content provided by third-party IPTV services.\n\nUsers are responsible for ensuring they have proper licensing and rights to access the content they stream through this application. IPTV Pro is not affiliated with any content providers and does not endorse or promote any specific IPTV service.\n\nBy using this application, you acknowledge that you are solely responsible for the legality of the content you access and that IPTV Pro bears no responsibility for any copyright infringement or illegal content accessed through third-party services."
                        font.pixelSize: 14
                        color: "#B3B3B3"
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                        lineHeight: 1.5
                    }
                }
            }

            // Footer
            Text {
                text: "© 2025 IPTV Pro — All rights reserved"
                font.pixelSize: 12
                color: "#666666"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.topMargin: 16
            }
        }
    }
}
