import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../styles"

Rectangle {
    color: Theme.bg
    
    signal retryClicked()
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: Theme.spacing8
        width: Math.min(parent.width * 0.8, 500)
        
        Rectangle {
            width: 120
            height: 120
            radius: 60
            color: "#e74c3c"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: "⚠️"
                font.pixelSize: 60
            }
        }
        
        Text {
            text: "Something Went Wrong"
            font.pixelSize: Theme.font3Xl
            font.bold: true
            color: Theme.text
            Layout.alignment: Qt.AlignHCenter
        }
        
        Text {
            text: "We encountered an unexpected error"
            font.pixelSize: Theme.fontBase
            color: Theme.textSecondary
            Layout.alignment: Qt.AlignHCenter
        }
        
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: Theme.spacing4
            
            Button {
                text: "Retry"
                height: 48
                background: Rectangle {
                    color: Theme.accent
                    radius: Theme.radiusMedium
                }
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: Theme.fontBase
                    font.bold: true
                    color: Theme.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: retryClicked()
            }
            
            Button {
                text: "Go Back"
                height: 48
                background: Rectangle {
                    color: "transparent"
                    radius: Theme.radiusMedium
                    border.color: Theme.border
                    border.width: 2
                }
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: Theme.fontBase
                    color: Theme.textSecondary
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}

