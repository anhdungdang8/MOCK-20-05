import QtQuick 2.15

import "../Component"
import QtQuick.Controls 2.15


Item {


    ListView
    {
        id:listFolder
        height: content.height
        width: content.width
        currentIndex: -1
        visible: true
        ScrollBar.vertical: ScrollBar {
            visible: true
            contentItem: Item {
                implicitWidth: 7
                implicitHeight: 5
                Rectangle {
                    color: "#8b9dc3"
                    anchors.fill: parent
                    radius: 5

                }
            }
        }
        model:mediaObj.proxy
        delegate:
            Rectangle{
            id:listRect
            width: listGlobal.width
            height: 50
            radius: 5
            border.width: 2
            border.color: "#F4A460"
            Row{
                Rectangle{
                    id:dataRect
                    width: listRect.width-100
                    height: listRect.height
                    border.width: 2
                    border.color: "#F4A460"
                    Column{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        spacing: 10
                        Text{

                            id: song_title
                            text:  index+1+"."+  TitleSongs
                            font.pixelSize: 20
                            color:  "green"
                        }
                        Text{
                            text:  "&nbsp;<b>Artist:</b>&nbsp;" + ArtistSongs+"&nbsp;<b>Album:</b>&nbsp;" + AlbumSongs;
                            font.pixelSize: 15
                            color: "black"
                        }
                    }
                    MouseArea{
                        anchors.fill:parent
                        hoverEnabled: true
                        onEntered: {
                            dataRect.color = "#F4A460"
                        }
                        onExited: {
                            dataRect.color="white"
                        }
                        onClicked: {
                            listGlobal.currentIndex = index
                            isPlaying=true
                            isVideo=false
                            isShowCoverArt=false
                            mediaObj.setMusicPlay()
                            mediaObj.playMusic(IndexSongs)
                            mediaObj.setIndex(IndexSongs)
                             mediaObj.setSource(SourceSongs);
                        }
                    }

                }

                Rectangle{
                    id:buttonRect
                    width: listRect.width-dataRect.width
                    height: listRect.height
                    border.width: 2
                    border.color: "#F4A460"
                    Row{
                        spacing: 10
                        anchors.centerIn: parent
                        ControllerButton{
                            id:addFavoriteButton
                            imgSource: "qrc:/Icons/favorite.png"
                            width: 40
                            height: 40
                            radius: 40
                        }
                        ControllerButton{
                            id:deleteButton
                            imgSource: "qrc:/Icons/delete_.png"
                            width: 40
                            height: 40
                            radius: 40
                            MouseArea{
                                anchors.fill:parent
                                hoverEnabled: true
                                onEntered: {
                                    deleteButton.color = "#F4A460"
                                }
                                onExited: {
                                    deleteButton.color="white"
                                }
                                onClicked: {
                                    mediaObj.removeMusic(index);
                                }
                            }

                        }


                    }


                }
            }

        }
    }
}
