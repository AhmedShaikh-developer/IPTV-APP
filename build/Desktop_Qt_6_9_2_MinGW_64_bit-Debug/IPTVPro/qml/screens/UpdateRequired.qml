import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../styles"

Rectangle {
    color: Theme.bg
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: Theme.spacing8
        width: Math.min(parent.width * 0.8, 600)
        
        Rectangle {
            width: 100
            height: 100
            radius: 50
            color: "#e74c3c"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: "🔄"
                font.pixelSize: 50
            }
        }
        
        Text {
            text: "Update Required"
            font.pixelSize: Theme.font3Xl
            font.bold: true
            color: Theme.text
            Layout.alignment: Qt.AlignHCenter
        }
        
        Text {
            text: "A new version is available"
            font.pixelSize: Theme.fontBase
            color: Theme.textSecondary
            Layout.alignment: Qt.AlignHCenter
        }
        
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            color: Theme.surface
            radius: Theme.radiusMedium
            
            Column {
                anchors.fill: parent
                anchors.margins: Theme.spacing6
                spacing: Theme.spacing4
                
                Text {
                    text: "What's New"
                    font.pixelSize: Theme.fontLg
                    font.bold: true
                    color: Theme.text
                }
                
                Text {
                    text: "• Performance improvements\n• Bug fixes\n• New features"
                    font.pixelSize: Theme.fontSm
                    color: Theme.textSecondary
                    lineHeight: 1.5
                }
            }
        }
        
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: Theme.spacing4
            
            Button {
                text: "App Store"
                enabled: false
                height: 48
                background: Rectangle {
                    color: "#007AFF"
                    opacity: parent.enabled ? 1.0 : 0.5
                    radius: Theme.radiusMedium
                }
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: Theme.fontBase
                    color: Theme.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            Button {
                text: "Google Play"
                enabled: false
                height: 48
                background: Rectangle {
                    color: "#01875F"
                    opacity: parent.enabled ? 1.0 : 0.5
                    radius: Theme.radiusMedium
                }
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: Theme.fontBase
                    color: Theme.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}

