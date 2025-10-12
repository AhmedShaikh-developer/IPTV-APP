import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: storageSettings
    color: "#000000"

    property real totalStorage: 10.0
    property real usedStorage: 2.3
    property real freeStorage: totalStorage - usedStorage
    property string storageLocation: "device"
    property bool useCellular: false

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#111111"
            layer.enabled: true
            layer.effect: Item {
                anchors.fill: parent
                Rectangle {
                    anchors.fill: parent
                    anchors.topMargin: parent.height
                    height: 4
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#00000040" }
                        GradientStop { position: 1.0; color: "transparent" }
                    }
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                Button {
                    width: 44
                    height: 44
                    background: Rectangle {
                        color: parent.hovered ? "#1A1A1A" : "transparent"
                        radius: 22
                        border.color: "#333333"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: "←"
                        font.pixelSize: 20
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        if (typeof navigateTo !== 'undefined') {
                            navigateTo("/downloads")
                        }
                    }
                }

                Text {
                    text: "Storage Settings"
                    font.pixelSize: 28
                    font.bold: true
                    color: "#FFFFFF"
                }

                Item { Layout.fillWidth: true }
            }
        }

        // Content
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 24
                anchors.margins: 32

                // Storage Overview Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: storageColumn.height + 48
                    Layout.leftMargin: 32
                    Layout.rightMargin: 32
                    Layout.topMargin: 32
                    radius: 16
                    color: "#111111"
                    border.color: "#1A1A1A"
                    border.width: 1

                    ColumnLayout {
                        id: storageColumn
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 20

                        Text {
                            text: "Storage Usage"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#FFFFFF"
                        }

                        // Storage meter
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12

                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 32
                                    radius: 16
                                    color: "#0D0D0D"

                                    RowLayout {
                                        anchors.fill: parent
                                        spacing: 0

                                        Rectangle {
                                            Layout.preferredWidth: parent.width * (usedStorage / totalStorage)
                                            Layout.fillHeight: true
                                            radius: 16
                                            color: "#E50914"

                                            Text {
                                                anchors.centerIn: parent
                                                text: usedStorage.toFixed(1) + " GB"
                                                font.pixelSize: 12
                                                font.bold: true
                                                color: "#FFFFFF"
                                                visible: parent.width > 60
                                            }

                                            Behavior on Layout.preferredWidth {
                                                NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
                                            }
                                        }

                                        Rectangle {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            radius: 16
                                            color: "transparent"

                                            Text {
                                                anchors.centerIn: parent
                                                text: freeStorage.toFixed(1) + " GB Free"
                                                font.pixelSize: 12
                                                color: "#B3B3B3"
                                                visible: parent.width > 80
                                            }
                                        }
                                    }
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 20

                                ColumnLayout {
                                    spacing: 4

                                    Text {
                                        text: "Total"
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                    }

                                    Text {
                                        text: totalStorage.toFixed(1) + " GB"
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#FFFFFF"
                                    }
                                }

                                ColumnLayout {
                                    spacing: 4

                                    Text {
                                        text: "Used"
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                    }

                                    Text {
                                        text: usedStorage.toFixed(1) + " GB"
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#E50914"
                                    }
                                }

                                ColumnLayout {
                                    spacing: 4

                                    Text {
                                        text: "Free"
                                        font.pixelSize: 12
                                        color: "#B3B3B3"
                                    }

                                    Text {
                                        text: freeStorage.toFixed(1) + " GB"
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#12B886"
                                    }
                                }

                                Item { Layout.fillWidth: true }
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 1
                            color: "#1A1A1A"
                        }

                        Button {
                            text: "View Downloads"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48
                            background: Rectangle {
                                color: parent.hovered ? "#F5191F" : "#E50914"
                                radius: 24
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#FFFFFF"
                                font.pixelSize: 15
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                if (typeof navigateTo !== 'undefined') {
                                    navigateTo("/downloads")
                                }
                            }
                        }
                    }
                }

                // Storage Location Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: locationColumn.height + 48
                    Layout.leftMargin: 32
                    Layout.rightMargin: 32
                    radius: 16
                    color: "#111111"
                    border.color: "#1A1A1A"
                    border.width: 1

                    ColumnLayout {
                        id: locationColumn
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 16

                        Text {
                            text: "Download Location"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#FFFFFF"
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                radius: 12
                                color: storageLocation === "device" ? "#1A1A1A" : "transparent"
                                border.color: storageLocation === "device" ? "#E50914" : "#333333"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 16
                                    spacing: 12

                                    Text {
                                        text: "📱"
                                        font.pixelSize: 24
                                    }

                                    Text {
                                        text: "Device Storage"
                                        font.pixelSize: 14
                                        color: "#FFFFFF"
                                    }

                                    Item { Layout.fillWidth: true }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        storageLocation = "device"
                                    }
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                radius: 12
                                color: storageLocation === "external" ? "#1A1A1A" : "transparent"
                                border.color: storageLocation === "external" ? "#E50914" : "#333333"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 16
                                    spacing: 12

                                    Text {
                                        text: "💾"
                                        font.pixelSize: 24
                                    }

                                    Text {
                                        text: "External Storage"
                                        font.pixelSize: 14
                                        color: "#FFFFFF"
                                    }

                                    Item { Layout.fillWidth: true }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        storageLocation = "external"
                                    }
                                }
                            }
                        }
                    }
                }

                // Download Settings Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: settingsColumn.height + 48
                    Layout.leftMargin: 32
                    Layout.rightMargin: 32
                    radius: 16
                    color: "#111111"
                    border.color: "#1A1A1A"
                    border.width: 1

                    ColumnLayout {
                        id: settingsColumn
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 20

                        Text {
                            text: "Download Settings"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#FFFFFF"
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 16

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 4

                                Text {
                                    text: "Use cellular for downloads"
                                    font.pixelSize: 15
                                    color: "#FFFFFF"
                                }

                                Text {
                                    text: "Download over mobile data when Wi-Fi is unavailable"
                                    font.pixelSize: 12
                                    color: "#B3B3B3"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                }
                            }

                            Switch {
                                checked: useCellular
                                onToggled: {
                                    useCellular = checked
                                }
                            }
                        }
                    }
                }

                // Maintenance Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: maintenanceColumn.height + 48
                    Layout.leftMargin: 32
                    Layout.rightMargin: 32
                    Layout.bottomMargin: 32
                    radius: 16
                    color: "#111111"
                    border.color: "#1A1A1A"
                    border.width: 1

                    ColumnLayout {
                        id: maintenanceColumn
                        anchors.fill: parent
                        anchors.margins: 24
                        spacing: 16

                        Text {
                            text: "Maintenance"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#FFFFFF"
                        }

                        Button {
                            text: "Clear Cached Artwork"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48
                            background: Rectangle {
                                color: parent.hovered ? "#1A1A1A" : "transparent"
                                radius: 24
                                border.color: "#333333"
                                border.width: 1
                            }
                            contentItem: RowLayout {
                                spacing: 12

                                Text {
                                    text: "🗑️"
                                    font.pixelSize: 18
                                    Layout.leftMargin: 16
                                }

                                Text {
                                    text: "Clear Cached Artwork"
                                    color: "#FFFFFF"
                                    font.pixelSize: 15
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: "245 MB"
                                    color: "#B3B3B3"
                                    font.pixelSize: 13
                                    Layout.rightMargin: 16
                                }
                            }
                        }

                        Button {
                            text: "Delete Completed Downloads"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 48
                            background: Rectangle {
                                color: parent.hovered ? "#1A1A1A" : "transparent"
                                radius: 24
                                border.color: "#FF4D4F"
                                border.width: 1
                            }
                            contentItem: RowLayout {
                                spacing: 12

                                Text {
                                    text: "🗑️"
                                    font.pixelSize: 18
                                    Layout.leftMargin: 16
                                }

                                Text {
                                    text: "Delete Completed Downloads"
                                    color: "#FF4D4F"
                                    font.pixelSize: 15
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: "2.1 GB"
                                    color: "#B3B3B3"
                                    font.pixelSize: 13
                                    Layout.rightMargin: 16
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

