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
                spacing: 100
                Text{
                    text: "Get ready to loose some fat"
                    visible: (isGoScreenVisible) ? false : true
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    font.pointSize: 15
                }
                Text{
                    text: (isGoScreenVisible) ? "GO!" : counter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    font.pointSize: (isGoScreenVisible) ? 120 : 100

                }
                MyButton{
                    id: startButton
                    buttonText: "Start"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        startCountdownTimer.start();
                        startButton.visible = false;
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
                            goSound.play();
                            startCountdownTimer.stop();
                            raceScreenTimer.start();
                        }
                    }
                }
                Timer{
                    id: raceScreenTimer
                    onTimeout: {
                        raceScreenTimer.stop();
                        isGoScreenVisible = false;
                        pageLoader.source = "race.qml"
                        counter = 3;
                        startButton.visible = true;
                    }
                    Component.onCompleted: {
                        raceScreenTimer.setInterval(500);
                    }
                }
                MediaPlayer{
                    id: beep
                    source: "res/beep.wav"
                }
                MediaPlayer{
                    id: goSound
                    source: "res/go.wav"
                }
            }
        }
    }
}

