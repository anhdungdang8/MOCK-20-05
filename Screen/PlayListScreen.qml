import QtQuick 2.15
import "../Component"



Rectangle{
    id:videoScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: "#F4A460"

    Column{
        Rectangle{
            id:title
            width: videoScreen.width
            height:62
            color:"#4EB09B"
            radius: 20
            border.width: 1
            border.color: "#F4A460"

            Rectangle{
                id:nameArea
                height: title.height
                width: 200
                color:"#4EB09B"
                radius: 20
                border.width: 1
                border.color: "#F4A460"

                Text{
                    id:textHome
                    text: "PLAY LIST"
                    font.pointSize: 25
                    anchors.centerIn: parent
                    font.family:"Tahoma"
                    color: "#001C44"

                }
            }


            Rectangle{
                id:folderArea
                height: title.height
                width: title.width-nameArea.width
                color:"#4EB09B"
                radius: 20
                border.width: 1
                border.color: "#F4A460"
                anchors.right: parent.right
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    spacing: 10
                    MenuButton{
                        id:folderButton
                        imgSource: "qrc:/Icons/foldernew.png"
                        width: 100
                        height: 30
                        Text{
                            text: "Folder"
                            anchors.centerIn: parent
                            color: "#001C44"

                        }
                    }
                    MenuButton{
                        id:favoriteButton
                        imgSource: "qrc:/Icons/favorite.png"
                        width: 100
                        height: 30
                        Text{
                            text: "Favorite"
                            anchors.centerIn: parent
                            color: "#001C44"

                        }
                        onButtonClicked: {
                            listViewArea.visible=!listViewArea.visible
                        }
                    }
                }


            }
        }



    }


}

