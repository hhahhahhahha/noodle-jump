// 跳跃破碎跳板
//  同破碎跳板一样，与noodle发生碰撞之后会破碎，有时会触发noodle的上跳效果（如果是noodle上身途中不会出发上跳效果,下降时会出发）

import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.5


EntityBase {
    id: jumpbrokefloor
    entityType: "JumpBrokeFloor"
    width: 42
    height: 12

    property int type

    SpriteSequence {//动画效果的设置
        id: jumpBrokeSequence
        defaultSource: if (gameWindow.theme === 0) {
                           "../../assets/snow/snowresource.png"
                       } else if (gameWindow.theme === 1) {
                           "../../assets/bunny/gametilesbunny_X.png"
                       } else if (gameWindow.theme === 2) {
                           "../../assets/ninja/game-tiles-ninja_X.png"
                       }else if(gameWindow.theme===3){
                           "../../assets/underwater/gametilesunderwater_X.png"
                       }
        anchors.fill: parent


        Sprite {//动画效果的第一帧,即动画效果的最初始状态
            name: "1"
            frameCount: 1
            frameY: 366
            frameWidth: 120
            frameHeight: 32
            frameRate: 0
        }
        Sprite {//当与noodle发碰撞后动画效果会被出发，
            //形成一种动画效果，该效果Sprite“2”，“3”，“4”,"5","6","7","8"共同组成
            name: "2"
            frameCount: 1
            frameY: 401
            frameWidth: 120
            frameHeight: 48
            frameRate: 5
            to: {
                3: 2
            }
        }
        Sprite {
            name: "3"
            frameCount: 1
            frameY: 436
            frameWidth: 120
            frameHeight: 64
            frameRate: 5
            to: {
                4: 2
            }
        }
        Sprite {
            name: "4"
            frameCount: 1
            frameY: 471
            frameWidth: 120
            frameHeight: 55
            frameRate: 1
            to: {
                5: 2
            }
        }
        Sprite {
            name: "5"
            frameCount: 1
            frameY: 509
            frameWidth: 120
            frameHeight: 55
            frameRate: 1
            to: {
                6: 2
            }
        }
        Sprite {
            name: "6"
            frameCount: 1
            frameY: 543
            frameWidth: 120
            frameHeight: 55
            frameRate: 1
            to: {
                7: 2
            }
        }
        Sprite {
            name: "7"
            frameCount: 1
            frameY: 584
            frameWidth: 120
            frameHeight: 55
            frameRate: 1
            to: {
                8: 2
            }
        }
        Sprite {
            name: "8"
            frameCount: 1
            frameY: 638
            frameWidth: 120
            frameHeight: 55
            frameRate: 1
        }
    }

    BoxCollider {//物理碰撞器
        id: floorCollider
        anchors.fill: parent
        width: parent.width
        height: 10
        bodyType: Body.Dynamic //状态为动态，只有动态才会与其他的物理碰撞器发生碰撞
        collisionTestingOnlyMode: true //不受“重力”（PhysicsWorld设置的y方向的力）影响
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType
            //console.log("jumpbrok",noodle.linevelocityY)

            if (otherEntityType === "noodle") {
                jumpBrokeSequence.jumpTo("2")//改变帧动画，触发碰撞效果
                movement.running = true
                movement2.running = true
                //console.log("noodle1")
                breaksound.play()//播放音乐
            }
        }
    }
    MovementAnimation {//实体的移动，即与noodle碰撞发生后，破碎跳板立即向下移动，直到移动到屏幕外
        id: movement
        target: jumpbrokefloor
        property: "y"
        velocity: 100
    }
    MovementAnimation {//实体的移动,当noodle跳到一定高度时，跳板会自动的下落一定高度
        id: movement1
        target: jumpbrokefloor
        property: "y"
        velocity: noodle.impulse / 2
        running: noodle.y < 260
    }
    NumberAnimation {//与noodle发生碰撞后，改实体的透明度逐渐降低直到不可见
        id: movement2
        target: jumpBrokeSequence
        property: "opacity"
        to: 0
        duration: 1000
    }
    NumberAnimation {//实体移动到屏幕下方看不见的位置时，改实体的透明度会升高，直到变为1
        id: movement3
        target: jumpBrokeSequence
        property: "opacity"
        to: 1
        duration: 10
    }
    onYChanged: {//实体的回收，当实体移动到屏幕外时，会改变该实体的位置(随机出现)，会出现在屏幕上方不可见的位置，随着noodle的跳动会在次出现
        if (y > gameScene.height) {
            x = utils.generateRandomValueBetween(20, gameScene.width - 60)
            y = utils.generateRandomValueBetween(-parent.height, 10)
            jumpBrokeSequence.jumpTo("1")
            movement.running = false
            movement2.running= false
            movement3.running = true
            //jumpbrokefloor.opacity=1
        }
    }
    Audio {//音效
        id: breaksound
        source: "../../assets/sound/breaking-arcade.ogg"
    }
}
