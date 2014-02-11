import QtQuick 2.0

Item {
    property int number
    property string textColor: "white"
    property bool isFireScreenOn: false
    height: counter.height
    Text {
        id: counter
        text: number
        color: textColor
        font.pointSize: 140
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
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
    
