
import QtQuick 2.15
import "../Component"
import MediaController 1.0





Rectangle{
    id:videoScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: "#F4A460"


    property alias contentArea: content
    property alias textVideoFilter: textSearch.text

    property bool softTitle: false
    property bool softAlbum: false
    property bool softArtist: false


    Column{
        Rectangle{
            id:titleArea
            width: videoScreen.width
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
                    text: "VIDEO"
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
                            mediaObj.getFolderVideo()
                            listGlobal.visible=false


                            loaderID2.source =""
                            loaderID2.source = "qrc:/Screen/ListVideo.qml"
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
                                mediaObj.sortTitleVideo(softTitle)

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
                                color: "#001C44"

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
//                                    mediaObj.filterVideo(textFilter);
//                                }

                            }
                            Rectangle{
                                width: searchArea.width-filterButton.width
                                height: searchArea.height
                                radius: 10


                                TextEdit {
                                    id:textSearch
                                    anchors.fill: parent
                                    anchors.verticalCenter: parent.verticalCenter

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
            //            color: "#a8e40f"
            clip: true
            ListView
            {
                id:listGlobal
                height: content.height
                width: content.width
                currentIndex: -1
                visible: true

                model:mediaObj.proxyVideo
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
                                    text:  index+1+"."+ TitleVideo
                                    font.pixelSize: 20
                                    color:"Green"


                                }
                                Text{
                                    text:"&nbsp;<b>Artist:</b>&nbsp;" + ArtistVideo+ "&nbsp;<b>Album:</b>&nbsp;" + AlbumVideo;
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
                                    isVideo=true

                                    mediaObj.setVideoPlay()

                                    mediaObj.playVideo(IndexVideo);
                                    mediaObj.setIndexVideo(IndexVideo);





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
                                            mediaObj.removeVideo(index);


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
                id:loaderID2
                anchors.fill: parent
            }

        }


    }
}
