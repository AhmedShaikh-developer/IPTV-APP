import QtQuick 2.15
import QtQuick.Controls 2.15
import "../styles"

Rectangle {
    id: root
    width: parent.width
    height: 60
    color: Theme.surfaceVariant
    radius: Theme.radiusMedium
    opacity: 0
    y: -height
    z: 9999
    
    property string message: ""
    property int duration: 3000
    
    Text {
        anchors.centerIn: parent
        text: root.message
        font.pixelSize: Theme.fontBase
        color: Theme.text
    }
    
    function show(msg) {
        message = msg
        showAnimation.start()
    }
    
    SequentialAnimation {
        id: showAnimation
        NumberAnimation { target: root; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: root; property: "y"; to: Theme.spacing4; duration: 200 }
        PauseAnimation { duration: root.duration }
        NumberAnimation { target: root; property: "opacity"; to: 0; duration: 200 }
        NumberAnimation { target: root; property: "y"; to: -root.height; duration: 200 }
    }
}

