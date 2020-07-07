//设置界面
import QtQuick 2.0
import Felgo 3.0

Scene {

    id: settingScene

    opacity: 0
    visible: opacity > 0
    enabled: visible

    Image {
        id: resume
        width: 110
        height: 40
        anchors.bottom: settingScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 15
        x: parent.width / 2
        source: "../assets/resume.png"
        scale: 0.7
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (theme0.visible) {
                    gameWindow.theme = 0
                } else if (theme1.visible) {
                    gameWindow.theme = 1
                } else if(theme2.visible){
                    gameWindow.theme = 2
                }else if(theme3.visible)
                    gameWindow.theme =3
                manager.themeChanged(gameWindow.theme)
                gameWindow.state = "menu"
            }
        }
    }

    Image {
        id: theme0
        visible: if (gameWindow.theme === 0) {
                     true
                 } else {
                     false
                 }
        width: (settingScene.gameWindowAnchorItem.width / 10) * 9
        height: (settingScene.gameWindowAnchorItem.height / 6) * 5
        anchors.topMargin: 1
        anchors.leftMargin: 15
        anchors.left: settingScene.gameWindowAnchorItem.left
        anchors.top: settingScene.gameWindowAnchorItem.top
        source: "../assets/snow/snowthem.png"
    }

    Image {
        visible: if (gameWindow.theme === 1) {
                     true
                 } else {
                     false
                 }

        id: theme1
        width: (settingScene.gameWindowAnchorItem.width / 10) * 9
        height: (settingScene.gameWindowAnchorItem.height / 6) * 5
        anchors.topMargin: 1
        anchors.leftMargin: 15
        anchors.left: settingScene.gameWindowAnchorItem.left
        anchors.top: settingScene.gameWindowAnchorItem.top
        source: "../assets/bunny/bunnythem.png"
    }

    Image {
        visible: if (gameWindow.theme === 2) {
                     true
                 } else {
                     false
                 }
        id: theme2
        width: (settingScene.gameWindowAnchorItem.width / 10) * 9
        height: (settingScene.gameWindowAnchorItem.height / 6) * 5
        anchors.topMargin: 1
        anchors.leftMargin: 10
        anchors.left: settingScene.gameWindowAnchorItem.left
        anchors.top: settingScene.gameWindowAnchorItem.top
        source: "../assets/ninja/ninjathem.png"
    }
    Image {
        visible: if (gameWindow.theme === 3) {
                     true
                 } else {
                     false
                 }
        id: theme3
        width: (settingScene.gameWindowAnchorItem.width / 10) * 9
        height: (settingScene.gameWindowAnchorItem.height / 6) * 5
        anchors.topMargin: 1
        anchors.leftMargin: 10
        anchors.left: settingScene.gameWindowAnchorItem.left
        anchors.top: settingScene.gameWindowAnchorItem.top
        source: "../assets/underwater/ocean_game.png"
    }
    Image {
        id: leftselect
        visible: if (gameWindow.theme === 0) {
                     false
                 } else {
                     true
                 }
        source: "../assets/leftselect.png"
        anchors.bottom: settingScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 10
        x: settingScene.gameWindowAnchorItem.width / 12
        scale: 0.5
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(gameWindow.theme === 3){
                    gameWindow.theme = 2
                    theme0.visible = false
                    theme1.visible = false
                    theme2.visible = true
                    theme3.visible = false
                }else if (gameWindow.theme === 2) {
                    gameWindow.theme = 1
                    theme0.visible = false
                    theme1.visible = true
                    theme2.visible = false
                } else if (gameWindow.theme === 1) {
                    gameWindow.theme = 0
                    theme0.visible = true
                    theme1.visible = false
                    theme2.visible = false
                }
            }
        }
    }

    Image {
        id: rightselect
        visible: if (gameWindow.theme === 3) {
                     false
                 } else {
                     true
                 }

        source: "../assets/rightselect.png"
        anchors.bottom: settingScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 14
        anchors.left: leftselect.right
        anchors.leftMargin: 7
        scale: 0.5
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (gameWindow.theme === 0) {
                    gameWindow.theme = 1
                    theme0.visible = false
                    theme1.visible = true
                    theme2.visible = false
                    theme3.visible = false
                } else if (gameWindow.theme === 1) {
                    gameWindow.theme = 2
                    theme0.visible = false
                    theme1.visible = false
                    theme2.visible = true
                    theme3.visible = false
                }else if(gameWindow.theme === 2){
                    gameWindow.theme = 3
                    theme0.visible = false
                    theme1.visible = false
                    theme2.visible = false
                    theme3.visible = true
                }
            }
        }
    }
}
