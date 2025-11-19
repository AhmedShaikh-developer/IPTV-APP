#include "ChannelModel.h"

ChannelModel::ChannelModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int ChannelModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_channels.size();
}

QVariant ChannelModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_channels.size())
        return QVariant();

    LiveChannel *channel = m_channels.at(index.row());

    switch (role) {
    case NameRole:
        return channel->name();
    case GroupTitleRole:
        return channel->groupTitle();
    case LogoRole:
        return channel->logo();
    case UrlRole:
        return channel->url();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ChannelModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[GroupTitleRole] = "groupTitle";
    roles[LogoRole] = "logo";
    roles[UrlRole] = "url";
    return roles;
}

void ChannelModel::addChannel(LiveChannel *channel)
{
    beginInsertRows(QModelIndex(), m_channels.size(), m_channels.size());
    m_channels.append(channel);
    endInsertRows();
}

void ChannelModel::clear()
{
    beginResetModel();
    qDeleteAll(m_channels);
    m_channels.clear();
    endResetModel();
}

LiveChannel* ChannelModel::get(int index) const
{
    if (index >= 0 && index < m_channels.size())
        return m_channels.at(index);
    return nullptr;
}

