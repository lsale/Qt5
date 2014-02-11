import QtQuick 2.0
import QtQuick.Window 2.0
import CustomTimer 1.0
import QtNfc 5.2
import QtMultimedia 5.0

Item{
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableWidth
    Loader{
        id: pageLoader
        sourceComponent: mainComponent
        anchors.fill: parent
    }
    Component{
        id: mainComponent
        Rectangle {
            id: childArea
            property int currentTimeRemaining: 10
            property int targetLapTime: 10
            property int lap
            property bool shoot
            color: (shoot)? "red" : "black"
            width: Screen.desktopAvailableWidth
            height: Screen.desktopAvailableWidth
            NearField{
                onMessageRecordsChanged: {
                    for (var i = 0; i < messageRecords.length; ++i) {
                        if(messageRecords[i].payload === "lap")
                            lap++;
                    }
                }
            }
            Text{
                id: fireText
                text:"Fire!"
                visible: shoot
                color: "white"
                font.pointSize: 110
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: counter.top
                anchors.bottomMargin: -150
            }
            CustomCountdown{
                id: counter
                visible: true
                number: currentTimeRemaining
                isFireScreenOn: shoot
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            Text{
                id: lapCounter
                text:"Lap: "+lap
                color: (shoot) ? "white" : "green"
                font.pointSize: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: counter.bottom
                anchors.topMargin: -150
            }
            MyButton{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                anchors.top: lapCounter.bottom
                buttonText: "Close"
                onClicked: {
                    pageLoader.source = "main.qml"
                }
            }
            Timer{
                id: raceTimer
                onTimeout: {
                    if(currentTimeRemaining > 1){
                        currentTimeRemaining--;
                    }else{
                        currentTimeRemaining = targetLapTime;
                        shoot = true;
                        siren.play();
                        resetter.start();
                    }
                }
            }
            Timer {
                id: resetter
                onTimeout: {
                    shoot = false
                    resetter.stop()
                }
                Component.onCompleted: {
                    resetter.setInterval(3000);
                }
            }
            MediaPlayer{
                id: yay
                source: "res/yay.wav"
            }
            MediaPlayer{
                id: bennyHill
                source: "res/benny.mp3"
            }
            MediaPlayer{
                id: siren
                source: "res/siren.wav"
            }

            Component.onCompleted:{
                raceTimer.start();
                bennyHill.play();
            }
            onLapChanged: {
                if(lap == 10){
                    console.log('race over')
                    raceTimer.stop()
                    pageLoader.source = "victory.qml"
                } else {
                    if(targetLapTime > 5){
                        targetLapTime--
                    }
                    currentTimeRemaining = targetLapTime
                    if(!shoot){
                        yay.play()
                    }
                }
            }
        }        
    }
}


