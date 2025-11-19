#ifndef CHANNELMODEL_H
#define CHANNELMODEL_H

#include <QAbstractListModel>
#include <QList>
#include "LiveChannel.h"

class ChannelModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        GroupTitleRole,
        LogoRole,
        UrlRole
    };

    explicit ChannelModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void addChannel(LiveChannel *channel);
    void clear();
    LiveChannel* get(int index) const;

private:
    QList<LiveChannel*> m_channels;
};

#endif // CHANNELMODEL_H

