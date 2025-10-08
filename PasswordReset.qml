import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#f8f9fa"
    
    property bool emailSent: false
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40
        width: Math.min(parent.width * 0.8, 450)
        
        // Reset icon
        Rectangle {
            width: 120
            height: 120
            radius: 60
            color: emailSent ? "#27ae60" : "#f39c12"
            Layout.alignment: Qt.AlignHCenter
            
            Text {
                anchors.centerIn: parent
                text: emailSent ? "✅" : "🔑"
                font.pixelSize: 60
                color: "white"
            }
            
            // Success animation
            SequentialAnimation on scale {
                running: emailSent
                NumberAnimation { to: 1.2; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { to: 1.0; duration: 200; easing.type: Easing.OutQuad }
            }
        }
        
        // Content based on state
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            
            Text {
                text: emailSent ? "Email Sent!" : "Reset Password"
                font.pixelSize: 32
                font.bold: true
                color: "#2c3e50"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: emailSent ? 
                      "We've sent password reset instructions to your email address." :
                      "Enter your email address and we'll send you instructions to reset your password."
                font.pixelSize: 16
                color: "#7f8c8d"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }
            
            // Email display (when sent)
            Text {
                text: emailSent ? userEmail : ""
                font.pixelSize: 16
                font.bold: true
                color: "#3498db"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                visible: emailSent
            }
        }
        
        // Email input form (when not sent)
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            visible: !emailSent
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10
                
                Text {
                    text: "Email Address"
                    font.pixelSize: 14
                    color: "#6c757d"
                }
                
                TextField {
                    id: emailField
                    placeholderText: "Enter your email address"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    background: Rectangle {
                        color: "#f8f9fa"
                        radius: 6
                        border.color: "#dee2e6"
                        border.width: 1
                    }
                }
            }
        }
        
        // Instructions card (when sent)
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 140
            color: "white"
            radius: 12
            border.color: "#e9ecef"
            border.width: 1
            visible: emailSent
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15
                
                Text {
                    text: "📋 Next Steps:"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }
                
                ColumnLayout {
                    spacing: 10
                    
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
                            text: "Click the password reset link"
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
                            text: "Create a new password"
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
                text: emailSent ? "✅ Got it!" : "📧 Send Reset Instructions"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                background: Rectangle {
                    color: emailSent ? "#27ae60" : "#3498db"
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
                    if (emailSent) {
                        navigateTo("/auth/sign-in")
                    } else {
                        if (emailField.text.length > 0) {
                            emailSent = true
                            userEmail = emailField.text
                        }
                    }
                }
            }
            
            Button {
                text: "🔙 Back to Sign In"
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                background: Rectangle {
                    color: "transparent"
                    radius: 8
                    border.color: "#6c757d"
                    border.width: 2
                }
                contentItem: Text {
                    text: parent.text
                    color: "#6c757d"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: navigateTo("/auth/sign-in")
            }
        }
        
        // Help text
        Text {
            text: emailSent ? 
                  "If you don't receive the email within a few minutes, check your spam folder or try again." :
                  "Don't remember your email address? Contact our support team for assistance."
            font.pixelSize: 12
            color: "#95a5a6"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
        }
    }
}

