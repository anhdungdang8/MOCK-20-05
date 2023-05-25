import QtQuick 2.15

Rectangle{
    id:menuButton
    width: menuScreen.width-3
    height: 40
    radius: 6
    border.color: "#F4A460"
    border.width: 0

    color:colorMenuButton
    property alias imgSource: imageID.source

    signal buttonClicked()

    Image {
        id: imageID
        source: ""
        height: 30
        width: 30
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            menuButton.buttonClicked()
        }
        onEntered: {
            menuButton.visible = true
            menuButton.border.width = 2
        }
        onExited: {
            menuButton.border.width = 0

        }
        onPressed: {
            menuButton.scale=0.75
        }
        onReleased: {
             menuButton.scale=1

        }


    }

}
