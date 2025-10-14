import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: seriesHub
    color: "#000000"

    function navigateTo(route) {
        if (typeof parent.navigateTo !== 'undefined') {
            parent.navigateTo(route)
        }
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 40

            Item { Layout.preferredHeight: 32 }

            // Header
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
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

                Text {
                    text: "📺 Series"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }

                Row {
                    spacing: 12
                    
                    Button {
                        text: "Featured"
                        background: Rectangle {
                            color: parent.hovered ? "#E50914" : "#333333"
                            radius: 20
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Filter: Featured")
                    }

                    Button {
                        text: "Trending"
                        background: Rectangle {
                            color: parent.hovered ? "#E50914" : "#333333"
                            radius: 20
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Filter: Trending")
                    }

                    Button {
                        text: "New Seasons"
                        background: Rectangle {
                            color: parent.hovered ? "#E50914" : "#333333"
                            radius: 20
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: console.log("Filter: New Seasons")
                    }
                }
            }

            // Continue Watching Section
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: childrenRect.height
                color: "transparent"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {
                            text: "▶️ Continue Watching"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 4
                            color: "#E50914"
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 300
                        clip: true

                        Row {
                            spacing: 20
                            Repeater {
                                model: 6
                                delegate: Rectangle {
                                    width: 200
                                    height: 280
                                    radius: 12
                                    color: "#111111"
                                    border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                                    border.width: 2
                                    scale: parent.hovered || parent.activeFocus ? 1.08 : 1.0

                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    Behavior on border.color {
                                        ColorAnimation { duration: 200 }
                                    }

                                    Column {
                                        width: parent.width
                                        height: parent.height

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.7
                                            color: "#333333"
                                            radius: 12

                                            Text {
                                                anchors.centerIn: parent
                                                text: "📺"
                                                font.pixelSize: 48
                                                color: "#666666"
                                            }
                                        }

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.3
                                            color: "transparent"
                                            anchors.margins: 12

                                            Column {
                                                anchors.fill: parent
                                                spacing: 4

                                                Text {
                                                    width: parent.width
                                                    text: "Series " + (index + 1)
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    color: "#FFFFFF"
                                                    wrapMode: Text.WordWrap
                                                }

                                                Text {
                                                    width: parent.width
                                                    text: "S2E5 - Episode Title"
                                                    font.pixelSize: 12
                                                    color: "#B3B3B3"
                                                    wrapMode: Text.WordWrap
                                                }

                                                Rectangle {
                                                    width: parent.width
                                                    height: 4
                                                    color: "#333333"
                                                    radius: 2
                                                    Rectangle {
                                                        width: parent.width * (0.3 + index * 0.1)
                                                        height: parent.height
                                                        color: "#E50914"
                                                        radius: 2
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            console.log("Continue watching series " + (index + 1))
                                            // Navigate to series details page
                                            if (typeof navigateTo !== 'undefined') {
                                                navigateTo("/series/details")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Featured Series Section
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: childrenRect.height
                color: "transparent"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {
                            text: "⭐ Featured Series"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 4
                            color: "#E50914"
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 300
                        clip: true

                        Row {
                            spacing: 20
                            Repeater {
                                model: 8
                                delegate: Rectangle {
                                    width: 180
                                    height: 270
                                    radius: 12
                                    color: "#111111"
                                    border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                                    border.width: 2
                                    scale: parent.hovered || parent.activeFocus ? 1.08 : 1.0

                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    Behavior on border.color {
                                        ColorAnimation { duration: 200 }
                                    }

                                    Column {
                                        width: parent.width
                                        height: parent.height

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.8
                                            color: "#333333"
                                            radius: 12

                                            Text {
                                                anchors.centerIn: parent
                                                text: "📺"
                                                font.pixelSize: 48
                                                color: "#666666"
                                            }
                                        }

                                        Text {
                                            width: parent.width
                                            height: parent.height * 0.2
                                            text: "Featured " + (index + 1)
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#FFFFFF"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            anchors.margins: 8
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            console.log("Navigate to series details")
                                            // Navigate to series details page
                                            if (typeof navigateTo !== 'undefined') {
                                                navigateTo("/series/details")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Trending Now Section
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: childrenRect.height
                color: "transparent"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {
                            text: "🔥 Trending Now"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 4
                            color: "#E50914"
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 300
                        clip: true

                        Row {
                            spacing: 20
                            Repeater {
                                model: 6
                                delegate: Rectangle {
                                    width: 180
                                    height: 270
                                    radius: 12
                                    color: "#111111"
                                    border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                                    border.width: 2
                                    scale: parent.hovered || parent.activeFocus ? 1.08 : 1.0

                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    Behavior on border.color {
                                        ColorAnimation { duration: 200 }
                                    }

                                    Column {
                                        width: parent.width
                                        height: parent.height

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.8
                                            color: "#333333"
                                            radius: 12

                                            Text {
                                                anchors.centerIn: parent
                                                text: "📺"
                                                font.pixelSize: 48
                                                color: "#666666"
                                            }
                                        }

                                        Text {
                                            width: parent.width
                                            height: parent.height * 0.2
                                            text: "Trending " + (index + 1)
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#FFFFFF"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            anchors.margins: 8
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            console.log("Navigate to series details")
                                            // Navigate to series details page
                                            if (typeof navigateTo !== 'undefined') {
                                                navigateTo("/series/details")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // New Seasons Section
            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.preferredHeight: childrenRect.height
                color: "transparent"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Text {
                            text: "🆕 New Seasons"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 4
                            color: "#E50914"
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 300
                        clip: true

                        Row {
                            spacing: 20
                            Repeater {
                                model: 5
                                delegate: Rectangle {
                                    width: 200
                                    height: 280
                                    radius: 12
                                    color: "#111111"
                                    border.color: parent.hovered || parent.activeFocus ? "#E50914" : "transparent"
                                    border.width: 2
                                    scale: parent.hovered || parent.activeFocus ? 1.08 : 1.0

                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                                    }
                                    Behavior on border.color {
                                        ColorAnimation { duration: 200 }
                                    }

                                    Column {
                                        width: parent.width
                                        height: parent.height

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.7
                                            color: "#333333"
                                            radius: 12

                                            Text {
                                                anchors.centerIn: parent
                                                text: "📺"
                                                font.pixelSize: 48
                                                color: "#666666"
                                            }

                                            // New season badge
                                            Rectangle {
                                                anchors.top: parent.top
                                                anchors.right: parent.right
                                                anchors.margins: 8
                                                width: 60
                                                height: 24
                                                radius: 12
                                                color: "#E50914"

                                                Text {
                                                    anchors.centerIn: parent
                                                    text: "NEW"
                                                    font.pixelSize: 10
                                                    font.bold: true
                                                    color: "#FFFFFF"
                                                }
                                            }
                                        }

                                        Rectangle {
                                            width: parent.width
                                            height: parent.height * 0.3
                                            color: "transparent"
                                            anchors.margins: 12

                                            Column {
                                                anchors.fill: parent
                                                spacing: 4

                                                Text {
                                                    width: parent.width
                                                    text: "Series " + (index + 1)
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    color: "#FFFFFF"
                                                    wrapMode: Text.WordWrap
                                                }

                                                Text {
                                                    width: parent.width
                                                    text: "Season " + (index + 3) + " Available"
                                                    font.pixelSize: 12
                                                    color: "#B3B3B3"
                                                    wrapMode: Text.WordWrap
                                                }
                                            }
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            console.log("Navigate to series details")
                                            // Navigate to series details page
                                            if (typeof navigateTo !== 'undefined') {
                                                navigateTo("/series/details")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item { Layout.preferredHeight: 32 }
        }
    }
}
