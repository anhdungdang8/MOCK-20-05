#include "MediaControl.h"
#include <taglib.h>
#include <fileref.h>
#include <QDir>
#include <QDebug>
#include <QRandomGenerator>
MediaController::MediaController(QObject *parent)
    : QObject(parent)
{
    player = new QMediaPlayer;
    playMusicList = new QMediaPlaylist;
    playVideoList= new QMediaPlaylist;
    m_proxyMusic= new QSortFilterProxyModel;
    m_proxyVideo=new QSortFilterProxyModel;
    player->setVolume(50);

    connect(player, &QMediaPlayer::volumeChanged, this, &MediaController::volumeChanged);
    connect(player, &QMediaPlayer::positionChanged, this, &MediaController::positionChanged);
    connect(player,&QMediaPlayer::durationChanged, this, &MediaController::durationChanged);
    connect(playMusicList,&QMediaPlaylist::currentIndexChanged,this,&MediaController::setIndexMediaChanged);
    connect(playVideoList,&QMediaPlaylist::currentIndexChanged,this,&MediaController::setIndexMediaChanged);

    getMusicLocal();
    getVideoLocal();
}

MediaController::~MediaController()
{
    delete player;
    delete playMusicList;
    delete playVideoList;
    delete m_proxyMusic;
    delete m_proxyVideo;

}

QVariantList MediaController::getMusicLocal()
{

    QDir m_musicPath;
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).at(0));// set path in music location
    QDir directory(m_musicPath);
    m_listSongPath = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files);// find files has format mp3, MP3
    QList<QMediaContent> content;
    for (int i = 0; i < m_listSongPath.size(); ++i)
    {
        //push path into vector and QVariantList
        const QString& f = m_listSongPath[i];
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        musicList.push_back(QVariant::fromValue(f));

        //get meta data of music
        TagLib::FileRef r((directory.path()+"/" + f).toLocal8Bit().data());
        TagLib::Tag* tag =r.tag();
        MediaModel* song = new MediaModel;
        song->setSource((directory.path()+"/" + f).toLocal8Bit().data());
        song->setTitle((QString::fromStdString(tag->title().to8Bit(true))));
        song->setArtist(QString::fromStdString(tag->artist().to8Bit(true)));
        song->setAlbum(QString::fromStdString(tag->album().to8Bit(true)));
        song->setIndex(i);
        songListModel.push_back(song); //push model into  QVector<MediaModel*>
    }
    m_songModel=new ListMusicModel(songListModel);
    m_proxyMusic->setSourceModel(m_songModel);//proxy get source of ListMusicModel
    playMusicList->addMedia(content);
    return musicList;

}
void MediaController::getFolderMusic()
{
    QFileDialog dialog;
    dialog.setFileMode(QFileDialog::Directory);
    QString folderPath = dialog.getExistingDirectory(nullptr, "Open Folder", "/home");// open folder has path /home
    if (!folderPath.isEmpty())
    {
        // Clear the models only when a valid folder path is selected
        songListModel.clear();
        playMusicList->clear();


        //get path has mp3, MP3 format
        QDir folder(folderPath);
        QStringList filters;
        filters << "*.mp3" << "*.MP3";
        QStringList filePath = folder.entryList(filters, QDir::Files);
        QList<QMediaContent> content;
        for (int i = 0; i < filePath.size(); i++)
        {
            const QString& fileName = filePath[i];
            QString fullPath = folder.filePath(fileName);

            //get metadata of media
            TagLib::FileRef f(fullPath.toLocal8Bit().data());
            TagLib::Tag* tag = f.tag();
//            if (!tag)
//            {
//                continue;
//            }
            MediaModel* song = new MediaModel;
            song->setSource(fullPath.toStdString().c_str());
            song->setTitle(QString::fromStdString(tag->title().to8Bit(true)));
            song->setArtist(QString::fromStdString(tag->artist().to8Bit(true)));
            song->setAlbum(QString::fromStdString(tag->album().to8Bit(true)));
            song->setIndex(i);
            songListModel.push_back(song);
            content.push_back(QMediaContent(QUrl::fromLocalFile(fullPath)));
        }

        m_songModel = new ListMusicModel(songListModel);
        m_proxyMusic->setSourceModel(m_songModel);
        playMusicList->addMedia(content);
    }
}



QVariantList MediaController::getVideoLocal()
{

    QDir m_videoPath;
    m_videoPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MoviesLocation).at(0));// set path in movie location
    QDir directory(m_videoPath);
    m_listVideoPath = directory.entryList(QStringList() << "*.mp4" << "*.MP4",QDir::Files);// find files has format mp4, MP4

    QList<QMediaContent> content;
        for(int i=0;i<m_listVideoPath.size();++i)
        {
            const QString& f=m_listVideoPath[i];

        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        videoList.push_back(QVariant::fromValue(f));
        //get metadata of video
        TagLib::FileRef r((directory.path()+"/" + f).toLocal8Bit().data());
        TagLib::Tag* tag =r.tag();
        MediaModel* video = new MediaModel;
        video->setSource((directory.path()+"/" + f).toLocal8Bit().data());
        video->setTitle(QString::fromStdString(tag->title().to8Bit(true)));
        video->setArtist(QString::fromStdString(tag->artist().to8Bit(true)));
        video->setAlbum(QString::fromStdString(tag->album().to8Bit(true)));
        video->setIndex(i);
        videoListModel.push_back(video);
    }
    m_videoModel= new ListVideoModel(videoListModel);
     m_proxyVideo->setSourceModel(m_videoModel);
    playVideoList->addMedia(content);
    return videoList;

}
void MediaController::getFolderVideo()
{

    QFileDialog dialog;
    dialog.setFileMode(QFileDialog::Directory);
    QString folderPath = dialog.getExistingDirectory(nullptr, "Open Folder", "/home");
    if (!folderPath.isEmpty())
    {
         // Clear the models only when a valid folder path is selected
        videoListModel.clear();
        playVideoList->clear();
        QDir folder(folderPath);
        QStringList filters;
        filters << "*.mp4" << "*.MP4";
        QStringList filePath = folder.entryList(filters, QDir::Files);
        QList<QMediaContent> content;
        for(int i=0;i<filePath.size();++i)
        {
            const QString& fileName =filePath[i];
            QString fullPath = folder.filePath(fileName);
            TagLib::FileRef f(fullPath.toLocal8Bit().data());
            TagLib::Tag* tag = f.tag();
//            if (!tag)
//            {
//                continue;
//            }
            MediaModel* video = new MediaModel;
            video->setSource(fullPath.toStdString().c_str());
            video->setTitle(QString::fromStdString(tag->title().to8Bit(true)));
            video->setArtist(QString::fromStdString(tag->artist().to8Bit(true)));
            video->setAlbum(QString::fromStdString(tag->album().to8Bit(true)));
            video->setIndex(i);
            videoListModel.push_back(video);
            content.push_back(QMediaContent(QUrl::fromLocalFile(fullPath)));
        }
        m_videoModel = new ListVideoModel(videoListModel);
        m_proxyVideo->setSourceModel(m_videoModel);
        playVideoList->addMedia(content);
    }

}

QString MediaController::getMusicTitle(int indexSong)
{

    QModelIndex index= m_songModel->index(indexSong,0);
    QVariant data= m_songModel->data(index,m_songModel->Songs::TitleSongs);
    QString tilteSong= data.toString();
    return tilteSong;


}

QString MediaController::getMusicArtist(int indexSong)
{
    QModelIndex index= m_songModel->index(indexSong,0);
    QVariant data= m_songModel->data(index,m_songModel->Songs::ArtistSongs);
    QString artist= data.toString();
    return artist;

}

QString MediaController::getVideoTitle(int indexVideo)
{
    QModelIndex index= m_videoModel->index(indexVideo,0);
    QVariant data= m_videoModel->data(index,m_videoModel->Videos::TitleVideo);
    QString tilteVideo= data.toString();
    return tilteVideo;

}

QString MediaController::getVideoArtist(int indexVideo)
{
    QModelIndex index= m_videoModel->index(indexVideo,0);
    QVariant data= m_videoModel->data(index,m_videoModel->Videos::ArtistVideo);
    QString artist= data.toString();
    return artist;
}



QStringList MediaController::listSongPath() const
{
    return m_listSongPath;
}
QStringList MediaController::listVideoPath() const
{
    return m_listVideoPath;
}

void MediaController::setListSongPath(const QStringList &newListSongPath)
{
    if (m_listSongPath == newListSongPath)
        return;
    m_listSongPath = newListSongPath;
    emit listSongPathChanged();
}
void MediaController::setListVideoPath(const QStringList &newListVideoPath)
{
    if (m_listVideoPath == newListVideoPath)
        return;
    m_listVideoPath = newListVideoPath;
    emit listVideoPathChanged();
}
void MediaController::setMusicPlay()
{
    player->setPlaylist(playMusicList);

}

void MediaController::setVideoPlay()
{
    player->setPlaylist(playVideoList);
    qDebug()<<player->mediaStatus();
}

void MediaController::seekForward()
{
    player->setPosition(player->position()+5000);
}

void MediaController::seekBack()
{
    player->setPosition(player->position()-5000);
}

void MediaController::removeMusic(int index)
{
    m_songModel->removeMusicModel(index);
    playMusicList->removeMedia(index);
    if(playMusicList->currentIndex()==index)
    {
        player->stop();

    }
    else
    {
       player->play();
    }

}

void MediaController::removeVideo(int index)
{
    m_videoModel->removeVideoModel(index);
    playVideoList->removeMedia(index);
}


void MediaController::sortTitleMusic(bool type)
{
    m_proxyMusic->setSortRole(ListMusicModel::Songs::TitleSongs);



    if (type) {
        m_proxyMusic->sort(0, Qt::AscendingOrder);
    } else {
        m_proxyMusic->sort(0, Qt::DescendingOrder);
    }
}

void MediaController::sortAlbumMusic(bool type)
{
    m_proxyMusic->setSortRole(ListMusicModel::Songs::AlbumSongs);


    if (type) {
        m_proxyMusic->sort(0, Qt::AscendingOrder);
    } else {
        m_proxyMusic->sort(0, Qt::DescendingOrder);
    }
}

void MediaController::sortArtistMusic(bool type)
{
    m_proxyMusic->setSortRole(ListMusicModel::Songs::ArtistSongs);

    if (type) {
        m_proxyMusic->sort(0, Qt::AscendingOrder);
    } else {
        m_proxyMusic->sort(0, Qt::DescendingOrder);
    }
}

void MediaController::filterMusic(QString text)
{

    m_proxyMusic->setFilterRole(ListMusicModel::Songs::TitleSongs);
    m_proxyMusic->setFilterFixedString(text);
    m_proxyMusic->filterRole();
}

void MediaController::sortTitleVideo(bool type)
{
    m_proxyVideo->setSortRole(ListVideoModel::Videos::TitleVideo);



    if (type) {
        m_proxyVideo->sort(0, Qt::AscendingOrder);

    } else {
        m_proxyVideo->sort(0, Qt::DescendingOrder);

    }

}

void MediaController::sortAlbumVideo(bool type)
{
    m_proxyVideo->setSortRole(ListVideoModel::Videos::AlbumVideo);



    if (type) {
        m_proxyVideo->sort(0, Qt::AscendingOrder);

    } else {
        m_proxyVideo->sort(0, Qt::DescendingOrder);

    }

}

void MediaController::sortArtistVideo(bool type)
{
    m_proxyVideo->setSortRole(ListVideoModel::Videos::ArtistVideo);



    if (type) {
        m_proxyVideo->sort(0, Qt::AscendingOrder);

    } else {
        m_proxyVideo->sort(0, Qt::DescendingOrder);

    }

}

void MediaController::filterVideo(QString text)
{
    m_proxyVideo->setFilterRole(ListVideoModel::Videos::TitleVideo);
    m_proxyVideo->setFilterFixedString(text);
    m_proxyVideo->filterRole();
}

QString MediaController::songCoverArt()
{
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);
    m_currentCoverArt.save(&buffer,"png");
    QString base64 = buffer.data().toBase64();
    if(base64=="")
    {
        return "qrc:/Icons/Logo.png";
    }
    QString ret= QString("data:image/png;base64,")+ base64;
    return ret;
}

void MediaController::setSource(QString source)
{
    m_currentCoverArt=m_songModel->imageForTag(source);

}








qint64 MediaController::position() const
{

    return player->position();

}

void MediaController::setPosition(qint64 newPosition)
{
    if (m_position == newPosition)
        return;
    m_position = newPosition;
    player->setPosition(newPosition);
    emit positionChanged();
}

qint64 MediaController::duration() const
{

    return player ->duration();
}
int MediaController::volume() const
{
    return player->volume();
}

void MediaController::setVolume(int newVolume)
{
    if (m_volume == newVolume)
        return;
    m_volume = newVolume;
    player->setVolume(newVolume);
    emit volumeChanged();

}


void MediaController::pauseMedia()
{
    player->pause();

}



void MediaController::playMusic(int index)
{
    playMusicList->setCurrentIndex(index);
    player->play();

}


void MediaController::playVideo(int index)
{

    playVideoList->setCurrentIndex(index);
    player->play();

}

void MediaController::resumeMedia()
{
    player->play();


}
void MediaController::nextMedia()
{
    playVideoList->next();
    playMusicList->next();
    player->play();


}

void MediaController::previousMedia()
{
    playMusicList->previous();
    playVideoList->previous();

}


void MediaController::repeatMedia(int repeatIndex)
{

    if(repeatIndex==0)
    {
        playMusicList->setPlaybackMode(QMediaPlaylist::Sequential);
        playVideoList->setPlaybackMode(QMediaPlaylist::Sequential);
    }
    else if(repeatIndex==1)
    {
        playMusicList->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
        playVideoList->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    }
    else if(repeatIndex==2){
        playMusicList->setPlaybackMode(QMediaPlaylist::Loop);
        playVideoList->setPlaybackMode(QMediaPlaylist::Loop);

    }



}
void MediaController::shuffleMedia()
{
    if (playMusicList->isEmpty())
        return;
    playMusicList->setPlaybackMode(QMediaPlaylist::Random);
    playVideoList->setPlaybackMode(QMediaPlaylist::Random);




}

void MediaController::adjustSpeedMedia(qreal rate)
{
    player->setPlaybackRate(rate);

}


QAbstractVideoSurface *MediaController::videoSurface() const
{
    return m_videoSurface;
}

void MediaController::setVideoSurface(QAbstractVideoSurface *newVideoSurface)
{
    if (m_videoSurface == newVideoSurface)
        return;
    m_videoSurface = newVideoSurface;
    player->setVideoOutput(m_videoSurface);
    emit videoSurfaceChanged();

}








ListMusicModel *MediaController::songModel() const
{
    return m_songModel;
}

void MediaController::setSongModel(ListMusicModel *newSongModel)
{
    if (m_songModel == newSongModel)
        return;
    m_songModel = newSongModel;
    emit songModelChanged();

}

ListVideoModel *MediaController::videoModel() const
{
    return m_videoModel;
}

void MediaController::setVideoModel(ListVideoModel *newVideoModel)
{
    if (m_videoModel == newVideoModel)
        return;
    m_videoModel = newVideoModel;
    emit videoModelChanged();
}

int MediaController::index() const
{
    return m_index;
}

void MediaController::setIndex(int newIndex)
{
//    QModelIndex index = m_songModel->index(m_index,0);
//    QVariant data = m_songModel->data(index,m_songModel->ListMusicModel::Songs::SourceSongs);
//    QString source= data.toString();
//    setSource(source);
    if (m_index == newIndex)
        return;
    if(newIndex>playMusicList->mediaCount()-1)
    {

        m_index=newIndex-playMusicList->mediaCount();

    }
    else if(newIndex<0)
    {
        m_index=newIndex-playMusicList->mediaCount()-1;

    }
    else{
        m_index = newIndex;
    }

    emit indexChanged();
}


int MediaController::indexVideo() const
{
    return m_indexVideo;
}

void MediaController::setIndexVideo(int newIndexVideo)
{
    if (m_indexVideo == newIndexVideo)
        return;
    if(newIndexVideo>playVideoList->mediaCount()-1)
    {

        m_indexVideo=newIndexVideo-playVideoList->mediaCount();

    }
    else if(newIndexVideo<0)
    {
        m_indexVideo=newIndexVideo-playVideoList->mediaCount()-1;

    }
    else{
        m_indexVideo = newIndexVideo;
    }

    emit indexVideoChanged();
}


void MediaController::setIndexMediaChanged()
{
    setIndex(playMusicList->currentIndex());
    setIndexVideo(playVideoList->currentIndex());
    QModelIndex index = m_songModel->index(m_index,0);
    QVariant data = m_songModel->data(index,m_songModel->ListMusicModel::Songs::SourceSongs);
    QString source= data.toString();
    setSource(source);
}

QSortFilterProxyModel *MediaController::proxyMusic() const
{
    return m_proxyMusic;
}

void MediaController::setProxyMusic(QSortFilterProxyModel *newProxyMusic)
{
    if (m_proxyMusic == newProxyMusic)
        return;
    m_proxyMusic = newProxyMusic;
    emit proxyMusicChanged();
}

QSortFilterProxyModel *MediaController::proxyVideo() const
{
    return m_proxyVideo;
}

void MediaController::setProxyVideo(QSortFilterProxyModel *newProxyVideo)
{
    if (m_proxyVideo == newProxyVideo)
        return;
    m_proxyVideo = newProxyVideo;
    emit proxyVideoChanged();
}
