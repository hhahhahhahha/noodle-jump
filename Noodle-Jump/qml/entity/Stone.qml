import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: stone
    entityType: "Stone"
    width: 36
    height: 36
    poolingEnabled: true

//    SpriteSequence {
//        id: floorSequence
//        defaultSource: "../../assets/halloween-1k-product_X.png"

//        anchors.fill: parent
//        Sprite{
//            frameCount: 1
//            frameWidth: 10
//            frameHeight: 10
//            //frameY: type === 1 ? 110 : 0
//        }

//    }

    Image {//
        id: stone1
        source: "../../assets/halloween-1k-product_X.png"
        anchors.fill: parent
    }
    BoxCollider {//物理碰撞器
        id: stoneCollider
        anchors.fill: parent
        width: parent.width
        height: parent.height
        bodyType: Body.Dynamic //状态为动态，只有动态才会与其他的物理碰撞器发生碰撞
        collisionTestingOnlyMode: true //不受“重力”（PhysicsWorld设置的y方向的力）影响
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType

            if (otherEntityType === "noodle") {
                noodle.y = 1000
            }
        }
    }


    MovementAnimation {//x方向移动速度
        id: movement
        target: stone
        property:  "x"
        velocity: 50
        running: true
    }
    MovementAnimation {//实体的移动,当noodle跳到一定高度时，stone会自动的下落一定高度
        id: movement1
        target: stone
        property: "y"
        velocity: noodle.impulse / 2
        running: noodle.y < 260
    }

    onXChanged: {//销毁
        if(x > gameScene.x){
            stone.entityDestroyed()
           //console.log("destroyed")
        }
        //console.log(x)
    }
}

