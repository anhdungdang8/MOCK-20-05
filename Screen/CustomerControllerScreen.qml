import QtQuick 2.15
import "../Component"
//import MediaController 1.0

Rectangle{
    id:controllerScreen

    color:"#C688EB"
    border.width: 1
    border.color: "#F4A460"

    property alias sliderBarID: sliderBarID
    property alias volumeSliderID: volumeSliderID



    Column{
        Rectangle{
            id:textArea
            width: controllerScreen.width
            height: 35
            color:"#4EB09B"
            Rectangle{
                id:textRunArea
                width: 300
                height: textArea.height
                color:"#4EB09B"

                anchors.centerIn:parent
                radius: 50
                // clip: true

                Text{
                    //anchors.centerIn: parent
                    //width: parent.width
                    id: textSong
                    text:root.songName
                    color: "#001C44"
                    font.family:"Tahoma"
                    font.pixelSize: 20
                    anchors.centerIn: parent

                    //                    NumberAnimation {
                    //                        target: textSong
                    //                        property: "x"
                    //                        loops: Animation.Infinite
                    //                        from: textRunArea.width
                    //                        to: -textRunArea.width
                    //                        duration: 5000
                    //                        running: true
                    //                    }
                }

            }

        }
        Rectangle{
            id:sliderArea
            width: controllerScreen.width
            height: 40

            color:"#4EB09B"
            Row{
                anchors.centerIn: parent
                spacing: 10
                Text{
                    id:timePlayingVideoID
                    text:formatTime(mediaObj.position)
                    color: "#001C44"
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                }
                SliderBar{
                    id:sliderBarID
                    anchors.verticalCenter: parent.verticalCenter
                    position:  (mediaObj.position/mediaObj.duration)*(ranger)
                    onClicked: {
                        mediaObj.position= (mediaObj.duration)*(position/ranger)

                    }
                    onDragged: {
                       //media.onPositionChanged(position*(media.duration)/ranger)
                        mediaObj.position= (mediaObj.duration)*(position/ranger)
                    }
                }

                Text{
                    id:timeVideoID
                    text: formatTime(mediaObj.duration)
                    color: "#001C44"
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
        Rectangle{
            id:controllerArea
            width: controllerScreen.width
            height: controllerScreen.height-sliderArea.height-textArea.height

            Row{
                //anchors.centerIn: parent
                Rectangle{
                    id:rect1
                    width: 150
                    height: controllerArea.height
                    color:"#4EB09B"
                }
                Rectangle{
                    id:rect2
                    width: controllerArea.width-rect1.width-170
                    height: controllerArea.height
                    color:"#4EB09B"
                    Row{
                        anchors.centerIn: parent
                        spacing:10
                        ControllerButton{
                            id:shufferButton
                            width: 40
                            height: 40
                            radius: 40
                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: isShuffle?"qrc:/Icons/shuffle_F.png":"qrc:/Icons/shuffle_.png"
                            onButtonCliked: {
                               mediaObj.shuffleMedia()

                                isShuffle=!isShuffle

                            }


                        }
                        ControllerButton{
                            id:previousButton
                            width: 40
                            height: 40
                            radius: 40
                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/skip_previous.png"
                            onButtonCliked: {
                              mediaObj.previousMedia()



                            }

                        }
                        ControllerButton{
                            id:playButton
                            imgSource: !isPlaying?"qrc:/Icons/Logo.png":"qrc:/Icons/pause imge.png"
                            anchors.verticalCenter: parent.verticalCenter
                            onButtonCliked: {
                                !isPlaying?mediaObj.resumeMedia(): mediaObj.pauseMedia()
                                isPlaying =!isPlaying
                            }


                        }
                        ControllerButton{
                            id:nextButton
                            width: 40
                            height: 40
                            radius: 40
                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/skip_next.png"
                            onButtonCliked: {
                              mediaObj.nextMedia()

                            }

                        }
                        ControllerButton{
                            id:repeatButton
                            width: 40
                            height: 40
                            radius: 40
                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/repeat.png"
                            onButtonCliked: {
                                mediaObj.repeatMedia()

                            }

                        }
                    }
                }
                Rectangle{
                    id:rect3
                    width: controllerArea.width-rect1.width-rect2.width
                    height: controllerArea.height
                    color:"#4EB09B"
                    Row{

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.centerIn: parent
                        spacing: 10
                        SliderBar{
                            id:volumeSliderID
                            width: 50
                            height: 10
                            rotation: -90
                            anchors.verticalCenter: parent.verticalCenter
                            position: mediaObj.volume*ranger/100
                            onClicked: {
                               mediaObj.volume=position/ranger*100
                            }

                            onDragged: {
                                mediaObj.volume=position/ranger*100
                                position/ranger===0?statusVolume=true:statusVolume=false
                            }
                            visible: false
                        }
                        ControllerButton{
                            id:volumeButton
                            width: 40
                            height: 40
                            radius: 40
                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: !statusVolume? "qrc:/Icons/volume_up.png":"qrc:/Icons/volume_off.png"
                            onButtonCliked: {
                                volumeSliderID.visible=!volumeSliderID.visible
                            }


                        }
                        SliderBar{
                            id:speedSliderID
                            width: 50
                            height: 10
                            rotation: -90
                            anchors.verticalCenter: parent.verticalCenter
                            visible: false
                        }
                        ControllerButton{
                            id:speedButton
                            width: 40
                            height: 40
                            radius: 40

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/speed.png"
                            onButtonCliked: {
                                speedSliderID.visible=!speedSliderID.visible
                            }

                        }
                    }

                }
            }

        }
    }
    function formatTime(milliseconds) {
        var totalSeconds = Math.floor(milliseconds / 1000);
        var minutes = Math.floor(totalSeconds / 60);
        var seconds = totalSeconds % 60;
        return minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0'); }

}
