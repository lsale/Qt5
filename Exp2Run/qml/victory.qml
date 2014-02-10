import QtQuick 2.0
import QtQuick.Window 2.0
import QtMultimedia 5.0

Item {
    Loader{
        id: loader
        sourceComponent: mainComponent
    }
    Component{
        id: mainComponent
        Rectangle{
            width: 720 //Screen.desktopAvailableWidth
            height: 1280 //Screen.desktopAvailableHeight
            color: "black"
            visible: true
            Text {
                text: "Victory!!!"
                font.pointSize: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: bananaImage.top
                color: "green"
            }
            Image {
                id: bananaImage
                source: "res/banana.gif"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            MediaPlayer{
                id: peanutButter
                source: "res/peanutbutter.mp3"
            }

            Component.onCompleted: {
                peanutButter.play()
            }
        }
    }
}
