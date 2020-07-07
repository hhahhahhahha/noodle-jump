//暂停界面

import QtQuick 2.0
import Felgo 3.0

Scene {

    id: pauseScene
    opacity: 0
    visible: opacity > 0
    enabled: visible

    signal resume
    property alias pauseScore: score.text

    Image {
        id: pauseSceneImage
        anchors.fill: pauseScene.gameWindowAnchorItem
        source: "../assets/pausecover.png"
    }

    Image {
        id: end
        width: 110
        height: 40
        anchors.centerIn: pauseScene.gameWindowAnchorItem
        source: "../assets/resume.png"
        scale: 0.8
        MouseArea {
            anchors.fill: parent
            onClicked: resume()
        }
    }
    Text {
        id: score
        anchors.left: end.left
        anchors.leftMargin: 30
        anchors.bottom: end.top
        anchors.topMargin: 60
        text: "0"
    }

    Image {
        id: menu
        width: 110
        height: 40
        scale: 0.8
        x: end.x
        anchors.top: end.bottom
        anchors.topMargin: 30
        source: "../assets/menu.png"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                gameWindow.state = "menu"
            }
        }
    }
}
