import QtQuick 2.15
import "../Component"
import MediaController 1.0

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
                clip: true
                Text{
                    id:textMusic
                    text: mediaObj.getMusicTitle(mediaObj.index)+"-"+mediaObj.getMusicArtist(mediaObj.index)
                    visible: false
                }
                Text{
                    id:textVideo
                    text:mediaObj.getVideoTitle(mediaObj.indexVideo)
                    visible: false
                }

                Text{
                    //anchors.centerIn: parent
                    width: parent.width
                    id: textSong
                    text:isVideo?textVideo.text: textMusic.text
                    color: "#001C44"
                    font.family:"Tahoma"
                    font.pixelSize: 20
                    //anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter

                    NumberAnimation {
                        target: textSong
                        property: "x"
                        loops: Animation.Infinite
                        from: textRunArea.width
                        to: -textRunArea.width
                        duration: 5000
                        running: true
                    }
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
                        if(positionMouse<ranger)
                        {
                            mediaObj.position= (mediaObj.duration)*(positionMouse/ranger)

                        }
                        else
                        {
                            mediaObj.position=mediaObj.duration

                        }



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

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: isShuffle?"qrc:/Icons/shuffle_F.png":"qrc:/Icons/shuffle_.png"
                            onButtonCliked: {
                                mediaObj.shuffleMedia()

                                isShuffle=!isShuffle

                            }


                        }
                        ControllerButton{
                            id:seekBacKButton

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/previous.png"
                            onButtonCliked: {
                                mediaObj.seekBack()
                            }

                        }

                        ControllerButton{
                            id:previousButton

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/skip_previous.png"
                            onButtonCliked: {
                                mediaObj.previousMedia()




                            }

                        }
                        ControllerButton{
                            id:playButton
                            width:60
                            height: 60
                            radius: 60
                            imgSource: !isPlaying?"qrc:/Icons/Logo.png":"qrc:/Icons/pause imge.png"
                            anchors.verticalCenter: parent.verticalCenter
                            onButtonCliked: {
                                !isPlaying?mediaObj.resumeMedia(): mediaObj.pauseMedia()
                                isPlaying =!isPlaying
                            }


                        }
                        ControllerButton{
                            id:nextButton

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/skip_next.png"
                            onButtonCliked: {
                                mediaObj.nextMedia()





                            }

                        }
                        ControllerButton{
                            id:seekForwardButton

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/next.png"
                            onButtonCliked: {
                                mediaObj.seekForward()
                            }

                        }

                        ControllerButton{
                            id:repeatButton

                            anchors.verticalCenter: parent.verticalCenter
                            color: root.repeatIndex===0?"white":"#4EB09B"

                            imgSource: root.repeatIndex===1?"qrc:/Icons/repeat_one.png":"qrc:/Icons/repeat.png"
                            onButtonCliked: {
                                root.repeatIndex+=1
                                mediaObj.repeatMedia(repeatIndex);
                                if(root.repeatIndex ===3 )
                                    root.repeatIndex = 0


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
                        spacing: 5
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

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: !statusVolume? "qrc:/Icons/volume_up.png":"qrc:/Icons/volume_off.png"
                            onButtonCliked: {
                                volumeSliderID.visible=!volumeSliderID.visible
                            }


                        }


                        ControllerButton{
                            id:speedButton


                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/speed.png"
                            property real rate: 1.0
                            Text {
                                anchors.bottom: speedButton.top
                                anchors.horizontalCenter: parent.horizontalCenter
                                id: speed
                                text: speedButton.rate.toString()+"x"
                            }

                            onButtonCliked: {

                                if(rate<2.0)
                                {
                                    rate+=0.25
                                }
                                else{
                                    rate=0.25;
                                }
                                speed.text =  rate.toString()+"x"
                                mediaObj.adjustSpeedMedia(rate)

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
