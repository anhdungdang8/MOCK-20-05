import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15
import MediaController 1.0








import "./Screen"

Window {
    id:root
    width: 860
    height: 600
    minimumHeight: 390
    minimumWidth: 680
    visible: true
    color: "#F4A460"
    title: qsTr("Media Player")
    property bool isShuffle: false
    property bool  isPlaying: false
    property bool statusVolume: false
    property bool  statusVideo: true
    property bool statusText: false
    property bool checkButton: false
    property bool statusScreen: true
    property string songName:""
    property var value
    property string sourceImageCover: ""
    property bool isLoad: false
    property bool isShuffleEnabled: false
    property bool isVideo: false
    property bool isColor:false

    property int repeatIndex: 0
    property bool softtype: false


    MediaController{
        id:mediaObj
    }




    CustomerMenuScreen{
        id:menuScreen
        width: ((root.width)>860?200:35)
        height: root.height-150
        border.width: 1
        border.color: "#F4A460"
        visible: true
    }
    CustomerControllerScreen{
        id:controllerScreen
        width: root.width
        height: root.height-menuScreen.height
        anchors.bottom: parent.bottom
        border.width: 1
        border.color: "#F4A460"

    }
    CustomerMediaScreen{
        id:mediaScreen
        width: root.width-menuScreen.width
        height: root.height-controllerScreen.height

        Loader{
            id:loader
            active: false
            anchors.fill: mediaScreen
        }



    }











}
