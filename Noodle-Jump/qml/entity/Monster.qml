import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: monster
    entityType: "monster"
    width: 60
    height: 36

    property int type

    SpriteSequence {//动画效果的设置
        id: floorSequenceVplay
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
        Sprite {//怪物的飞行效果设置
            name: "1"
            frameCount: 4
            frameY: 0
            frameX: 296
            frameWidth: 162
            frameHeight: 94
            frameRate: 20
        }
    }

    BoxCollider {//物理碰撞器
        id: monsterCollider
        anchors.fill: parent
        width: parent.width
        height: 10
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType

            if (otherEntityType === "noodle") {
                noodle.y = 1000//noodle死亡
            }
        }
    }

    MovementAnimation {//实体的移动,当noodle跳到一定高度时，monster会自动的下落一定高度
        id: movement
        target: monster
        property: "y"
        velocity: noodle.impulse / 2
        running: noodle.y < 260
    }
    onYChanged: {//怪物的销毁
        if (y > gameScene.height) {
            monster.entityDestroyed()
        }
    }
}
