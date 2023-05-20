#ifndef SONGMODEL_H
#define SONGMODEL_H
#include <QString>
#include <QUrl>
#include <QVariant>

struct SongData{
    SongData(){}
    QString m_source;
    QString m_fileName;
    QString m_title;
    QString m_artist;
    QString m_album;

};

class SongModel
{
public:
    SongModel();
    QString getSource();
    void setSource(QString);
    QString getFileName();
    void setFileName(QString);
    QString getTitle();
    void setTitle(QString);
    QString getArtist();
    void setArtist(QString);
    QString getAlbum();
    void setAlbum(QString);
private:
    SongData song;

};

#endif // SONGMODEL_H
