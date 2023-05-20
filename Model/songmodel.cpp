#include "songmodel.h"

SongModel::SongModel()
{

}

QString SongModel::getSource()
{
    return song.m_source;

}

void SongModel::setSource(QString source)
{
    song.m_source=source;

}

QString SongModel::getFileName()
{
    return song.m_fileName;

}

void SongModel::setFileName(QString fileName)
{
    song.m_fileName=fileName;

}

QString SongModel::getTitle()
{
    return song.m_title;

}

void SongModel::setTitle(QString title)
{
    song.m_title=title;

}

QString SongModel::getArtist()
{
    return song.m_artist;

}

void SongModel::setArtist(QString artist)
{
    song.m_artist=artist;

}

QString SongModel::getAlbum()
{return song.m_album;

}

void SongModel::setAlbum(QString album)
{
    song.m_album=album;
}


