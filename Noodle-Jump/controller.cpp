//移动实体产生的控制器
#include "controller.h"
#include <QDebug>
#include "time.h"

Controller::Controller(QObject *parent) : QObject(parent),m_height(0),m_monsterPosition(0),m_floorPosition(0)
  ,m_springPosition(0),m_stonePosition(0),m_theme(1)
{
    QFile file("./assets/myconfig.json");
    file.open(QIODevice::ReadOnly);
    QByteArray json = file.readAll();

    QJsonParseError json_error;
    QJsonDocument parse_doucment = QJsonDocument::fromJson(json, &json_error);
    if(json_error.error == QJsonParseError::NoError) {
        if(parse_doucment.isObject())  {
            QJsonObject obj = parse_doucment.object();
            if(obj.contains("theme"))  {
                QJsonValue name_value = obj.take("theme");

                m_theme = name_value.toInt();

            }
        }
    }
    file.close();
}

QString Controller::height(){
    long int a = static_cast<long>(m_height);
    QString s = QString::number(a, 10);
    return s;
}

double Controller::monsterPosition(){
    return m_monsterPosition;
}
void Controller::monsterPositionChanged(){
    if(m_monsterPosition > monsterCreateHeight){
        if(monsterCreateHeight>=500)
            monsterCreateHeight=monsterCreateHeight-100;
        m_monsterPosition = 0;
        emit monsterCreate();
    }
}

void Controller::floorPositionChanged(){
    if(m_floorPosition > floorCreateHeight){
        m_floorPosition = 0;
        emit floorCreate();
    }
}

void Controller::heightChanged(double height){
    m_height += height;
    m_monsterPosition += height;
    m_floorPosition += height;
    m_springPosition += height;
    m_stonePosition +=height;
    monsterPositionChanged();
    floorPositionChanged();
    springPositionChanged();
    stonePositionChanged();
}
int Controller::theme(){
    return m_theme;
}

void Controller::themeChanged(int _theme){


    QJsonObject themeObject;
    themeObject.insert("theme",_theme);

        QJsonDocument jsonDoc(themeObject);
        QByteArray ba = jsonDoc.toJson();
        QFile file("./assets/myconfig.json");
        if(!file.open(QIODevice::WriteOnly))
        {
            qDebug() << "write json file failed";
        }
        file.write(ba);
        file.close();
}
void Controller::springPositionChanged(){
    if(m_springPosition > springCreateheight){
        m_springPosition = 0;
        emit springCreate();
    }
}

void Controller::stonePositionChanged()
{
    if(m_stonePosition > stoneCreateheight){
        m_stonePosition = 0;
        qDebug()<<"sign";
        emit stoneCreate();
    }
}




