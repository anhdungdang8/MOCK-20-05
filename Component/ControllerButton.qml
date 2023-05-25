import QtQuick 2.15


Rectangle{
    id:myControllerButton

    width: 30
    height: 30
    color: colorControlScreen


    //color:"transparent"
    property alias imgSource: imageID1.source
    signal buttonCliked()


    Image {
        id: imageID1
        source: ""
        anchors.centerIn: parent
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit


    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            myControllerButton.buttonCliked()
            console.log("1")

        }
        onPressed: {
            myControllerButton.scale=0.75
        }
        onReleased: {
             myControllerButton.scale=1

        }

    }
}


