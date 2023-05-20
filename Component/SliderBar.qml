import QtQuick 2.15
Rectangle{
    id:sliderBarID
    width: root.width-200
    height: 10
    radius: 20
    border.width: 3
    border.color: "#F4A460"
    property alias  position: handleID.x
    property real ranger:sliderBarID.width - handleID.width
    signal clicked()
    signal dragged()

    MouseArea{
        anchors.fill: parent
        onClicked: {
            if(mouseX>sliderBarID.width-handleID.width/2)
            {
                position=mouseX-handleID.width
            }
            else if(mouseX<handleID.width/2)
            {
                position=0
            }
            else{
               position=mouseX


            }
            sliderBarID.clicked()

        }

    }

    Rectangle{
        id:handleID
        width: 20
        height: 20
        radius: 20
       color: "#F4A460"
        anchors.verticalCenter: sliderBarID.verticalCenter
        MouseArea{
            id:mouseArea1
            anchors.fill: parent
            drag.target: handleID
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: sliderBarID.width - handleID.width
            onPositionChanged: {
               dragged()

            }
            onPressed: {
                handleID.scale=1.15
            }
            onReleased: {
                 handleID.scale=1

            }

        }
    }
    Rectangle{
        width: sliderBarID.width-(sliderBarID.width-position-handleID.width/2)
        height:10
        radius: 20
        color: "#F4A460"
        anchors.verticalCenter: sliderBarID.verticalCenter
    }

}



