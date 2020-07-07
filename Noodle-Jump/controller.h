#ifndef CONTROLLER_H
#define CONTROLLER_H
//移动实体产生的控制器
#include <QtGui>
#include <QString>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>



#define floorCreateHeight 1000//每产生一个移动跳板的分数
#define springCreateheight 2000//每产生一个弹簧跳板的分数
#define stoneCreateheight 500//每产生一个飞行怪物的分数

class Controller : public QObject
{
    Q_OBJECT
public:
    explicit Controller(QObject *parent = nullptr);

    Q_INVOKABLE QString height();
    Q_INVOKABLE double monsterPosition();//改变相应的分数记录，当这个分数达到设定的值时，发出相应的信号，如改函数每次调用会增加m_monster的值，发出的信号为monstercreate
      //相似的函数具有相似的功能
    Q_INVOKABLE void monsterPositionChanged();

    Q_INVOKABLE void floorPositionChanged();
    Q_INVOKABLE int theme();

    Q_INVOKABLE void springPositionChanged();
    Q_INVOKABLE void stonePositionChanged();

signals:

    Q_INVOKABLE void monsterCreate();//移动实体产生的信号
    Q_INVOKABLE void floorCreate();
    Q_INVOKABLE void springCreate();
    Q_INVOKABLE void stoneCreate();


public slots:
    Q_INVOKABLE void heightChanged(double height);
    Q_INVOKABLE void themeChanged(int _theme);

private:
    int monsterCreateHeight{1000};//每产生一个怪物的分数,该值会被改变
    double m_height;//记录得分
    double m_monsterPosition;//标记怪物产生的分数，一旦达到某个设定的值，则产生发出相应的信号
    double m_floorPosition;
    double m_springPosition;
    double m_stonePosition;
    int m_theme;//默认的游戏主题
};

#endif // CONTROLLER_H
