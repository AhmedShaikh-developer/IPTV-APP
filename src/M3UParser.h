#ifndef M3UPARSER_H
#define M3UPARSER_H

#include <QObject>
#include <QString>
#include <QList>
#include "LiveChannel.h"
#include "VodItem.h"

class M3UParser : public QObject
{
    Q_OBJECT

public:
    explicit M3UParser(QObject *parent = nullptr);

    struct ParseResult {
        QList<LiveChannel*> liveChannels;
        QList<VodItem*> vodItems;
    };

    ParseResult parse(const QString &m3uContent);

private:
    bool isLiveGroup(const QString &groupTitle) const;
    bool isVodGroup(const QString &groupTitle) const;
    QString extractAttribute(const QString &line, const QString &attrName) const;
};

#endif // M3UPARSER_H

