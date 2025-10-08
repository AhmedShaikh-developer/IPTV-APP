# App Shell & System - Frontend Design

A comprehensive Qt QML application featuring a complete app shell with system screens for handling various application states.

## Features

### 🚀 App Shell & System Screens

#### 1. Splash Screen (`/boot` - `SplashScreen.qml`)
- **Bootstrap Checks**: Network, auth token, provider sources, subscription status, migrations
- **Animated Loading**: Rotating logo with progress bar
- **Status Indicators**: Real-time status updates for each check
- **Retry Functionality**: Manual retry option if bootstrap fails

#### 2. Update Required (`/update-required` - `UpdateRequired.qml`)
- **Version Information**: Current vs available version display
- **Changelog**: Detailed feature list with categorized updates
- **Store Integration**: Direct links to App Store and Google Play
- **In-App Update**: Simulated update process with progress overlay
- **Update Options**: Force update or skip for later

#### 3. Offline Screen (`/offline` - `OfflineScreen.qml`)
- **Connection Status**: Clear offline indication with last connection time
- **Limited Mode Features**: Shows what's available offline
- **Retry Actions**: Connection retry and download management
- **Diagnostics**: Network interface, DNS, and proxy status
- **Feature Availability**: Visual indicators for online/offline features

#### 4. Error Fallback (`/error` - `ErrorFallback.qml`)
- **Contextual Error Display**: Clear error messaging
- **Troubleshooting Guide**: Step-by-step resolution suggestions
- **Support Integration**: Multiple support channels (help center, chat, phone)
- **Error Details**: Technical information for debugging
- **Retry Mechanisms**: Context-aware retry options

## Technical Implementation

### Architecture
- **QML-based UI**: Modern declarative UI with Qt Quick
- **Routing System**: Centralized navigation with route management
- **Component-based**: Reusable UI components for consistency
- **State Management**: Global application state handling

### Key Components
- `main.qml`: Main application shell with routing
- `SplashScreen.qml`: Bootstrap and loading screen
- `UpdateRequired.qml`: Update management interface
- `OfflineScreen.qml`: Offline mode and diagnostics
- `ErrorFallback.qml`: Error handling and recovery

### Design System
- **Color Palette**: Professional blue/gray theme
- **Typography**: Clear hierarchy with appropriate font sizes
- **Layout**: Responsive design with proper spacing
- **Animations**: Subtle transitions and loading indicators
- **Accessibility**: High contrast and readable text

## Build & Run

### Prerequisites
- Qt 6.x with Quick module
- CMake 3.16+
- C++17 compatible compiler

### Build Instructions
```bash
mkdir build && cd build
cmake ..
make
```

### Run
```bash
./untitled
```

## User Experience Flow

1. **Application Start** → Splash Screen with bootstrap checks
2. **Bootstrap Success** → Main application
3. **Update Required** → Update screen with changelog
4. **Offline Mode** → Offline screen with limited features
5. **Error State** → Error fallback with recovery options

## Customization

The application is designed with IPTV Pro branding and can be easily customized:
- Update colors in the theme properties
- Modify text content in each screen
- Adjust animations and transitions
- Add additional routing paths

## Navigation Routes

- `/boot` - Splash screen and bootstrap
- `/update-required` - Mandatory update screen
- `/offline` - Offline mode interface
- `/error` - Error fallback screen
- `/main` - Main application (placeholder)

## Future Enhancements

- Real network status monitoring
- Actual update download integration
- Persistent offline content management
- Advanced error reporting and analytics
- Multi-language support
