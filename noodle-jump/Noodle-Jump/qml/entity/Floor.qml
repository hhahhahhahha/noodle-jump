//普通跳板,移动跳板
//与noodle发生碰撞时，noodle会出现向上跳动的情况
//有时也会出现特殊跳板，及水平移动或则上下移动的跳板
//有时也会出现特殊跳板，及水平移动或则上下移动的跳板，为了区分改情况，增加了新的property type（int）0代表普通跳板，1或2代表可以移动的跳板


import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: floor
    entityType: "Floor"
    width: 42
    height: 12
    poolingEnabled: true

    property int type: 0
    property int time: 1

    SpriteSequence {//动画效果的设置
        id: floorSequence
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
        Sprite{//动画效果的第一帧,即动画效果的最初始状态
            frameCount: 1
            frameWidth: 116
            frameHeight: 32
            frameY: type === 1 ? 110 : 0
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
        }
    }
    MovementAnimation {//实体的移动,当noodle跳到一定高度时，跳板会自动的下落一定高度
        id: movement
        target: floor
        property: 'y'
        velocity: noodle.impulse / 2
        running: noodle.y < 260
    }

    MovementAnimation {//可移动跳板的移动
        id: movement1
        target: floor
        property: type===1? "x":"y"
        velocity: 50
        running: type === 0 ? false : true
    }

    onYChanged: {//跳板移动到屏幕外的处理
        if (y > gameScene.height) {
            if (type !== 0) {//如果是移动跳板，则销毁
                floor.entityDestroyed()
            } else {//如果是移动跳板，则销毁//如果是普通跳板，则回收
                type = 0
                x = utils.generateRandomValueBetween(20, gameScene.width - 60)
                y = 0
            }
        }
    }

    onXChanged: {//移动跳板开始移动之后，计时器开始计时，这只会执行一次因为time初始化为1
        if (x < floorSequence.width||x>0) {
            if (time) {
                movement1.velocity = -movement1.velocity
                timer.restart()
                time--
            }
        }
    }

    Timer {//计时器，改变实体的运动方向
        id: timer
        interval: 2000
        running: true
        repeat: true
        onTriggered: movement1.velocity = -movement1.velocity
    }
}
