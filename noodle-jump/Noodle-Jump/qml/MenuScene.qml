//游戏开始界面

import Felgo 3.0
import QtQuick 2.0
import "../qml/entity"

Scene {
    id: menuScene

    opacity: 0
    visible: opacity > 0
    enabled: visible

    signal gameStart
    signal gameSettings

    Image {
        id: menuImage
        anchors.fill: menuScene.gameWindowAnchorItem
        fillMode: Image.Stretch
        source: if (gameWindow.theme === 0) {
                    "../assets/snow/snowbck.png"
                } else if (gameWindow.theme === 1) {
                    "../assets/bunny/hopbck_X.png"
                } else if (gameWindow.theme === 2) {
                    "../assets/ninja/ghostbck_X.png"
                }else if(gameWindow.theme===3){
                    "../assets/underwater/underwaterbck_X.png"
                }
    }
    Image {
        id: bckBottom
        height: 30
        anchors.left: menuScene.gameWindowAnchorItem.left
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.bottom: parent.bottom
        source: if (gameWindow.theme === 0) {
                    "../assets/snow/bottom.png"
                } else if (gameWindow.theme === 1) {
                    "../assets/bunny/bottom.png"
                } else if (gameWindow.theme === 2) {
                    "../assets/ninja/bottom.png"
                } else if(gameWindow.theme === 3){
                    "../assets/underwater/scroll.png"
                }
    }

    Image {
        id: title
        width: 202
        height: 48
        anchors.top: menuScene.gameWindowAnchorItem.top
        anchors.margins: 20
        anchors.left: parent.left
        anchors.leftMargin: 10
        source: "../assets/doodle-jump.png"
    }

    PhysicsWorld {
        id: gravity
        gravity.y: 15
        updatesPerSecondForPhysics: 60
        debugDrawVisible: false
    }

    Particle {
        id: fireParticle
        fileName: "../qml/particle/snowPractice.json"
        autoStart: true
    }

    Noodle {
        id: noodle
        x: 30
        y: 200
    }

    Floor {
        id: floor1
        x: 110
        y: 390
    }

    Monster {
        id: monster
        x:100
        y:350
    }

    Floor {
        id: floor
        x: 30
        y: 400
    }

    Image {
        id: start
        width: 110
        height: 40
        anchors.centerIn: menuScene.gameWindowAnchorItem
        source: "../assets/play.png"

        MouseArea {
            anchors.fill: parent
            onClicked: gameStart()
        }
    }
    Image {
        id: setting
        width: 57
        height: 48
        anchors.top: start.bottom
        anchors.left: start.left
        anchors.leftMargin: 150
        anchors.topMargin: 150
        source: "../assets/options.png"

        MouseArea {
            anchors.fill: parent
            onClicked: gameSettings()
        }
    }

    Image {
        id: help
        width: 30
        height: 30
        anchors.top: menuScene.gameWindowAnchorItem.top
        anchors.topMargin: 5
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.rightMargin: 8
        source: "../assets/redhelp.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                gameWindow.state = "help"
            }
        }
    }
    onBackButtonPressed: {
        Qt.quit()
    }
}
