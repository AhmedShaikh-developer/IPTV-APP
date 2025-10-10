import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: zapOverlay
    color: "transparent"
    
    property int currentChannelIndex: 2
    property bool isVisible: false
    
    function show() {
        isVisible = true
        slideAnimation.to = parent.height - zapPanel.height - 160
        slideAnimation.start()
        autoHideTimer.restart()
    }
    
    function hide() {
        isVisible = false
        slideAnimation.to = parent.height + 20
        slideAnimation.start()
    }
    
    function zapUp() {
        if (currentChannelIndex < channelModel.count - 1) {
            currentChannelIndex++
            zapList.positionViewAtIndex(currentChannelIndex, ListView.Center)
        }
    }
    
    function zapDown() {
        if (currentChannelIndex > 0) {
            currentChannelIndex--
            zapList.positionViewAtIndex(currentChannelIndex, ListView.Center)
        }
    }
    
    Timer {
        id: autoHideTimer
        interval: 3000
        onTriggered: hide()
    }
    
    Rectangle {
        id: zapPanel
        anchors.horizontalCenter: parent.horizontalCenter
        width: Math.min(parent.width - 100, 800)
        height: 140
        y: parent.height + 20
        radius: 12
        color: "#0B0B0BE0"
        
        NumberAnimation on y {
            id: slideAnimation
            duration: 300
            easing.type: Easing.OutCubic
        }
        
        layer.enabled: true
        layer.effect: ShaderEffect {
            property variant source: zapPanel
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
        
        RowLayout {
            anchors.fill: parent
            spacing: 0
            
            Button {
                Layout.preferredWidth: 50
                Layout.fillHeight: true
                
                background: Rectangle {
                    color: parent.hovered ? "#262626" : "transparent"
                    radius: 12
                }
                
                contentItem: Text {
                    text: "◀"
                    font.pixelSize: 24
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    zapList.decrementCurrentIndex()
                    autoHideTimer.restart()
                }
            }
            
            ListView {
                id: zapList
                Layout.fillWidth: true
                Layout.fillHeight: true
                orientation: ListView.Horizontal
                spacing: 15
                clip: true
                currentIndex: currentChannelIndex
                
                model: ListModel {
                    id: channelModel
                    ListElement { name: "BBC One"; logo: "📺"; number: "1"; current: "News at 10" }
                    ListElement { name: "ITV"; logo: "📺"; number: "2"; current: "Coronation Street" }
                    ListElement { name: "Channel 4"; logo: "📺"; number: "3"; current: "Bake Off" }
                    ListElement { name: "Sky Sports"; logo: "⚽"; number: "4"; current: "Premier League" }
                    ListElement { name: "ESPN"; logo: "🏀"; number: "5"; current: "NBA Live" }
                    ListElement { name: "CNN"; logo: "📰"; number: "6"; current: "Breaking News" }
                }
                
                delegate: Rectangle {
                    width: 160
                    height: 110
                    radius: 10
                    color: index === currentChannelIndex ? "#1E1E1E" : "#141414"
                    border.color: index === currentChannelIndex ? "#E50914" : "#2f2f2f"
                    border.width: index === currentChannelIndex ? 3 : 1
                    scale: index === currentChannelIndex ? 1.05 : 0.95
                    
                    Behavior on scale {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                    
                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                    
                    Behavior on border.color {
                        ColorAnimation { duration: 200 }
                    }
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 8
                        
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10
                            
                            Rectangle {
                                width: 40
                                height: 40
                                radius: 8
                                color: "#2f2f2f"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: model.logo
                                    font.pixelSize: 20
                                }
                            }
                            
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2
                                
                                Text {
                                    text: model.number
                                    font.pixelSize: 12
                                    font.bold: true
                                    color: index === currentChannelIndex ? "#E50914" : "#B3B3B3"
                                }
                                
                                Text {
                                    text: model.name
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: "#FFFFFF"
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                }
                            }
                        }
                        
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            color: "#2f2f2f"
                        }
                        
                        Text {
                            text: model.current
                            font.pixelSize: 12
                            color: "#B3B3B3"
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            currentChannelIndex = index
                            zapList.currentIndex = index
                            autoHideTimer.restart()
                        }
                    }
                }
                
                highlightFollowsCurrentItem: true
                highlightMoveDuration: 200
                preferredHighlightBegin: width / 2 - 80
                preferredHighlightEnd: width / 2 + 80
                highlightRangeMode: ListView.StrictlyEnforceRange
            }
            
            Button {
                Layout.preferredWidth: 50
                Layout.fillHeight: true
                
                background: Rectangle {
                    color: parent.hovered ? "#262626" : "transparent"
                    radius: 12
                }
                
                contentItem: Text {
                    text: "▶"
                    font.pixelSize: 24
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    zapList.incrementCurrentIndex()
                    autoHideTimer.restart()
                }
            }
        }
    }
}
