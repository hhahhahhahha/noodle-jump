//游戏界面


import QtQuick 2.0
import Felgo 3.0
import QtSensors 5.5
import QtQuick 2.4

import "../qml/entity"



Scene {
    id: gameScene
    width: 320
    height: 480
    opacity: 0
    visible: opacity > 0
    enabled: visible

    signal pause
    signal gameover

    property alias score: score.text
    Image {////背景图片设置
        id: gamebackImage
        anchors.fill: gameScene.gameWindowAnchorItem
        source: if (gameWindow.theme === 0) {
                    "../assets/snow/snowbck.png"
                } else if (gameWindow.theme === 1) {
                    "../assets/bunny/hopbck_X.png"
                } else if (gameWindow.theme === 2) {
                    "../assets/ninja/ghostbck_X.png"
                }else if(gameWindow.theme===3){
                    "../assets/underwater/underwaterbck_X"
                }
    }
    Image {//
        id: bckBottom
        height: gameWindow.theme ===3? gameWindow.height:30
        anchors.left:gameScene.gameWindowAnchorItem.left
        anchors.right:gameScene.gameWindowAnchorItem.right
        anchors.bottom: parent.bottom
        source: if (gameWindow.theme === 0) {
                    "../assets/snow/bottom.png"
                } else if (gameWindow.theme === 1) {
                    "../assets/bunny/bottom.png"
                } else if (gameWindow.theme === 2) {
                    "../assets/ninja/bottom.png"
                } else if(gameWindow.theme ===3){
                    "../assets/underwater/scroll.png"
                }
    }
    Text {
        id: score
        text: "0"
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 20
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
    }

    Image {
        width: 16
        height: 16
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 5
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 5
        source: "../assets/pause_button.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                pause()
            }
        }
    }

    PhysicsWorld {
        id: gravity
        gravity.y: 9.81
        debugDrawVisible: true
        updatesPerSecondForPhysics: 60
    }
    Accelerometer {
        id: accelerometer
        active: true
    }

    Floor {
        id: floor
        x: 10
        y: 400
        //type: 0
    }

    Repeater {
        id: f_repeater
        model: 15
        Floor {

            x: utils.generateRandomValueBetween(
                   20, parent.width - 60) // random value
            y: gameScene.height / 15 * index // distribute the platforms across the screen
        }
    }

    Repeater {
        model: 5
        BrokeFloor {

            x: utils.generateRandomValueBetween(
                   20, parent.width - 50) // random value
            y: gameScene.height / 5 * index // distribute the platforms across the screen
        }
    }
    Repeater {
        model: 5
        JumpBrokeFloor {

            x: utils.generateRandomValueBetween(
                   20, parent.width - 50) // random value
            y: gameScene.height / 5 * index // distribute the platforms across the screen
        }
    }
    Connections {
        target: noodle
        onDie: {
            sceneState = "gameover"
            noodle.y = 350
            noodle.x = 30

            floor.x = 10
            floor.y = 400
        }
    }

    Component {
        id: monsterComponent
        Monster {
            id: monster
            x: 50
            y: -10
        }
    }
    Component {
        id: floorComponent
        Floor {
            x: 50
            y: 0
        }
    }

    Component {
        id: stoneComponent
        Stone {
            x: 0
            y: utils.generateRandomValueBetween(0, gameScene.height)
        }
    }

    Component {
        id: springComponent
        Spring {
            x: floor.x + 5
            y: floor.y - 10
        }
    }

    Connections {
        target: manager
        onMonsterCreate: {
            var newProperty = {
                x: Math.random() * gameScene.width,
                y: manager.monsterPosition()
            }
            entityManager.createEntityFromComponentWithProperties(
                        monsterComponent, newProperty)
        }
        onFloorCreate: {
            var newProperty = {
                x: utils.generateRandomValueBetween(100, gameScene.width - 140),
                y: 0,
                type: utils.generateRandomValueBetween(0, 4) > 2 ? 1 : 2
            }
            entityManager.createEntityFromComponentWithProperties(
                        floorComponent, newProperty)
        }
        onSpringCreate: {
            entityManager.createEntityFromComponent(springComponent)
        }
        onStoneCreate: {
            var newProperty = {
                x:0,
                y: utils.generateRandomValueBetween(0, gameScene.height)
            }
            console.log("stoneCreate")
            entityManager.createEntityFromComponentWithProperties(stoneComponent,newProperty)
        }
    }
    Noodle {
        id: noodle
        x: 30
        y: 350
    }
    Particle {
        id: fireParticle
        fileName: "../qml/particle/snowPractice.json"
        autoStart: true
    }
    onBackButtonPressed: {
        pause()
    }
    Keys.forwardTo: noodle.controller
}
