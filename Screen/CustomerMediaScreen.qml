import QtQuick 2.15
import QtMultimedia 5.15
import "../Component"
Rectangle{
    id:mediaScreen
    anchors.right: parent.right
   // property alias videoID: videoID
//    Image {
//        id: imageHome
//        source: "file:///D:/DN23_FR_CPP23_03/Music App/MusicApp_1105/Image/album-cover.jpg"

//        anchors.centerIn: parent
//        width: mediaScreen.width-430
//        height: mediaScreen.height-130
//        fillMode: Image.PreserveAspectFit

//    }
    VideoOutput{
        id:videoID
        source: mediaObj
        anchors.fill: parent}


//        onPositionChanged:
//        {
//           controllerScreen.sliderBarID.position= videoID.position*(controllerScreen.sliderBarID.ranger)/videoID.duration
//        }
//        focus: true
//        //Keys.onSpacePressed: videoID.playbackState == videoID.PlayingState ? videoID.pause() : videoID.play()
//        Keys.onLeftPressed: videoID.position = videoID.position - 5000
//        Keys.onRightPressed: videoID.position = videoID.position + 5000
    //}



}
