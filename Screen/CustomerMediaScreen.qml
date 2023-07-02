import QtQuick 2.15
import QtMultimedia 5.15
import QtGraphicalEffects 1.15

Rectangle{
    id:mediaScreen
    anchors.right: parent.right
    color: colorMediaScreen
    property alias coverArt: coverArt

    Image {
        id: coverArt
        source: mediaObj.songCoverArt()
        z:isShowCoverArt?-1:0
        anchors.centerIn: parent
        height: parent.height*2/3
        width: parent.height*2/3
        fillMode: Image.PreserveAspectFit
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: coverArt.width
                height: coverArt.height
                radius: Math.min(coverArt.width, coverArt.height) / 2
                color: "black"
            }
        }
    }
    RotationAnimation{
        id: rollanimationid
        target: coverArt
        from: 0
        to:360
        loops: Animation.Infinite
        duration: 10000
        running:true
    }
    Connections{
        target: mediaObj
        function onDurationChanged(){
            coverArt.source = mediaObj.songCoverArt()
        }
    }
    VideoOutput{
        id:videoID
        source: mediaObj
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectFit
    }


}
