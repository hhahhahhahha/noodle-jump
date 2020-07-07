//弹簧
//与noodle发生碰撞后，会让noodle产生一个大的跳跃
import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.5

EntityBase {
    id: springFloor
    visible: true
    entityType: "Spring"
    width: 20
    height: 12
    poolingEnabled: true

    SpriteSequence {//动画效果的设置
        id: springSequence
        visible: true
        defaultSource: if (gameWindow.theme === 0) {
                           "../../assets/snow/snowresource.png"
                       } else if (gameWindow.theme === 1) {
                           "../../assets/bunny/gametilesbunny_X.png"
                       } else if (gameWindow.theme === 2) {
                           "../../assets/ninja/game-tiles-ninja_X.png"
                       } else if(gameWindow.theme===3){
                           "../../assets/underwater/gametilesunderwater_X.png"
                       }
        anchors.fill: parent

        Sprite {//动画效果的第一帧
            name: "spring"
            frameCount: 1
            frameX: 296
            frameY: 185
            frameWidth: 80
            frameHeight: 35
            frameRate: 5
            //            to: {
            //                springDown: 0
            //                spring: 1
            //            }
        }
        Sprite {//当与noodle发碰撞后动画帧
            name: "springDown" //fall
            frameCount: 1
            frameX: 375
            frameY: 185
            frameWidth: 70
            frameHeight: 32
            frameRate: 5
        }
    }

    BoxCollider {//物理碰撞器
        id: springCollider
        width: 20
        height: 20
        bodyType: Body.Dynamic//状态为动态，只有动态才会与其他的物理碰撞器发生碰撞
        collisionTestingOnlyMode: true//不受“重力”（PhysicsWorld设置的y方向的力）影响
        fixture.onBeginContact: {

            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType

            if (otherEntityType === "noodle" && linearVelocity.y > 0) {
                noodle.linevelocityY = -600
                springSequence.jumpTo("springDown")//改变帧动画，触发碰撞效果
                stimer.running = true
                ntssound.play()
            }
        }
    }
    onYChanged: {//弹簧的销毁
        if (y > gameScene.height) {
            entityDestroyed()
        }
    }
    MovementAnimation {//实体的移动,当noodle跳到一定高度时，spring会自动的下落一定高度
        id: movement
        target: springFloor
        property: "y"
        velocity: noodle.impulse / 2
        running: noodle.y < 260
    }

    Audio {
        id: ntssound
        source: "../../assets/sound/trampoline.mp3"
    }

    Timer {//计时器，帧动画回复原状
        id: stimer
        interval: 350
        running: false
        repeat: false
        onTriggered: {
            springSequence.jumpTo("spring")
        }
    }
}
