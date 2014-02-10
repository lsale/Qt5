import QtQuick 2.0
import QtQuick.Window 2.0
import CustomTimer 1.0
import QtNfc 5.2

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
            }
            MyButton{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: -100
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
            Component.onCompleted:{
                raceTimer.start();
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
                        //yay.play()
                    }
                }
            }
        }        
    }
}


