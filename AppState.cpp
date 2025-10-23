#include "AppState.h"

AppState::AppState(QObject *parent)
    : QObject(parent)
    , m_settings("IPTVPro", "App")
{
}

QVariant AppState::get(const QString& key, const QVariant& def) const
{
    return m_settings.value(key, def);
}

void AppState::set(const QString& key, const QVariant& value)
{
    m_settings.setValue(key, value);
    emit valueChanged(key, value);
}

void AppState::remove(const QString& key)
{
    m_settings.remove(key);
    emit valueChanged(key, QVariant());
}
