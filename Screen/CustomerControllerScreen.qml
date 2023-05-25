import QtQuick 2.15
import "../Component"
import MediaController 1.0

Rectangle{
    id:controllerScreen

    color:colorControlScreen
    border.width: 1
    border.color: "#F4A460"

    property alias sliderBarID: sliderBarID
    property alias volumeSliderID: volumeSliderID
    property int repeatIndex: 0



    Column{
        Rectangle{
            id:textArea
            width: controllerScreen.width
            height: 35
            color:colorControlScreen

            Rectangle{
                id:textRunArea
                width: 400
                height: textArea.height
                color:colorControlScreen

                anchors.centerIn:parent
                radius: 50
                clip: true
                Text{
                    id:textMusic
                    text: "<b>"+mediaObj.getMusicTitle(mediaObj.index)+"-"+mediaObj.getMusicArtist(mediaObj.index)
                    visible: false
                }
                Text{
                    id:textVideo
                    text:"<b>"+mediaObj.getVideoTitle(mediaObj.indexVideo)
                    visible: false
                }

                Text{
                    //anchors.centerIn: parent

                    id: textMedia
                    width: parent.width
                    text:isVideo?textVideo.text: textMusic.text
                    color: colorText
                    font.family:"Tahoma"
                    font.pixelSize: 20
                    //anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter

                    NumberAnimation {
                        target: textMedia
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


            color:colorControlScreen
            Row{
                anchors.centerIn: parent
                spacing: 10
                Text{
                    id:timePlayingVideoID
                    text:formatTime(mediaObj.position)
                    color: colorText
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
                    color: colorText
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
                    color:colorControlScreen
                }
                Rectangle{
                    id:rect2
                    width: controllerArea.width-rect1.width-170
                    height: controllerArea.height
                    color:colorControlScreen
                    Row{
                        anchors.centerIn: parent
                        spacing:15
                        ControllerButton{
                            id:shufferButton

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: isShuffle?"qrc:/Icons/shuffle_on_FILL0_wght300_GRAD200_opsz48.png":"qrc:/Icons/shuffle_FILL0_wght300_GRAD200_opsz48.png"
                            onButtonCliked: {
                                mediaObj.shuffleMedia()

                                isShuffle=!isShuffle

                            }


                        }
                        ControllerButton{
                            id:seekBacKButton

                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/fast_rewind_FILL0_wght400_GRAD0_opsz48.png"
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
                            width:50
                            height: 50
                            radius: 50
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
                            imgSource: "qrc:/Icons/fast_forward_FILL0_wght400_GRAD0_opsz48.png"
                            onButtonCliked: {
                                mediaObj.seekForward()
                            }

                        }
                        ControllerButton {
                            id: repeatButton
                            anchors.verticalCenter: parent.verticalCenter
                            imgSource: "qrc:/Icons/repeat_FILL0_wght300_GRAD200_opsz48.png"

                            Text {
                                id: buttonText
                                text: ""
                                font.pixelSize: 10

                                anchors.centerIn: parent
                            }

                           onButtonCliked:  {
                                repeatIndex += 1
                                mediaObj.repeatMedia(repeatIndex)
                                if (repeatIndex === 3)
                                    repeatIndex = 0
                                updateButtonText()
                            }

                            function updateButtonText() {
                                if (repeatIndex == 1)
                                    buttonText.text = "1"
                                else if (repeatIndex == 2)
                                    buttonText.text = "A"
                                else
                                    buttonText.text = ""
                            }
                        }


//                        ControllerButton{
//                            id:repeatButton


//                            anchors.verticalCenter: parent.verticalCenter

//                            imgSource:"qrc:/Icons/repeat.png"
//                            Text{
//                                text: {
//                                    if(repeatIndex==1)
//                                    {
//                                        text="1"
//                                    }
//                                    else if(repeatIndex==1)
//                                    {
//                                        text="l"

//                                    }
//                                    else{
//                                        text=""
//                                    }

//                                }
//                            }

//                            onButtonCliked: {
//                                repeatIndex+=1
//                                mediaObj.repeatMedia(repeatIndex);
//                                if(repeatIndex ===3 )
//                                    repeatIndex = 0


//                            }

//                        }
                    }
                }
                Rectangle{
                    id:rect3
                    width: controllerArea.width-rect1.width-rect2.width
                    height: controllerArea.height
                    color:colorControlScreen
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
