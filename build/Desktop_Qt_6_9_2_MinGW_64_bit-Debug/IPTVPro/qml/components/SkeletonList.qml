import QtQuick 2.15
import "../styles"

Column {
    id: root
    spacing: Theme.spacing4
    
    property int count: 3
    property int itemHeight: 80
    
    Repeater {
        model: root.count
        
        Rectangle {
            width: parent.width
            height: root.itemHeight
            color: Theme.surface
            radius: Theme.radiusMedium
            
            Rectangle {
                id: shimmer
                anchors.fill: parent
                radius: parent.radius
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 0.5; color: Theme.borderLight }
                    GradientStop { position: 1.0; color: "transparent" }
                }
                opacity: 0.3
                
                SequentialAnimation on x {
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation { from: -parent.width; to: parent.width; duration: 1500 }
                }
            }
        }
    }
}

