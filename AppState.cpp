#include "AppState.h"
#include <QDebug>

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
    qDebug() << "AppState::set called with key:" << key << "value:" << value;
    m_settings.setValue(key, value);
    qDebug() << "AppState::set emitting valueChanged signal";
    emit valueChanged(key, value);
}

void AppState::remove(const QString& key)
{
    m_settings.remove(key);
    emit valueChanged(key, QVariant());
}
