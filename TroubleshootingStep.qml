import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string step: ""
    property string description: ""
    
    Layout.fillWidth: true
    height: 40
    color: "transparent"
    
    RowLayout {
        anchors.fill: parent
        spacing: 15
        
        Text {
            text: step
            font.pixelSize: 12
            font.bold: true
            color: "#2c3e50"
            Layout.preferredWidth: 200
        }
        
        Text {
            text: description
            font.pixelSize: 12
            color: "#6c757d"
            Layout.fillWidth: true
        }
    }
}

