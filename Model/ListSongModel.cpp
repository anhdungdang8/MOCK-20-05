#include "ListSongModel.h"
#include "fileref.h"


ListSongModel::ListSongModel(QObject *parent)
    : QAbstractListModel(parent),m_listSong()
{


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

void ListSongModel::getFolderMusic()
{

    QFileDialog dialog;
    QStringList musicPath=dialog.getOpenFileNames(nullptr,"","/home","*.mp3");

    for(int i=0;i<musicPath.size();i++)
    {

        TagLib::FileRef f(musicPath[i].toLocal8Bit().data());
        TagLib::Tag* tag =f.tag();
        SongModel* song = new SongModel;
        song->setSource(musicPath[i].toLocal8Bit().data());
        song->setTitle(QString::fromStdString(tag->title().to8Bit(true)));
        song->setArtist(QString::fromStdString(tag->artist().to8Bit(true)));
        song->setAlbum(QString::fromStdString(tag->album().to8Bit(true)));
        m_listSong.push_back(song);
        qDebug()<<"A";
        qDebug()<<song->getAlbum()<<"\"";
        qDebug()<<song->getTitle();




    }



    //--->

}

void ListSongModel::getMusicLocal()
{
  QDir dir;
  dir.setPath(QStandardPaths::standardLocations(QStandardPaths::MoviesLocation).at(0));
  QStringList filters;
  filters<<"*.mp3";
  dir.setNameFilters(filters);
  QStringList musicPath = dir.entryList(QStringList()<<"*.mp3",QDir::Files);

    for(int i=0;i<musicPath.size();i++)
    {
        QString filePath =dir.absoluteFilePath(musicPath[i]);

        TagLib::FileRef f(filePath.toLocal8Bit().data());
        TagLib::Tag* tag =f.tag();
        SongModel* song = new SongModel;
        //song->setSource(musicPath[i].toLocal8Bit().data());
        song->setTitle(QString::fromStdString(tag->title().to8Bit(true)));
        song->setArtist(QString::fromStdString(tag->artist().to8Bit(true)));
        song->setAlbum(QString::fromStdString(tag->album().to8Bit(true)));
        m_listSong.push_back(song);
        qDebug()<<"A";
        qDebug()<<song->getAlbum()<<"\"";
        qDebug()<<song->getTitle();




    }
}


