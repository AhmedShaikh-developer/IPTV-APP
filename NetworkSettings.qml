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
    property var customHeaders: []

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

    function showCustomHeadersDialog() {
        console.log("Show custom headers dialog")
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
                        text: "Network"
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
                            proxyEnabled = false
                            proxyHost = ""
                            proxyPort = ""
                            proxyUsername = ""
                            proxyPassword = ""
                            userAgentOverride = ""
                            httpsRelaxMode = false
                            customHeaders = []
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

                // Proxy Section
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
                            text: "Proxy"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Proxy Enable Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Enable Proxy"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: proxyEnabled
                                        onCheckedChanged: proxyEnabled = checked

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
                                    }
                                }

                                Text {
                                    text: "Route network traffic through a proxy server"
                                    font.pixelSize: 13
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        // Proxy Configuration (shown when enabled)
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 16
                            visible: proxyEnabled

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 1
                                color: "#2A2A2A"
                            }

                            // Proxy Host
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Host"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40
                                    text: proxyHost
                                    placeholderText: "proxy.example.com"
                                    selectByMouse: true

                                    background: Rectangle {
                                        color: "#171717"
                                        radius: 8
                                        border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                        border.width: 1
                                    }

                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    rightPadding: 12

                                    onTextChanged: proxyHost = text
                                }
                            }

                            // Proxy Port
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Port"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40
                                    text: proxyPort
                                    placeholderText: "8080"
                                    selectByMouse: true
                                    inputMethodHints: Qt.ImhDigitsOnly

                                    background: Rectangle {
                                        color: "#171717"
                                        radius: 8
                                        border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                        border.width: 1
                                    }

                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    rightPadding: 12

                                    onTextChanged: proxyPort = text
                                }
                            }

                            // Proxy Username
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Username (Optional)"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40
                                    text: proxyUsername
                                    placeholderText: "username"
                                    selectByMouse: true

                                    background: Rectangle {
                                        color: "#171717"
                                        radius: 8
                                        border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                        border.width: 1
                                    }

                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    rightPadding: 12

                                    onTextChanged: proxyUsername = text
                                }
                            }

                            // Proxy Password
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "Password (Optional)"
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40
                                    text: proxyPassword
                                    placeholderText: "password"
                                    echoMode: TextInput.Password
                                    selectByMouse: true

                                    background: Rectangle {
                                        color: "#171717"
                                        radius: 8
                                        border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                        border.width: 1
                                    }

                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                    leftPadding: 12
                                    rightPadding: 12

                                    onTextChanged: proxyPassword = text
                                }
                            }
                        }
                    }
                }

                // Advanced Section
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
                            text: "Advanced"
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            color: "#FFFFFF"
                        }

                        // Custom Headers
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 16

                                Text {
                                    text: "Custom Headers per Source"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                Item { Layout.fillWidth: true }

                                Button {
                                    text: "Manage..."
                                    Layout.preferredHeight: 36
                                    Layout.preferredWidth: 100
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
                                    onClicked: showCustomHeadersDialog()
                                }
                            }

                            Text {
                                text: "Add custom HTTP headers for specific sources"
                                font.pixelSize: 13
                                color: "#B3B3B3"
                                wrapMode: Text.WordWrap
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            color: "#2A2A2A"
                        }

                        // User-Agent Override
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "User-Agent Override"
                                font.pixelSize: 16
                                font.weight: Font.Medium
                                color: "#FFFFFF"
                            }

                            TextField {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 48
                                text: userAgentOverride
                                placeholderText: "Custom User-Agent string"
                                selectByMouse: true

                                background: Rectangle {
                                    color: "#171717"
                                    radius: 12
                                    border.color: parent.activeFocus ? "#E50914" : "#2A2A2A"
                                    border.width: 1
                                }

                                color: "#FFFFFF"
                                font.pixelSize: 15
                                leftPadding: 16
                                rightPadding: 16

                                onTextChanged: userAgentOverride = text
                            }

                            Text {
                                text: "Override the default User-Agent header for HTTP requests"
                                font.pixelSize: 13
                                color: "#B3B3B3"
                                wrapMode: Text.WordWrap
                            }
                        }

                        // HTTPS Relax Mode Toggle
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 20

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Text {
                                    text: "HTTPS Relax Mode"
                                    font.pixelSize: 16
                                    font.weight: Font.Medium
                                    color: "#FFFFFF"
                                }

                                RowLayout {
                                    spacing: 12

                                    Switch {
                                        checked: httpsRelaxMode
                                        onCheckedChanged: httpsRelaxMode = checked

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
                                    }
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40
                                    color: httpsRelaxMode ? "#FF4D4F15" : "#171717"
                                    radius: 8
                                    border.color: httpsRelaxMode ? "#FF4D4F" : "#2A2A2A"
                                    border.width: 1

                                    Text {
                                        anchors.centerIn: parent
                                        text: "⚠️ Warning: This may reduce security by accepting invalid certificates"
                                        font.pixelSize: 12
                                        color: httpsRelaxMode ? "#FF4D4F" : "#B3B3B3"
                                        horizontalAlignment: Text.AlignHCenter
                                        wrapMode: Text.WordWrap
                                    }
                                }

                                Text {
                                    text: "Relax HTTPS certificate validation (use with caution)"
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
