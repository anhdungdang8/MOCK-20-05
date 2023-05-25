
import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Component"
import MediaController 1.0





Rectangle{
    id:videoScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: colorMediaScreen


    property alias contentArea: content
    property alias textVideoFilter: textSearch.text

    property bool softTitle: false
    property bool softAlbum: false
    property bool softArtist: false


    Column{
        Rectangle{
            id:titleArea
            width: videoScreen.width
            height:100
            color: colorMediaScreen




            Rectangle{
                id:nameArea
                height: titleArea.height
                width: 150
                color: colorMediaScreen




                Text{
                    id:textHome
                    text: "VIDEO"
                    font.pointSize: 25
                    anchors.centerIn: parent
                    font.family:"Tahoma"
                    color: colorText

                }
            }


            Rectangle{
                id:folderArea
                height: titleArea.height
                width: titleArea.width-nameArea.width
                color: colorMediaScreen



                anchors.right: parent.right
                Row{
                    anchors.verticalCenter: parent.verticalCenter
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
                            color: colorText

                        }
                        onButtonClicked: {
                            mediaObj.getFolderVideo()



                            loaderID2.source =""
                            loaderID2.source = "qrc:/Screen/ListSong.qml"
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
                            color: colorText

                        }
                        onButtonClicked: {

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
                                color: colorText

                            }
                            onButtonClicked: {
                                softTitle=!softTitle

                                mediaObj.sortTitleVideo(softTitle)

                            }
                        }
                        MenuButton{
                            id:sortAlbumButton
                            width: 60
                            height: 30
                            Text{
                                text:"Album"
                                anchors.centerIn: parent
                                color: colorText

                            }
                            onButtonClicked: {
                                softAlbum=!softAlbum



                                mediaObj.sortAlbumVideo(softAlbum)

                            }
                        }
                        MenuButton{
                            id:sortArtitsButton
                            width: 60
                            height: 30
                            Text{
                                text: "Artist"
                                anchors.centerIn: parent
                                color: colorText

                            }
                            onButtonClicked: {
                                softArtist=!softArtist


                                mediaObj.sortArtistVideo(softArtist)

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

                                        mediaObj.filterVideo(textVideoFilter);
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
            width: videoScreen.width
            height:videoScreen.height-titleArea.height
            color: colorMediaScreen
            clip: true
            ListView
            {
                spacing: 5
                id:listGlobalVideo
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
                model:mediaObj.proxyVideo
                delegate:

                    Rectangle{

                    id:listRect
                    width: listGlobalVideo.width
                    height: 100
                    radius: 10
                    color: colorListView

                    MouseArea{
                        anchors.fill:parent
                        hoverEnabled: true

                        onEntered: {

                            listRect.color = "#8b9dc3"
                        }

                        onExited: {

                            listRect.color=colorListView





                        }
                        onClicked: {
                            listGlobalVideo.currentIndex = index
                            isPlaying=true
                            isVideo=true
                            mediaObj.setVideoPlay()
                            mediaObj.playVideo(IndexVideo);
                            mediaObj.setIndexVideo(IndexVideo);
                            loader.active=false

                        }
                    }
                    Column{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        spacing: 5
                        Text{
                            text:  index+1+"."+ TitleVideo
                            font.pixelSize: 30
                            color:"Green"


                        }
                        Text{
                            text:"&nbsp;<b>Artist:</b>&nbsp;" + ArtistVideo+ "&nbsp;<b>Album:</b>&nbsp;" + AlbumVideo;
                            font.pixelSize: 20
                            color:  "black"

                        }

                    }








                    Row{
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 15

                        ControllerButton{
                            id:addFavoriteButton
                            imgSource: "qrc:/Icons/favorite.png"
                            width: 20
                            height: 20
                            radius: 20
                            visible: false
                        }
                        ControllerButton{
                            id:deleteButton
                            imgSource: "qrc:/Icons/delete_.png"
                            width: 20
                            height: 20
                            radius: 20
                            visible: false
                            onButtonCliked: {
                                mediaObj.removeVideo(index)

                            }




                        }
                        ControllerButton{
                            id:hideButton

                            height: 20
                            width: 20
                            radius: 10



                            Image{
                                height: 10
                                width: 10
                                source: "qrc:/Icons/drag_handle_FILL0_wght200_GRAD200_opsz48.png"
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                            }



                            onButtonCliked: {
                                addFavoriteButton.visible =!addFavoriteButton.visible
                                deleteButton.visible=!deleteButton.visible
                            }
                        }





                    }



                }


            }
            Loader
            {
                id:loaderID2
                anchors.fill: parent
            }

        }


    }
}
