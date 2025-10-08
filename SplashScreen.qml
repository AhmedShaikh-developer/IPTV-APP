import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: splashScreen
    color: "#000000"
    
    signal retryBootstrap()
    
    // Netflix gradient background
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#000000" }
            GradientStop { position: 0.5; color: "#141414" }
            GradientStop { position: 1.0; color: "#000000" }
        }
    }
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 600)
        
        // Netflix Logo/Icon
        Rectangle {
            id: logoContainer
            width: 120
            height: 120
            radius: 8
            color: "#e50914"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: "N"
                font.pixelSize: 80
                font.bold: true
                color: "white"
            }
            
            // Rotating animation
            RotationAnimation on rotation {
                running: true
                loops: Animation.Infinite
                duration: 2000
                from: 0
                to: 360
            }
        }
        
        // App Title
        Text {
            text: "IPTV Pro"
            font.pixelSize: 48
            font.bold: true
            color: "#e50914"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
        }
        
        Text {
            text: "Netflix Style Streaming"
            font.pixelSize: 20
            font.weight: Font.Light
            color: "#b3b3b3"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
        }
        
        
        // Netflix loading indicator
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 4
            color: "#2f2f2f"
            radius: 2
            
            Rectangle {
                id: progressBar
                height: parent.height
                radius: parent.radius
                color: "#e50914"
                width: parent.width * progress
                
                property real progress: 0
                
                SequentialAnimation on progress {
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation { to: 1; duration: 2000; easing.type: Easing.InOutQuad }
                    NumberAnimation { to: 0; duration: 500 }
                }
            }
        }
        
        // Status messages
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15
            width: parent.width
            
            StatusCheck {
                id: networkCheck
                statusText: "Checking network connection..."
                status: "checking"
                Layout.fillWidth: true
            }
            
            StatusCheck {
                id: authCheck
                statusText: "Validating authentication token..."
                status: "checking"
                Layout.fillWidth: true
            }
            
            StatusCheck {
                id: providerCheck
                statusText: "Loading provider sources..."
                status: "checking"
                Layout.fillWidth: true
            }
            
            StatusCheck {
                id: subscriptionCheck
                statusText: "Checking subscription status..."
                status: "checking"
                Layout.fillWidth: true
            }
            
            StatusCheck {
                id: migrationCheck
                statusText: "Running database migrations..."
                status: "checking"
                Layout.fillWidth: true
            }
        }
        
        // Retry button (hidden initially)
        Button {
            id: retryButton
            text: "Retry Bootstrap"
            visible: false
            Layout.alignment: Qt.AlignHCenter
            background: Rectangle {
                color: "#e74c3c"
                radius: 8
            }
            contentItem: Text {
                text: retryButton.text
                color: "white"
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: retryBootstrap()
        }
    }
    
    // Simulate bootstrap checks
    Timer {
        id: checkTimer
        interval: 800
        repeat: true
        running: true
        property int currentCheck: 0
        
        onTriggered: {
            switch(currentCheck) {
                case 0:
                    networkCheck.status = "success"
                    networkCheck.statusText = "Network connection established ✓"
                    break
                case 1:
                    authCheck.status = "success"
                    authCheck.statusText = "Authentication token valid ✓"
                    break
                case 2:
                    providerCheck.status = "success"
                    providerCheck.statusText = "Provider sources loaded ✓"
                    break
                case 3:
                    subscriptionCheck.status = "success"
                    subscriptionCheck.statusText = "Subscription active ✓"
                    break
                case 4:
                    migrationCheck.status = "success"
                    migrationCheck.statusText = "Database migrations completed ✓"
                    break
                case 5:
                    stop()
                    break
            }
            currentCheck++
        }
    }
}
