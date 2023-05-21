#include "ListSongModel.h"
#include "fileref.h"


ListSongModel::ListSongModel(QVector<SongModel*> &songList, QObject *parent)
    : QAbstractListModel(parent),m_listSong()
{

    m_listSong=songList;

}

ListSongModel::~ListSongModel()
{
    for (SongModel* song : m_listSong) {
        delete song;
    }
    m_listSong.clear();

}

int ListSongModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_listSong.count();
}

QVariant ListSongModel::data(const QModelIndex &index, int role) const
{
    if ( !index.isValid() )
        return QVariant();

    SongModel* songs = m_listSong.at(index.row());
    if ( role == Title ){
        return songs->getTitle();
    }
    else if ( role == Album )
        return songs->getAlbum();
    else if ( role == Artist )
        return songs->getArtist();
    else if(role==Source)
        return songs->getSource();
    else
        return QVariant();
}

QHash<int, QByteArray> ListSongModel::roleNames() const
{
    static QHash<int, QByteArray> mapping {
        {Title, "Title"},
        {Album, "Album"},
        {Artist, "Artist"},
        {Source,"Source"}
    };
    return mapping;
}






