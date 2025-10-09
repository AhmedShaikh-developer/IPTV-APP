import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property string selectedPlan: "pro"
    property string billingPeriod: "monthly"
    property bool processingPayment: false
    property bool paymentSuccess: false
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 600)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30
            
            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 20
                
                Button {
                    text: "←"
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#2f2f2f"
                        radius: 25
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#ffffff"
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/billing/plans")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "💳 Checkout"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Complete your subscription"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Order Summary
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 180
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 15
                    
                    Text {
                        text: "📋 Order Summary"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Text {
                            text: "Plan:"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                            Layout.fillWidth: true
                        }
                        
                        Text {
                            text: selectedPlan === "pro" ? "Pro Plan" : "Premium Plan"
                            font.pixelSize: 14
                            font.bold: true
                            color: "#ffffff"
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Text {
                            text: "Billing:"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                            Layout.fillWidth: true
                        }
                        
                        Text {
                            text: billingPeriod === "monthly" ? "Monthly" : "Yearly"
                            font.pixelSize: 14
                            font.bold: true
                            color: "#ffffff"
                        }
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#2f2f2f"
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Text {
                            text: "Total:"
                            font.pixelSize: 18
                            font.bold: true
                            color: "#ffffff"
                            Layout.fillWidth: true
                        }
                        
                        Text {
                            text: "$" + (selectedPlan === "pro" ? (billingPeriod === "monthly" ? "9.99" : "79.99") : (billingPeriod === "monthly" ? "19.99" : "159.99"))
                            font.pixelSize: 18
                            font.bold: true
                            color: "#e50914"
                        }
                    }
                }
            }
            
            // Payment Method
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 220
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 15
                    
                    Text {
                        text: "💳 Payment Method"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Uses platform IAP or Stripe webview"
                        font.pixelSize: 14
                        color: "#b3b3b3"
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        
                        Button {
                            text: "🍎 Apple Pay"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 45
                            background: Rectangle {
                                color: "#000000"
                                radius: 4
                                border.color: "#ffffff"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                processingPayment = true
                                paymentTimer.start()
                            }
                        }
                        
                        Button {
                            text: "🔍 Google Pay"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 45
                            background: Rectangle {
                                color: "#4285f4"
                                radius: 4
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                processingPayment = true
                                paymentTimer.start()
                            }
                        }
                        
                        Button {
                            text: "💳 Credit Card (Stripe)"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 45
                            background: Rectangle {
                                color: "transparent"
                                radius: 4
                                border.color: "#e50914"
                                border.width: 2
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "#e50914"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                processingPayment = true
                                paymentTimer.start()
                            }
                        }
                    }
                }
            }
            
            // Trial Info
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#fff3cd"
                radius: 8
                border.color: "#ffeaa7"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 15
                    
                    Text {
                        text: "🎁"
                        font.pixelSize: 30
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: "7-Day Free Trial"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#856404"
                        }
                        
                        Text {
                            text: "You won't be charged today. Cancel anytime during trial."
                            font.pixelSize: 14
                            color: "#856404"
                        }
                    }
                }
            }
            
            // Terms
            Text {
                text: "By subscribing, you agree to our Terms of Service and Privacy Policy. Subscription automatically renews unless cancelled. SCA/3D Secure may be required."
                font.pixelSize: 12
                color: "#b3b3b3"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }
        }
    }
    
    // Processing Overlay
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: processingPayment ? 0.95 : 0
        visible: processingPayment
        z: 1000
        
        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }
        
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 30
            
            Rectangle {
                width: 100
                height: 100
                radius: 50
                color: "#e50914"
                Layout.alignment: Qt.AlignHCenter
                
                Text {
                    anchors.centerIn: parent
                    text: paymentSuccess ? "✓" : "💳"
                    font.pixelSize: 50
                    color: "white"
                }
                
                RotationAnimation on rotation {
                    running: processingPayment && !paymentSuccess
                    loops: Animation.Infinite
                    duration: 1000
                    from: 0
                    to: 360
                }
            }
            
            Text {
                text: paymentSuccess ? "Payment Successful!" : "Processing Payment..."
                font.pixelSize: 24
                font.bold: true
                color: "#ffffff"
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: paymentSuccess ? "Redirecting to app..." : "Please wait..."
                font.pixelSize: 16
                color: "#b3b3b3"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
    
    Timer {
        id: paymentTimer
        interval: 2000
        onTriggered: {
            paymentSuccess = true
            successTimer.start()
        }
    }
    
    Timer {
        id: successTimer
        interval: 1500
        onTriggered: {
            processingPayment = false
            paymentSuccess = false
            hasActiveSubscription = true
            subscriptionStatus = "active"
            navigateTo("/main")
        }
    }
}

