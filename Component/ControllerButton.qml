import QtQuick 2.15


Rectangle{
    id:controllerButton

    width: 30
    height: 30
    color: colorControlScreen
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
            controllerButton.buttonCliked()
            console.log("1")
        }
        onPressed: {
            controllerButton.scale=0.75
        }
        onReleased: {
             controllerButton.scale=1

        }

    }
}


