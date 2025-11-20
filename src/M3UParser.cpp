#include "M3UParser.h"
#include <QDebug>
#include <QRegularExpression>

M3UParser::M3UParser(QObject *parent)
    : QObject(parent)
{
}

M3UParser::ParseResult M3UParser::parse(const QString &m3uContent)
{
    ParseResult result;

    QStringList lines = m3uContent.split('\n', Qt::SkipEmptyParts);
    QString currentName;
    QString currentGroup;
    QString currentLogo;
    QString currentUrl;
    QStringList currentOptions;

    for (int i = 0; i < lines.size(); ++i) {
        QString line = lines[i].trimmed();

        if (line.startsWith("#EXTM3U")) {
            // M3U header, continue
            continue;
        } else if (line.startsWith("#EXTINF:")) {
            // Parse EXTINF line
            // Format: #EXTINF:-1 tvg-name="Channel Name" tvg-logo="logo.png" group-title="Group",Channel Name
            currentName = extractAttribute(line, "tvg-name");
            currentLogo = extractAttribute(line, "tvg-logo");
            currentGroup = extractAttribute(line, "group-title");

            // If tvg-name is not found, try to get name from the end of the line
            if (currentName.isEmpty()) {
                int commaIndex = line.lastIndexOf(',');
                if (commaIndex >= 0) {
                    currentName = line.mid(commaIndex + 1).trimmed();
                }
            }

            // If group-title is not found, try to extract from the line
            if (currentGroup.isEmpty()) {
                QRegularExpression groupRegex(QStringLiteral("group-title=\"([^\"]+)\""));
                QRegularExpressionMatch match = groupRegex.match(line);
                if (match.hasMatch()) {
                    currentGroup = match.captured(1);
                }
            }

            // Reset per-entry VLC options for the new entry
            currentOptions.clear();
        } else if (line.startsWith("#EXTVLCOPT:")) {
            // Per-entry VLC options that should be passed directly to libVLC
            // Example: #EXTVLCOPT:http-user-agent=...
            QString opt = line.mid(QStringLiteral("#EXTVLCOPT:").length()).trimmed();
            if (!opt.isEmpty()) {
                currentOptions.append(opt);
                qDebug() << "M3U Parser: Found VLC option for" << currentName << ":" << opt;
            }
        } else if (!line.startsWith("#") && !line.isEmpty()) {
            // This is the URL line
            currentUrl = line.trimmed();

            // Create channel/item if we have all necessary data
            if (!currentUrl.isEmpty() && !currentName.isEmpty()) {
                if (isVodGroup(currentGroup)) {
                    VodItem *item = new VodItem(currentName, currentGroup, currentLogo, currentUrl, currentOptions, this);
                    result.vodItems.append(item);
                    if (!currentOptions.isEmpty()) {
                        qDebug() << "M3U Parser: Created VOD item" << currentName << "with" << currentOptions.size() << "VLC options";
                    }
                } else {
                    // Default to live channel
                    LiveChannel *channel = new LiveChannel(currentName, currentGroup, currentLogo, currentUrl, currentOptions, this);
                    result.liveChannels.append(channel);
                    if (!currentOptions.isEmpty()) {
                        qDebug() << "M3U Parser: Created live channel" << currentName << "with" << currentOptions.size() << "VLC options";
                    }
                }
            }

            // Reset for next entry
            currentName.clear();
            currentGroup.clear();
            currentLogo.clear();
            currentUrl.clear();
            currentOptions.clear();
        }
    }

    qDebug() << "M3U Parser: Found" << result.liveChannels.size() << "live channels and" << result.vodItems.size() << "VOD items";
    return result;
}

bool M3UParser::isLiveGroup(const QString &groupTitle) const
{
    if (groupTitle.isEmpty())
        return true; // Default to live

    QString lower = groupTitle.toLower();
    return lower.contains("live") || lower.contains("channel") || 
           lower.contains("tv") || lower.contains("stream");
}

bool M3UParser::isVodGroup(const QString &groupTitle) const
{
    if (groupTitle.isEmpty())
        return false;

    QString lower = groupTitle.toLower();
    return lower.contains("vod") || lower.contains("movie") || 
           lower.contains("series") || lower.contains("film");
}

QString M3UParser::extractAttribute(const QString &line, const QString &attrName) const
{
    QRegularExpression regex(QString(QStringLiteral("%1=\"([^\"]+)\"")).arg(attrName));
    QRegularExpressionMatch match = regex.match(line);
    if (match.hasMatch()) {
        return match.captured(1);
    }
    return QString();
}

