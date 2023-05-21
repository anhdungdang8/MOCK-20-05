import QtQuick 2.15
import "../Component"
import MediaController 1.0





Rectangle{
    id:musicScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: "#F4A460"


    property alias contentArea: content


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
                width: 200
                color:"#4EB09B"
                radius: 20
                border.width: 1
                border.color: "#F4A460"

                Text{
                    id:textHome
                    text: "MUSIC"
                    font.pointSize: 25
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
                    anchors.centerIn: parent
                    spacing: 10
                    MenuButton{
                        id:folderButton
                        imgSource: "qrc:/Icons/foldernew.png"
                        width: 100
                        height: 30
                        Text{
                            text: "Folder"
                            anchors.centerIn: parent
                            color: "#001C44"

                        }
                        onButtonClicked: {
                           mediaObj.getFolder()
                            listGlobal.visible=false


                            loaderID1.source =""
                            loaderID1.source = "qrc:/Screen/ListSong.qml"
                            console.log("1")



                        }
                    }
                    MenuButton{
                        id:favoriteButton
                        imgSource: "qrc:/Icons/favorite.png"
                        width: 100
                        height: 30
                        Text{
                            text: "Favorite"
                            anchors.centerIn: parent
                            color: "#001C44"

                        }
                        onButtonClicked: {
                            //listViewArea.visible=!listViewArea.visible
                        }
                    }
                }


            }
        }
        Rectangle{
            id:content
            width: musicScreen.width
            height:musicScreen.height-titleArea.height
            color: "#a8e40f"
            clip: true
            ListView
            {
                id:listGlobal
                height: content.height
                width: content.width
                currentIndex: -1
                visible: true
              model:mediaObj.listSongPath
                //model:songModel

                delegate:
                    Rectangle{
                    width: listGlobal.width
                    height: 50
                    radius: 20
                    border.width: 2
                    border.color: "#F4A460"
                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        id: song_title

                        text:mediaObj.listSongPath[index]
                        //text:Tilte


                        font.pixelSize: 20
                        color: index == listGlobal.currentIndex ? "red" : "black"
                        MouseArea{
                            anchors.fill:parent
                            onClicked: {
                                listGlobal.currentIndex = index
                                isPlaying=true
                                mediaObj.setMusicPlay()

                                 mediaObj.playMusic(index);
                                console.log(song_title.text)

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
