import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: playerInfoBar
    color: "transparent"
    
    property bool isVisible: false
    
    function slideIn() {
        isVisible = true
        slideAnimation.to = 0
        slideAnimation.start()
        autoHideTimer.restart()
    }
    
    function slideOut() {
        isVisible = false
        slideAnimation.to = infoPanel.height + 20
        slideAnimation.start()
    }
    
    Timer {
        id: autoHideTimer
        interval: 4000
        onTriggered: slideOut()
    }
    
    Rectangle {
        id: infoPanel
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        height: 220
        y: height + 20
        radius: 12
        color: "#0B0B0BE0"
        
        NumberAnimation on y {
            id: slideAnimation
            duration: 300
            easing.type: Easing.OutCubic
        }
        
        layer.enabled: true
        layer.effect: ShaderEffect {
            property variant source: infoPanel
            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform sampler2D source;
                uniform lowp float qt_Opacity;
                void main() {
                    gl_FragColor = texture2D(source, qt_TexCoord0) * qt_Opacity;
                }
            "
        }
        
        Rectangle {
            anchors.fill: parent
            anchors.margins: -6
            radius: parent.radius + 2
            color: "transparent"
            border.color: "#33000000"
            border.width: 6
            z: -1
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 25
            spacing: 18
            
            RowLayout {
                Layout.fillWidth: true
                spacing: 20
                
                Rectangle {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 75
                    radius: 10
                    color: "#1E1E1E"
                    border.color: "#2f2f2f"
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "📺"
                        font.pixelSize: 40
                        color: "#FFFFFF"
                    }
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12
                        
                        Text {
                            text: "BBC News HD"
                            font.pixelSize: 26
                            font.bold: true
                            color: "#FFFFFF"
                        }
                        
                        Rectangle {
                            width: 50
                            height: 24
                            radius: 12
                            color: "#E50914"
                            
                            Text {
                                anchors.centerIn: parent
                                text: "LIVE"
                                font.pixelSize: 11
                                font.bold: true
                                color: "#FFFFFF"
                            }
                            
                            SequentialAnimation on opacity {
                                running: true
                                loops: Animation.Infinite
                                NumberAnimation { from: 1.0; to: 0.6; duration: 800 }
                                NumberAnimation { from: 0.6; to: 1.0; duration: 800 }
                            }
                        }
                    }
                    
                    Text {
                        text: "Channel 24 • HD • News"
                        font.pixelSize: 15
                        color: "#B3B3B3"
                    }
                    
                    Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: 1
                        color: "transparent"
                        Layout.topMargin: 4
                    }
                    
                    Text {
                        text: "Now: News Live"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#FFFFFF"
                    }
                }
                
                Button {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 44
                    
                    background: Rectangle {
                        radius: 22
                        color: parent.hovered ? "#2E2E2E" : "#1E1E1E"
                        border.color: parent.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                        
                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                    }
                    
                    contentItem: Text {
                        text: "✕"
                        font.pixelSize: 20
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: slideOut()
                }
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "#2f2f2f"
            }
            
            RowLayout {
                Layout.fillWidth: true
                spacing: 20
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    
                    Text {
                        text: "19:00 - 20:30"
                        font.pixelSize: 14
                        color: "#B3B3B3"
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 6
                        radius: 3
                        color: "#2f2f2f"
                        
                        Rectangle {
                            width: parent.width * 0.65
                            height: parent.height
                            radius: parent.radius
                            color: "#E50914"
                        }
                    }
                    
                    Text {
                        text: "65% complete • 29 min remaining"
                        font.pixelSize: 12
                        color: "#B3B3B3"
                    }
                }
            }
            
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Text {
                    text: "Next:"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#E50914"
                }
                
                Text {
                    text: "BBC Newsroom • 20:30"
                    font.pixelSize: 14
                    color: "#FFFFFF"
                    Layout.fillWidth: true
                }
            }
        }
    }
}

