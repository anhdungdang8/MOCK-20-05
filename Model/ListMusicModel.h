#ifndef LISTMUSICMODEL_H
#define LISTMUSICMODEL_H
#include <taglib.h>
#include <QObject>
#include <QVector>
#include <QDir>
//#include <tag.h>
//#include<fileref.h>
#include <QByteArray>
#include <QStandardPaths>
#include <QFileDialog>
#include <cstdlib>
#include <QDebug>
#include <QAbstractListModel>
#include <QBuffer>
#include "MediaModel.h"


#include <tag.h>
#include <fileref.h>

#include <mpegfile.h>
#include <attachedpictureframe.h>
#include <id3v2tag.h>
#include <mp4file.h>
#include <mp4tag.h>
#include <mp4coverart.h>

class ListMusicModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ListMusicModel(QVector<MediaModel*> &songList,QObject *parent = nullptr);
    enum Songs {
        TitleSongs = Qt::UserRole+1,
        ArtistSongs,
        AlbumSongs,
        SourceSongs,
        IndexSongs,
        //Duration,



    };
    ~ListMusicModel();

    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;
    void removeMusicModel(int index);
    QImage  imageForTag(QString mediasource);


signals:


private:
    QVector<MediaModel*> m_listSong;

};

#endif // LISTMUSICMODEL_H
