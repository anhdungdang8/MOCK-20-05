import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15









import "./Screen"

Window {
    id:root
    width: 860
    height: 600
    minimumHeight: 390
    minimumWidth: 680
    visible: true
    color: colorMediaScreen
    title: qsTr("Media Player")
    property bool isShuffle: false
    property bool  isPlaying: false
    property bool statusVolume: false
    property bool  statusVideo: true
    property bool statusText: false
    property bool checkButton: false
    property bool statusScreen: true
    property bool isShowCoverArt: false
    property string songName:""
    property var value
    property string sourceImageCover: ""
    property bool isLoad: false
    property bool isShuffleEnabled: false
    property bool isVideo: false
    property bool isColor:false

// property to set color for app
    property bool softtype: false
    property bool colorCheck: false
    property string colorMenuScreen: colorCheck?"#333333":"#dfe3ee"
    property string colorControlButton: colorCheck?"#808080":"#778899"
    property string colorMenuButton: colorCheck?"#777777":"#dfe3ee"
    property string colorMediaScreen: colorCheck?"#111111":"#f7f7f7"
    property string colorControlScreen: colorCheck?"#333333":"#dfe3ee"
    property string colorText: colorCheck?"#f7f7f7":"#001C44"
    property string colorBoder: colorCheck?"#999999":"#ffffff"
    property string colorSlider: colorCheck?"#ffffff":"#3b5998"
    property string colorHandle: colorCheck?"#3b5998":"#F4A460"
    property string colorListView: colorCheck?"#555555":"#ffffff"






    CustomerMenuScreen{
        id:menuScreen
        width: ((root.width)>860?200:35)
        height: root.height-150
        visible: true
    }
    CustomerControllerScreen{
        id:controllerScreen
        width: root.width
        height: root.height-menuScreen.height
        anchors.bottom: parent.bottom
    }
    CustomerMediaScreen{
        id:mediaScreen
        width: root.width-menuScreen.width
        height: root.height-controllerScreen.height
        color: colorMediaScreen
        Loader{
            id:loader
            active: false
            anchors.fill: mediaScreen
        }
    }











}
