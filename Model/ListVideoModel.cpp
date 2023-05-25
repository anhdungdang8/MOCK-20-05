#include "ListVideoModel.h"

ListVideoModel::ListVideoModel(QVector<MediaModel*> &videoListModel,QObject *parent)
    :  QAbstractListModel(parent),m_listVideo()
{
    m_listVideo=videoListModel;
}

ListVideoModel::~ListVideoModel()
{

    for(int i=0;i<m_listVideo.size();i++)
    {
        delete m_listVideo[i];
    }

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

    MediaModel* videos = m_listVideo.at(index.row());
    if ( role == TitleVideo ){
        return videos->getTitle();
    }
    else if ( role == AlbumVideo )
        return videos->getAlbum();
    else if ( role == ArtistVideo )
        return videos->getArtist();
    else if(role==SourceVideo)
        return videos->getSource();
    else if(role==IndexVideo)
        return videos->getIndex();
    else
        return QVariant();
}

QHash<int, QByteArray> ListVideoModel::roleNames() const
{
    static QHash<int, QByteArray> mapping {
        {TitleVideo, "TitleVideo"},
        {AlbumVideo, "AlbumVideo"},
        {ArtistVideo, "ArtistVideo"},
        {SourceVideo,"SourceVideo"},
        {IndexVideo,"IndexVideo"}
    };
    return mapping;
}

void ListVideoModel::removeVideoModel(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    m_listVideo.removeAt(index);
    endRemoveRows();

}
