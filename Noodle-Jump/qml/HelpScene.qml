//帮助界面

import QtQuick 2.0
import QtQuick.Controls 2.1
import Felgo 3.0

Scene {
    id: helpScene
    opacity: 0
    visible: opacity > 0
    enabled: visible

    Column {
        TextEdit {
            id: helpText
            textFormat: TextEdit.RichText
            font.pointSize: 9
            wrapMode: TextEdit.WrapAnywhere
            width: 310
            color: "blue"
            text: "<b>如果你是手机游戏用户，角色是自动跳动的，可通过左右偏移手机来控制角色的偏移;如果你是电脑游戏用户，角色是自动跳动的，可通过按动左右键来控制角色的移动.游戏过程中会有怪物出现，要控制角色避免触碰到怪物，其中还有跳板，角色触碰到跳板会加速。</b>"
        }
        TextArea {
            id: welcomeText
            font.pointSize: 7
            textFormat: TextEdit.RichText
            font.italic: true
            text: "<i>欢迎您的加入,更多精彩请在游戏中发现！</i>"
            color: "red"
        }
    }
    Image {
        id: helpBackGround
        source: "../assets/bck.png"
        anchors.fill: helpScene.gameWindowAnchorItem
        z: -1
    }
    Image {
        id: helpReturn
        source: "../assets/menu.png"
        anchors.left: helpScene.gameWindowAnchorItem.left
        anchors.leftMargin: 70
        anchors.bottom: helpScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 90
        scale: 0.4
        MouseArea {
            anchors.fill: parent
            onClicked: {
                gameWindow.state = "menu"
            }
        }
    }
}
