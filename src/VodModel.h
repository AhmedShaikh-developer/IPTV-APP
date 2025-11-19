#ifndef VODMODEL_H
#define VODMODEL_H

#include <QAbstractListModel>
#include <QList>
#include "VodItem.h"

class VodModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        GroupTitleRole,
        LogoRole,
        UrlRole
    };

    explicit VodModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void addItem(VodItem *item);
    void clear();
    VodItem* get(int index) const;

private:
    QList<VodItem*> m_items;
};

#endif // VODMODEL_H

