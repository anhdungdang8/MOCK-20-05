import QtQuick 2.15
import "../Component"


Rectangle{
    id:menuScreen
    color: colorMenuScreen
    Column{
        spacing:5
        anchors.top: parent.top
        anchors.topMargin: 50
        MenuButton{
            id:homeButton
            imgSource: "qrc:/Icons/home1.png"
            visible: true
            Text{
                font.family:"Tahoma"
                font.pixelSize: 20
                color: colorText
                anchors.left: parent.left
                anchors.leftMargin: 55
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Home")
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
                color: colorText
                anchors.left: parent.left
                anchors.leftMargin: 55
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Music")
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
                color: colorText
                anchors.left: parent.left
                anchors.leftMargin: 55
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Video")
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
                color: colorText
                anchors.left: parent.left
                anchors.leftMargin: 55
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Play List")
                visible: (statusText||root.width>860)?true:false
            }
            onButtonClicked: {
                loader.active=true
                loader.source="qrc:/Screen/PlayListScreen.qml"
            }
        }
    }
    MenuButton{
        id:settingButton
        imgSource:"qrc:/Icons/settings.png"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        Text{
            font.family:"Tahoma"
            font.pixelSize: 20
            color: colorText
            anchors.left: parent.left
            anchors.leftMargin: 55
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Setting")
            visible: (statusText||root.width>860)?true:false
        }
        onButtonClicked: {
            loader.active=true
            loader.source="qrc:/Screen/SettingScreen.qml"
        }

    }

}




