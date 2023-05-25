#include "ListMusicModel.h"
#include "fileref.h"


ListMusicModel::ListMusicModel(QVector<MediaModel*> &songList, QObject *parent)
    : QAbstractListModel(parent),m_listSong()
{

    m_listSong=songList;


}

ListMusicModel::~ListMusicModel()
{

    for(int i=0;i<m_listSong.size();i++)
    {
        delete m_listSong[i];
    }
    m_listSong.clear();

}

int ListMusicModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_listSong.count();
}

QVariant ListMusicModel::data(const QModelIndex &index, int role) const
{
    if ( !index.isValid() )
        return QVariant();

    MediaModel* songs = m_listSong.at(index.row());
    if ( role == TitleSongs ){
        return songs->getTitle();
    }
    else if ( role == AlbumSongs )
        return songs->getAlbum();
    else if ( role == ArtistSongs )
        return songs->getArtist();
    else if(role==SourceSongs)
        return songs->getSource();
    else if(role==IndexSongs)
        return songs->getIndex();
    else
        return QVariant();
}

QHash<int, QByteArray> ListMusicModel::roleNames() const
{
    static QHash<int, QByteArray> mapping {
        {TitleSongs, "TitleSongs"},
        {ArtistSongs, "ArtistSongs"},
        {AlbumSongs, "AlbumSongs"},
        {SourceSongs,"SourceSongs"},
        {IndexSongs,"IndexSongs"}
    };
    return mapping;
}

void ListMusicModel::removeMusicModel(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    m_listSong.removeAt(index);
    endRemoveRows();

}

QImage ListMusicModel::imageForTag(QString mediasource)
{
    QImage image;
        TagLib::FileRef taglib_file(mediasource.toLocal8Bit().data());
        if (taglib_file.isNull())
            std::cerr << "TagLib can't read the file." << std::endl;
        TagLib::ID3v2::Tag tagObject = TagLib::ID3v2::Tag(taglib_file.file(), 0);
        TagLib::ID3v2::Tag* tag = &tagObject;
        TagLib::ID3v2::FrameList l = tag->frameList("APIC");
        if(l.isEmpty()) {
            return image;
        }
        TagLib::ID3v2::AttachedPictureFrame *f =
                static_cast<TagLib::ID3v2::AttachedPictureFrame *>(l.front());
        image.loadFromData((const uchar *) f->picture().data(), f->picture().size());
        return image;

}









