#ifndef LISTSONGMODEL_H
#define LISTSONGMODEL_H
#include <taglib.h>
#include <QObject>
#include <QVector>
#include <QDir>
#include <tag.h>
#include<fileref.h>
#include <QByteArray>
#include <QStandardPaths>
#include <QFileDialog>
#include <cstdlib>
#include <QDebug>
#include <QAbstractListModel>
#include "SongModel.h"

class ListSongModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ListSongModel(QObject *parent = nullptr);
    enum Roles {
        Title = Qt::UserRole+1,
        Artist,
        Album,
        //Duration,



    };

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;
    void getFolderMusic();








signals:
private:
    QVector<SongModel*> m_listSong;
};

#endif // LISTSONGMODEL_H
