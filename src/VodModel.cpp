#include "VodModel.h"

VodModel::VodModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int VodModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_items.size();
}

QVariant VodModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    VodItem *item = m_items.at(index.row());

    switch (role) {
    case NameRole:
        return item->name();
    case GroupTitleRole:
        return item->groupTitle();
    case LogoRole:
        return item->logo();
    case UrlRole:
        return item->url();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> VodModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[GroupTitleRole] = "groupTitle";
    roles[LogoRole] = "logo";
    roles[UrlRole] = "url";
    return roles;
}

void VodModel::addItem(VodItem *item)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append(item);
    endInsertRows();
}

void VodModel::clear()
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    endResetModel();
}

VodItem* VodModel::get(int index) const
{
    if (index >= 0 && index < m_items.size())
        return m_items.at(index);
    return nullptr;
}

