#ifndef LIVECHANNEL_H
#define LIVECHANNEL_H

#include <QObject>
#include <QString>

class LiveChannel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString groupTitle READ groupTitle CONSTANT)
    Q_PROPERTY(QString logo READ logo CONSTANT)
    Q_PROPERTY(QString url READ url CONSTANT)

public:
    explicit LiveChannel(QObject *parent = nullptr);
    LiveChannel(const QString &name, const QString &groupTitle, const QString &logo, const QString &url, QObject *parent = nullptr);

    QString name() const { return m_name; }
    QString groupTitle() const { return m_groupTitle; }
    QString logo() const { return m_logo; }
    QString url() const { return m_url; }

private:
    QString m_name;
    QString m_groupTitle;
    QString m_logo;
    QString m_url;
};

#endif // LIVECHANNEL_H

