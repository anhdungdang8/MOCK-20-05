import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Component"
import MediaController 1.0





Rectangle{
    id:settingScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: colorMediaScreen
    property bool isOnLight: false
    property bool isOnDark: false






    Column{
        Rectangle{
            id:titleArea
            width: settingScreen.width
            height:100
            color: colorMediaScreen




            Rectangle{
                id:nameArea
                height: titleArea.height
                width: 300
                color: colorMediaScreen




                Text{
                    id:textHome
                    text: "SETTING"
                    font.pointSize: 25
                    anchors.centerIn: parent
                    font.family:"Tahoma"
                    color: colorText

                }
            }




        }
        Rectangle{
            id:settingArea
            width: settingScreen.width
            height: settingScreen.height-titleArea.height
            color: colorMediaScreen
            Row{
                anchors.left:parent.left
                anchors.leftMargin: 50
                spacing: 20
                Column{
                    spacing: 20


                    //                anchors.top: parent.bottom
                    //                anchors.topMargin: 30
                    Text{
                        text:"Themes"
                        font.pointSize: 15
                        font.family:"Tahoma"
                        color: colorText

                    }

                    MenuButton{
                        id:themesDarkButton

                        width: 120
                        height: 50

                        Text{
                            text: "Dark"
                            anchors.left: parent.left
                            anchors.leftMargin: 40
                            anchors.verticalCenter: parent.verticalCenter
                            color: colorText

                        }
                        imgSource: isOnDark?"qrc:/Icons/toggle_off_FILL0_wght400_GRAD200_opsz48.png":"qrc:/Icons/toggle_on_FILL0_wght400_GRAD200_opsz48.png"
                        onButtonClicked: {
                            isOnDark=true
                            colorCheck=true

                            console.log("1")



                        }
                    }
                    MenuButton{
                        id:themesLightButton

                        width: 120
                        height: 50
                        Text{
                            text: "Light"
                            anchors.left: parent.left

                            anchors.leftMargin: 40
                            anchors.verticalCenter: parent.verticalCenter
                            color: colorText

                        }
                        imgSource: isOnLight?"qrc:/Icons/toggle_off_FILL0_wght400_GRAD200_opsz48.png":"qrc:/Icons/toggle_on_FILL0_wght400_GRAD200_opsz48.png"
                        onButtonClicked: {
                            colorCheck=false
                            isOnLight=true
                            isOnDark=false

                            console.log("1")



                        }
                    }
                }
                Column{
                    spacing: 20


                    //                anchors.top: parent.bottom
                    //                anchors.topMargin: 30
                    Text{
                        text:"Language"
                        font.pointSize: 15
                        font.family:"Tahoma"
                        color: colorText

                    }

                    MenuButton{
                        id:vnChangeButton

                        width: 120
                        height: 50

                        Text{
                            text: "English"
                            anchors.left: parent.left
                            anchors.leftMargin: 40
                            anchors.verticalCenter: parent.verticalCenter
                            color: colorText

                        }
//                        imgSource: isOnDark?"qrc:/Icons/toggle_off_FILL0_wght400_GRAD200_opsz48.png":"qrc:/Icons/toggle_on_FILL0_wght400_GRAD200_opsz48.png"
//                        onButtonClicked: {
//                            isOnDark=true
//                            colorCheck=true

//                            console.log("1")



//                        }
                    }
                    MenuButton{
                        id:enChangeButton

                        width: 120
                        height: 50
                        Text{
                            text: "VietNamese"
                            anchors.left: parent.left

                            anchors.leftMargin: 40
                            anchors.verticalCenter: parent.verticalCenter
                            color: colorText

                        }
//                        imgSource: isOnLight?"qrc:/Icons/toggle_off_FILL0_wght400_GRAD200_opsz48.png":"qrc:/Icons/toggle_on_FILL0_wght400_GRAD200_opsz48.png"
//                        onButtonClicked: {
//                            colorCheck=false
//                            isOnLight=true
//                            isOnDark=false

//                            console.log("1")



//                        }
                    }
                }
            }

        }

    }




}


