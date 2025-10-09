import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../styles"

Column {
    id: root
    spacing: Theme.spacing6
    anchors.centerIn: parent
    width: Math.min(parent.width * 0.8, 400)
    
    property string icon: "📭"
    property string title: "Nothing here"
    property string subtitle: "No items to display"
    property string ctaText: ""
    signal ctaClicked()
    
    Text {
        text: root.icon
        font.pixelSize: 64
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Text {
        text: root.title
        font.pixelSize: Theme.font2Xl
        font.bold: true
        color: Theme.text
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Text {
        text: root.subtitle
        font.pixelSize: Theme.fontBase
        color: Theme.textSecondary
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Button {
        visible: root.ctaText !== ""
        text: root.ctaText
        anchors.horizontalCenter: parent.horizontalCenter
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
        onClicked: root.ctaClicked()
    }
}

