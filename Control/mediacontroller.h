#ifndef MEDIACONTROLLER_H
#define MEDIACONTROLLER_H


#include <QFileDialog>
#include <QObject>
#include <QDirIterator>
#include <QMediaPlaylist>
#include<QDebug>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QQmlApplicationEngine>
#include <QMediaMetaData>
#include <QStandardPaths>
#include <QAbstractVideoSurface>
#include <QVector>
#include <QAbstractListModel>
#include "../Model/ListSongModel.h"
#include "../Model/songmodel.h"







class MediaController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList listSongPath READ listSongPath WRITE setListSongPath NOTIFY listSongPathChanged)
    Q_PROPERTY(QStringList listVideoPath READ listVideoPath WRITE setListVideoPath NOTIFY listVideoPathChanged)
    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface NOTIFY videoSurfaceChanged)

    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(qint64 duration READ duration  NOTIFY durationChanged)



    Q_PROPERTY(ListSongModel* songModel READ songModel WRITE setSongModel NOTIFY songModelChanged)











public:
    explicit MediaController(QObject *parent = nullptr);
    ~MediaController();

    Q_INVOKABLE QVariantList getMusicLocal();
    Q_INVOKABLE QVariantList getVideoLocal();

    Q_INVOKABLE void pauseMedia();
    Q_INVOKABLE void playMusic(int index);
    Q_INVOKABLE void playVideo(int index);
    Q_INVOKABLE void resumeMedia();
    Q_INVOKABLE void nextMedia();
    Q_INVOKABLE void previousMedia();
    Q_INVOKABLE void repeatMedia();
    Q_INVOKABLE void shuffleMedia();
    Q_INVOKABLE void setMusicPlay();
    Q_INVOKABLE void setVideoPlay();

  //  Q_INVOKABLE QStringList getMusicModelLocal();



    qint64 position() const;
    qint64 duration() const;
    void setPosition(qint64 newPosition);

    Q_INVOKABLE int getCurrentMediaIndex();
    Q_INVOKABLE void setCurrentIndex(int index);


    QStringList listSongPath() const;
    void setListSongPath(const QStringList &newListSongPath);

    int volume() const;
    void setVolume(int newVolume);

    QAbstractVideoSurface *videoSurface() const;
    void setVideoSurface(QAbstractVideoSurface *newVideoSurface);

    QStringList listVideoPath() const;
    void setListVideoPath(const QStringList &newListVideoPath);




    ListSongModel *songModel() const;
    void setSongModel(ListSongModel *newSongModel);

public slots:
    void onCurrentMediaIndexChanged();


signals:
    void currentMediaIndexChanged();
    void mediaIndexChanged();
    void positionChanged();
    void durationChanged();
    void listSongPathChanged();

    void volumeChanged();

    void videoSurfaceChanged();

    void listVideoPathChanged();




    void songModelChanged();

private:

    QMediaPlayer* player ;
    QMediaPlaylist *playMuscList;
    QMediaPlaylist *playVideoList;
    QVariantList musicList;
    QVariantList videoList;
    qint64 m_position;
    qint64 m_duration;
    QStringList m_listSongPath;
    QStringList m_listVideoPath;
    int m_volume;
    int m_currentMediaIndex = 0;
    int m_currentMusicIndex = 0;
    int m_repeatIndex = 0;
    bool m_isMusicPlaying = false;
    bool m_isMusicPaused = false;
    bool m_isShuffleEnabled = false;
    QAbstractVideoSurface *m_videoSurface = nullptr;




    ListSongModel *m_songModel = nullptr;
    QVector<SongModel*> songList;
    QVector<SongModel*> videoListModel;

};

#endif // MEDIACONTROLLER_H
