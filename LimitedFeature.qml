import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string feature: ""
    property string status: ""
    property bool available: false
    
    Layout.fillWidth: true
    height: 25
    color: "transparent"
    
    RowLayout {
        anchors.fill: parent
        spacing: 10
        
        Text {
            text: feature
            font.pixelSize: 12
            color: "#495057"
            Layout.fillWidth: true
        }
        
        Rectangle {
            width: 8
            height: 8
            radius: 4
            color: available ? "#27ae60" : "#e74c3c"
        }
        
        Text {
            text: status
            font.pixelSize: 12
            color: available ? "#27ae60" : "#e74c3c"
        }
    }
}

