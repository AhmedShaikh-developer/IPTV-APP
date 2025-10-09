import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property string currentPlan: "Pro"
    property string nextBillingDate: "Jan 15, 2025"
    property string nextChargeAmount: "$9.99"
    property string paymentMethod: "•••• 4242"
    property bool showCancelDialog: false
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 800)
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
                    onClicked: navigateTo("/main")
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    
                    Text {
                        text: "📊 Subscription Status"
                        font.pixelSize: 36
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "Manage your subscription"
                        font.pixelSize: 16
                        color: "#b3b3b3"
                    }
                }
            }
            
            // Current Plan
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                color: "#181818"
                radius: 8
                border.color: "#e50914"
                border.width: 2
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 15
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Text {
                            text: "✨ Current Plan"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                            Layout.fillWidth: true
                        }
                        
                        Rectangle {
                            Layout.preferredWidth: 80
                            Layout.preferredHeight: 30
                            color: "#27ae60"
                            radius: 15
                            
                            Text {
                                anchors.centerIn: parent
                                text: "ACTIVE"
                                font.pixelSize: 12
                                font.bold: true
                                color: "white"
                            }
                        }
                    }
                    
                    Text {
                        text: currentPlan + " Plan - Monthly"
                        font.pixelSize: 24
                        font.bold: true
                        color: "#e50914"
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 30
                        
                        Text {
                            text: "📺 5,000+ Channels"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                        
                        Text {
                            text: "📱 3 Devices"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                        
                        Text {
                            text: "⚡ No Ads"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                    }
                }
            }
            
            // Next Charge
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 20
                    
                    Rectangle {
                        width: 60
                        height: 60
                        radius: 30
                        color: "#2f2f2f"
                        
                        Text {
                            anchors.centerIn: parent
                            text: "💰"
                            font.pixelSize: 30
                        }
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: "Next Charge"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: nextChargeAmount + " on " + nextBillingDate
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                    }
                }
            }
            
            // Payment Method
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 20
                    
                    Rectangle {
                        width: 60
                        height: 60
                        radius: 30
                        color: "#2f2f2f"
                        
                        Text {
                            anchors.centerIn: parent
                            text: "💳"
                            font.pixelSize: 30
                        }
                    }
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        
                        Text {
                            text: "Payment Method"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#ffffff"
                        }
                        
                        Text {
                            text: "Visa " + paymentMethod
                            font.pixelSize: 14
                            color: "#b3b3b3"
                        }
                    }
                    
                    Button {
                        text: "Update"
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 40
                        background: Rectangle {
                            color: "transparent"
                            radius: 4
                            border.color: "#e50914"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#e50914"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
            
            // Invoices
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 250
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 15
                    
                    Text {
                        text: "📄 Billing History"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                    }
                    
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 10
                            
                            Repeater {
                                model: [
                                    { date: "Dec 15, 2024", amount: "$9.99", status: "Paid" },
                                    { date: "Nov 15, 2024", amount: "$9.99", status: "Paid" },
                                    { date: "Oct 15, 2024", amount: "$9.99", status: "Paid" }
                                ]
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    color: "transparent"
                                    radius: 4
                                    border.color: "#564d4d"
                                    border.width: 1
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 15
                                        spacing: 15
                                        
                                        Text {
                                            text: modelData.date
                                            font.pixelSize: 14
                                            color: "#ffffff"
                                            Layout.fillWidth: true
                                        }
                                        
                                        Text {
                                            text: modelData.amount
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#e50914"
                                        }
                                        
                                        Rectangle {
                                            Layout.preferredWidth: 60
                                            Layout.preferredHeight: 25
                                            color: "#27ae60"
                                            radius: 12
                                            
                                            Text {
                                                anchors.centerIn: parent
                                                text: modelData.status
                                                font.pixelSize: 10
                                                font.bold: true
                                                color: "white"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // Actions
            RowLayout {
                Layout.fillWidth: true
                spacing: 15
                
                Button {
                    text: "📈 Change Plan"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#e50914"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/billing/plans")
                }
                
                Button {
                    text: "⏸️ Pause"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "transparent"
                        radius: 4
                        border.color: "#f39c12"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#f39c12"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                
                Button {
                    text: "❌ Cancel"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "transparent"
                        radius: 4
                        border.color: "#e74c3c"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#e74c3c"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: showCancelDialog = true
                }
            }
        }
    }
    
    // Cancel Dialog
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: showCancelDialog ? 0.95 : 0
        visible: showCancelDialog
        z: 1000
        
        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }
        
        Rectangle {
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "#181818"
            radius: 8
            border.color: "#e74c3c"
            border.width: 2
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 30
                spacing: 20
                
                Text {
                    text: "Cancel Subscription?"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "You'll lose access to all premium features on " + nextBillingDate + "."
                    font.pixelSize: 14
                    color: "#b3b3b3"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }
                
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 10
                    spacing: 15
                    
                    Button {
                        text: "Keep Subscription"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "#e50914"
                            radius: 4
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: showCancelDialog = false
                    }
                    
                    Button {
                        text: "Yes, Cancel"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        background: Rectangle {
                            color: "transparent"
                            radius: 4
                            border.color: "#e74c3c"
                            border.width: 2
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#e74c3c"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            showCancelDialog = false
                            subscriptionStatus = "cancelled"
                            navigateTo("/main")
                        }
                    }
                }
            }
        }
    }
}

