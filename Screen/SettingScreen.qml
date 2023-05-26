import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Component"




Rectangle{
    id:settingScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: colorMediaScreen
    property bool isOnLight: false
    property bool isOnDark: false
    property bool isEnglish: false
    property bool isVietNamese: false

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
                    text: qsTr("SETTING")
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
                    Text{
                        text:qsTr("Themes")
                        font.pointSize: 15
                        font.family:"Tahoma"
                        color: colorText
                    }
                    MenuButton{
                        id:themesDarkButton
                        width: 120
                        height: 50
                        Text{
                            text: qsTr("Dark")
                            anchors.left: parent.left
                            anchors.leftMargin: 40
                            anchors.verticalCenter: parent.verticalCenter
                            color: colorText
                        }
                        imgSource: isOnDark?"qrc:/Icons/toggle_on_FILL0_wght400_GRAD200_opsz48.png":"qrc:/Icons/toggle_off_FILL0_wght400_GRAD200_opsz48.png"
                        onButtonClicked: {
                            isOnDark=true
                            isOnLight=false
                            colorCheck=true
                        }
                    }
                    MenuButton{
                        id:themesLightButton

                        width: 120
                        height: 50
                        Text{
                            text: qsTr("Light")
                            anchors.left: parent.left

                            anchors.leftMargin: 40
                            anchors.verticalCenter: parent.verticalCenter
                            color: colorText
                        }
                        imgSource: isOnLight?"qrc:/Icons/toggle_on_FILL0_wght400_GRAD200_opsz48.png":"qrc:/Icons/toggle_off_FILL0_wght400_GRAD200_opsz48.png"
                        onButtonClicked: {
                            colorCheck=false
                            isOnLight=true
                            isOnDark=false
                        }
                    }
                }
                Column{
                    spacing: 20
                    Text{
                        text:qsTr("Language")
                        font.pointSize: 15
                        font.family:"Tahoma"
                        color: colorText

                    }
                    MenuButton{
                        id:enChangeButton
                        width: 120
                        height: 50
                         imgSource: isEnglish?"qrc:/Icons/toggle_on_FILL0_wght400_GRAD200_opsz48.png":"qrc:/Icons/toggle_off_FILL0_wght400_GRAD200_opsz48.png"
                        Text{
                            text:qsTr("English")
                            anchors.left: parent.left
                            anchors.leftMargin: 40
                            anchors.verticalCenter: parent.verticalCenter
                            color: colorText

                        }
                        onButtonClicked:{
                            mediaObj.transtoEnglish()
                            isEnglish=true
                            isVietNamese=false
                        }
                    }
                    MenuButton{
                        id:vnChangeButton

                        width: 120
                        height: 50
                         imgSource: isVietNamese?"qrc:/Icons/toggle_on_FILL0_wght400_GRAD200_opsz48.png":"qrc:/Icons/toggle_off_FILL0_wght400_GRAD200_opsz48.png"
                        Text{
                            text: qsTr("VietNamese")
                            anchors.left: parent.left

                            anchors.leftMargin: 40
                            anchors.verticalCenter: parent.verticalCenter
                            color: colorText

                        }
                        onButtonClicked:{
                            mediaObj.transtoVietNamese()
                            isVietNamese=true
                            isEnglish=false
                        }

                    }
                }
            }

        }

    }




}


