#include "ListVideoModel.h"

ListVideoModel::ListVideoModel(QVector<SongModel*> &videoListModel,QObject *parent)
    :  QAbstractListModel(parent),m_listVideo()
{
    m_listVideo=videoListModel;
}

ListVideoModel::~ListVideoModel()
{
    for (SongModel* video : m_listVideo) {
        delete video;
    }
    m_listVideo.clear();

}

int ListVideoModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_listVideo.count();
}

QVariant ListVideoModel::data(const QModelIndex &index, int role) const
{
    if ( !index.isValid() )
        return QVariant();

    SongModel* videos = m_listVideo.at(index.row());
    if ( role == Title ){
        return videos->getTitle();
    }
    else if ( role == Album )
        return videos->getAlbum();
    else if ( role == Artist )
        return videos->getArtist();
    else if(role==Source)
        return videos->getSource();
    else
        return QVariant();
}

QHash<int, QByteArray> ListVideoModel::roleNames() const
{
    static QHash<int, QByteArray> mapping {
        {Title, "Title"},
        {Album, "Album"},
        {Artist, "Artist"},
        {Source,"Source"}
    };
    return mapping;
}
