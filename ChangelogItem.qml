import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string type: "feature" // feature, improvement, bugfix, security
    property string title: ""
    property string description: ""
    
    Layout.fillWidth: true
    Layout.preferredHeight: childrenRect.height + 20
    color: "transparent"
    
    RowLayout {
        anchors.fill: parent
        spacing: 15
        
        // Type icon
        Rectangle {
            width: 30
            height: 30
            radius: 15
            color: {
                switch(type) {
                    case "feature": return "#3498db"
                    case "improvement": return "#f39c12"
                    case "bugfix": return "#e74c3c"
                    case "security": return "#9b59b6"
                    default: return "#95a5a6"
                }
            }
            
            Text {
                anchors.centerIn: parent
                text: {
                    switch(type) {
                        case "feature": return "✨"
                        case "improvement": return "⚡"
                        case "bugfix": return "🐛"
                        case "security": return "🔒"
                        default: return "📝"
                    }
                }
                font.pixelSize: 14
                color: "white"
            }
        }
        
        // Content
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 5
            
            Text {
                text: title
                font.pixelSize: 14
                font.bold: true
                color: "#2c3e50"
                Layout.fillWidth: true
            }
            
            Text {
                text: description
                font.pixelSize: 12
                color: "#6c757d"
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }
        }
    }
}

