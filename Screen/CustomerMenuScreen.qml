import QtQuick 2.15
import "../Component"


Rectangle{
    id:menuScreen
    color:"#4EB09B"
    radius: 20

    //property bool statusText: false
    // property bool checkButton: false
    Column{
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter

        MenuButton{
            id:logo
            imgSource: "qrc:/Icons/menu.png"
            visible: true
            width:30
            height: 30
            radius: 30

            Image {
                id: logoImage
                source: "qrc:/Icons/Logo.png"
                anchors.fill: parent
            }

            onButtonClicked: {
                searchButton.visible =! searchButton.visible
                homeButton.visible =! homeButton.visible
                musicButton.visible =! musicButton.visible
                videoButton.visible =! videoButton.visible
                playlistButton.visible =! playlistButton.visible
            }

        }
        Column{
            spacing:5
            //        Image {
            //            id: background
            //            source: "qrc:/Image/backgroundImage.png"
            //            height: 30
            //            width: 30
            //        }

            MenuButton{
                id:searchButton
                imgSource: "qrc:/Icons/search.png"
                visible: true
                Text{
                    font.family:"Tahoma"
                    font.pixelSize: 20
                    color: "#001C44"
                    anchors.left: parent.left
                    anchors.leftMargin: 55
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Search"
                    visible: (statusText||root.width>860)?true:false
                }

            }
            MenuButton{
                id:homeButton
                imgSource: "qrc:/Icons/home1.png"
                visible: true
                Text{
                    font.family:"Tahoma"
                    font.pixelSize: 20
                    color: "#001C44"
                    anchors.left: parent.left
                    anchors.leftMargin: 55
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Home"
                    visible: (statusText||root.width>860)?true:false
                }
                onButtonClicked: {
                    loader.active=false



                }
            }
            MenuButton{
                id:musicButton
                imgSource: "qrc:/Icons/library_music.png"
                visible: true
                Text{
                    font.family:"Tahoma"
                    font.pixelSize: 20
                    color: "#001C44"
                    anchors.left: parent.left
                    anchors.leftMargin: 55
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Music List"
                    visible: (statusText||root.width>860)?true:false
                }
                onButtonClicked: {
                    isLoad=false


                    loader.active=true
                    loader.source="qrc:/Screen/MusicScreen.qml"
                }
            }
            MenuButton{
                id:videoButton
                imgSource: "qrc:/Icons/video_library.png"
                visible: true
                Text{
                    font.family:"Tahoma"
                    font.pixelSize: 20
                    color: "#001C44"
                    anchors.left: parent.left
                    anchors.leftMargin: 55
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Video List"
                    visible: (statusText||root.width>860)?true:false
                }
                onButtonClicked: {
                    isLoad=true

                    loader.active=true
                    loader.source="qrc:/Screen/VideoScreen.qml"
                }

            }
            MenuButton{
                id:playlistButton
                imgSource: "qrc:/Icons/queue_music.png"
                visible: true
                Text{
                    font.family:"Tahoma"
                    font.pixelSize: 20
                    color: "#001C44"
                    anchors.left: parent.left
                    anchors.leftMargin: 55
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Play List"
                    visible: (statusText||root.width>860)?true:false
                }
                onButtonClicked: {
                    loader.active=true
                    loader.source="qrc:/Screen/PlayListScreen.qml"
                }
            }



        }


    }




}




