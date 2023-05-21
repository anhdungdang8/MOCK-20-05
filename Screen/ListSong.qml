import QtQuick 2.15
import MediaController 1.0


Item {


    ListView
    {
        id:listLocal
        height: content.height
        width: content.width
        currentIndex: -1

        //model:mediaObj.listSongPath
        model:mediaObj.songModel

        delegate:
            Rectangle{
            width: listLocal.width
            height: 50
            radius: 20
            border.width: 2
            border.color: "#F4A460"
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                id: song_title
                //text:mediaObj.listSongPath[index]
                text:"<b>Title:</b>&nbsp;" + Title + "&nbsp;<b>Artist:</b>&nbsp;" + Artist;

                font.pixelSize: 20
                color: index == listLocal.currentIndex ? "red" : "black"
                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        listLocal.currentIndex = index
                        isPlaying =true
                        mediaObj.playMedia(index);
                        console.log(song_title.text)

                    }
                }
            }
        }


    }

}
