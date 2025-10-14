import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: settingsRow
    height: 64
    color: "transparent"
    
    property alias icon: iconText.text
    property alias title: titleText.text
    property alias subtitle: subtitleText.text
    property alias control: controlLoader.sourceComponent
    property bool focusable: true
    
    signal clicked()
    
    Rectangle {
        anchors.fill: parent
        color: parent.hovered ? "#1A1A1A" : "transparent"
        radius: 12
        border.color: parent.activeFocus ? "#E50914" : "transparent"
        border.width: 2
        visible: focusable
        
        Behavior on color { ColorAnimation { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }
    }
    
    MouseArea {
        anchors.fill: parent
        enabled: focusable
        onClicked: settingsRow.clicked()
    }
    
    RowLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16
        
        // Left side: Icon and Labels
        RowLayout {
            Layout.fillWidth: true
            spacing: 16
            
            // Icon
            Text {
                id: iconText
                font.pixelSize: 24
                color: "#E50914"
                Layout.preferredWidth: 32
                Layout.alignment: Qt.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            
            // Labels
            ColumnLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                spacing: 4
                
                Text {
                    id: titleText
                    font.pixelSize: 16
                    font.weight: Font.SemiBold
                    color: "#FFFFFF"
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                }
                
                Text {
                    id: subtitleText
                    font.pixelSize: 13
                    color: "#B3B3B3"
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    visible: text !== ""
                }
            }
        }
        
        // Right side: Control
        Loader {
            id: controlLoader
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
