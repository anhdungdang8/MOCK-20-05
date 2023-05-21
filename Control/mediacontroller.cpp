#include "mediacontroller.h"
#include <taglib.h>
#include <fileref.h>
#include <QDir>
#include <QDebug>
#include <QRandomGenerator>
MediaController::MediaController(QObject *parent)
    : QObject(parent)
{
    player = new QMediaPlayer;
    playMuscList = new QMediaPlaylist;
    playVideoList= new QMediaPlaylist;

    player->setVolume(50);
    connect(player, &QMediaPlayer::volumeChanged, this, &MediaController::volumeChanged);
    connect(player, &QMediaPlayer::positionChanged, this, &MediaController::positionChanged);
    connect(player,&QMediaPlayer::durationChanged, this, &MediaController::durationChanged);
    m_songModel= new ListSongModel(this);
 connect(m_songModel, &ListSongModel::songAdded, this, &MediaController::playMusic);

    getMusicLocal();

    getVideoLocal();
    //getMusicModelLocal();



}

MediaController::~MediaController()
{
    delete player;
    delete playMuscList;
    delete playVideoList;
}

QVariantList MediaController::getMusicLocal()
{





     qDebug()<<"oke oke";

    QDir m_musicPath;
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).at(0));
    QDir directory(m_musicPath);
    m_listSongPath = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files);

    QList<QMediaContent> content;

    for(const QString& f:m_listSongPath)
    {
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        musicList.push_back(QVariant::fromValue(f));
    }
    playMuscList->addMedia(content);
    return musicList;



}

QVariantList MediaController::getVideoLocal()
{

    QDir m_videoPath;
    m_videoPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MoviesLocation).at(0));
    QDir directory(m_videoPath);
    m_listVideoPath = directory.entryList(QStringList() << "*.mp4" << "*.MP4",QDir::Files);

    QList<QMediaContent> content;

    for(const QString& f:m_listVideoPath)
    {
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        videoList.push_back(QVariant::fromValue(f));
    }
    playVideoList->addMedia(content);
    return videoList;

}
void MediaController::getFolder()
{
    //    QFileDialog dialog;
    //    QStringList filePaths = dialog.getOpenFileNames(nullptr, " ", "/home", "*.mp3");
    //    QList<QMediaContent> content;

    //    foreach (const QString& filePath, filePaths) {
    //        QFileInfo fileInfo(filePath);
    //        QString fileName = fileInfo.baseName();
    //        m_listSongPath.append(fileName);
    //         musicList.push_back(QVariant::fromValue(filePath));
    //    }
    //    playlist->addMedia(content);
     m_songModel->getFolderMusic();



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
    player->setPlaylist(playMuscList);

}

void MediaController::setVideoPlay()
{
    player->setPlaylist(playVideoList);
    qDebug()<<player->mediaStatus();
}

//QStringList MediaController::getMusicModelLocal()
//{
//  m_songModel->getMusicLocal();


//}






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

int MediaController::getCurrentMediaIndex()
{
    return playMuscList->currentIndex();

}

void MediaController::setCurrentIndex(int index)
{
    playMuscList->setCurrentIndex(index);
}


void MediaController::onCurrentMediaIndexChanged()
{
    m_currentMediaIndex=playMuscList->currentIndex();
}


void MediaController::pauseMedia()
{
    player->pause();

}

void MediaController::playMusic(int index)
{
    playMuscList->setCurrentIndex(index);




    player->play();
}

void MediaController::playVideo(int index)
{



    playVideoList->setCurrentIndex(index);
    player->play();
    qDebug()<<"Aaaa"<<index;
}

void MediaController::resumeMedia()
{
    player->play();


}
void MediaController::nextMedia()
{
    playVideoList->next();

    playMuscList->next();
    player->play();


}

void MediaController::previousMedia()
{
    playMuscList->previous();
    playVideoList->previous();

}

void MediaController::repeatMedia()
{

    playMuscList->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    playVideoList->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
}
void MediaController::shuffleMedia()
{
    if (playMuscList->isEmpty())
        return;
    playMuscList->setPlaybackMode(QMediaPlaylist::Random);
    playVideoList->setPlaybackMode(QMediaPlaylist::Random);




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
    qDebug()<<"oke111";
}








ListSongModel *MediaController::songModel() const
{
    return m_songModel;
}

void MediaController::setSongModel(ListSongModel *newSongModel)
{
    if (m_songModel == newSongModel)
        return;
    m_songModel = newSongModel;
    emit songModelChanged();

}
