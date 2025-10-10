import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: playerControls
    color: "transparent"
    
    property bool isPlaying: false
    property real playbackPosition: 0.3
    property real bufferedPosition: 0.7
    
    signal togglePlay()
    signal showInfo()
    signal zapUp()
    signal zapDown()
    signal togglePiP()
    signal showMultiView()
    signal backPressed()
    signal showError()
    signal toggleRecording()
    
    Behavior on opacity {
        NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
    }
    
    Rectangle {
        id: controlsBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        height: 120
        radius: 12
        color: "#0B0B0BE0"
        
        layer.enabled: true
        layer.effect: ShaderEffect {
            property variant source: controlsBar
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
            id: shadow
            anchors.fill: parent
            anchors.margins: -8
            radius: parent.radius + 2
            color: "transparent"
            border.color: "#33000000"
            border.width: 8
            z: -1
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            
            Rectangle {
                id: progressContainer
                Layout.fillWidth: true
                Layout.preferredHeight: 6
                color: "#404040"
                radius: 3
                
                Rectangle {
                    id: buffered
                    width: parent.width * bufferedPosition
                    height: parent.height
                    color: "#666666"
                    radius: parent.radius
                    opacity: 0.6
                }
                
                Rectangle {
                    id: played
                    width: parent.width * playbackPosition
                    height: parent.height
                    color: "#E50914"
                    radius: parent.radius
                    
                    Rectangle {
                        id: handle
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width: 16
                        height: 16
                        radius: 8
                        color: "#E50914"
                        scale: handleArea.containsMouse ? 1.3 : 1.0
                        visible: handleArea.containsMouse || handleArea.pressed
                        
                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.OutBack }
                        }
                    }
                }
                
                MouseArea {
                    id: handleArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onPositionChanged: {
                        if (pressed) {
                            var newPos = Math.max(0, Math.min(1, mouse.x / width))
                            playbackPosition = newPos
                        }
                    }
                }
            }
            
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 12
                
                component ControlButton: Button {
                    id: control
                    property string label: ""
                    property string iconText: ""
                    property bool isActive: false
                    
                    Layout.preferredWidth: 52
                    Layout.preferredHeight: 48
                    
                    scale: hovered ? 1.08 : 1.0
                    
                    Behavior on scale {
                        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                    }
                    
                    background: Rectangle {
                        radius: 10
                        color: control.isActive ? "#2E2E2E" : (control.hovered ? "#262626" : "#1E1E1E")
                        border.color: control.activeFocus ? "#E50914" : "transparent"
                        border.width: 2
                        
                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                        
                        Rectangle {
                            anchors.fill: parent
                            radius: parent.radius
                            color: "#E50914"
                            opacity: control.isActive ? 0.15 : 0
                            
                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                        }
                    }
                    
                    contentItem: Text {
                        text: control.iconText
                        font.pixelSize: 20
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    ToolTip {
                        visible: parent.hovered
                        text: control.label
                        delay: 500
                        
                        background: Rectangle {
                            color: "#1E1E1E"
                            radius: 6
                            border.color: "#E50914"
                            border.width: 1
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "#FFFFFF"
                            font.pixelSize: 12
                        }
                    }
                }
                
                ControlButton {
                    iconText: "⏮"
                    label: "Zap Down (↓)"
                    onClicked: zapDown()
                }
                
                ControlButton {
                    iconText: "🔊"
                    label: "Audio Tracks (A)"
                    onClicked: console.log("Audio tracks")
                }
                
                ControlButton {
                    iconText: "🖼"
                    label: "Aspect Ratio (F)"
                    onClicked: console.log("Aspect ratio")
                }
                
                Item { Layout.fillWidth: true }
                
                Button {
                    id: playPauseBtn
                    Layout.preferredWidth: 64
                    Layout.preferredHeight: 64
                    
                    scale: hovered ? 1.1 : 1.0
                    
                    Behavior on scale {
                        NumberAnimation { duration: 150; easing.type: Easing.OutBack }
                    }
                    
                    background: Rectangle {
                        radius: 32
                        color: playPauseBtn.hovered ? "#F5191F" : "#E50914"
                        border.color: playPauseBtn.activeFocus ? "#FFFFFF" : "transparent"
                        border.width: 2
                        
                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                        
                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width + 8
                            height: parent.height + 8
                            radius: width / 2
                            color: "transparent"
                            border.color: "#E50914"
                            border.width: 2
                            opacity: playPauseBtn.hovered ? 0.3 : 0
                            
                            Behavior on opacity {
                                NumberAnimation { duration: 200 }
                            }
                        }
                    }
                    
                    contentItem: Text {
                        text: isPlaying ? "⏸" : "▶"
                        font.pixelSize: 28
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        togglePlay()
                        isPlaying = !isPlaying
                    }
                }
                
                Item { Layout.fillWidth: true }
                
                ControlButton {
                    iconText: "ℹ"
                    label: "Info (I)"
                    onClicked: showInfo()
                }
                
                ControlButton {
                    iconText: "🌀"
                    label: "Deinterlace (D)"
                    onClicked: console.log("Deinterlace")
                }
                
                ControlButton {
                    iconText: "📊"
                    label: "Stats (S)"
                    onClicked: showError()
                }
                
                ControlButton {
                    iconText: "🧩"
                    label: "Multi-View (M)"
                    onClicked: showMultiView()
                }
                
                ControlButton {
                    iconText: "🖥"
                    label: "Picture-in-Picture (P)"
                    onClicked: togglePiP()
                }
                
                ControlButton {
                    iconText: "⏺"
                    label: "Record (R)"
                    isActive: false
                    onClicked: toggleRecording()
                }
                
                ControlButton {
                    iconText: "⏭"
                    label: "Zap Up (↑)"
                    onClicked: zapUp()
                }
            }
        }
    }
    
    Button {
        id: backBtn
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        width: 52
        height: 52
        
        scale: hovered ? 1.1 : 1.0
        
        Behavior on scale {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
        
        background: Rectangle {
            radius: 26
            color: backBtn.hovered ? "#262626" : "#80000000"
            border.color: backBtn.activeFocus ? "#E50914" : "transparent"
            border.width: 2
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }
        }
        
        contentItem: Text {
            text: "←"
            font.pixelSize: 24
            color: "#FFFFFF"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: backPressed()
        
        ToolTip {
            visible: parent.hovered
            text: "Back (Esc)"
            delay: 500
            
            background: Rectangle {
                color: "#1E1E1E"
                radius: 6
                border.color: "#E50914"
                border.width: 1
            }
            
            contentItem: Text {
                text: parent.text
                color: "#FFFFFF"
                font.pixelSize: 12
            }
        }
    }
}
