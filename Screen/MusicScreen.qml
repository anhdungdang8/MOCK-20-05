import QtQuick 2.15
import "../Component"
import MediaController 1.0





Rectangle{
    id:musicScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: "#F4A460"


    property alias contentArea: content
    property alias textFilter: textSearch.text

    property bool softTitle: false
    property bool softAlbum: false
    property bool softArtist: false


    Column{
        Rectangle{
            id:titleArea
            width: musicScreen.width
            height:62
            color:"#4EB09B"
            radius: 20
            border.width: 1
            border.color: "#F4A460"

            Rectangle{
                id:nameArea
                height: titleArea.height
                width: 100
                color:"#4EB09B"
                radius: 20
                border.width: 1
                border.color: "#F4A460"

                Text{
                    id:textHome
                    text: "MUSIC"
                    font.pointSize: 17
                    anchors.centerIn: parent
                    font.family:"Tahoma"
                    color: "#001C44"

                }
            }


            Rectangle{
                id:folderArea
                height: titleArea.height
                width: titleArea.width-nameArea.width
                color:"#4EB09B"
                radius: 20
                border.width: 1
                border.color: "#F4A460"
                anchors.right: parent.right
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.centerIn: parent
                    spacing: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    MenuButton{
                        id:folderButton
                        imgSource: "qrc:/Icons/foldernew.png"
                        width: 85
                        height: 30
                        Text{
                            text: "Folder"
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#001C44"

                        }
                        onButtonClicked: {
                            mediaObj.getFolderMusic()
                            listGlobal.visible=false


                            loaderID1.source =""
                            loaderID1.source = "qrc:/Screen/ListSong.qml"
                            console.log("1")



                        }
                    }
                    MenuButton{
                        id:favoriteButton
                        imgSource: "qrc:/Icons/favorite.png"
                        width: 85
                        height: 30
                        Text{
                            text: " Favorite"
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#001C44"

                        }
                        onButtonClicked: {
                            //listViewArea.visible=!listViewArea.visible
                        }
                    }

                    Row{

                        MenuButton{
                            id:sortTitleButton
                            width: 60
                            height: 30
                            Text{
                                text: "Title"
                                anchors.centerIn: parent
                                color: "#001C44"

                            }
                            onButtonClicked: {
                                 softTitle=!softTitle

                                mediaObj.sortTitleMusic(softTitle)

                            }
                        }
                        MenuButton{
                            id:sortAlbumButton
                            width: 60
                            height: 30
                            Text{
                                text: "Album"
                                anchors.centerIn: parent
                                color: "#001C44"

                            }
                            onButtonClicked: {
                                softAlbum=!softAlbum



                                mediaObj.sortAlbumMusic(softAlbum)

                            }
                        }
                        MenuButton{
                            id:sortArtitsButton
                            width: 60
                            height: 30
                            Text{
                                text: "Artist"
                                anchors.centerIn: parent
                                color: "#001C44"

                            }
                            onButtonClicked: {
                                softArtist=!softArtist


                                mediaObj.sortArtistMusic(softArtist)

                            }
                        }
                    }
                    Rectangle{
                        id:searchArea
                        width: folderArea.width/6
                        height: 30
                        clip:true
                        radius: 10
                        Row{
                            MenuButton{
                                id:filterButton
                                width:30
                                height: 30
                                imgSource: "qrc:/Icons/search.png"
//                                onButtonClicked: {
//                                    mediaObj.filterMusic(textFilter);
//                                }

                            }
                            Rectangle{
                                width: searchArea.width-filterButton.width
                                height: searchArea.height
                                 radius: 10


                                TextEdit {
                                    id:textSearch
                                   anchors.fill: parent
                                   anchors.top: parent.top
                                   anchors.topMargin: 5
                                   anchors.left: parent.left
                                   anchors.leftMargin: 5
                                   height: 20



                                    onTextChanged: {

                                        mediaObj.filterMusic(textFilter);
                                    }

                                    focus: true

                                }

                            }
                        }


                    }

                }



            }
        }
        Rectangle{
            id:content
            width: musicScreen.width
            height:musicScreen.height-titleArea.height
            //            color: "#a8e40f"
            clip: true
            ListView
            {
                id:listGlobal
                height: content.height
                width: content.width
                currentIndex: -1
                visible: true
                //model:mediaObj.songModel
                model:mediaObj.proxyMusic
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
                                spacing: 5
                                Text{
                                    text:  index+1+"."+ TitleSongs
                                    font.pixelSize: 20
                                    color:"Green"


                                }
                                Text{
                                    text:"&nbsp;<b>Artist:</b>&nbsp;" + ArtistSongs+ "&nbsp;<b>Album:</b>&nbsp;" + AlbumSongs;
                                    font.pixelSize: 15
                                    color:  "black"

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

                                    mediaObj.setMusicPlay()
                                    mediaObj.setSource(SourceSongs);


                                    mediaObj.playMusic(IndexSongs)
                                    mediaObj.setIndex(IndexSongs)



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
                                    MouseArea{
                                        anchors.fill:parent
                                        hoverEnabled: true

                                        onEntered: {

                                            addFavoriteButton.color = "#F4A460"
                                        }

                                        onExited: {

                                            addFavoriteButton.color="white"

                                        }

                                    }


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
            Loader
            {
                id:loaderID1
                anchors.fill: parent
            }

        }


    }
}
