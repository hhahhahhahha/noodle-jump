//定义游戏屏幕的状态，一旦状态改变界面也就随之切换
import Felgo 3.0
import QtQuick 2.0
import "../qml/entity"

GameWindow {
    id: gameWindow
    property alias sceneState: gameWindow.state
    property int theme: manager.theme()
    property alias userScore: gameNetwork

    //licenseKey: "00DC442A0FAD6489D865F4A57F621C96A111F237AC6A42640199DD646F4AD6DBF9C0210C517770849D94914151EAE126577D964323514F17F353FCEC93ECB67EC887222AF138B086371E40AFBC4603481D01A73BF08FAEA2D84F116A58C96B6A7852196E73776C90A54193B9EFA8240EBE695B335FB3D0CE0FCBCC803B1340305781BC369705E5C2C68CA4C54ECA4B76A6316A32908E87544A7FD6199F2EBDC5E695DB076A24B6B50D3049A36856682D6E5B6BD71F227295F09F8D4A57084B3DCB1365EC48EB4B6C70173E8326906E35281F95D348F6C3E3B849C3A3A2275508363132BB59A3C41EF06819D32E10E95132E9255F8323D5E3F210AEEFE9F8F90F59C9C437D6927B0F3E76D6B989457326254D2C8275DE79050BFED1C5E242DBAC8389577FFD2CF4189D852917921DCBD8DE5EF1076519D5D69E7EE704BDE2AA93"

    screenWidth: 640
    screenHeight: 960
    activeScene: menuScene

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    MenuScene {
        id: menuScene
        onGameStart: {
            gameWindow.state = "game"
        }
        onGameSettings: {
            gameWindow.state = "settings"
        }
    }
    SettingScene {
        id: settingScene
    }
    GameScene {
        id: gameScene
        onPause: {
            gameWindow.state = "pause"
        }
    }
    PauseScene {
        id: pauseScene
        onResume: {
            gameWindow.state = "game"
        }
    }
    GameoverScene {
        id: gameoverScene
        onGameStart: {
            gameWindow.state = "game"
        }
        onGameSettings: {
            gameWindow.state = "settings"
        }
    }

    HelpScene {
        id: helpScene
    }
    // set up game network and achievements
    FelgoGameNetwork {
        id: gameNetwork
        gameId: 173 // put your gameId here
        secret: "doodlefrogsecret12345" // put your game secret here
        gameNetworkView: frogNetworkView
        userScores: 0
        clearAllUserDataAtStartup: true
        userScoresInitiallySynced: true

        achievements: [
            Achievement {
                key: "5opens"
                name: "Game Opener"
                target: 5
                points: 10
                description: "Open this game 5 times"
            },

            Achievement {
                key: "die100"
                name: "Y U DO DIS?"
                iconSource: "../assets/achievementImage.png"
                target: 100
                description: "Die 100 times"
            }
        ]
    }

    Scene {
        id: achievementScene
        opacity: 0
        visible: opacity > 0
        enabled: visible

        // the game network view shows the leaderboard and achievements
        GameNetworkView {
            id: frogNetworkView
            visible: false
            anchors.fill: parent.gameWindowAnchorItem

            onShowCalled: {
                frogNetworkView.visible = true
            }

            onBackClicked: {
                frogNetworkView.visible = false
                gameWindow.state = "gameover"
            }
        }
    }

    // the menu scene of the game

    //default state is menu
    state: "menu"
    states: [
        State {
            name: "menu"
            PropertyChanges {
                target: menuScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: menuScene
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: settingScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: settingScene
            }
        },
        State {
            name: "game"
            PropertyChanges {
                target: gameScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: gameScene
            }
        },
        State {
            name: "pause"
            PropertyChanges {
                target: pauseScene
                opacity: 1
            }
            PropertyChanges {
                target: pauseScene
                pauseScore: manager.height()
            }
            PropertyChanges {
                target: gameWindow
                activeScene: pauseScene
            }
        },
        State {
            name: "gameover"
            PropertyChanges {
                target: gameoverScene
                opacity: 1
            }
            PropertyChanges {
                target: gameoverScene
                gameoverScore: manager.height()
            }
            PropertyChanges {
                target: gameWindow
                activeScene: gameoverScene
            }
        },
        State {
            name: "achievement"
            PropertyChanges {
                target: achievementScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: achievementScene
            }
        },
        State {
            name: "help"
            PropertyChanges {
                target: helpScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: helpScene
            }
        }
    ]
}
