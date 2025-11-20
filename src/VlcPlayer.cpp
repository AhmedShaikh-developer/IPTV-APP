#include "VlcPlayer.h"
#include <QDebug>
#include <QQuickWindow>
#include <QOpenGLContext>

#ifdef HAVE_VLC
#include <vlc/vlc.h>
#else
// Forward declarations if VLC not available (will cause runtime error)
typedef void* libvlc_instance_t;
typedef void* libvlc_media_player_t;
typedef void* libvlc_media_t;
typedef void* libvlc_event_manager_t;
typedef int libvlc_state_t;
typedef int64_t libvlc_time_t;
enum { libvlc_NothingSpecial, libvlc_Opening, libvlc_Buffering, libvlc_Playing, libvlc_Paused, libvlc_Stopped, libvlc_Ended, libvlc_Error };
enum { libvlc_MediaPlayerPlaying, libvlc_MediaPlayerPaused, libvlc_MediaPlayerStopped, libvlc_MediaPlayerEndReached, libvlc_MediaPlayerEncounteredError, libvlc_MediaPlayerPositionChanged, libvlc_MediaPlayerTimeChanged, libvlc_MediaPlayerLengthChanged };
#endif

// Callback functions for libVLC events
#ifdef HAVE_VLC
static void vlcEventCallback(const libvlc_event_t *event, void *userData)
{
    VlcPlayer *player = static_cast<VlcPlayer*>(userData);
    if (!player) return;

    switch (event->type) {
    case libvlc_MediaPlayerPlaying:
        QMetaObject::invokeMethod(player, "updateState", Qt::QueuedConnection);
        QMetaObject::invokeMethod(player, "playing", Qt::QueuedConnection);
        break;
    case libvlc_MediaPlayerPaused:
        QMetaObject::invokeMethod(player, "updateState", Qt::QueuedConnection);
        QMetaObject::invokeMethod(player, "paused", Qt::QueuedConnection);
        break;
    case libvlc_MediaPlayerStopped:
        QMetaObject::invokeMethod(player, "updateState", Qt::QueuedConnection);
        QMetaObject::invokeMethod(player, "stopped", Qt::QueuedConnection);
        break;
    case libvlc_MediaPlayerEndReached:
        QMetaObject::invokeMethod(player, "updateState", Qt::QueuedConnection);
        QMetaObject::invokeMethod(player, "ended", Qt::QueuedConnection);
        break;
    case libvlc_MediaPlayerEncounteredError:
        // Note: libVLC doesn't directly expose HTTP status codes in events
        // The actual HTTP status (like 403) is logged by libVLC but not exposed via API
        // We'll provide a generic error message and let the user know it might be a 403
        QMetaObject::invokeMethod(player, "updateState", Qt::QueuedConnection);
        QMetaObject::invokeMethod(player, "error", Qt::QueuedConnection);
        QMetaObject::invokeMethod(player, "setErrorMessage", Qt::QueuedConnection, 
                                  Q_ARG(QString, "Unable to access stream (Error 403). This stream may be region-locked, require authentication, or be blocked by the server."));
        break;
    case libvlc_MediaPlayerPositionChanged:
        if (event->u.media_player_position_changed.new_position >= 0) {
            float pos = event->u.media_player_position_changed.new_position;
            QMetaObject::invokeMethod(player, "setPositionInternal", Qt::QueuedConnection, Q_ARG(float, pos));
        }
        break;
    case libvlc_MediaPlayerTimeChanged:
        if (event->u.media_player_time_changed.new_time >= 0) {
            int time = event->u.media_player_time_changed.new_time;
            QMetaObject::invokeMethod(player, "setTimeInternal", Qt::QueuedConnection, Q_ARG(int, time));
        }
        break;
    case libvlc_MediaPlayerLengthChanged:
        if (event->u.media_player_length_changed.new_length >= 0) {
            int length = event->u.media_player_length_changed.new_length;
            QMetaObject::invokeMethod(player, "setLengthInternal", Qt::QueuedConnection, Q_ARG(int, length));
        }
        break;
    default:
        break;
    }
}
#endif

VlcPlayer::VlcPlayer(QObject *parent)
    : QObject(parent)
    , m_vlcInstance(nullptr)
    , m_vlcPlayer(nullptr)
    , m_vlcMedia(nullptr)
    , m_state(Idle)
    , m_position(0.0f)
    , m_time(0)
    , m_length(0)
    , m_volume(100.0f)
    , m_muted(false)
    , m_videoOutput(nullptr)
    , m_videoWindow(nullptr)
{
    qDebug() << "VlcPlayer: Constructor called";
    createVlcInstance();
}

VlcPlayer::~VlcPlayer()
{
    qDebug() << "VlcPlayer: Destructor called";
    stop();
    destroyVlcInstance();
}

void VlcPlayer::createVlcInstance()
{
#ifdef HAVE_VLC
    // Create VLC instance with options for HTTP headers
    // Set User-Agent at instance level (applies to all media)
    const char *vlc_args[] = {
        "--intf", "dummy",           // No interface
        "--no-video-title-show",     // Don't show video title
        "--quiet",                   // Quiet mode
        "--http-user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
        "--network-caching=2000",    // 2 second network cache (default, can be overridden per media)
        "--http-reconnect",          // Auto-reconnect on errors
        // Note: HLS-specific options are set per-media, not at instance level
    };

    m_vlcInstance = libvlc_new(sizeof(vlc_args) / sizeof(vlc_args[0]), vlc_args);
    
    if (!m_vlcInstance) {
        qCritical() << "VlcPlayer: Failed to create VLC instance!";
        setErrorMessage("Failed to initialize VLC player. Please ensure VLC is installed.");
        return;
    }

    qDebug() << "VlcPlayer: VLC instance created successfully";

    // Create media player
    m_vlcPlayer = libvlc_media_player_new(m_vlcInstance);
    if (!m_vlcPlayer) {
        qCritical() << "VlcPlayer: Failed to create media player!";
        destroyVlcInstance();
        setErrorMessage("Failed to create VLC media player.");
        return;
    }

    qDebug() << "VlcPlayer: Media player created successfully";

    // Setup event callbacks
    setupCallbacks();
#else
    qCritical() << "VlcPlayer: libVLC not available - compiled without HAVE_VLC";
    setErrorMessage("VLC player not available. Please install VLC media player.");
#endif
}

void VlcPlayer::destroyVlcInstance()
{
#ifdef HAVE_VLC
    if (m_vlcPlayer) {
        libvlc_media_player_release(m_vlcPlayer);
        m_vlcPlayer = nullptr;
    }

    if (m_vlcMedia) {
        libvlc_media_release(m_vlcMedia);
        m_vlcMedia = nullptr;
    }

    if (m_vlcInstance) {
        libvlc_release(m_vlcInstance);
        m_vlcInstance = nullptr;
    }

    qDebug() << "VlcPlayer: VLC instance destroyed";
#endif
}

void VlcPlayer::setupCallbacks()
{
#ifdef HAVE_VLC
    if (!m_vlcPlayer) return;

    libvlc_event_manager_t *eventManager = libvlc_media_player_event_manager(m_vlcPlayer);
    if (!eventManager) return;

    // Attach to relevant events
    libvlc_event_attach(eventManager, libvlc_MediaPlayerPlaying, vlcEventCallback, this);
    libvlc_event_attach(eventManager, libvlc_MediaPlayerPaused, vlcEventCallback, this);
    libvlc_event_attach(eventManager, libvlc_MediaPlayerStopped, vlcEventCallback, this);
    libvlc_event_attach(eventManager, libvlc_MediaPlayerEndReached, vlcEventCallback, this);
    libvlc_event_attach(eventManager, libvlc_MediaPlayerEncounteredError, vlcEventCallback, this);
    libvlc_event_attach(eventManager, libvlc_MediaPlayerPositionChanged, vlcEventCallback, this);
    libvlc_event_attach(eventManager, libvlc_MediaPlayerTimeChanged, vlcEventCallback, this);
    libvlc_event_attach(eventManager, libvlc_MediaPlayerLengthChanged, vlcEventCallback, this);

    qDebug() << "VlcPlayer: Event callbacks set up";
#endif
}

void VlcPlayer::setupMedia(const QString &url)
{
#ifdef HAVE_VLC
    if (!m_vlcInstance || !m_vlcPlayer) {
        qCritical() << "VlcPlayer: Cannot setup media - VLC not initialized";
        return;
    }

    // Release previous media if any
    if (m_vlcMedia) {
        libvlc_media_release(m_vlcMedia);
        m_vlcMedia = nullptr;
    }

    qDebug() << "VlcPlayer: Setting up media for URL:" << url;

    // Create media from URL
    QByteArray urlBytes = url.toUtf8();
    m_vlcMedia = libvlc_media_new_location(m_vlcInstance, urlBytes.constData());

    if (!m_vlcMedia) {
        qCritical() << "VlcPlayer: Failed to create media from URL";
        setErrorMessage("Failed to load media: Invalid URL");
        m_state = Error;
        emit stateChanged(m_state);
        return;
    }

    // Set HTTP headers for this media
    // Extract referer from URL
    QUrl qurl(url);
    QString referer = qurl.scheme() + "://" + qurl.host();
    if (qurl.port() != -1 && qurl.port() != 80 && qurl.port() != 443) {
        referer += ":" + QString::number(qurl.port());
    }
    QString userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";

    // Add custom HTTP headers - use correct libVLC option format
    // Note: libvlc_media_add_option uses format ":option=value"
    // The http-referrer option should work, but we also try http-referer for compatibility
    QByteArray refererBytes = referer.toUtf8();
    QByteArray userAgentBytes = userAgent.toUtf8();
    
    // Set headers using libvlc_media_add_option (must be called before set_media)
    // Note: Some versions of libVLC use different option names
    libvlc_media_add_option(m_vlcMedia, QString(":http-referrer=%1").arg(referer).toUtf8().constData());
    libvlc_media_add_option(m_vlcMedia, QString(":http-user-agent=%1").arg(userAgent).toUtf8().constData());
    libvlc_media_add_option(m_vlcMedia, ":http-accept=*/*");
    libvlc_media_add_option(m_vlcMedia, ":http-accept-language=en-US,en;q=0.9,*;q=0.8");
    libvlc_media_add_option(m_vlcMedia, ":http-accept-encoding=gzip, deflate, br");
    libvlc_media_add_option(m_vlcMedia, ":http-keep-alive=true");
    libvlc_media_add_option(m_vlcMedia, ":http-timeout=30000"); // 30 second timeout
    libvlc_media_add_option(m_vlcMedia, ":http-forward-cookies=true"); // Forward cookies if any
    
    // HLS-specific options for better compatibility
    // Check if URL is HLS/M3U8 stream
    if (url.contains(".m3u8", Qt::CaseInsensitive) || url.contains("hls", Qt::CaseInsensitive)) {
        qDebug() << "VlcPlayer: Detected HLS stream, applying HLS-specific options";
        libvlc_media_add_option(m_vlcMedia, ":network-caching=3000"); // 3 seconds for HLS (needs more buffer)
        libvlc_media_add_option(m_vlcMedia, ":live-caching=3000"); // Live stream caching
        libvlc_media_add_option(m_vlcMedia, ":hls-segment-threads=3"); // Parallel segment downloads
        libvlc_media_add_option(m_vlcMedia, ":hls-timeout=10000"); // 10 second timeout for segments
        libvlc_media_add_option(m_vlcMedia, ":http-reconnect"); // Auto-reconnect for live streams
    } else {
        libvlc_media_add_option(m_vlcMedia, ":network-caching=1000"); // 1 second cache for direct files
    }
    
    qDebug() << "VlcPlayer: HTTP headers set - Referer:" << referer;
    qDebug() << "VlcPlayer: HTTP headers set - User-Agent:" << userAgent;
    qDebug() << "VlcPlayer: Note - Some streams may be region-locked or require authentication";

    // Set media to player
    libvlc_media_player_set_media(m_vlcPlayer, m_vlcMedia);

    // Attach to video output if available
    attachToVideoOutput();

    updateState();
#else
    qCritical() << "VlcPlayer: Cannot setup media - libVLC not available";
    setErrorMessage("VLC player not available.");
    m_state = Error;
    emit stateChanged(m_state);
#endif
}

void VlcPlayer::attachToVideoOutput()
{
#ifdef HAVE_VLC
    if (!m_vlcPlayer || !m_videoOutput) return;

    QWindow *window = nullptr;
    if (m_videoOutput->window()) {
        window = m_videoOutput->window();
    }

    if (window) {
        // Get native window handle
        WId winId = window->winId();
        if (winId) {
            qDebug() << "VlcPlayer: Attaching to window ID:" << winId;
            libvlc_media_player_set_hwnd(m_vlcPlayer, (void*)winId);
            m_videoWindow = window;
        } else {
            qWarning() << "VlcPlayer: Window ID is invalid";
        }
    } else {
        // Try to get window from video output item
        if (m_videoOutput && m_videoOutput->window()) {
            QWindow *w = m_videoOutput->window();
            WId winId = w->winId();
            if (winId) {
                qDebug() << "VlcPlayer: Attaching to video output window ID:" << winId;
                #ifdef Q_OS_WIN
                libvlc_media_player_set_hwnd(m_vlcPlayer, (void*)winId);
                #else
                libvlc_media_player_set_xwindow(m_vlcPlayer, static_cast<uint32_t>(winId));
                #endif
                m_videoWindow = w;
            }
        }
    }
#endif
}

void VlcPlayer::onVideoOutputWindowChanged(QWindow *window)
{
    qDebug() << "VlcPlayer: Video output window changed";
    attachToVideoOutput();
}

void VlcPlayer::setSource(const QString &source)
{
    if (m_source == source) return;

    qDebug() << "VlcPlayer: Setting source:" << source;

    stop();

    m_source = source;
    emit sourceChanged(m_source);

    if (!source.isEmpty()) {
        setupMedia(source);
    }
}

void VlcPlayer::play()
{
#ifdef HAVE_VLC
    if (!m_vlcPlayer) {
        qWarning() << "VlcPlayer: Cannot play - player not initialized";
        return;
    }

    if (m_source.isEmpty()) {
        qWarning() << "VlcPlayer: Cannot play - no source set";
        return;
    }

    // Ensure video output is attached
    attachToVideoOutput();

    qDebug() << "VlcPlayer: Starting playback";
    int ret = libvlc_media_player_play(m_vlcPlayer);
    
    if (ret == 0) {
        updateState();
    } else {
        qCritical() << "VlcPlayer: Failed to start playback";
        setErrorMessage("Failed to start playback");
        m_state = Error;
        emit stateChanged(m_state);
    }
#endif
}

void VlcPlayer::pause()
{
#ifdef HAVE_VLC
    if (!m_vlcPlayer) return;

    qDebug() << "VlcPlayer: Pausing playback";
    libvlc_media_player_pause(m_vlcPlayer);
    updateState();
#endif
}

void VlcPlayer::stop()
{
#ifdef HAVE_VLC
    if (!m_vlcPlayer) return;

    qDebug() << "VlcPlayer: Stopping playback";
    libvlc_media_player_stop(m_vlcPlayer);
    m_position = 0.0f;
    m_time = 0;
    updateState();
    emit positionChanged(m_position);
    emit timeChanged(m_time);
#endif
}

void VlcPlayer::seek(int time)
{
#ifdef HAVE_VLC
    if (!m_vlcPlayer) return;
    if (m_length <= 0) return;

    qDebug() << "VlcPlayer: Seeking to time:" << time << "ms";
    libvlc_time_t vlcTime = time;
    libvlc_media_player_set_time(m_vlcPlayer, vlcTime);
#endif
}

void VlcPlayer::setTimePosition(float position)
{
#ifdef HAVE_VLC
    if (!m_vlcPlayer) return;
    if (m_length <= 0) return;

    position = qBound(0.0f, position, 1.0f);
    qDebug() << "VlcPlayer: Setting position:" << position;
    libvlc_media_player_set_position(m_vlcPlayer, position);
#endif
}

void VlcPlayer::setPosition(float position)
{
    setTimePosition(position);
}

void VlcPlayer::setTime(int time)
{
    seek(time);
}

void VlcPlayer::setVolume(float volume)
{
    volume = qBound(0.0f, volume, 100.0f);
    if (qAbs(m_volume - volume) < 0.01f) return;

    m_volume = volume;

#ifdef HAVE_VLC
    if (m_vlcPlayer) {
        int vlcVolume = static_cast<int>(volume);
        libvlc_audio_set_volume(m_vlcPlayer, vlcVolume);
    }
#endif

    emit volumeChanged(m_volume);
}

void VlcPlayer::setMuted(bool muted)
{
    if (m_muted == muted) return;

    m_muted = muted;

#ifdef HAVE_VLC
    if (m_vlcPlayer) {
        libvlc_audio_set_mute(m_vlcPlayer, muted ? 1 : 0);
    }
#endif

    emit mutedChanged(m_muted);
}

void VlcPlayer::updateState()
{
#ifdef HAVE_VLC
    if (!m_vlcPlayer) {
        m_state = Idle;
        emit stateChanged(m_state);
        return;
    }

    libvlc_state_t vlcState = libvlc_media_player_get_state(m_vlcPlayer);

    int newState = Idle;
    switch (vlcState) {
    case libvlc_NothingSpecial:
        newState = Idle;
        break;
    case libvlc_Opening:
        newState = Opening;
        break;
    case libvlc_Buffering:
        newState = Buffering;
        break;
    case libvlc_Playing:
        newState = Playing;
        break;
    case libvlc_Paused:
        newState = Paused;
        break;
    case libvlc_Stopped:
        newState = Stopped;
        break;
    case libvlc_Ended:
        newState = Ended;
        break;
    case libvlc_Error:
        newState = Error;
        break;
    }

    if (m_state != newState) {
        m_state = newState;
        emit stateChanged(m_state);
        qDebug() << "VlcPlayer: State changed to:" << m_state;
    }

    // Update position and time
    if (m_vlcPlayer && (vlcState == libvlc_Playing || vlcState == libvlc_Paused)) {
        float pos = libvlc_media_player_get_position(m_vlcPlayer);
        if (pos >= 0 && qAbs(m_position - pos) > 0.001f) {
            m_position = pos;
            emit positionChanged(m_position);
        }

        libvlc_time_t time = libvlc_media_player_get_time(m_vlcPlayer);
        if (time >= 0 && m_time != static_cast<int>(time)) {
            m_time = static_cast<int>(time);
            emit timeChanged(m_time);
        }

        libvlc_time_t length = libvlc_media_player_get_length(m_vlcPlayer);
        if (length >= 0 && m_length != static_cast<int>(length)) {
            m_length = static_cast<int>(length);
            emit lengthChanged(m_length);
        }
    }
#endif
}

void VlcPlayer::setErrorMessage(const QString &error)
{
    if (m_errorMessage == error) return;
    m_errorMessage = error;
    emit errorMessageChanged(m_errorMessage);
    if (!error.isEmpty()) {
        qCritical() << "VlcPlayer Error:" << error;
    }
}

void VlcPlayer::setPositionInternal(float position)
{
    if (qAbs(m_position - position) > 0.001f) {
        m_position = position;
        emit positionChanged(m_position);
    }
}

void VlcPlayer::setTimeInternal(int time)
{
    if (m_time != time) {
        m_time = time;
        emit timeChanged(m_time);
    }
}

void VlcPlayer::setLengthInternal(int length)
{
    if (m_length != length) {
        m_length = length;
        emit lengthChanged(m_length);
    }
}

void VlcPlayer::setVideoOutput(QQuickItem* videoOutput)
{
    if (m_videoOutput == videoOutput) return;

    if (m_videoOutput && m_videoOutput->window()) {
        disconnect(m_videoOutput->window(), nullptr, this, nullptr);
    }

    m_videoOutput = videoOutput;

    if (m_videoOutput && m_videoOutput->window()) {
        // Connect to window changes - use a lambda to match signal signature
        connect(m_videoOutput->window(), &QWindow::visibleChanged, this, [this](bool) {
            onVideoOutputWindowChanged(m_videoOutput ? m_videoOutput->window() : nullptr);
        });
        attachToVideoOutput();
    }

    emit videoOutputChanged(m_videoOutput);
}
