import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: zapOverlay
    color: "transparent"
    
    property bool isVisible: false
    property int currentChannelIndex: 5 // Center channel
    property int totalChannels: 10
    property real slideOffset: -height
    
    // Horizontal strip with channel thumbnails
    Rectangle {
        id: channelStrip
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.9, 800)
        height: 120
        y: slideOffset
        
        // Semi-transparent background
        Rectangle {
            anchors.fill: parent
            color: "#CC000000"
            radius: 12
            border.color: "#1AFFFFFF"
            border.width: 1
        }
        
        // Channel list
        ListView {
            id: channelList
            anchors.fill: parent
            anchors.margins: 15
            orientation: ListView.Horizontal
            spacing: 15
            clip: true
            
            model: ListModel {
                ListElement { channelNum: "101"; name: "BBC One"; logo: "📺"; program: "BBC News" }
                ListElement { channelNum: "102"; name: "BBC Two"; logo: "📺"; program: "Documentary" }
                ListElement { channelNum: "103"; name: "ITV"; logo: "📺"; program: "ITV News" }
                ListElement { channelNum: "104"; name: "Channel 4"; logo: "📺"; program: "4 News" }
                ListElement { channelNum: "105"; name: "Channel 5"; logo: "📺"; program: "5 News" }
                ListElement { channelNum: "106"; name: "BBC News HD"; logo: "📺"; program: "BBC News at 10" }
                ListElement { channelNum: "107"; name: "Sky News"; logo: "📺"; program: "Sky News" }
                ListElement { channelNum: "108"; name: "CNN"; logo: "📺"; program: "CNN Newsroom" }
                ListElement { channelNum: "109"; name: "Al Jazeera"; logo: "📺"; program: "News" }
                ListElement { channelNum: "110"; name: "RT"; logo: "📺"; program: "RT News" }
            }
            
            delegate: Rectangle {
                width: 200
                height: channelList.height
                color: "transparent"
                
                Rectangle {
                    anchors.fill: parent
                    radius: 8
                    color: index === currentChannelIndex ? "#33E50914" : "#0DFFFFFF"
                    border.color: index === currentChannelIndex ? "#E50914" : "transparent"
                    border.width: 2
                    
                    // Scale animation for active channel
                    scale: index === currentChannelIndex ? 1.05 : 1.0
                    
                    Behavior on scale {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutQuad
                        }
                    }
                    
                    Behavior on border.color {
                        ColorAnimation { duration: 200 }
                    }
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 8
                        
                        // Channel number and logo
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Text {
                                text: channelNum
                                font.pixelSize: 12
                                font.bold: true
                                color: "#E50914"
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Text {
                                text: logo
                                font.pixelSize: 20
                                color: "#ffffff"
                            }
                        }
                        
                        // Channel name
                        Text {
                            text: name
                            font.pixelSize: 14
                            font.bold: true
                            color: "#ffffff"
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }
                        
                        // Now playing
                        Text {
                            text: program
                            font.pixelSize: 12
                            color: "#b3b3b3"
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }
                }
            }
            
            // Ensure current channel is visible
            onCurrentIndexChanged: {
                positionViewAtIndex(currentIndex, ListView.Center)
            }
        }
        
        // Navigation arrows
        Button {
            id: leftArrow
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 40
            visible: channelList.contentX > 0
            
            background: Rectangle {
                color: parent.hovered ? "#33FFFFFF" : "#1AFFFFFF"
                radius: 20
                border.color: parent.activeFocus ? "#E50914" : "transparent"
                border.width: 2
            }
            
            contentItem: Text {
                text: "←"
                font.pixelSize: 18
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            onClicked: {
                channelList.decrementCurrentIndex()
                currentChannelIndex = channelList.currentIndex
            }
            Keys.onReturnPressed: {
                channelList.decrementCurrentIndex()
                currentChannelIndex = channelList.currentIndex
            }
        }
        
        Button {
            id: rightArrow
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 40
            visible: channelList.contentX < (channelList.contentWidth - channelList.width)
            
            background: Rectangle {
                color: parent.hovered ? "#33FFFFFF" : "#1AFFFFFF"
                radius: 20
                border.color: parent.activeFocus ? "#E50914" : "transparent"
                border.width: 2
            }
            
            contentItem: Text {
                text: "→"
                font.pixelSize: 18
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            onClicked: {
                channelList.incrementCurrentIndex()
                currentChannelIndex = channelList.currentIndex
            }
            Keys.onReturnPressed: {
                channelList.incrementCurrentIndex()
                currentChannelIndex = channelList.currentIndex
            }
        }
        
        // Animation for slide in/out
        Behavior on y {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
    }
    
    // Auto-dismiss timer
    Timer {
        id: dismissTimer
        interval: 3000
        running: isVisible
        repeat: false
        onTriggered: {
            if (isVisible) {
                hide()
            }
        }
    }
    
    // Show overlay
    function show() {
        isVisible = true
        slideOffset = 0
        dismissTimer.restart()
    }
    
    // Hide overlay
    function hide() {
        slideOffset = -height
        hideTimer.start()
    }
    
    Timer {
        id: hideTimer
        interval: 250
        repeat: false
        onTriggered: {
            isVisible = false
            visible = false
        }
    }
    
    // Zap up (previous channel)
    function zapUp() {
        currentChannelIndex = Math.max(0, currentChannelIndex - 1)
        channelList.currentIndex = currentChannelIndex
        show()
    }
    
    // Zap down (next channel)
    function zapDown() {
        currentChannelIndex = Math.min(totalChannels - 1, currentChannelIndex + 1)
        channelList.currentIndex = currentChannelIndex
        show()
    }
    
    // Mouse area to close on click outside
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: {
            hide()
        }
        
        // Don't interfere with strip clicks
        onPressed: function(mouse) {
            if (channelStrip.contains(Qt.point(mouse.x, mouse.y))) {
                mouse.accepted = false
            }
        }
    }
    
    // Keyboard shortcuts
    Keys.onPressed: function(event) {
        switch(event.key) {
            case Qt.Key_Left:
                channelList.decrementCurrentIndex()
                currentChannelIndex = channelList.currentIndex
                event.accepted = true
                break
            case Qt.Key_Right:
                channelList.incrementCurrentIndex()
                currentChannelIndex = channelList.currentIndex
                event.accepted = true
                break
            case Qt.Key_Return:
            case Qt.Key_Enter:
                // Switch to selected channel
                console.log("Switching to channel:", channelList.model.get(currentChannelIndex).name)
                hide()
                event.accepted = true
                break
            case Qt.Key_Escape:
                hide()
                event.accepted = true
                break
        }
    }
    
    focus: isVisible
    
    // Update visibility
    onIsVisibleChanged: {
        visible = isVisible
        if (isVisible) {
            dismissTimer.restart()
        }
    }
    
    // Initialize current index
    Component.onCompleted: {
        channelList.currentIndex = currentChannelIndex
    }
}
