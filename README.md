# IPTV Pro - Streaming Application

A comprehensive Qt QML application featuring a IPTV streaming platform with modern UI, responsive design, and extensive feature set.

## 🎬 Features

### 🏠 Main Application Screens

#### 1. Home Screen (`/home`)
- **Rails**: Horizontal scrolling content sections
- **Featured Content**: Hero banners with play buttons
- **Content Categories**: Movies, Series, Live TV, Catch-up
- **Search Integration**: Global search functionality
- **Responsive Layout**: Adapts to desktop, tablet, and mobile

#### 2. Live TV (`/live`)
- **Channel Grid**: Multi-column channel layout
- **EPG Integration**: Electronic Program Guide
- **Channel Groups**: Organized channel categories
- **Real-time Updates**: Live program information

#### 3. TV Guide (`/guide`)
- **Timeline View**: Horizontal scrolling program schedule
- **Channel List**: Vertical channel navigation
- **Program Details**: Rich program information
- **Filtering**: Genre, time, and channel filters

#### 4. Movies Hub (`/movies`)
- **Movie Grid**: Responsive movie poster layout
- **Genre Categories**: Action, Comedy, Drama, etc.
- **Search & Filter**: Advanced filtering options
- **Movie Details**: Full movie information pages

#### 5. Series Hub (`/series`)
- **Series Grid**: TV show poster layout
- **Season Navigation**: Multi-season support
- **Episode Management**: Individual episode access
- **Series Details**: Comprehensive show information

#### 6. Catch-up TV (`/catchup`)
- **Program Library**: Past program availability
- **Time Filters**: 24h, 48h, 7 days options
- **Channel Organization**: Grouped by channel
- **Watch Now**: Direct program playback

### 🔐 Authentication & Account

#### 1. Sign In (`/auth/sign-in`)
- **Email/Password**: Traditional login form
- **Social Login**: Apple, Google integration
- **TV Pairing**: 6-digit code authentication
- **Password Recovery**: Forgot password flow

#### 2. Sign Up (`/auth/sign-up`)
- **Account Creation**: Full registration form
- **Terms & Privacy**: Legal agreement integration
- **Email Verification**: Account activation flow
- **Social Registration**: Quick signup options

#### 3. Account Management (`/account`)
- **Profile Management**: User information editing
- **Device Management**: Active device tracking
- **Subscription Status**: Billing and plan information
- **Security Settings**: Password and security options

### ⚙️ Settings & Configuration

#### 1. Settings Home (`/settings`)
- **Settings Grid**: Organized settings categories
- **Quick Actions**: Common setting shortcuts
- **Search Settings**: Find specific options
- **Account Overview**: Quick account access

#### 2. General Settings (`/settings/general`)
- **Startup Behavior**: App launch preferences
- **Language & Region**: Localization options
- **Time Format**: 12/24 hour display
- **Content Rating**: Parental controls

#### 3. Appearance Settings (`/settings/appearance`)
- **Theme Selection**: Dark/Light mode
- **Density Control**: UI element spacing
- **Accent Colors**: Color customization
- **Safe Area**: TV overscan adjustment

#### 4. Playback Settings (`/settings/playback`)
- **Hardware Decode**: Performance optimization
- **Buffer Size**: Streaming quality control
- **Audio/Subtitles**: Default language preferences
- **External Player**: Third-party player integration

#### 5. Live TV Settings (`/settings/live`)
- **Navigation**: EPG and channel behavior
- **Channel Numbers**: Entry timeout settings
- **Logo Size**: Channel logo display options

#### 6. EPG Settings (`/settings/epg`)
- **Timeline Zoom**: Program guide scaling
- **Genre Display**: Show program categories
- **Timezone**: Local time adjustment

#### 7. Network Settings (`/settings/network`)
- **Proxy Configuration**: Network proxy setup
- **User Agent**: Custom browser identification
- **HTTPS Validation**: Security certificate options

#### 8. Notifications (`/settings/notifications`)
- **Reminders**: Program reminder settings
- **Do Not Disturb**: Quiet hours configuration

### 📱 Additional Features

#### 1. Search & Discovery (`/search`)
- **Global Search**: Search across all content
- **Voice Search**: Speech-to-text search
- **Search Results**: Filtered and categorized results
- **Search History**: Recent search tracking

#### 2. Favorites (`/favorites`)
- **Saved Content**: Bookmarked movies and shows
- **Quick Access**: Easy favorite management
- **Sync Across Devices**: Cloud-based favorites

#### 3. Custom Groups (`/live/custom-groups`)
- **Channel Organization**: User-defined channel groups
- **Drag & Drop**: Easy channel management
- **Group Sharing**: Share custom groups

#### 4. History (`/history`)
- **Recently Watched**: Viewing history tracking
- **Continue Watching**: Resume incomplete content
- **Clear History**: Privacy control options

#### 5. Downloads (`/downloads`)
- **Offline Content**: Download for offline viewing
- **Download Manager**: Manage download queue
- **Storage Settings**: Download location and limits

#### 6. Recordings (`/record`)
- **Schedule Recording**: Set up future recordings
- **Recording Library**: View recorded content
- **Scheduled List**: Manage upcoming recordings

### 🆘 Help & Support

#### 1. Help Center (`/help`)
- **FAQ Sections**: Categorized help articles
- **Search Help**: Find specific help topics
- **Contact Support**: Direct support access
- **Video Tutorials**: Step-by-step guides

#### 2. Report Issue (`/help/report`)
- **Issue Reporting**: Detailed problem reporting
- **Log Attachment**: Automatic log file inclusion
- **Support Ticket**: Track support requests

#### 3. Legal Information (`/legal`)
- **Terms of Service**: Legal terms and conditions
- **Privacy Policy**: Data protection information
- **Disclaimer**: App usage disclaimers

## 🎨 Design System

### Visual Design
- **Modern UI**: Modern streaming platform aesthetic
- **Dark Theme**: Professional dark color scheme
- **Red Accent**: #E50914 brand color throughout
- **Card-based Layout**: Clean, organized content presentation
- **Responsive Design**: Seamless desktop, tablet, mobile experience

### Typography
- **Primary Font**: Inter/Figtree family
- **Hierarchy**: 28-32px titles, 16-18px labels, 13-14px secondary text
- **Weight**: DemiBold for titles, Medium for labels, Regular for body text
- **Colors**: #FFFFFF primary, #B3B3B3 secondary, #CCCCCC muted

### Layout & Spacing
- **Container Width**: Max 1080-1200px centered
- **Padding**: 40px desktop, 24px tablet, 16px mobile
- **Card Spacing**: 24px between sections, 12-16px within cards
- **Border Radius**: 16px for cards, 8-12px for buttons

### Interactive Elements
- **Hover Effects**: Subtle color and shadow changes
- **Smooth Animations**: 150-200ms transitions
- **Focus States**: Clear keyboard navigation support
- **Touch Targets**: 44x44px minimum for mobile

## 🔧 Technical Implementation

### Architecture
- **QML-based UI**: Modern declarative UI with Qt Quick
- **Centralized Routing**: Main routing system in `main.qml`
- **Component-based**: Reusable UI components
- **State Management**: Global application state handling
- **Responsive Properties**: Screen size detection and adaptation

### Key Files Structure
```
├── main.qml                    # Main application shell with routing
├── Home.qml                    # home screen
├── LiveTv.qml                  # Live TV interface
├── EpgGrid.qml                 # TV Guide implementation
├── MoviesHub.qml               # Movies section
├── SeriesHub.qml               # Series section
├── CatchupBrowser.qml          # Catch-up TV
├── SignIn.qml                  # Authentication
├── SignUp.qml                  # Registration
├── AccountSettings.qml         # Account management
├── SettingsHome.qml            # Settings overview
├── GeneralSettings.qml         # General preferences
├── AppearanceSettings.qml      # UI customization
├── PlaybackSettings.qml        # Media playback options
├── LiveTvSettings.qml          # Live TV configuration
├── EpgSettings.qml             # EPG preferences
├── NetworkSettings.qml         # Network configuration
├── NotificationSettings.qml    # Notification preferences
├── HelpCenter.qml              # Help and FAQ
├── ReportIssue.qml             # Issue reporting
├── LegalDocs.qml               # Legal information
└── qml.qrc                     # Resource file
```

### Navigation System
- **Route-based**: URL-style routing (`/home`, `/settings`, etc.)
- **StackLayout**: Page stack management
- **Sidebar Navigation**: Left sidebar with all main sections
- **Breadcrumb Support**: Context-aware navigation
- **Back Button**: Consistent back navigation throughout

### Responsive Design
- **Breakpoints**: 
  - Mobile: < 768px
  - Tablet: 768px - 1080px  
  - Desktop: > 1080px
- **Adaptive Layouts**: Grid columns adjust based on screen size
- **Touch Optimization**: Larger touch targets on mobile
- **Content Scaling**: Text and UI elements scale appropriately

## 🚀 Build & Run

### Prerequisites
- Qt 6.x with Quick module
- CMake 3.16+
- C++17 compatible compiler
- Windows 10/11, macOS 10.15+, or Linux

### Build Instructions
```bash
# Clone or navigate to project directory
cd IPTV

# Create build directory
mkdir build && cd build

# Configure with CMake
cmake ..

# Build the application
make

# On Windows with Visual Studio
cmake .. -G "Visual Studio 17 2022"
cmake --build . --config Release
```

### Run
```bash
# From build directory
./untitled

# Or on Windows
untitled.exe
```

## 📱 User Experience Flow

### Authentication Flow
1. **App Launch** → Splash screen with system checks
2. **Sign In/Up** → Authentication screens
3. **Account Setup** → Profile and preferences
4. **Main App** → Home screen with content

### Content Discovery
1. **Home Screen** → Browse featured content
2. **Category Navigation** → Movies, Series, Live TV
3. **Search** → Find specific content
4. **Content Details** → View information and play

### Settings & Customization
1. **Settings Home** → Overview of all settings
2. **Category Selection** → Choose setting category
3. **Configuration** → Adjust preferences
4. **Apply Changes** → Save and return

## 🎯 Navigation Routes

### Main Application
- `/home` - home screen
- `/live` - Live TV interface
- `/guide` - Electronic Program Guide
- `/catchup` - Catch-up TV programs
- `/movies` - Movies section
- `/series` - TV series section

### Authentication
- `/auth/sign-in` - User sign in
- `/auth/sign-up` - User registration
- `/auth/verify` - Email verification
- `/auth/reset` - Password reset
- `/auth/pair` - TV code pairing

### Settings
- `/settings` - Settings home
- `/settings/general` - General preferences
- `/settings/appearance` - UI customization
- `/settings/playback` - Media settings
- `/settings/live` - Live TV settings
- `/settings/epg` - EPG configuration
- `/settings/network` - Network settings
- `/settings/notifications` - Notification preferences
- `/account` - Account management

### Additional Features
- `/search` - Global search
- `/favorites` - Saved content
- `/history` - Viewing history
- `/downloads` - Offline content
- `/help` - Help center
- `/legal` - Legal information

## 🔮 Future Enhancements

### Planned Features
- **Real IPTV Integration**: Connect to actual IPTV services
- **Video Player**: Custom video playback engine
- **Cloud Sync**: Cross-device synchronization
- **Advanced EPG**: Enhanced program guide features
- **Parental Controls**: Content filtering and restrictions
- **Multi-language**: International localization
- **Themes**: Additional color schemes
- **Widgets**: Home screen widgets
- **Voice Control**: Advanced voice commands
- **Chromecast/AirPlay**: Streaming to external devices

### Technical Improvements
- **Performance Optimization**: Faster loading and rendering
- **Offline Mode**: Enhanced offline functionality
- **Data Caching**: Intelligent content caching
- **Analytics**: Usage tracking and insights
- **Error Reporting**: Automatic crash reporting
- **Accessibility**: Enhanced accessibility features

## 📄 License

This project is part of the IPTV Pro application suite. All rights reserved.

---

**IPTV Pro** - Professional IPTV streaming platform.