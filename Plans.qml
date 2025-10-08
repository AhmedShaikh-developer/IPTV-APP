import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#000000"
    
    property bool yearlySelected: false
    property string selectedPlan: "pro"
    
    ScrollView {
        anchors.fill: parent
        anchors.margins: 40
        
        ColumnLayout {
            width: Math.min(parent.width, 900)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 40
            
            // Header
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20
                
                Text {
                    text: "Choose Your Plan"
                    font.pixelSize: 40
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "Netflix Style Streaming Experience"
                    font.pixelSize: 18
                    color: "#b3b3b3"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "Unlock unlimited streaming with premium features"
                    font.pixelSize: 16
                    color: "#564d4d"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
            }
            
            // Billing toggle
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "#181818"
                radius: 8
                border.color: "#2f2f2f"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 20
                    
                    Text {
                        text: "Billing Period:"
                        font.pixelSize: 16
                        color: "#ffffff"
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        
                        Button {
                            text: "Monthly"
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 35
                            background: Rectangle {
                                color: !yearlySelected ? "#e50914" : "transparent"
                                radius: 4
                                border.color: "#e50914"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: !yearlySelected ? "white" : "#e50914"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: yearlySelected = false
                        }
                        
                        Button {
                            text: "Yearly"
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 35
                            background: Rectangle {
                                color: yearlySelected ? "#e50914" : "transparent"
                                radius: 4
                                border.color: "#e50914"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: yearlySelected ? "white" : "#e50914"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: yearlySelected = true
                        }
                        
                        Rectangle {
                            Layout.preferredWidth: 80
                            Layout.preferredHeight: 25
                            color: "#27ae60"
                            radius: 12
                            visible: yearlySelected
                            
                            Text {
                                anchors.centerIn: parent
                                text: "Save 20%"
                                font.pixelSize: 10
                                font.bold: true
                                color: "white"
                            }
                        }
                    }
                }
            }
            
            // Plans grid
            RowLayout {
                Layout.fillWidth: true
                spacing: 20
                
                // Free Plan
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 400
                    color: selectedPlan === "free" ? "#e50914" : "#181818"
                    radius: 8
                    border.color: selectedPlan === "free" ? "#e50914" : "#2f2f2f"
                    border.width: selectedPlan === "free" ? 3 : 1
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: selectedPlan = "free"
                    }
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15
                        
                        Text {
                            text: "Basic"
                            font.pixelSize: 24
                            font.bold: true
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        Text {
                            text: "Basic streaming"
                            font.pixelSize: 14
                            color: "#b3b3b3"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        Text {
                            text: "$0"
                            font.pixelSize: 36
                            font.bold: true
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Text {
                                text: "📺 50+ Channels"
                                font.pixelSize: 14
                                color: selectedPlan === "free" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📱 1 Device"
                                font.pixelSize: 14
                                color: selectedPlan === "free" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📺 SD Quality"
                                font.pixelSize: 14
                                color: selectedPlan === "free" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📢 With Ads"
                                font.pixelSize: 14
                                color: selectedPlan === "free" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        
                        Button {
                            text: selectedPlan === "free" ? "Selected" : "Select Plan"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            enabled: selectedPlan !== "free"
                            background: Rectangle {
                                color: parent.enabled ? "white" : "transparent"
                                radius: 6
                                border.color: selectedPlan === "free" ? "white" : "#3498db"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: selectedPlan === "free" ? "white" : "#3498db"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: selectedPlan = "free"
                        }
                    }
                }
                
                // Pro Plan
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 400
                    color: selectedPlan === "pro" ? "#3498db" : "white"
                    radius: 12
                    border.color: selectedPlan === "pro" ? "#3498db" : "#e74c3c"
                    border.width: selectedPlan === "pro" ? 3 : 2
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: selectedPlan = "pro"
                    }
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15
                        
                        Rectangle {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: 80
                            Layout.preferredHeight: 25
                            color: "#e74c3c"
                            radius: 12
                            
                            Text {
                                anchors.centerIn: parent
                                text: "POPULAR"
                                font.pixelSize: 10
                                font.bold: true
                                color: "white"
                            }
                        }
                        
                        Text {
                            text: "Pro"
                            font.pixelSize: 24
                            font.bold: true
                            color: selectedPlan === "pro" ? "white" : "#2c3e50"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        Text {
                            text: "Most popular choice"
                            font.pixelSize: 14
                            color: selectedPlan === "pro" ? "#bdc3c7" : "#7f8c8d"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        Text {
                            text: "$" + (yearlySelected ? "79.99" : "9.99")
                            font.pixelSize: 36
                            font.bold: true
                            color: selectedPlan === "pro" ? "white" : "#2c3e50"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Text {
                                text: "📺 5,000+ Channels"
                                font.pixelSize: 14
                                color: selectedPlan === "pro" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📱 3 Devices"
                                font.pixelSize: 14
                                color: selectedPlan === "pro" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📺 HD Quality"
                                font.pixelSize: 14
                                color: selectedPlan === "pro" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "⚡ No Ads"
                                font.pixelSize: 14
                                color: selectedPlan === "pro" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📱 Mobile App"
                                font.pixelSize: 14
                                color: selectedPlan === "pro" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "🔄 Cloud DVR"
                                font.pixelSize: 14
                                color: selectedPlan === "pro" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        
                        Button {
                            text: selectedPlan === "pro" ? "Selected" : "Select Plan"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            enabled: selectedPlan !== "pro"
                            background: Rectangle {
                                color: parent.enabled ? "white" : "transparent"
                                radius: 6
                                border.color: selectedPlan === "pro" ? "white" : "#3498db"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: selectedPlan === "pro" ? "white" : "#3498db"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: selectedPlan = "pro"
                        }
                    }
                }
                
                // Premium Plan
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 400
                    color: selectedPlan === "premium" ? "#3498db" : "white"
                    radius: 12
                    border.color: selectedPlan === "premium" ? "#3498db" : "#e9ecef"
                    border.width: selectedPlan === "premium" ? 3 : 1
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: selectedPlan = "premium"
                    }
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15
                        
                        Text {
                            text: "Premium"
                            font.pixelSize: 24
                            font.bold: true
                            color: selectedPlan === "premium" ? "white" : "#2c3e50"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        Text {
                            text: "For power users"
                            font.pixelSize: 14
                            color: selectedPlan === "premium" ? "#bdc3c7" : "#7f8c8d"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        Text {
                            text: "$" + (yearlySelected ? "159.99" : "19.99")
                            font.pixelSize: 36
                            font.bold: true
                            color: selectedPlan === "premium" ? "white" : "#2c3e50"
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            
                            Text {
                                text: "📺 10,000+ Channels"
                                font.pixelSize: 14
                                color: selectedPlan === "premium" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📱 Unlimited Devices"
                                font.pixelSize: 14
                                color: selectedPlan === "premium" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📺 4K Quality"
                                font.pixelSize: 14
                                color: selectedPlan === "premium" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "⚡ No Ads"
                                font.pixelSize: 14
                                color: selectedPlan === "premium" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📱 Mobile App"
                                font.pixelSize: 14
                                color: selectedPlan === "premium" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "🔄 Cloud DVR"
                                font.pixelSize: 14
                                color: selectedPlan === "premium" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "🏠 Family Sharing"
                                font.pixelSize: 14
                                color: selectedPlan === "premium" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "📞 Priority Support"
                                font.pixelSize: 14
                                color: selectedPlan === "premium" ? "white" : "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        
                        Button {
                            text: selectedPlan === "premium" ? "Selected" : "Select Plan"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            enabled: selectedPlan !== "premium"
                            background: Rectangle {
                                color: parent.enabled ? "white" : "transparent"
                                radius: 6
                                border.color: selectedPlan === "premium" ? "white" : "#3498db"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                color: selectedPlan === "premium" ? "white" : "#3498db"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: selectedPlan = "premium"
                        }
                    }
                }
            }
            
            // Feature comparison
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 300
                color: "white"
                radius: 12
                border.color: "#e9ecef"
                border.width: 1
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15
                    
                    Text {
                        text: "📊 Feature Comparison"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#2c3e50"
                    }
                    
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        GridLayout {
                            columns: 4
                            rowSpacing: 10
                            columnSpacing: 15
                            
                            // Header row
                            Text {
                                text: "Feature"
                                font.pixelSize: 14
                                font.bold: true
                                color: "#495057"
                            }
                            
                            Text {
                                text: "Free"
                                font.pixelSize: 14
                                font.bold: true
                                color: "#495057"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "Pro"
                                font.pixelSize: 14
                                font.bold: true
                                color: "#3498db"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            Text {
                                text: "Premium"
                                font.pixelSize: 14
                                font.bold: true
                                color: "#e74c3c"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            
                            // Feature rows
                            Repeater {
                                model: [
                                    "Channels", "50+", "5,000+", "10,000+",
                                    "Devices", "1", "3", "Unlimited",
                                    "Quality", "SD", "HD", "4K",
                                    "Ads", "Yes", "No", "No",
                                    "Cloud DVR", "No", "Yes", "Yes",
                                    "Family Sharing", "No", "No", "Yes",
                                    "Support", "Community", "Email", "Priority"
                                ]
                                
                                Text {
                                    text: modelData
                                    font.pixelSize: 12
                                    color: index % 4 === 0 ? "#495057" : "#6c757d"
                                    horizontalAlignment: index % 4 === 0 ? Text.AlignLeft : Text.AlignHCenter
                                }
                            }
                        }
                    }
                }
            }
            
            // Trial information
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#fff3cd"
                radius: 8
                border.color: "#ffeaa7"
                border.width: 1
                visible: selectedPlan !== "free"
                
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
                            text: "Try " + (selectedPlan === "pro" ? "Pro" : "Premium") + " plan free for 7 days. Cancel anytime."
                            font.pixelSize: 14
                            color: "#856404"
                        }
                    }
                }
            }
            
            // Action buttons
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20
                
                Button {
                    text: "💳 Start " + (selectedPlan === "free" ? "Free Plan" : "Free Trial")
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: selectedPlan === "pro" ? "#3498db" : selectedPlan === "premium" ? "#e74c3c" : "#27ae60"
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
                    onClicked: navigateTo("/billing/checkout")
                }
                
                Button {
                    text: "🔙 Back"
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "transparent"
                        radius: 8
                        border.color: "#6c757d"
                        border.width: 2
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#6c757d"
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: navigateTo("/welcome")
                }
            }
            
            // Terms
            Text {
                text: "By subscribing, you agree to our Terms of Service and Privacy Policy. Subscription automatically renews unless cancelled."
                font.pixelSize: 12
                color: "#95a5a6"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
