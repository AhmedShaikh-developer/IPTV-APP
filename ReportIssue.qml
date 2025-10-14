import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: reportIssue
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

    function showConfirmDialog(title, message, callback) {
        console.log("Confirm:", title, message)
        if (callback) callback()
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
                    onClicked: navigateTo("/help")
                }

                // Title
                Text {
                    text: "Report a Problem"
                    font.pixelSize: 28
                    font.weight: Font.SemiBold
                    color: "#FFFFFF"
                }

                // Spacer
                Item { Layout.fillWidth: true }
            }

            // Subtitle
            Text {
                text: "Describe the issue or attach logs for support"
                font.pixelSize: 14
                color: "#B3B3B3"
                Layout.fillWidth: true
            }

            // Form Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 400
                color: "#171717"
                radius: 16
                border.color: "#2A2A2A"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    // Subject Field
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "Subject"
                            font.pixelSize: 16
                            font.weight: Font.SemiBold
                            color: "#FFFFFF"
                        }

                        TextField {
                            id: subjectField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48
                            placeholderText: "Brief description of the issue"
                            
                            background: Rectangle {
                                color: "#0F0F0F"
                                radius: 12
                                border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                border.width: 1
                            }

                            color: "#FFFFFF"
                            font.pixelSize: 14
                            placeholderTextColor: "#666666"
                            leftPadding: 16
                            rightPadding: 16
                        }
                    }

                    // Description Field
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "Description"
                            font.pixelSize: 16
                            font.weight: Font.SemiBold
                            color: "#FFFFFF"
                        }

                        ScrollView {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 120
                            clip: true

                            TextArea {
                                id: descriptionField
                                placeholderText: "Please provide detailed information about the issue, including steps to reproduce it..."
                                
                                background: Rectangle {
                                    color: "#0F0F0F"
                                    radius: 12
                                    border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                    border.width: 1
                                }

                                color: "#FFFFFF"
                                font.pixelSize: 14
                                placeholderTextColor: "#666666"
                                wrapMode: TextArea.Wrap
                                selectByMouse: true
                            }
                        }
                    }

                    // File Upload Section
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "Attach Logs (Optional)"
                            font.pixelSize: 16
                            font.weight: Font.SemiBold
                            color: "#FFFFFF"
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 80
                            color: "#0F0F0F"
                            radius: 12
                            border.color: "#2A2A2A"
                            border.width: 1

                            RowLayout {
                                anchors.centerIn: parent
                                spacing: 12

                                Text {
                                    text: "📎"
                                    font.pixelSize: 24
                                    color: "#B3B3B3"
                                }

                                Text {
                                    text: "Click to attach log files"
                                    font.pixelSize: 14
                                    color: "#B3B3B3"
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: showToast("File upload feature (UI only)")
                            }
                        }
                    }
                }
            }

            // Action Buttons
            RowLayout {
                Layout.fillWidth: true
                spacing: 16

                Button {
                    text: "Cancel"
                    Layout.preferredHeight: 44
                    Layout.preferredWidth: 120

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

                    onClicked: navigateTo("/help")
                }

                Item { Layout.fillWidth: true }

                Button {
                    text: "Send Report"
                    Layout.preferredHeight: 44
                    Layout.preferredWidth: 140

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

                    onClicked: {
                        if (subjectField.text.trim() === "" || descriptionField.text.trim() === "") {
                            showToast("Please fill in all required fields")
                            return
                        }

                        showConfirmDialog("Send Report", "Are you sure you want to send this report?", function() {
                            showToast("Report sent successfully! We'll get back to you soon.")
                            subjectField.text = ""
                            descriptionField.text = ""
                            navigateTo("/help")
                        })
                    }
                }
            }
        }
    }
}
