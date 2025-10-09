import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../styles"

Rectangle {
    id: root
    color: Theme.bg
    
    signal bootCompleted()
    
    property bool networkOk: false
    property bool authOk: false
    property bool sourceOk: false
    property bool subscriptionOk: false
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: Theme.spacing10
        width: Math.min(parent.width * 0.8, 600)
        
        Rectangle {
            width: 120
            height: 120
            radius: Theme.radiusMedium
            color: Theme.accent
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: "N"
                font.pixelSize: 80
                font.bold: true
                color: Theme.text
            }
            
            RotationAnimation on rotation {
                running: true
                loops: Animation.Infinite
                duration: 2000
                from: 0
                to: 360
            }
        }
        
        Text {
            text: "IPTV Pro"
            font.pixelSize: Theme.font4Xl
            font.bold: true
            color: Theme.accent
            Layout.alignment: Qt.AlignHCenter
        }
        
        Rectangle {
            Layout.preferredWidth: 200
            Layout.preferredHeight: 4
            color: Theme.border
            radius: Theme.radiusSmall
            Layout.alignment: Qt.AlignHCenter
            
            Rectangle {
                height: parent.height
                radius: parent.radius
                color: Theme.accent
                width: parent.width * progressValue
                
                property real progressValue: 0
                
                SequentialAnimation on progressValue {
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation { to: 1; duration: 2000; easing.type: Easing.InOutQuad }
                    NumberAnimation { to: 0; duration: 500 }
                }
            }
        }
        
        Column {
            Layout.alignment: Qt.AlignHCenter
            spacing: Theme.spacing3
            
            CheckItem {
                text: "Checking network..."
                checked: networkOk
            }
            
            CheckItem {
                text: "Validating auth..."
                checked: authOk
            }
            
            CheckItem {
                text: "Loading sources..."
                checked: sourceOk
            }
            
            CheckItem {
                text: "Checking subscription..."
                checked: subscriptionOk
            }
        }
    }
    
    Component {
        id: checkItemComponent
        
        Row {
            spacing: Theme.spacing3
            
            property string text: ""
            property bool checked: false
            
            Text {
                text: parent.checked ? "✓" : "⏳"
                font.pixelSize: Theme.fontBase
                color: parent.checked ? "#27ae60" : Theme.textSecondary
            }
            
            Text {
                text: parent.text
                font.pixelSize: Theme.fontBase
                color: Theme.textSecondary
            }
        }
    }
    
    component CheckItem: Row {
        property string text: ""
        property bool checked: false
        spacing: Theme.spacing3
        
        Text {
            text: checked ? "✓" : "⏳"
            font.pixelSize: Theme.fontBase
            color: checked ? "#27ae60" : Theme.textSecondary
        }
        
        Text {
            text: parent.text
            font.pixelSize: Theme.fontBase
            color: Theme.textSecondary
        }
    }
    
    Timer {
        interval: 800
        repeat: true
        running: true
        property int step: 0
        
        onTriggered: {
            switch(step) {
                case 0: networkOk = true; break
                case 1: authOk = true; break
                case 2: sourceOk = true; break
                case 3: subscriptionOk = true; break
                case 4: bootCompleted(); stop(); break
            }
            step++
        }
    }
}

