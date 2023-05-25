#ifndef MEDIACONTROL_H
#define MEDIACONTROL_H


#include <QFileDialog>
#include <QObject>
#include <QDirIterator>
#include <QMediaPlaylist>
#include <QDebug>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QQmlApplicationEngine>
#include <QMediaMetaData>
#include <QStandardPaths>
#include <QAbstractVideoSurface>
#include <QVector>
#include <QBuffer>
#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include <QTimer>
#include <QEventLoop>
#include "ListMusicModel.h"
#include "MediaModel.h"
#include "ListVideoModel.h"






class MediaController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QStringList listSongPath READ listSongPath WRITE setListSongPath NOTIFY listSongPathChanged)
    Q_PROPERTY(QStringList listVideoPath READ listVideoPath WRITE setListVideoPath NOTIFY listVideoPathChanged)

    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(qint64 duration READ duration  NOTIFY durationChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)

    Q_PROPERTY(ListMusicModel* songModel READ songModel WRITE setSongModel NOTIFY songModelChanged)
    Q_PROPERTY(ListVideoModel* videoModel READ videoModel WRITE setVideoModel NOTIFY videoModelChanged)

    Q_PROPERTY(int index READ index WRITE setIndex NOTIFY indexChanged)
    Q_PROPERTY(int indexVideo READ indexVideo WRITE setIndexVideo NOTIFY indexVideoChanged)

    Q_PROPERTY(QSortFilterProxyModel* proxyMusic READ proxyMusic WRITE setProxyMusic NOTIFY proxyMusicChanged)
    Q_PROPERTY(QSortFilterProxyModel* proxyVideo READ proxyVideo WRITE setProxyVideo NOTIFY proxyVideoChanged)

    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface NOTIFY videoSurfaceChanged)

public:
    explicit MediaController(QObject *parent = nullptr);
    ~MediaController();

    Q_INVOKABLE QVariantList getMusicLocal();
    Q_INVOKABLE QVariantList getVideoLocal();
    Q_INVOKABLE void getFolderMusic();//open and get media in folder
    Q_INVOKABLE void getFolderVideo();//open and get media in folder

    Q_INVOKABLE QString getMusicTitle(int indexSong);
    Q_INVOKABLE QString getMusicArtist(int indexSong);
    Q_INVOKABLE QString getVideoTitle(int indexVideo);
    Q_INVOKABLE QString getVideoArtist(int indexVideo);

    Q_INVOKABLE void playMusic(int index);
    Q_INVOKABLE void playVideo(int index);
    Q_INVOKABLE void pauseMedia();
    Q_INVOKABLE void resumeMedia();
    Q_INVOKABLE void nextMedia();
    Q_INVOKABLE void previousMedia();
    Q_INVOKABLE void repeatMedia(int repeatIndex);
    Q_INVOKABLE void shuffleMedia();
    Q_INVOKABLE void adjustSpeedMedia(qreal rate);
    Q_INVOKABLE void seekForward();
    Q_INVOKABLE void seekBack();

    Q_INVOKABLE void setMusicPlay();
    Q_INVOKABLE void setVideoPlay();

    Q_INVOKABLE void removeMusic(int);
    Q_INVOKABLE void removeVideo(int);
    Q_INVOKABLE void sortTitleMusic(bool type);
    Q_INVOKABLE void sortAlbumMusic(bool type);
    Q_INVOKABLE void sortArtistMusic(bool type);
    Q_INVOKABLE void filterMusic(QString text);
    Q_INVOKABLE void sortTitleVideo(bool type);
    Q_INVOKABLE void sortAlbumVideo(bool type);
    Q_INVOKABLE void sortArtistVideo(bool type);
    Q_INVOKABLE void filterVideo(QString text);

    Q_INVOKABLE QString songCoverArt();
    Q_INVOKABLE void setSource(QString source);

    Q_INVOKABLE void setIndex(int newIndex);
    Q_INVOKABLE void setIndexVideo(int newIndexVideo);

    qint64 position() const;
    qint64 duration() const;
    void setPosition(qint64 newPosition);

    QStringList listSongPath() const;
    void setListSongPath(const QStringList &newListSongPath);

    int volume() const;
    void setVolume(int newVolume);

    QAbstractVideoSurface *videoSurface() const;
    void setVideoSurface(QAbstractVideoSurface *newVideoSurface);

    QStringList listVideoPath() const;
    void setListVideoPath(const QStringList &newListVideoPath);

    ListMusicModel *songModel() const;
    void setSongModel(ListMusicModel *newSongModel);

    ListVideoModel *videoModel() const;
    void setVideoModel(ListVideoModel *newVideoModel);

    int index() const;
    int indexVideo() const;

    QSortFilterProxyModel *proxyMusic() const;
    void setProxyMusic(QSortFilterProxyModel *newProxyMusic);

    QSortFilterProxyModel *proxyVideo() const;
    void setProxyVideo(QSortFilterProxyModel *newProxyVideo);

public slots:
    void setIndexMediaChanged();

signals:

    void positionChanged();
    void durationChanged();
    void listSongPathChanged();
    void listVideoPathChanged();
    void volumeChanged();
    void songModelChanged();
    void videoModelChanged();
    void indexChanged();
    void indexVideoChanged();
    void proxyMusicChanged();
    void proxyVideoChanged();
    void videoSurfaceChanged();

private:

    QMediaPlayer* player ;
    QMediaPlaylist *playMusicList;
    QMediaPlaylist *playVideoList;
    QVariantList musicList;
    QVariantList videoList;
    qint64 m_position;
    qint64 m_duration;
    QStringList m_listSongPath;
    QStringList m_listVideoPath;
    int m_volume;

    QAbstractVideoSurface *m_videoSurface = nullptr;

    QVector<MediaModel*> songListModel;
    QVector<MediaModel*> videoListModel;

    ListMusicModel *m_songModel = nullptr;
    ListVideoModel *m_videoModel = nullptr;

    QSortFilterProxyModel *m_proxyMusic = nullptr;
    QSortFilterProxyModel *m_proxyVideo = nullptr;

    QImage m_currentCoverArt;
    int m_index;
    int m_indexVideo;
    int m_repeatIndex = 0;
};

#endif // MEDIACONTROL_H
