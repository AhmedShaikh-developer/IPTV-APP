import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property alias statusText: statusText.text
    property string status: "checking" // checking, success, error
    
    height: 30
    color: "transparent"
    
    RowLayout {
        anchors.fill: parent
        spacing: 15
        
        // Status icon
        Text {
            id: statusIcon
            text: {
                switch(parent.parent.status) {
                    case "checking": return "⏳"
                    case "success": return "✅"
                    case "error": return "❌"
                    default: return "⏳"
                }
            }
            font.pixelSize: 16
            color: {
                switch(parent.parent.status) {
                    case "checking": return "#f39c12"
                    case "success": return "#27ae60"
                    case "error": return "#e74c3c"
                    default: return "#f39c12"
                }
            }
        }
        
        // Status text
        Text {
            id: statusText
            text: "Checking..."
            font.pixelSize: 14
            color: "#bdc3c7"
            Layout.fillWidth: true
        }
    }
}

