//游戏结束界面

import QtQuick 2.0
import Felgo 3.0

Scene {

    id: gameoverScene
    opacity: 0
    visible: opacity > 0
    enabled: visible

    signal gameStart
    signal gameSettings

    property alias gameoverScore: score.text

    Image {//背景图片设置
        id: gamebackImage
        anchors.fill: gameoverScene.gameWindowAnchorItem
        source: if (gameWindow.theme === 0) {
                    "../assets/snow/snowbck.png"
                } else if (gameWindow.theme === 1) {
                    "../assets/bunny/hopbck_X.png"
                } else if (gameWindow.theme === 2) {
                    "../assets/ninja/ghostbck_X.png"
                } else if(gameWindow.theme===3){
                    "../assets/underwater/underwaterbck_X"
                }
    }

    Image {//race over
        id: overImage
        width: 200
        height: 60
        anchors.top: gameoverScene.gameWindowAnchorItem.top
        anchors.topMargin: 30
        anchors.left: gameoverScene.gameWindowAnchorItem.left
        anchors.leftMargin: 30
        source: "../assets/race-over.png"
    }
    Text {//分数显示前面的score样式
        id: socretext
        anchors.right: score.left
        anchors.leftMargin: 30
        anchors.bottom: end.top
        anchors.topMargin: 200
        text: "Scores:"
        font.pixelSize: 15
    }

    Text {//分数显示
        id: score
        anchors.left: end.left
        anchors.leftMargin: 60
        anchors.bottom: end.top
        anchors.topMargin: 200
        text: "0"
    }

    Image {//继续
        id: end
        width: 110
        height: 40
        anchors.centerIn: gameoverScene.gameWindowAnchorItem
        source: "../assets/resume.png"
        MouseArea {
            anchors.fill: parent
            onClicked: gameStart()
        }
    }
    Image {//menu
        id: quit
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

    Image {//得分排行榜
        id: achievement
        width: 110
        height: 40
        scale: 0.8
        x: quit.x
        anchors.top: quit.bottom
        anchors.topMargin: 30
        source: "../assets/achievement.png"
        MouseArea {
            anchors.fill: achievement
            onClicked: {
                gameWindow.userScore.reportScore(manager.height())
                gameWindow.state = "achievement"
                frogNetworkView.visible = true
                gameoverScene.opacity = 0
            }
        }
    }
}
