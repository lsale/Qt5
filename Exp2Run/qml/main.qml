import QtQuick 2.0
import QtQuick.Window 2.0
import CustomTimer 1.0
import QtNfc 5.2
import QtMultimedia 5.0

Item{
    Loader{
        id: pageLoader
        anchors.fill: parent
        sourceComponent: mainPage
    }
    Component{
        id: mainPage
        Rectangle{
            id: mainArea
            property int counter: 3
            property bool isGoScreenVisible
            clip: true
            width: Screen.desktopAvailableWidth
            height: Screen.desktopAvailableHeight
            color: (isGoScreenVisible) ? "green" : "black"
            NearField{
                onMessageRecordsChanged: {
                    if(messageRecords[0].payload === "start")
                       startCountdownTimer.start();
                }
            }
            Column{
                id: column1
                width: mainArea.width
                height: mainArea.height
                Text{
                    text: "Get ready to loose some fat"
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    font.pointSize: 15
                }
                Text{
                    text: (isGoScreenVisible) ? "GO!" : counter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    font.pointSize: (isGoScreenVisible) ? 60 : 40

                }
                MyButton{
                    id: startButton
                    buttonText: "Click me"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        startCountdownTimer.start();
                        startButton.enabled = false;
                        startButton.opacity = 0.3;
                    }
                }
                Timer{
                    id: startCountdownTimer
                    onTimeout: {
                        if(counter >0){
                            beep.stop()
                            beep.play()
                            counter--
                        }else{
                            isGoScreenVisible = true;
                            startCountdownTimer.stop();
                            raceScreenTimer.start();
                            counter = 3;
                            startButton.enabled = true;
                            startButton.opacity = 1;
                        }
                    }
                }
                Timer{
                    id: raceScreenTimer
                    onTimeout: {
                        raceScreenTimer.stop();
                        isGoScreenVisible = false;
                        pageLoader.source = "race.qml"
                    }
                    Component.onCompleted: {
                        raceScreenTimer.setInterval(500);
                    }
                }
                MediaPlayer{
                    id: beep
                    source: "res/beep.wav"
                }
            }
        }
    }
}

