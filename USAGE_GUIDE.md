# IPTV Backend Usage Guide

## Complete User Flow

### 1. **Adding a Playlist**

#### Option A: Xtream Codes Login
1. Navigate to: **Sources → Add Source** (`/sources/add`)
2. Click on **"🔐 Xtream Codes"** card
3. Fill in the form:
   - **Playlist Name**: e.g., "My IPTV Service"
   - **Server URL**: e.g., `http://example.com:8080` or `https://example.com`
   - **Username**: Your Xtream username
   - **Password**: Your Xtream password
   - **Timezone Offset** (optional): EPG time adjustment
4. Click **"🔍 Test Connection"** (optional - validates credentials)
5. Click **"💾 Save"** or **"💾 Save & Sync"**
   - The app will:
     - Call `player_api.php` to verify credentials
     - Download the M3U playlist
     - Parse channels and VOD items
     - Save the playlist to disk

#### Option B: M3U URL
1. Navigate to: **Sources → Add Source** (`/sources/add`)
2. Click on **"📄 M3U / M3U8"** card
3. Make sure **"🌐 URL"** tab is selected
4. Fill in:
   - **Playlist Name**: e.g., "Free IPTV"
   - **Playlist URL**: e.g., `http://example.com/playlist.m3u8`
5. Click **"💾 Save"** or **"💾 Save & Sync"**
   - The app will download and parse the M3U file

#### Option C: M3U Local File
1. Navigate to: **Sources → Add Source** (`/sources/add`)
2. Click on **"📄 M3U / M3U8"** card
3. Click **"📁 Local File"** tab
4. Fill in:
   - **Playlist Name**: e.g., "Local Playlist"
   - Click **"Browse"** to select an `.m3u` or `.m3u8` file
5. Click **"💾 Save"**
   - The app will read and parse the local file

#### Option D: Single Stream URL
1. Navigate to: **Sources → Add Source** (`/sources/add`)
2. Click on **"🎬 Single URL"** card
3. Fill in:
   - **Stream URL**: e.g., `http://example.com/stream.m3u8`
   - **Stream Name** (optional)
   - **Category** (optional)
4. Click **"▶️ Play Now"** to play immediately
   - OR click **"💾 Save"** to save for later

---

### 2. **Managing Playlists**

1. Navigate to: **Sources → Manage Sources** (`/sources/manage`)
   - Or click **"⚙️ Manage Existing Sources"** from Add Source screen

2. You'll see a list of all saved playlists with:
   - Playlist name
   - Type (Xtream Codes, M3U URL, M3U File)
   - Channel count
   - Last synced time

3. Actions available:
   - **🔄 Refresh**: Re-downloads/refreshes the playlist and sets it as active
   - **▶️ Play**: Sets the playlist as active and navigates to Home
   - **🗑️ Delete**: Removes the playlist

---

### 3. **Viewing Channels & Content**

#### Live Channels
1. After adding/activating a playlist, navigate to **Home** (`/home`) or **Live TV** (`/live`)
2. Channels are automatically loaded from `PlaylistManager.liveChannelsModel`
3. Click any channel card to play it
   - The app calls `PlaylistManager.playSingleStream(channelUrl)`
   - Navigates to player screen
   - Stream starts automatically

#### VOD (Movies/Series)
1. Navigate to **Movies** (`/movies`) or **Series** (`/series`)
2. VOD items are loaded from `PlaylistManager.vodItemsModel`
3. Click any item to play it

---

### 4. **Playing Streams**

#### From Channel List
1. Navigate to **Live TV → Channel List** (`/live`)
2. Browse channels (from active playlist or demo data)
3. Click any channel → automatically plays

#### From Single URL Form
1. Go to **Sources → Single URL** (`/sources/single`)
2. Enter stream URL
3. Click **"▶️ Play Now"**
   - Calls `PlaylistManager.playSingleStream(url)`
   - Opens player with the stream

#### Player Screen
- The player automatically receives the stream URL via `PlaylistManager.playStream` signal
- Video starts playing automatically
- Controls appear on hover/click
- Error messages shown if playback fails

---

## Backend API Reference (For Developers)

### QML Usage

```qml
import IPTVBackend 1.0

// Access the singleton
PlaylistManager {
    id: playlistManager
}

// Add Xtream playlist
PlaylistManager.addXtreamPlaylist("My Playlist", "http://server.com:8080", "user", "pass")

// Add M3U URL
PlaylistManager.addM3UUrlPlaylist("My M3U", "http://example.com/playlist.m3u8")

// Add M3U file
PlaylistManager.addM3UFilePlaylist("Local", "/path/to/file.m3u")

// Play single stream
PlaylistManager.playSingleStream("http://example.com/stream.m3u8")

// Get all playlists
var playlists = PlaylistManager.getPlaylists() // Returns QJsonArray

// Set active playlist (loads channels/VOD)
PlaylistManager.setActivePlaylist(playlistId)

// Refresh active playlist
PlaylistManager.refreshActivePlaylist()

// Remove playlist
PlaylistManager.removePlaylist(playlistId)

// Access models
ListView {
    model: PlaylistManager.liveChannelsModel
    delegate: Text { text: model.name }
}

ListView {
    model: PlaylistManager.vodItemsModel
    delegate: Text { text: model.name }
}

// Listen to signals
Connections {
    target: PlaylistManager
    function onPlaylistAdded(id) { console.log("Added:", id) }
    function onPlaylistRemoved(id) { console.log("Removed:", id) }
    function onPlayStream(url) { console.log("Playing:", url) }
    function onErrorMessageChanged() { 
        console.log("Error:", PlaylistManager.errorMessage) 
    }
}
```

---

## Data Storage

- **Location**: `QStandardPaths::AppDataLocation/playlists.json`
- **Format**: JSON array of playlist objects
- **Auto-save**: Playlists are saved automatically when added/removed
- **Auto-load**: Playlists are loaded when app starts

### Playlist JSON Structure
```json
[
  {
    "id": "1234567890",
    "name": "My Playlist",
    "type": "xtream",
    "serverUrl": "http://server.com:8080",
    "username": "user",
    "password": "pass",
    "m3uUrl": "http://server.com/get.php?...",
    "lastUsed": 1234567890
  }
]
```

---

## Error Handling

- **Empty fields**: Shows error message "All fields are required"
- **Invalid URL**: Shows "Invalid server URL" or "Invalid M3U URL"
- **Network errors**: Shows "Network error: [details]"
- **Invalid credentials**: Shows "Invalid credentials" or "Invalid credentials or account inactive"
- **File errors**: Shows "File does not exist" or "Failed to read file"
- **Invalid M3U**: Shows "Invalid M3U file"

All errors are accessible via `PlaylistManager.errorMessage` property.

---

## Navigation Routes

- `/sources/add` - Add Source screen
- `/sources/xtream` - Xtream Codes form
- `/sources/m3u` - M3U form
- `/sources/single` - Single URL form
- `/sources/manage` - Manage playlists
- `/home` - Home screen (shows channels/VOD)
- `/live` - Live TV screen
- `/player` - Video player

---

## Example Workflow

1. **First Time Setup**:
   ```
   App Start → /boot → /main → /sources/add
   ```

2. **Add Xtream Playlist**:
   ```
   /sources/add → Click "Xtream Codes" → Fill form → Save
   → Auto-navigates to /sources/manage
   ```

3. **Activate & Watch**:
   ```
   /sources/manage → Click "▶️" on playlist → /home
   → Click channel → /player (stream plays)
   ```

4. **Quick Play Single Stream**:
   ```
   /sources/add → "Single URL" → Enter URL → "Play Now"
   → /player (stream plays immediately)
   ```

---

## Tips

- Playlists persist between app restarts
- Only one playlist can be "active" at a time (populates channels/VOD models)
- Use "Refresh" to re-download M3U for URL-based playlists
- Local M3U files are read from disk each time you activate them
- Xtream playlists automatically fetch M3U URL from API
- All network operations are asynchronous (won't freeze UI)

