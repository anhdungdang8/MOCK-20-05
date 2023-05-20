import QtQuick 2.15

Text {
    id: txt
    text:""
    property real distance:40
    property bool runState: false
    property alias animation: animation
    signal completed()

    NumberAnimation on x{
        id: animation
        from: x
        to: (contentWidth > parent.width) ?  -(contentWidth+distance) : 0
        duration: (contentWidth > parent.width) ? (contentWidth*25):0
        running: runState
        onStarted:
        {
            if(contentWidth>parent.width)
                tempT.visible = true
        }
        onStopped:
        {
            x=0 //tra text lai vi tri ban dau
            tmr.start()
        }

    }
    Timer
    {
        id:tmr
        interval: 0
        running: false
        onTriggered:
        {
            if(runState)
            animation.restart()
        }
    }

    Text {
    id: tempT
    visible: false
    text: txt.text
    y:0
    x: txt.contentWidth + txt.distance
    height: txt.height
    font.pixelSize: txt.font.pixelSize
    color: txt.color
    }

}
