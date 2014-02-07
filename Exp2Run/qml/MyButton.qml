import QtQuick 2.0

Rectangle {
    id: mainArea
    property int buttonWidth: 400
    property int buttonHeight: 100
    property string buttonText: "Button"
    property string textColor: "black"
    signal clicked
    width: buttonWidth
    height: buttonHeight
    border.color: "black"
    border.width: 3
    radius: 20
    color: "#d4d4d4"
    Text {
        id: buttonLabel
        text: buttonText
        font.pointSize: 15
        font.family: "Verdana"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: textColor
    }
    MouseArea{
        id: mouseArea
        width: buttonWidth
        height: buttonHeight
        onPressed:{
            mainArea.opacity = 0.5
        }
        onReleased: {
            mainArea.opacity = 1
        }
        onClicked: {
            mainArea.clicked();
        }
    }
}
