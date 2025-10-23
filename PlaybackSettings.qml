import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: playbackSettings
    color: "#000000"

    property var screenWidth: parent.width
    property bool isDesktop: screenWidth >= 1920
    property bool isTablet: screenWidth >= 1366 && screenWidth < 1920
    property bool isMobile: screenWidth < 1366

    // Settings state
    property bool hardwareDecode: appSettings ? appSettings.playbackHwDecode : true
    property bool autoFrameRate: appSettings ? appSettings.playbackAfr : false
    property string bufferSize: appSettings ? appSettings.playbackBuffer : "medium"
    property string defaultAudioLanguage: "English"
    property string defaultSubtitles: "Off"
    property bool useExternalPlayer: false
    property string externalPlayer: "VLC"

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
                        appSettings.' + key + ' = ' + (typeof value === 'string' ? '"' + value + '"' : value) + '
                    }
                }
            }
        ', playbackSettings)
        
        writeTimers[key].start()
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
                    text: "Playback"
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
                        hardwareDecode = true
                        autoFrameRate = false
                        bufferSize = "Medium"
                        defaultAudioLanguage = "English"
                        defaultSubtitles = "Off"
                        useExternalPlayer = false
                        externalPlayer = "VLC"
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

                // Hardware & AFR Section
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

                        // Hardware Decode Row
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
                                    text: "⚙️"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Hardware Decode"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Use hardware acceleration for video decoding"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }

                            RowLayout {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.preferredWidth: 140
                                spacing: 8

                                Switch {
                                    checked: hardwareDecode
                                    onCheckedChanged: {
                                        hardwareDecode = checked
                                        writeSetting("playbackHwDecode", checked)
                                    }

                                    indicator: Rectangle {
                                        implicitWidth: 48
                                        implicitHeight: 28
                                        radius: 14
                                        color: parent.checked ? "#E50914" : "#666666"
                                        border.color: parent.checked ? "#E50914" : "#999999"

                                        Rectangle {
                                            x: parent.checked ? parent.width - width - 2 : 2
                                            width: 24
                                            height: 24
                                            radius: 12
                                            color: parent.parent.checked ? "#FFFFFF" : "#CCCCCC"
                                            anchors.verticalCenter: parent.verticalCenter

                                            Behavior on x {
                                                NumberAnimation { duration: 200 }
                                            }
                                        }
                                    }
                                }

                                Text {
                                    text: hardwareDecode ? "Enabled" : "Disabled"
                                    font.pixelSize: 14
                                    color: hardwareDecode ? "#E50914" : "#B3B3B3"
                                    Layout.fillWidth: true
                                    horizontalAlignment: Text.AlignLeft
                                }
                            }
                        }

                        // Auto Frame Rate Row
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
                                    text: "🔄"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Auto Frame Rate (AFR)"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Match video frame rate to display refresh rate"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }

                            RowLayout {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.preferredWidth: 140
                                spacing: 8

                                Switch {
                                    checked: autoFrameRate
                                    onCheckedChanged: {
                                        autoFrameRate = checked
                                        writeSetting("playbackAfr", checked)
                                    }

                                    indicator: Rectangle {
                                        implicitWidth: 48
                                        implicitHeight: 28
                                        radius: 14
                                        color: parent.checked ? "#E50914" : "#666666"
                                        border.color: parent.checked ? "#E50914" : "#999999"

                                        Rectangle {
                                            x: parent.checked ? parent.width - width - 2 : 2
                                            width: 24
                                            height: 24
                                            radius: 12
                                            color: parent.parent.checked ? "#FFFFFF" : "#CCCCCC"
                                            anchors.verticalCenter: parent.verticalCenter

                                            Behavior on x {
                                                NumberAnimation { duration: 200 }
                                            }
                                        }
                                    }
                                }

                                Text {
                                    text: autoFrameRate ? "Enabled" : "Disabled"
                                    font.pixelSize: 14
                                    color: autoFrameRate ? "#E50914" : "#B3B3B3"
                                    Layout.fillWidth: true
                                    horizontalAlignment: Text.AlignLeft
                                }
                            }
                        }
                    }
                }

                // Buffer Size Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
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
                                text: "📊"
                                font.pixelSize: 20
                            }
                        }

                        // Text Content
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 2

                            Text {
                                text: "Buffer Size"
                                font.pixelSize: 16
                                font.weight: Font.SemiBold
                                color: "#FFFFFF"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Text {
                                text: "Low: Faster start, more buffering. High: Slower start, smoother playback."
                                font.pixelSize: 13
                                color: "#CCCCCC"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                                Layout.maximumWidth: 280
                            }
                        }

                        // SegmentedControl
                        ColumnLayout {
                            Layout.alignment: Qt.AlignVCenter
                            Layout.preferredWidth: 160
                            spacing: 4

                            RowLayout {
                                spacing: 6
                                Layout.alignment: Qt.AlignHCenter

                                Repeater {
                                    model: ["Low", "Medium", "High"]

                                    Button {
                                        text: modelData
                                        Layout.preferredHeight: 32
                                        Layout.preferredWidth: 50
                                        background: Rectangle {
                                            color: bufferSize === modelData ? "#E50914" : "transparent"
                                            radius: 16
                                            border.color: bufferSize === modelData ? "#E50914" : "#666666"
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
                                        onClicked: {
                                            bufferSize = modelData
                                            writeSetting("playbackBuffer", modelData)
                                        }
                                    }
                                }
                            }

                            Text {
                                text: bufferSize
                                font.pixelSize: 12
                                color: "#E50914"
                                font.weight: Font.Medium
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }

                // Audio & Subtitles Section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 160
                    color: "#1A1A1A"
                    radius: 12
                    border.color: "#333333"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 16

                        // Default Audio Language Row
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
                                    text: "🔊"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Default Audio Language"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Preferred audio language for multi-language content"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }

                            ComboBox {
                                Layout.preferredWidth: 160
                                Layout.preferredHeight: 40
                                Layout.alignment: Qt.AlignVCenter
                                model: ["English", "Spanish", "French", "German", "Italian", "Portuguese", "Chinese", "Japanese", "Korean", "Auto"]
                                currentIndex: model.indexOf(defaultAudioLanguage)
                                
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

                                onCurrentIndexChanged: defaultAudioLanguage = model[currentIndex]
                            }
                        }

                        // Default Subtitles Row
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
                                    text: "💬"
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 2

                                Text {
                                    text: "Default Subtitles"
                                    font.pixelSize: 16
                                    font.weight: Font.SemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: "Default subtitle language or disable subtitles"
                                    font.pixelSize: 13
                                    color: "#CCCCCC"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 280
                                }
                            }

                            ComboBox {
                                Layout.preferredWidth: 160
                                Layout.preferredHeight: 40
                                Layout.alignment: Qt.AlignVCenter
                                model: ["Off", "Auto", "English", "Spanish", "French", "German", "Italian", "Portuguese", "Chinese", "Japanese", "Korean"]
                                currentIndex: model.indexOf(defaultSubtitles)
                                
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

                                onCurrentIndexChanged: defaultSubtitles = model[currentIndex]
                            }
                        }
                    }
                }

                // External Player Section
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
                                text: "▶️"
                                font.pixelSize: 20
                            }
                        }

                        // Text Content
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 2

                            Text {
                                text: "External Player"
                                font.pixelSize: 16
                                font.weight: Font.SemiBold
                                color: "#FFFFFF"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Text {
                                text: "Use external media player for video playback"
                                font.pixelSize: 13
                                color: "#CCCCCC"
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                                Layout.maximumWidth: 280
                            }
                        }

                        // Toggle
                        RowLayout {
                            Layout.alignment: Qt.AlignVCenter
                            Layout.preferredWidth: 140
                            spacing: 8

                            Switch {
                                checked: useExternalPlayer
                                onCheckedChanged: useExternalPlayer = checked

                                indicator: Rectangle {
                                    implicitWidth: 48
                                    implicitHeight: 28
                                    radius: 14
                                    color: parent.checked ? "#E50914" : "#666666"
                                    border.color: parent.checked ? "#E50914" : "#999999"

                                    Rectangle {
                                        x: parent.checked ? parent.width - width - 2 : 2
                                        width: 24
                                        height: 24
                                        radius: 12
                                        color: parent.parent.checked ? "#FFFFFF" : "#CCCCCC"
                                        anchors.verticalCenter: parent.verticalCenter

                                        Behavior on x {
                                            NumberAnimation { duration: 200 }
                                        }
                                    }
                                }
                            }

                            Text {
                                text: useExternalPlayer ? "Enabled" : "Disabled"
                                font.pixelSize: 14
                                color: useExternalPlayer ? "#E50914" : "#B3B3B3"
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignLeft
                            }
                        }
                    }
                }
            }
        }
    }
}