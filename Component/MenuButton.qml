import QtQuick 2.15

Rectangle{
    id:myButton
    width: menuScreen.width-3
    height: 30
    radius: 6
    border.color: "#F4A460"
    border.width: 0

    color:"#FAE0C7"
    property alias imgSource: imageID.source
    signal buttonClicked()

    Image {
        id: imageID
        source: ""
        height: 30
        width: 30
        anchors.leftMargin: 10
        fillMode: Image.PreserveAspectFit
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            myButton.buttonClicked()
        }
        onEntered: {
            myButton.visible = true
            myButton.border.width = 4
        }

        onExited: {

            myButton.border.width = 0

        }
        onPressed: {
            myButton.scale=0.75
        }
        onReleased: {
             myButton.scale=1

        }


    }

}
