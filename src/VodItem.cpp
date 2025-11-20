#include "VodItem.h"

VodItem::VodItem(QObject *parent)
    : QObject(parent)
{
}

VodItem::VodItem(const QString &name,
                 const QString &groupTitle,
                 const QString &logo,
                 const QString &url,
                 const QStringList &vlcOptions,
                 QObject *parent)
    : QObject(parent)
    , m_name(name)
    , m_groupTitle(groupTitle)
    , m_logo(logo)
    , m_url(url)
    , m_vlcOptions(vlcOptions)
{
}

