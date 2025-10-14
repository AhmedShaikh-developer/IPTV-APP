import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: networkSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Mock settings state
    property bool proxyEnabled: false
    property string proxyHost: ""
    property string proxyPort: ""
    property string proxyUsername: ""
    property string proxyPassword: ""
    property string userAgentOverride: ""
    property bool httpsRelaxMode: false

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
                    text: "Network"
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
                        proxyEnabled = false
                        proxyHost = ""
                        proxyPort = ""
                        proxyUsername = ""
                        proxyPassword = ""
                        userAgentOverride = ""
                        httpsRelaxMode = false
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

                // Proxy Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: proxyEnabled ? 280 : 100
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
                                    text: "🔗"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Proxy"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Route network traffic through a proxy server"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }

                            // Toggle Switch
                            RowLayout {
                                spacing: 8
                                Layout.alignment: Qt.AlignVCenter

                                Switch {
                                    checked: proxyEnabled
                                    onCheckedChanged: proxyEnabled = checked
                                    Layout.preferredWidth: 50
                                    Layout.preferredHeight: 30

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
                                    text: proxyEnabled ? "Enabled" : "Disabled"
                                    font.pixelSize: 14
                                    color: proxyEnabled ? "#E50914" : "#B3B3B3"
                                    Layout.alignment: Qt.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                }
                            }
                        }

                        // Proxy Configuration Fields (stacked in right column)
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12
                            visible: proxyEnabled

                            // Host and Port Row
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 36
                                    text: proxyHost
                                    placeholderText: "Host"
                                    enabled: proxyEnabled
                                    selectByMouse: true

                                    background: Rectangle {
                                        color: proxyEnabled ? "#2A2A2A" : "#1A1A1A"
                                        radius: 6
                                        border.color: parent.activeFocus ? "#E50914" : "#444444"
                                        border.width: 1
                                        opacity: proxyEnabled ? 1.0 : 0.5
                                    }

                                    color: proxyEnabled ? "#FFFFFF" : "#666666"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    rightPadding: 12

                                    onTextChanged: proxyHost = text
                                }

                                TextField {
                                    Layout.preferredWidth: 80
                                    Layout.preferredHeight: 36
                                    text: proxyPort
                                    placeholderText: "Port"
                                    enabled: proxyEnabled
                                    selectByMouse: true
                                    inputMethodHints: Qt.ImhDigitsOnly

                                    background: Rectangle {
                                        color: proxyEnabled ? "#2A2A2A" : "#1A1A1A"
                                        radius: 6
                                        border.color: parent.activeFocus ? "#E50914" : "#444444"
                                        border.width: 1
                                        opacity: proxyEnabled ? 1.0 : 0.5
                                    }

                                    color: proxyEnabled ? "#FFFFFF" : "#666666"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    rightPadding: 12

                                    onTextChanged: proxyPort = text
                                }
                            }

                            // Username and Password Row
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 36
                                    text: proxyUsername
                                    placeholderText: "Username"
                                    enabled: proxyEnabled
                                    selectByMouse: true

                                    background: Rectangle {
                                        color: proxyEnabled ? "#2A2A2A" : "#1A1A1A"
                                        radius: 6
                                        border.color: parent.activeFocus ? "#E50914" : "#444444"
                                        border.width: 1
                                        opacity: proxyEnabled ? 1.0 : 0.5
                                    }

                                    color: proxyEnabled ? "#FFFFFF" : "#666666"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    rightPadding: 12

                                    onTextChanged: proxyUsername = text
                                }

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 36
                                    text: proxyPassword
                                    placeholderText: "Password"
                                    echoMode: TextInput.Password
                                    enabled: proxyEnabled
                                    selectByMouse: true

                                    background: Rectangle {
                                        color: proxyEnabled ? "#2A2A2A" : "#1A1A1A"
                                        radius: 6
                                        border.color: parent.activeFocus ? "#E50914" : "#444444"
                                        border.width: 1
                                        opacity: proxyEnabled ? 1.0 : 0.5
                                    }

                                    color: proxyEnabled ? "#FFFFFF" : "#666666"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    rightPadding: 12

                                    onTextChanged: proxyPassword = text
                                }
                            }
                        }
                    }
                }

                // Custom User-Agent Section
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
                                text: "🔧"
                                font.pixelSize: 20
                            }
                        }

                        // Text Content
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 2

                            Text {
                                text: "Custom User-Agent"
                                font.pixelSize: 16
                                font.weight: Font.SemiBold
                                color: "#FFFFFF"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Text {
                                text: "Override the default User-Agent header for HTTP requests"
                                font.pixelSize: 13
                                color: "#CCCCCC"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                                Layout.maximumWidth: 280
                            }
                        }

                        // Text Field
                        TextField {
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 40
                            text: userAgentOverride
                            placeholderText: "Custom User-Agent string"
                            selectByMouse: true

                            background: Rectangle {
                                color: "#2A2A2A"
                                radius: 6
                                border.color: parent.activeFocus ? "#E50914" : "#444444"
                                border.width: 1
                            }

                            color: "#FFFFFF"
                            font.pixelSize: 14
                            leftPadding: 12
                            rightPadding: 12

                            onTextChanged: userAgentOverride = text
                        }
                    }
                }

                // Relax HTTPS Validation Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: httpsRelaxMode ? 140 : 100
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
                                    text: "🔒"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Relax HTTPS Validation"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Relax HTTPS certificate validation (use with caution)"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }

                            // Toggle Switch
                            RowLayout {
                                spacing: 8
                                Layout.alignment: Qt.AlignVCenter

                                Switch {
                                    checked: httpsRelaxMode
                                    onCheckedChanged: httpsRelaxMode = checked
                                    Layout.preferredWidth: 50
                                    Layout.preferredHeight: 30

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
                                    text: httpsRelaxMode ? "Enabled" : "Disabled"
                                    font.pixelSize: 14
                                    color: httpsRelaxMode ? "#E50914" : "#B3B3B3"
                                    Layout.alignment: Qt.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                }
                            }
                        }

                        // Warning Banner (full content width)
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            color: httpsRelaxMode ? "#FF4D4F15" : "transparent"
                            radius: 8
                            border.color: httpsRelaxMode ? "#FF4D4F" : "transparent"
                            border.width: 1
                            visible: httpsRelaxMode

                            RowLayout {
                                anchors.centerIn: parent
                                spacing: 8

                                Text {
                                    text: "⚠️"
                                    font.pixelSize: 16
                                    color: "#FF4D4F"
                                }

                                Text {
                                    text: "This may reduce security by accepting invalid certificates"
                                    font.pixelSize: 12
                                    color: "#FF4D4F"
                                    Layout.fillWidth: true
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