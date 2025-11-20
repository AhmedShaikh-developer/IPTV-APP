#ifndef VLCPLAYER_H
#define VLCPLAYER_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QUrl>
#include <QQuickItem>
#include <QWindow>

// Forward declarations for VLC
struct libvlc_instance_t;
struct libvlc_media_player_t;
struct libvlc_media_t;

class VlcPlayer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(int state READ state NOTIFY stateChanged)
    Q_PROPERTY(float position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(int time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(int length READ length NOTIFY lengthChanged)
    Q_PROPERTY(float volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(bool muted READ muted WRITE setMuted NOTIFY mutedChanged)
    Q_PROPERTY(QString errorMessage READ errorMessage NOTIFY errorMessageChanged)
    Q_PROPERTY(QQuickItem* videoOutput READ videoOutput WRITE setVideoOutput NOTIFY videoOutputChanged)
    // Additional libVLC options (from #EXTVLCOPT). Each entry should be in the
    // form "option=value" (without leading colon). They will be passed to
    // libvlc_media_add_option as ":option=value".
    Q_PROPERTY(QStringList vlcOptions READ vlcOptions WRITE setVlcOptions NOTIFY vlcOptionsChanged)

public:
    enum State {
        Idle = 0,
        Opening = 1,
        Buffering = 2,
        Playing = 3,
        Paused = 4,
        Stopped = 5,
        Ended = 6,
        Error = 7
    };
    Q_ENUM(State)

    explicit VlcPlayer(QObject *parent = nullptr);
    ~VlcPlayer();

    QString source() const { return m_source; }
    void setSource(const QString &source);

    int state() const { return m_state; }
    float position() const { return m_position; }
    void setPosition(float position);
    int time() const { return m_time; }
    void setTime(int time);
    int length() const { return m_length; }
    float volume() const { return m_volume; }
    void setVolume(float volume);
    bool muted() const { return m_muted; }
    void setMuted(bool muted);
    QString errorMessage() const { return m_errorMessage; }

    QQuickItem* videoOutput() const { return m_videoOutput; }
    void setVideoOutput(QQuickItem* videoOutput);

    QStringList vlcOptions() const { return m_vlcOptions; }
    void setVlcOptions(const QStringList &options);

    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void seek(int time);
    Q_INVOKABLE void setTimePosition(float position);

    // Internal methods for callbacks (public for QMetaObject::invokeMethod)
    Q_INVOKABLE void setPositionInternal(float position);
    Q_INVOKABLE void setTimeInternal(int time);
    Q_INVOKABLE void setLengthInternal(int length);

signals:
    void sourceChanged(const QString &source);
    void stateChanged(int state);
    void positionChanged(float position);
    void timeChanged(int time);
    void lengthChanged(int length);
    void volumeChanged(float volume);
    void mutedChanged(bool muted);
    void errorMessageChanged(const QString &error);
    void videoOutputChanged(QQuickItem* videoOutput);
    void playing();
    void paused();
    void stopped();
    void ended();
    void error();
    void vlcOptionsChanged(const QStringList &options);

public slots:
    // Public slots for QMetaObject::invokeMethod access
    Q_INVOKABLE void updateState();
    Q_INVOKABLE void setErrorMessage(const QString &error);

private slots:
    void onVideoOutputWindowChanged(QWindow *window);

private:
    void createVlcInstance();
    void destroyVlcInstance();
    void setupMedia(const QString &url);
    void setupCallbacks();
    void attachToVideoOutput();

    libvlc_instance_t *m_vlcInstance;
    libvlc_media_player_t *m_vlcPlayer;
    libvlc_media_t *m_vlcMedia;

    QString m_source;
    int m_state;
    float m_position;
    int m_time;
    int m_length;
    float m_volume;
    bool m_muted;
    QString m_errorMessage;
    QQuickItem *m_videoOutput;
    QWindow *m_videoWindow;
    QStringList m_vlcOptions;
};

#endif // VLCPLAYER_H
