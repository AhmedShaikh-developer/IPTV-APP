import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: downloadsManager
    color: "#000000"

    property var downloadItems: []
    property string currentFilter: "all"
    property var selectedItems: []

    Component.onCompleted: {
        // Mock data for testing
        downloadItems = [
            {
                id: "1",
                title: "The Dark Knight",
                type: "Movie",
                thumb: "🎬",
                status: "downloading",
                progress: 0.65,
                speed: "5.2 MB/s",
                eta: "2 min left",
                quality: "1080p"
            },
            {
                id: "2",
                title: "Breaking Bad S05E14",
                type: "Series",
                thumb: "📺",
                status: "paused",
                progress: 0.35,
                speed: "0 MB/s",
                eta: "Paused",
                quality: "720p"
            },
            {
                id: "3",
                title: "Inception",
                type: "Movie",
                thumb: "🎬",
                status: "completed",
                progress: 1.0,
                speed: "",
                eta: "Completed",
                quality: "1080p"
            },
            {
                id: "4",
                title: "Game of Thrones S08E03",
                type: "Series",
                thumb: "📺",
                status: "failed",
                progress: 0.12,
                speed: "",
                eta: "Failed",
                quality: "1080p"
            }
        ]
    }

    function getFilteredItems() {
        if (currentFilter === "all") return downloadItems
        if (currentFilter === "inprogress") return downloadItems.filter(function(item) { return item.status === "downloading" || item.status === "queued" })
        if (currentFilter === "completed") return downloadItems.filter(function(item) { return item.status === "completed" })
        if (currentFilter === "failed") return downloadItems.filter(function(item) { return item.status === "failed" })
        if (currentFilter === "paused") return downloadItems.filter(function(item) { return item.status === "paused" })
        return downloadItems
    }

    function togglePause(itemId) {
        for (var i = 0; i < downloadItems.length; i++) {
            if (downloadItems[i].id === itemId) {
                if (downloadItems[i].status === "downloading") {
                    downloadItems[i].status = "paused"
                    downloadItems[i].speed = "0 MB/s"
                    downloadItems[i].eta = "Paused"
                } else if (downloadItems[i].status === "paused") {
                    downloadItems[i].status = "downloading"
                    downloadItems[i].speed = "5.2 MB/s"
                    downloadItems[i].eta = "2 min left"
                }
                downloadItems = downloadItems.slice()
                break
            }
        }
    }

    function cancelItem(itemId) {
        downloadItems = downloadItems.filter(function(item) { return item.id !== itemId })
    }

    function retryItem(itemId) {
        for (var i = 0; i < downloadItems.length; i++) {
            if (downloadItems[i].id === itemId) {
                downloadItems[i].status = "queued"
                downloadItems[i].progress = 0
                downloadItems = downloadItems.slice()
                break
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Top Bar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#111111"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                Button {
                    width: 50
                    height: 50
                    z: 1000
                    background: Rectangle {
                        color: parent.hovered ? "#E50914" : "#FF0000"
                        radius: 25
                        border.color: "#FFFFFF"
                        border.width: 2
                        opacity: 1.0
                    }
                    contentItem: Text {
                        text: "←"
                        font.pixelSize: 24
                        font.bold: true
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        if (typeof navigateTo !== 'undefined') {
                            navigateTo("/home")
                        }
                    }
                }

                Text {
                    text: "Downloads"
                    font.pixelSize: 28
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }

                // Storage meter
                ColumnLayout {
                    spacing: 4
                    Layout.preferredWidth: 200

                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Storage"
                            font.pixelSize: 12
                            color: "#B3B3B3"
                        }
                        Item { Layout.fillWidth: true }
                        Text {
                            text: "2.3 GB / 10 GB"
                            font.pixelSize: 12
                            color: "#B3B3B3"
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 6
                        radius: 3
                        color: "#333333"

                        Rectangle {
                            width: parent.width * 0.23
                            height: parent.height
                            radius: parent.radius
                            color: "#E50914"
                        }
                    }
                }

                Button {
                    text: "Clear All"
                    enabled: downloadItems.length > 0
                    background: Rectangle {
                        color: parent.enabled ? (parent.hovered ? "#E50914" : "transparent") : "transparent"
                        radius: 8
                        border.color: parent.enabled ? "#E50914" : "#555555"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: parent.enabled ? "#FFFFFF" : "#555555"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        downloadItems = []
                        showToast("All downloads cleared")
                    }
                }
            }
        }

        // Tabs
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: "#0D0D0D"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 20

                Repeater {
                    model: [
                        { id: "all", label: "All" },
                        { id: "inprogress", label: "In Progress" },
                        { id: "completed", label: "Completed" },
                        { id: "failed", label: "Failed" },
                        { id: "paused", label: "Paused" }
                    ]

                    Button {
                        text: modelData.label
                        background: Rectangle {
                            color: currentFilter === modelData.id ? "#E50914" : "transparent"
                            radius: 20
                        }
                        contentItem: Text {
                            text: parent.text
                            color: currentFilter === modelData.id ? "#FFFFFF" : "#B3B3B3"
                            font.pixelSize: 14
                            font.bold: currentFilter === modelData.id
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            currentFilter = modelData.id
                        }
                    }
                }

                Item { Layout.fillWidth: true }

                // Bulk actions
                Button {
                    text: "Pause All"
                    visible: selectedItems.length > 0
                    background: Rectangle {
                        color: "transparent"
                        radius: 8
                        border.color: "#E50914"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    text: "Cancel Selected"
                    visible: selectedItems.length > 0
                    background: Rectangle {
                        color: "transparent"
                        radius: 8
                        border.color: "#FF4D4F"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FF4D4F"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }

        // Content Area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#000000"

            // Empty state
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20
                visible: downloadItems.length === 0

                Text {
                    text: "📥"
                    font.pixelSize: 80
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "No downloads yet"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "Start downloading movies and series for offline viewing"
                    font.pixelSize: 14
                    color: "#B3B3B3"
                    Layout.alignment: Qt.AlignHCenter
                }

                Button {
                    text: "Browse Movies"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredHeight: 44
                    background: Rectangle {
                        color: "#E50914"
                        radius: 22
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 20
                        rightPadding: 20
                    }
                    onClicked: {
                        if (typeof navigateTo !== 'undefined') {
                            navigateTo("/movies")
                        }
                    }
                }
            }

            // Download list
            ScrollView {
                anchors.fill: parent
                anchors.margins: 20
                clip: true
                visible: downloadItems.length > 0

                ColumnLayout {
                    width: parent.width
                    spacing: 12

                    Repeater {
                        model: getFilteredItems()

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 100
                            color: "#111111"
                            radius: 12
                            border.color: "#1A1A1A"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 16
                                spacing: 16

                                // Thumbnail
                                Rectangle {
                                    Layout.preferredWidth: 68
                                    Layout.preferredHeight: 68
                                    radius: 8
                                    color: "#333333"

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.thumb
                                        font.pixelSize: 32
                                    }
                                }

                                // Content
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    spacing: 6

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 10

                                        Text {
                                            text: modelData.title
                                            font.pixelSize: 16
                                            font.bold: true
                                            color: "#FFFFFF"
                                            Layout.fillWidth: true
                                        }

                                        Rectangle {
                                            Layout.preferredHeight: 22
                                            Layout.preferredWidth: statusText.width + 16
                                            radius: 11
                                            color: {
                                                if (modelData.status === "downloading") return "#2F80ED"
                                                if (modelData.status === "paused") return "#555555"
                                                if (modelData.status === "completed") return "#12B886"
                                                if (modelData.status === "failed") return "#FF4D4F"
                                                return "#F2C94C"
                                            }

                                            Text {
                                                id: statusText
                                                anchors.centerIn: parent
                                                text: {
                                                    if (modelData.status === "downloading") return "Downloading"
                                                    if (modelData.status === "paused") return "Paused"
                                                    if (modelData.status === "completed") return "Completed"
                                                    if (modelData.status === "failed") return "Failed"
                                                    return "Queued"
                                                }
                                                font.pixelSize: 11
                                                font.bold: true
                                                color: "#FFFFFF"
                                            }
                                        }
                                    }

                                    Text {
                                        text: modelData.type + " • " + modelData.quality
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 8

                                        Rectangle {
                                            Layout.fillWidth: true
                                            height: 4
                                            radius: 2
                                            color: "#333333"

                                            Rectangle {
                                                width: parent.width * modelData.progress
                                                height: parent.height
                                                radius: parent.radius
                                                color: "#E50914"

                                                Behavior on width {
                                                    NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
                                                }
                                            }
                                        }

                                        Text {
                                            text: Math.round(modelData.progress * 100) + "%"
                                            font.pixelSize: 11
                                            color: "#B3B3B3"
                                            Layout.preferredWidth: 35
                                        }
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 10

                                        Text {
                                            text: modelData.speed
                                            font.pixelSize: 11
                                            color: "#B3B3B3"
                                            visible: modelData.speed !== ""
                                        }

                                        Text {
                                            text: "•"
                                            font.pixelSize: 11
                                            color: "#B3B3B3"
                                            visible: modelData.speed !== ""
                                        }

                                        Text {
                                            text: modelData.eta
                                            font.pixelSize: 11
                                            color: "#B3B3B3"
                                        }
                                    }
                                }

                                // Actions
                                RowLayout {
                                    spacing: 8

                                    Button {
                                        visible: modelData.status === "downloading" || modelData.status === "paused"
                                        width: 40
                                        height: 40
                                        background: Rectangle {
                                            color: parent.hovered ? "#1A1A1A" : "transparent"
                                            radius: 20
                                            border.color: "#333333"
                                            border.width: 1
                                        }
                                        contentItem: Text {
                                            text: modelData.status === "downloading" ? "⏸" : "▶"
                                            font.pixelSize: 16
                                            color: "#FFFFFF"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: {
                                            togglePause(modelData.id)
                                            showToast(modelData.status === "downloading" ? "Download paused" : "Download resumed")
                                        }
                                    }

                                    Button {
                                        visible: modelData.status === "failed"
                                        width: 40
                                        height: 40
                                        background: Rectangle {
                                            color: parent.hovered ? "#1A1A1A" : "transparent"
                                            radius: 20
                                            border.color: "#333333"
                                            border.width: 1
                                        }
                                        contentItem: Text {
                                            text: "🔄"
                                            font.pixelSize: 16
                                            color: "#FFFFFF"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: {
                                            retryItem(modelData.id)
                                            showToast("Retrying download")
                                        }
                                    }

                                    Button {
                                        width: 40
                                        height: 40
                                        background: Rectangle {
                                            color: parent.hovered ? "#1A1A1A" : "transparent"
                                            radius: 20
                                            border.color: "#333333"
                                            border.width: 1
                                        }
                                        contentItem: Text {
                                            text: "✕"
                                            font.pixelSize: 16
                                            color: "#FF4D4F"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: {
                                            cancelItem(modelData.id)
                                            showToast("Download cancelled")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Toast notification
    Rectangle {
        id: toast
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        width: toastText.width + 40
        height: 48
        radius: 24
        color: "#0D0D0DB3"
        opacity: 0
        z: 1000

        RowLayout {
            anchors.centerIn: parent
            spacing: 12

            Text {
                text: "✓"
                font.pixelSize: 18
                color: "#12B886"
            }

            Text {
                id: toastText
                font.pixelSize: 14
                color: "#FFFFFF"
            }
        }

        SequentialAnimation {
            id: toastAnimation
            NumberAnimation {
                target: toast
                property: "opacity"
                to: 1
                duration: 200
            }
            PauseAnimation {
                duration: 2000
            }
            NumberAnimation {
                target: toast
                property: "opacity"
                to: 0
                duration: 200
            }
        }
    }

    function showToast(message) {
        toastText.text = message
        toastAnimation.restart()
    }
}

