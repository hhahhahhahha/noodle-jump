//破碎跳板
//一触碰就会破碎，且不会跳跃



import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.5

EntityBase {
    id: brokefloor
    entityType: "BrokeFloor"
    width: 42
    height: 12
    opacity: 1

    property int type

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

        Sprite {//动画效果的第一帧,即动画效果的最初始状态
            name: "1"
            frameCount: 1
            frameY: 144
            frameWidth: 120
            frameHeight: 32
            frameRate: 0
        }
        Sprite {//当与noodle发碰撞后动画效果会被出发，
            //形成一种动画效果，该效果Sprite“2”，“3”，“4”共同组成
            name: "2"
            frameCount: 1
            frameY: 184
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
            frameY: 224
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
            frameY: 306
            frameWidth: 120
            frameHeight: 55
            frameRate: 1
        }
    }

    BoxCollider { //物理碰撞器
        id: floorCollider
        anchors.fill: parent
        width: parent.width
        height: 10
        bodyType: Body.Dynamic//状态为动态，只有动态才会与其他的物理碰撞器发生碰撞
        collisionTestingOnlyMode: true//不受“重力”（PhysicsWorld设置的y方向的力）影响
        fixture.onBeginContact: {//碰撞信号
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType
            //console.log("broke",noodle.linevelocityY)

            if (otherEntityType === "noodle" ) {
                floorSequence.jumpTo("2")//改变帧动画，触发碰撞效果
                movement.running = true//
                movement2.running = true//
                breaksound.play()//播放音乐
            }
        }
    }
    MovementAnimation {//实体的移动，即与noodle碰撞发生后，破碎跳板立即向下移动，直到移动到屏幕外
        id: movement
        target: brokefloor
        property: "y"
        velocity: 100
    }
    MovementAnimation {//实体的移动,当noodle跳到一定高度时，跳板会自动的下落一定高度
        id: movement1
        target: brokefloor
        property: "y"
        velocity: noodle.impulse / 2
        running: noodle.y < 260
    }
    NumberAnimation {//与noodle发生碰撞后，改实体的透明度逐渐降低直到不可见
        id: movement2
        target: floorSequence
        property: "opacity"
        to: 0
        duration: 1000
    }
    NumberAnimation {//实体移动到屏幕下方看不见的位置时，改实体的透明度会升高，直到变为1
        id: movement3
        target: floorSequence
        property: "opacity"
        to: 1
        duration: 10
    }

    onYChanged: {//实体的回收，当实体移动到屏幕外时，会改变该实体的位置(随机出现)，会出现在屏幕上方不可见的位置，随着noodle的跳动会在次出现
        if (y > gameScene.height) {
            x = utils.generateRandomValueBetween(20, gameScene.width - 60)
            y = utils.generateRandomValueBetween(-parent.height, 10)
            floorSequence.jumpTo("1")
            movement.running = false
            movement3.running =true
            //brokefloor.opacity = 1
        }
        //console.log(brokefloor.opacity)
    }
    Audio {//音效
        id: breaksound
        source: "../../assets/sound/floorbreak.mp3"
    }
}
