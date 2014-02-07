import QtQuick 2.0

Rectangle {
    property int number
    property string textColor: "white"
    property bool isFireScreenOn: false
    height: counter.height-100
    Text {
        id: counter
        text: number
        color: textColor
        font.pointSize: 140
        anchors.horizontalCenter: parent.horizontalCenter
    }
    onNumberChanged: {
        if(number>7){
            textColor = "green"
        }else if(number>3){
            textColor = "yellow"
        }else {
            textColor = (isFireScreenOn) ? "white" : "red"
        }
    }
}
    
