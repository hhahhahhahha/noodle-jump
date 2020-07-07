import QtQuick 2.0
import QtMultimedia 5.0
import Felgo 3.0

EntityBase {
    id: noodle
    entityType: "noodle"
    width: 40
    height: 32
    poolingEnabled: true

    signal die

    property alias controller: controller
    property alias linevelocityY: noodleCollider.linearVelocity.y//noodle的y方向速度
    property int impulse: y - noodleCollider.linearVelocity.y
    Image {//图片
        id: noodleImage
        source: if (gameWindow.theme === 0) {
                    "../../assets/snow/noodlesnow.png"
                } else if (gameWindow.theme === 1) {
                    "../../assets/bunny/bunnyleft_X.png"
                } else if (gameWindow.theme === 2) {
                    "../../assets/ninja/ninja-left_X.png"
                }else if(gameWindow.theme===3){
                    "../../assets/underwater/underwaterleft_L.png"
                }
        anchors.fill: parent
        mirror: true//镜像
    }

    Audio {//音效
        id: dieSound
        source: "../../assets/sound/die.mp3"
    }
    Audio {
        id: jumpSound
        source: "../../assets/sound/jump.ogg"
    }

    BoxCollider {//物理碰撞器
        id: noodleCollider
        width: 20
        x: 10
        y: 25
        height: 7
        bodyType: Body.Dynamic//状态为动态，只有动态才会与其他的物理碰撞器发生碰撞
        fixture.onBeginContact: {

            var otherEntity = other.getBody().target
            var otherEntityType = otherEntity.entityType

            if (otherEntityType === "Floor" && linearVelocity.y > 50||(otherEntityType === "JumpBrokeFloor" && linearVelocity.y > 50)) {
                jumpSound.play()
                linearVelocity.y = -250
            }
        }
        linearVelocity.x: {//xy方向速度
            system.desktopPlatform ? controller.xAxis * 200 : //  for desktop
                                                   (accelerometer.reading
                                                    !== null ? -accelerometer.reading.x
                                                               * 100 : 0) // for mobile
        }
    }

    TwoAxisController {//水平控制器,以此来控制物体的左右移动
        id: controller
    }

    onYChanged: {
        if (y < 200) {
            y = 200
            manager.heightChanged(10)//controler的使用,controller控制随机实体的产生（除普通跳板，破碎跳板，跳跃破碎跳板之外的实体），以及得分
            gameScene.score = manager.height()//得分控制
        }
        if (noodleCollider.linearVelocity.y < -100) {
            if (gameWindow.theme === 0) {
                noodleImage.source = "../../assets/snow/noodlesnow_sit.png"
            } else if (gameWindow.theme === 1) {
                noodleImage.source = "../../assets/bunny/bunnyleftodskok_X.png"
            } else if (gameWindow.theme === 2) {
                noodleImage.source = "../../assets/ninja/ninja-left-odskok_X.png"
            }else if(gameWindow.theme===3){
                noodleImage.source="../../assets/underwater/underwaterleftodskok_L.png"
            }
        } else if (gameWindow.theme === 0) {
            noodleImage.source = "../../assets/snow/noodlesnow.png"
        } else if (gameWindow.theme === 1) {
            noodleImage.source = "../../assets/bunny/bunnyleft_X.png"
        } else if (gameWindow.theme === 2) {
            noodleImage.source = "../../assets/ninja/ninja-left_X.png"
        }else if(gameWindow.theme===3){
            noodleImage.source="../../assets/underwater/underwaterleft_L.png"
        }

        if (y > gameScene.height) {
            die()//
            dieSound.play()//
        }
        //console.log("noodle ",noodle.linearVelocityY)
    }
    onXChanged: {
        if (x < 0) {//从屏幕的左右测相互跳跃，noodle可以从左侧直接跳到右侧，反之亦然
            x = gameScene.width
        }
        if (x > gameScene.width) {
            x = 0
        }
        //noodle的镜像，向左和向右相互切换
        if (noodleCollider.linearVelocity.x < -50) {
            noodleImage.mirror = false
        } else if (noodleCollider.linearVelocity.x > 50) {
            noodleImage.mirror = true
        }
    }
}
