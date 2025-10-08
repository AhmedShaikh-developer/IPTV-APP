import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#f8f9fa"
    
    property string email: userEmail
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 500)
        
        // Verification icon
        Rectangle {
            width: 120
            height: 120
            radius: 60
            color: "#f39c12"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: "📧"
                font.pixelSize: 60
                color: "white"
            }
            
            // Pulse animation
            SequentialAnimation on scale {
                running: true
                loops: Animation.Infinite
                NumberAnimation { to: 1.1; duration: 1000; easing.type: Easing.InOutQuad }
                NumberAnimation { to: 1.0; duration: 1000; easing.type: Easing.InOutQuad }
            }
        }
        
        // Verification text
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Text {
                text: "Check Your Email"
                font.pixelSize: 32
                font.bold: true
                color: "#2c3e50"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "We've sent a verification link to:"
                font.pixelSize: 16
                color: "#7f8c8d"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: email
                font.pixelSize: 16
                font.bold: true
                color: "#3498db"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Click the link in the email to verify your account and start streaming!"
                font.pixelSize: 14
                color: "#6c757d"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }
        }
        
        // Instructions card
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10
                
                Text {
                    text: "📋 Next Steps:"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }
                
                ColumnLayout {
                    spacing: 8
                    
                    RowLayout {
                        spacing: 10
                        
                        Text {
                            text: "1."
                            font.pixelSize: 14
                            color: "#3498db"
                        }
                        
                        Text {
                            text: "Check your email inbox (and spam folder)"
                            font.pixelSize: 14
                            color: "#495057"
                            Layout.fillWidth: true
                        }
                    }
                    
                    RowLayout {
                        spacing: 10
                        
                        Text {
                            text: "2."
                            font.pixelSize: 14
                            color: "#3498db"
                        }
                        
                        Text {
                            text: "Click the verification link"
                            font.pixelSize: 14
                            color: "#495057"
                            Layout.fillWidth: true
                        }
                    }
                    
                    RowLayout {
                        spacing: 10
                        
                        Text {
                            text: "3."
                            font.pixelSize: 14
                            color: "#3498db"
                        }
                        
                        Text {
                            text: "Return here and tap 'Continue'"
                            font.pixelSize: 14
                            color: "#495057"
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }
        
        // Action buttons
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 15
            
            Button {
                text: "✅ I've Verified My Email"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                background: Rectangle {
                    color: "#27ae60"
                    radius: 8
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // Simulate email verification
                    navigateTo("/main")
                }
            }
            
            Button {
                text: "📧 Resend Verification Email"
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                background: Rectangle {
                    color: "transparent"
                    radius: 8
                    border.color: "#3498db"
                    border.width: 2
                }
                contentItem: Text {
                    text: parent.text
                    color: "#3498db"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // Simulate resend
                    console.log("Resending verification email...")
                }
            }
            
            Button {
                text: "✏️ Change Email Address"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Text {
                    text: parent.text
                    color: "#6c757d"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    navigateTo("/auth/sign-up")
                }
            }
        }
        
        // Help text
        Text {
            text: "Didn't receive the email? Check your spam folder or contact support if you continue to have issues."
            font.pixelSize: 12
            color: "#95a5a6"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
        }
    }
}

