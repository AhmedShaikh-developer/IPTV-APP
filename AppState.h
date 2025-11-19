#ifndef APPSTATE_H
#define APPSTATE_H

#include <QObject>
#include <QSettings>
#include <QVariant>

class AppState : public QObject
{
    Q_OBJECT

public:
    explicit AppState(QObject *parent = nullptr);
    
    Q_INVOKABLE QVariant get(const QString& key, const QVariant& def = QVariant()) const;
    Q_INVOKABLE void set(const QString& key, const QVariant& value);
    Q_INVOKABLE void remove(const QString& key);

signals:
    void valueChanged(QString key, QVariant value);

private:
    QSettings m_settings;
};

#endif // APPSTATE_H
