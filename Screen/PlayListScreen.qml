import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Component"
import MediaController 1.0





Rectangle{
    id:musicScreen
    width: mediaScreen.width
    height: mediaScreen.height
    color: colorMediaScreen





    Column{
        Rectangle{
            id:titleArea
            width: musicScreen.width
            height:100
            color: colorMediaScreen




            Rectangle{
                id:nameArea
                height: titleArea.height
                width: 300
                color: colorMediaScreen




                Text{
                    id:textHome
                    text: "PLAY LIST"
                    font.pointSize: 25
                    anchors.centerIn: parent
                    font.family:"Tahoma"
                    color: colorText

                }
            }




        }


    }
}
