import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Component"
import MediaController 1.0





Rectangle{
    id:musicScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: colorMediaScreen


    property alias content: content
    property alias textFilter: textSearch.text
    property bool softTitle: false
    property bool softAlbum: false
    property bool softArtist: false


    Column{
        Rectangle{
            id:titleArea
            width: musicScreen.width
            height:100
            color: colorMediaScreen
            Rectangle{
                id:nameArea
                height: titleArea.height
                width: 150
                color: colorMediaScreen
                Text{
                    id:textHome
                    text: "MUSIC"
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
                            mediaObj.getFolderMusic()
                            loaderID1.active=false
                            loaderID1.source =""
                            loaderID1.source = "qrc:/Screen/ListSong.qml"
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

                                mediaObj.sortTitleMusic(softTitle)

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
                                color: colorText

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

                            }
                            Rectangle{
                                width: searchArea.width-filterButton.width
                                height: searchArea.height
                                radius: 10

                                TextEdit {
                                    id:textSearch
                                    anchors.fill: parent
                                    anchors.top: parent.top
                                    anchors.topMargin: 7
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
            color: colorMediaScreen
            clip: true
            ListView
            {
                spacing: 5
                id:listGlobal
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
                model:mediaObj.proxyMusic
                delegate:

                    Rectangle{

                    id:listRect
                    width: listGlobal.width
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
                            listGlobal.currentIndex = index
                            isPlaying=true
                            isVideo=false
                            mediaObj.setMusicPlay()
                            mediaObj.setSource(SourceSongs);
                            mediaObj.playMusic(IndexSongs)
                            mediaObj.setIndex(IndexSongs)

                        }
                    }
                    Column{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        spacing: 5
                        Text{
                            text:  index+1+"."+ TitleSongs
                            font.pixelSize: 30
                            color:"Green"
                        }
                        Text{
                            text:"&nbsp;<b>Artist:</b>&nbsp;" + ArtistSongs+ "&nbsp;<b>Album:</b>&nbsp;" + AlbumSongs;
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
                                mediaObj.removeMusic(index)

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
                id:loaderID1
                anchors.fill: parent
            }

        }


    }
}
